package Misc
{
	import Game.*;
	import Scene.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.system.*;
	import flash.utils.*;
	import net.theyak.server.*;
	import net.theyak.ui.*;
	import net.theyak.util.*;

	public class Server extends ElectroServer4
	{
		private var _pingTime:int;
		private var _latency:Number;
		private var _pingInterval:uint;
		private var _muteInterval:uint = 0;
		public var manualAway:Boolean = false;

		public function Server()
		{
			super();
			addEventListener("connectionClosed", "connectionClosed", this);
			addEventListener("pluginMessage", "pluginMessageEvent", this);
			addEventListener("UserVariableUpdated", "userVariableUpdatedEvent", this);
			addEventListener("UserVariableCreated", "userVariableCreatedEvent", this);
			addEventListener("UserVariableDeleted", "userVariableDeletedEvent", this);
		}

		public function toServerPlugin(param1:String, param2:String, param3:Object = null, param4:Boolean = true) : void
		{
			super.serverPlugin(param1, param2, param3, param4);
		}

		public function pluginMessageEvent(param1:Object) : void
		{
			var _loc_3:String = null;
			var _loc_2:EsObject = new EsObject();
			switch(param1.response.Action)
			{
			case "Pong":
				pong();
				break;
			case "System":
				system(param1.response.m);
				break;
			case "Error":
				system(param1.response.text);
				break;
			case "Mute":
				mute(param1.response.time, param1.response.reason);
				ban(param1.response.time, param1.response.reason);
				break;
			case "Ban":
				ban(param1.response.time, param1.response.reason);
				break;
			case "Unmute":
				unmute();
				break;
			case "History":
				history(param1.response.history);
				break;
			case "Userinfo":
				user_info(param1.response.user);
				break;
			case "on_ftw":
				on_ftw(param1.response.id, param1.response.tpp, param1.response.pc, param1.response.type, param1.response.zone, param1.response.room);
				break;
			case "user_ping":
				_loc_2 = new EsObject();
				_loc_2.setString("user", param1.response.user);
				_loc_2.setInteger("time", int(param1.response.time));
				g.server.esServerPlugin(g.auxiliary, "user_pong", _loc_2);
				break;
			case "user_pong":
				_loc_3 = String(getTimer() - param1.response.time);
				g.chat.noticeEvent("Ping response from " + param1.response.user + " " + _loc_3 + " milliseconds.");
				break;
			case "inc_games_today":
				var _loc_4:* = g.user;
				var _loc_5:* = _loc_4.gamesToday + 1;
				_loc_4.gamesToday = _loc_5;
				break;
			case "leave_game":
				on_leave_game();
				break;
			default:
				break;
			}
		}

		private function on_leave_game() : void
		{
			if(g.scene.activeScene == "FTW" || g.scene.activeScene == "Countdown")
			{
				FTWBase(g.scene.getScene()).on_leave_game(null);
			}
		}

		private function on_ftw(param1:uint, param2:uint, param3:uint, param4:String, param5:String, param6:String)
		{
			g.server.leaveRoom(g.activeZoneName, g.activeRoomName);
			if(param4 == "FTW")
			{
				g.game.id = param1;
				g.game.time_per_problem = param2;
				g.game.problem_count = param3;
				g.game.type = param4;
				g.game.room_name = param6;
				g.game.zone_name = param5;
				g.activeRoomName = param6;
				g.activeZoneName = param5;
				g.scene.ftw();
			}
			else
			{
				if(param4 == "Countdown")
				{
					g.game.id = param1;
					g.game.time_per_problem = param2;
					g.game.problem_count = param3;
					g.game.type = param4;
					g.game.room_name = param6;
					g.game.zone_name = param5;
					g.activeRoomName = param6;
					g.activeZoneName = param5;
					g.scene.countdown();
				}
			}
		}

		public function on_chess(param1:Object) : void
		{
		}

		public function userVariableCreatedEvent(param1:Object) : void
		{
		}

		public function userVariableUpdatedEvent(param1:Object) : void
		{
			switch(param1.variable)
			{
			case "away":
				if(g.scene.activeScene == "Lobby")
				{
					Lobby(g.scene.getScene()).setAway(param1.username, param1.value);
				}
				break;
			case "rating":
				if(param1.username == g.user.name)
				{
					g.user.current_rating = Number(param1.value);
				}
				if(g.scene.activeScene == "Lobby")
				{
					Lobby(g.scene.getScene()).setRating(param1.username, Number(param1.value));
				}
				break;
			default:
				break;
			}
		}

		public function userVariableDeletedEvent(param1:Object) : void
		{
		}

		public function connectionClosed(param1:Object) : void
		{
			stopPingPong();
			if(this._muteInterval)
			{
				clearInterval(this._muteInterval);
			}
			g.scene.message("\n\n\n\n\n\nYou have lost connection to server.\n\nRefresh this page to attempt re-connect");
		}

		public function setAway(param1:Boolean) : void
		{
			g.away = param1;
			if(param1)
			{
				lastRequest = getTimer() - 900000;
				g.server.setUserVariable("away", "true");
			}
			else
			{
				lastRequest = getTimer();
				manualAway = false;
				g.server.setUserVariable("away", "false");
			}
		}

		private function history(param1:String) : void
		{
			var _loc_4:String = null;
			var _loc_2:Array = new Array();
			var _loc_3:Array = new Array();
			_loc_3 = param1.split("\n");
			var _loc_5:int = 0;
			while(_loc_5 < _loc_3.length)
			{
				_loc_2 = String(_loc_3[_loc_5]).split("\t");
				_loc_4 = "Game ID: " + _loc_2[0];
				_loc_4 = _loc_4 + "  Time: " + _loc_2[1] + " " + _loc_2[2];
				_loc_4 = _loc_4 + "  Score: " + _loc_2[4];
				_loc_4 = _loc_4 + "  Place: " + _loc_2[5];
				g.chat.noticeEvent(_loc_4);
				_loc_5++;
			}
		}

		private function user_info(param1:String) : void
		{
			var _loc_2:Object = new Object();
			_loc_2.user = param1;
			_loc_2.ftw = g.version;
			_loc_2.flash = Capabilities.version;
			_loc_2.mem = System.totalMemory;
			_loc_2.diff = System.totalMemory - g.initialMemoryUsage;
			g.server.toServerPlugin(g.auxiliary, "Userinfo", _loc_2, false);
		}

		private function system(param1:String) : void
		{
			var _loc_2:YakAlert = new YakAlert(param1, "System Message", "OK");
			_loc_2.center(g.scene.getScene());
			g.scene.getScene().addChild(_loc_2);
		}

		public function setMuteInterval(param1:uint) : void
		{
			this._muteInterval = setInterval(unmute, param1 * 1000);
		}

		private function mute(param1:int, param2:String) : void
		{
			var _loc_3:String = null;
		}

		private function unmute() : void
		{
			if(this._muteInterval > 0)
			{
				clearInterval(_muteInterval);
				_muteInterval = 0;
			}
			g.chat.mute = false;
			system("You are no longer muted.");
			if(g.scene.getScene() is BaseChat)
			{
				BaseChat(g.scene.getScene()).onUnmute();
			}
			g.user.muted = false;
			Net.callServer(g.URLPath + "PHP/SetCookie.php?n=__utmf&m=-60&v=12");
		}

		private function ban(param1:int, param2:String) : void
		{
		}

		public function startPingPong() : void
		{
			_pingInterval = setInterval(ping, 120000);
		}

		public function stopPingPong() : void
		{
			clearInterval(_pingInterval);
		}

		private function ping() : void
		{
			if(!g.away && lastRequest < (getTimer() - 900000))
			{
				setAway(true);
			}
			else
			{
				if(lastRequest < (getTimer() - -297152))
				{
					stopPingPong();
					g.server.leaveAllRooms();
					g.scene.message("\n\n\n\n\n\nYou have been signed out due to inactivity");
					return;
				}
				g.away;
				if(!manualAway && g.away && lastRequest > (getTimer() - 900000))
				{
					setAway(false);
				}
			}
			_pingTime = getTimer();
			esServerPlugin(g.auxiliary, "Ping", new EsObject(), false);
		}

		private function pong() : void
		{
			_latency = getTimer() - _pingTime;
		}

		public function get latency() : uint
		{
			return _latency;
		}

		public function log(param1:String) : void
		{
			var _loc_2:EsObject = new EsObject();
			_loc_2.setString("message", param1);
			esServerPlugin(g.auxiliary, "Log", _loc_2, true);
		}
	}
}
