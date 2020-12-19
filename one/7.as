package Misc
{
	import com.adobe.utils.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.system.*;
	import flash.utils.*;
	import net.theyak.chat.*;
	import net.theyak.util.*;

	public class Chat extends Chat
	{
		private var floodCount:uint = 0;
		private var languageCount:uint = 0;
		public var flood_mute:Number = 0;

		public function Chat()
		{
			super();
			registerCommand("version", "version", "Display game and Flash version information");
			registerCommand("credits", "credits", "hidden");
			registerCommand("latency", "latency", "Show round trip time of message from you to server");
			registerCommand("away", "away", "Toggle your away status. Users marked away show up in grey in the userlist");
			registerCommand("whisper", "whisper", "hidden");
			registerCommand("msg", "whisper", "hidden");
			registerCommand("w", "whisper", "hidden");
			registerCommand("logout", "logout", "hidden");
			registerCommand("stats", "whois", "<username> Display information about user - same as double click on username");
			registerCommand("whois", "whois", "hidden");
			registerCommand("uwho", "whois", "hidden");
			registerCommand("debug", "debug");
			registerCommand("lastgame", "lastGame");
			registerCommand("displayevents", "display_events", "Debugging tool. Copy output to forum message");
			registerCommand("ping", "user_ping", "<username> Calculate time it takes a message to reach a user and back");
			registerCommand("history", "history", "Display information about previous games");
			registerCommand("replay", "replay", "Replay the same type of game as you last created this session. ");
			if(g.user.access >= 255)
			{
				registerCommand("listrooms", "listRooms", "List all rooms you are in");
				registerCommand("listzones", "listZones", "List all zones on server");
				registerCommand("listroomsinzone", "listRoomsInZone", "[zonename] List all rooms in zone");
				registerCommand("kick", "kick", "Kick user - no real point in this since they can just refresh");
				registerCommand("broadcast", "broadcast", "Sends a message to all users on server in chat");
				registerCommand("system", "system", "Sends a message to all users on server with an alert window");
				registerCommand("alert", "alert", "Sends a message to the alert window");
				registerCommand("palert", "palert", "<username> <message> Send alert to user");
				registerCommand("nogames", "nogames", "Toggle ability for users to create games");
				registerCommand("serverstats", "server_stats", "Show zones, rooms, and users in rooms on server");
				registerCommand("gamestats", "game_stats", "Show game statistics");
				registerCommand("userinfo", "user_info", "Show information of remote user");
				registerCommand("emptygame", "empty_game", "Empty and destroy a game");
			}
		}

		public function display_events(param1:Object) : void
		{
			g.chat.noticeEvent(EventManager.toString());
		}

		public function version(param1:Object) : void
		{
			noticeEvent("FTW Version: " + g.version);
			noticeEvent("Flash Version: " + Capabilities.version);
			if(g.user.access >= 255)
			{
				noticeEvent("Memory usage: " + System.totalMemory + " Difference from start: " + (System.totalMemory - g.initialMemoryUsage));
			}
		}

		public function replay(param1:Object) : void
		{
			if(g.scene.activeScene != "Lobby")
			{
				noticeEvent("/" + param1.command + " only available in lobby.");
				return;
			}
			if(g.replay)
			{
				g.game = g.replay.clone();
				g.game.create();
			}
			else
			{
				noticeEvent("*** You have not created any games. You must create a game before replaying a game.");
			}
		}

		public function credits(param1:Object) : void
		{
			noticeEvent("Original Concept: levans and Richard Rusczyk");
			noticeEvent("Flash 7 Version: Art of Problem Solving (AoPS Incorporated)");
			noticeEvent("Converted to Flash 9 and ES4 by Golden Tree Academy");
		}

		public function latency(param1:Object) : void
		{
			noticeEvent("Latency: " + g.server.latency + " milliseconds");
		}

		override protected function ignore(param1:Object) : Boolean
		{
			var _loc_2:Boolean = super.ignore(param1);
			Net.callServer((g.URLPath + "PHP/Ignore.php?u=") + param1.target + "&s=" + (_loc_2 ? "1" : "0"));
			return true;
		}

		public function away(param1:Object) : void
		{
			g.away = !g.away;
			g.server.setAway(g.away);
			if(g.away)
			{
				g.server.manualAway = true;
			}
			if(g.away)
			{
				noticeEvent("You are now marked away");
			}
			else
			{
				noticeEvent("You are no longer away");
			}
		}

		public function logout(param1:Object) : void
		{
			g.server.toServerPlugin(g.auxiliary, "Logout", {});
			g.server.stopPingPong();
			g.scene.message("\n\n\n\n\n\nYou have been signed out");
		}

		override public function whisper(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0 || param1.str == null || param1.str.length == 0)
			{
				noticeEvent("Usage: /whisper <username> <message>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "W", {name:param1.target, m:StringUtil.trim(param1.str)});
			privateMessageEvent("To: " + param1.target, StringUtil.trim(param1.str));
		}

		public function history(param1:Object) : void
		{
			var _loc_2:EsObject = new EsObject();
			if(!(param1.target == null) && param1.target.length > 0 && g.user.access >= 255)
			{
				_loc_2.setString("username", param1.target);
			}
			else
			{
				_loc_2.setString("username", g.user.name);
			}
			_loc_2.setInteger("games", 6);
			g.server.esServerPlugin(g.auxiliary, "history", _loc_2);
		}

		public function user_ping(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /ping <username>");
				return;
			}
			var _loc_2:EsObject = new EsObject();
			_loc_2.setString("user", param1.target);
			_loc_2.setInteger("time", getTimer());
			g.server.esServerPlugin(g.auxiliary, "user_ping", _loc_2);
		}

		public function debug(param1:Object) : void
		{
			noticeEvent(g.debug ? "Debugging disabled" : "Debugging enabled");
			g.debug = !g.debug;
		}

		public function whois(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /" + param1.command + " <username>");
				return;
			}
			var _loc_2:Whois = new Whois(param1.target);
			g.scene.getScene().addChild(_loc_2);
		}

		public function server_stats(param1:Object) : void
		{
			g.server.toServerPlugin(g.auxiliary, "server_users", {});
		}

		public function game_stats(param1:Object) : void
		{
			g.server.toServerPlugin(g.manager, "game_stats", {});
		}

		public function user_info(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /userinfo <username>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "Userinfo", {user:param1.target});
		}

		public function empty_game(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /emptygame <game id>");
				return;
			}
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("game_id", int(param1.target));
			g.server.esServerPlugin(g.manager, "empty_game", _loc_2);
		}

		public function palert(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0 || param1.str == null || param1.str.length == 0)
			{
				noticeEvent("Usage: /palert <username> <message>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "PAlert", {name:param1.target, m:StringUtil.trim(param1.str)});
		}

		public function listRooms(param1:Object) : void
		{
			var _loc_2:Array = g.server.getRoomList();
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				noticeEvent((_loc_2[_loc_3].zonename + ":") + _loc_2[_loc_3].roomname);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function kick(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /kick <username>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "Kick", {user:param1.target});
		}

		public function broadcast(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /broadcast <message>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "Broadcast", {message:(param1.target + " ") + StringUtil.trim(param1.str)});
		}

		public function system(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /system <message>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "System", {message:(param1.target + " ") + StringUtil.trim(param1.str)});
		}

		public function alert(param1:Object) : void
		{
			if(param1.target == null || param1.target.length == 0)
			{
				noticeEvent("Usage: /alert <message>");
				return;
			}
			g.server.toServerPlugin(g.auxiliary, "Alert", {zonename:activeZoneName, message:(param1.target + " ") + StringUtil.trim(param1.str)});
		}

		public function nogames(param1:Object) : void
		{
			var _loc_2:String = null;
			if(param1.target == null || param1.target.length == 0)
			{
				g.server.toServerPlugin(g.manager, "NoGames", {reason:""});
				noticeEvent("New games now enabled");
			}
			else
			{
				_loc_2 = (param1.target + " ") + StringUtil.trim(param1.str);
				g.server.toServerPlugin(g.manager, "NoGames", {reason:_loc_2});
				g.server.toServerPlugin(g.auxiliary, "Alert", {zonename:activeZoneName, message:"* Games can not currently be created. " + _loc_2});
			}
		}

		public function lastGame(param1:Object) : void
		{
			if(g.game.id > 0)
			{
				noticeEvent("Last game this session was number " + g.game.id);
			}
			else
			{
				noticeEvent("You have not played a game this session.");
			}
		}

		override public function send(param1:String, param2:String = null, param3:String = null) : void
		{
			var _loc_4:Date = new Date();
			if(flood_mute != 0)
			{
				if(_loc_4.time <= (flood_mute + (1000 * 60) * 10))
				{
					noticeEvent("Sorry, you are currently muted");
					return;
				}
				flood_mute = 0;
			}
			if(checkFlood(4, 6))
			{
				var _loc_6:* = this.floodCount + 1;
				this.floodCount = _loc_6;
				if(floodCount > 2)
				{
					floodCount = 0;
					flood_mute = _loc_4.time;
					noticeEvent("You have been muted");
					g.server.toServerPlugin(g.auxiliary, "FloodMute", {id:g.user.id, expires:_loc_4.time + (1000 * 60) * 10});
				}
				else
				{
					noticeEvent("Whoa! Slow down!");
				}
			}
			else
			{
				var _loc_5:checkLanguage = checkLanguage(param1);
				languageCount = _loc_5;
				if(_loc_5 > 0)
				{
					g.server.toServerPlugin(g.auxiliary, "C", {msg:"Filtered: " + param1});
					if(languageCount > 2)
					{
						g.server.toServerPlugin(g.auxiliary, "Banme", {time:(60 * 24) * 7, reason:"Inappropriate language used in chat."});
					}
					else
					{
						if(languageCount == 1)
						{
							noticeEvent("Please, you have got to be more mature than that");
						}
						else
						{
							noticeEvent("Why oh why must you insist on such immature language? Next time, that's a banning.");
						}
					}
				}
				else
				{
					if(param1.length > 1)
					{
						g.server.toServerPlugin(g.auxiliary, "C", {msg:param1});
						super.send(param1, param2, param3);
					}
					else
					{
						if(param1.length <= 1)
						{
							noticeEvent("Message too short");
						}
					}
				}
			}
		}
	}
}
package Misc
{
	import flash.events.*;

	public class EventManager extends Object
	{
		private static var listeners:Array = new Array();

		final public static function exists(param1:EventDispatcher, param2:String, param3:Function) : Boolean
		{
			var _loc_4:int = listeners.length - 1;
			while(_loc_4 >= 0)
			{
				if(param1 == listeners[_loc_4].object && param2 == listeners[_loc_4].type && param3 == listeners[_loc_4].listener)
				{
					return true;
				}
				_loc_4 = _loc_4 - 1;
			}
			return false;
		}

		final public static function add(param1:EventDispatcher, param2:String, param3:Function, param4:String = null) : void
		{
			var _loc_5:Object = null;
			if(!(EventManager.exists(param1, param2, param3)))
			{
				param1.addEventListener(param2, param3);
				_loc_5 = new Object();
				_loc_5.object = param1;
				_loc_5.type = param2;
				_loc_5.listener = param3;
				_loc_5.description = param4;
				_loc_5.time = (new Date()).toString();
				EventManager.listeners.push(_loc_5);
			}
		}

		final public static function remove(param1:EventDispatcher = null, param2:String = null, param3:Function = null) : void
		{
			var _loc_4:int = listeners.length - 1;
			while(_loc_4 >= 0)
			{
				if(param1 == listeners[_loc_4].object)
				{
					if(param2 == null || param2 == EventManager.String(listeners[_loc_4].type))
					{
						if(param3 == null || listeners[_loc_4].listener == param3)
						{
							EventManager.EventDispatcher(listeners[_loc_4].object).removeEventListener(EventManager.String(listeners[_loc_4].type), listeners[_loc_4].listener);
							listeners.splice(_loc_4, 1);
						}
					}
				}
				_loc_4 = _loc_4 - 1;
			}
		}

		final public static function toString(param1:String = null) : String
		{
			var _loc_2:String = "";
			var _loc_3:int = listeners.length - 1;
			while(_loc_3 >= 0)
			{
				if(param1 == null || (EventManager.String(listeners[_loc_3].category).substr(0, param1.length)) == param1)
				{
					_loc_2 = _loc_2 + (_loc_3 + ": ");
					_loc_2 = _loc_2 + (listeners[_loc_3].time + "\t");
					_loc_2 = _loc_2 + (listeners[_loc_3].object + "\t\t");
					_loc_2 = _loc_2 + listeners[_loc_3].type;
					if(listeners[_loc_3].description != null)
					{
						_loc_2 = _loc_2 + "\t\t" + listeners[_loc_3].description;
					}
					_loc_2 = _loc_2 + "\n";
				}
				_loc_3 = _loc_3 - 1;
			}
			return _loc_2;
		}

		public function EventManager()
		{
			super();
		}
	}
}
package Misc
{
	import Scene.*;
	import Type.*;
	import com.adobe.utils.*;
	import flash.display.*;
	import flash.system.*;
	import net.theyak.util.*;

	public class g extends Object
	{
		public static var version:String = "2018-03-28 4:00pm";
		public static var auxiliary:String = "Auxiliary";
		public static var manager:String = "Manager";
		public static var scene:Manager;
		public static var host:String = "www.artofproblemsolving.com";
		public static var remote:String = "www.artofproblemsolving.com";
		public static var root:String = "/m/ftw/";
		public static var URLPath:String = "http://" + host + root;
		public static var phpPath:String = URLPath + "PHP/";
		public static var latexPath:String = "http://www.artofproblemsolving.com/Edutainment/as3/GameImages/";
		public static var stageWidth:int;
		public static var stageHeight:int;
		public static var port:int = 9898;
		public static var ip:String = "127.0.0.1";
		public static var user:User = new User();
		public static var game:FTW = new FTW();
		public static var replay:FTW = null;
		private static var defaultZoneName:String = "FTW";
		private static var _activeZoneName:String = g.defaultZoneName;
		private static var _activeRoomName:String = "Lobby";
		public static var server:Server;
		public static var chat:Chat;
		public static var initialMemoryUsage:uint;
		public static var away:Boolean = false;
		public static var debug:Boolean = true;

		final public static function set activeZoneName(param1:String) : void
		{
			g._activeZoneName = param1;
			g.chat.activeZoneName = param1;
		}

		final public static function set activeRoomName(param1:String) : void
		{
			g._activeRoomName = param1;
			g.chat.activeRoomName = param1;
		}

		final public static function get activeZoneName() : String
		{
			return g._activeZoneName;
		}

		final public static function get activeRoomName() : String
		{
			return g._activeRoomName;
		}

		final public static function debuglog(param1:String) : void
		{
			g.chat;
			if(g.chat && g.debug)
			{
				g.chat.noticeEvent(param1);
			}
		}

		final public static function sendToLogFile(param1:String) : void
		{
			Net.callServer((g.phpPath + "log.php?log=") + param1);
		}

		final public static function clean_answer(param1:String) : String
		{
			param1 = StringUtil.trim(param1);
			param1 = param1.split("$").join("");
			param1 = g.convert_fraction(param1);
			param1 = param1.split("\\").join("");
			param1 = param1.split("{").join("");
			param1 = param1.split("}").join("");
			param1 = param1.split(",").join("");
			param1 = (param1.split(" ")).join("");
			if(param1.charAt(0) == ".")
			{
				param1 = "0" + param1;
			}
			return param1.toLowerCase();
		}

		final public static function convert_fraction(param1:String)
		{
			var _loc_2:Array = null;
			var _loc_3:RegExp = null;
			var _loc_4:String = "";
			param1 = param1.toLowerCase();
			var _loc_5:int = param1.indexOf("\\frac");
			if(_loc_5 < 0)
			{
				_loc_5 = param1.indexOf("\\dfrac");
			}
			if(_loc_5 > -1)
			{
				if(_loc_5 > 0)
				{
					_loc_4 = param1.substr(0, _loc_5);
					_loc_4 = StringUtil.trim(_loc_4);
					if(_loc_4.length > 1)
					{
						_loc_4 = _loc_4 + " ";
					}
					param1 = param1.substr(_loc_5);
					param1 = StringUtil.trim(param1);
				}
				_loc_3 = new RegExp("\\\\[d]?frac[\\s]?(\\d)(\\d)");
				_loc_2 = param1.match(_loc_3);
				if(!(_loc_2 == null) && _loc_2.length == 3)
				{
					return (_loc_4 + _loc_2[1]) + "/" + _loc_2[2];
				}
				_loc_3 = new RegExp("\\\\[d]?frac[\\s]?\\{([^\\}]*)\\}\\{([^\\}]*)\\}");
				_loc_2 = param1.match(_loc_3);
				if(!(_loc_2 == null) && _loc_2.length == 3)
				{
					return (_loc_4 + _loc_2[1]) + "/" + _loc_2[2];
				}
				_loc_3 = new RegExp("\\\\[d]?frac[\\s]?(\\d)\\{([^\\}]*)\\}");
				_loc_2 = param1.match(_loc_3);
				if(!(_loc_2 == null) && _loc_2.length == 3)
				{
					return (_loc_4 + _loc_2[1]) + "/" + _loc_2[2];
				}
				_loc_3 = new RegExp("\\\\[d]?frac[\\s]?\\{([^\\}]*)\\}(\\d)");
				_loc_2 = param1.match(_loc_3);
				if(!(_loc_2 == null) && _loc_2.length == 3)
				{
					return (_loc_4 + _loc_2[1]) + "/" + _loc_2[2];
				}
			}
			return param1;
		}

		public function g(param1:MovieClip)
		{
			super();
			server = new Server();
			initialMemoryUsage = System.totalMemory;
			g.stageWidth = param1.stage.stageWidth;
			g.stageHeight = param1.stage.stageHeight;
		}
	}
}
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
package Misc
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;

	public class SmallAd extends Sprite
	{
		private var interval:uint = 0;
		private var ad:int;
		private var ads:Array;
		private var _text:TextField;

		public function SmallAd()
		{
			super();
			ads = new Array();
			var _loc_1:Object = new Object();
			_loc_1.name = "Art of Problem Solving, Volume 1: The Basics";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=100";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Art of Problem Solving, Volume 1: and Beyond";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=102";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Algebra by Richard Rusczyk";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=200";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Counting and Probability by David Patrick";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=202";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Geometry by Richard Rusczyk";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=204";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Number Theory by Mathew Crawford";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=206";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "MATHCOUNTS books";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_CP_MC.php";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "AMC Preparation books";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_CP_AMC.php";
			ads.push(_loc_1);
			addEventListener(MouseEvent.CLICK, onAdClick);
			addEventListener(Event.ADDED, startTimer);
			addEventListener(Event.REMOVED, destroy);
		}

		private function updateAd() : void
		{
			ad = Math.floor(Math.random() * ads.length);
			_text.text = ads[ad].name;
		}

		private function onAdClick(param1:Event) : void
		{
			navigateToURL(new URLRequest(ads[ad].url), "_blank");
		}

		private function startTimer(param1:Event) : void
		{
			trace("Start timer");
			updateAd();
			interval = setInterval(updateAd, 60000);
		}

		private function destroy(param1:Event) : void
		{
			trace("Destroy");
			if(interval != 0)
			{
				clearInterval(interval);
			}
			removeEventListener(MouseEvent.CLICK, onAdClick);
			removeEventListener(Event.ADDED, startTimer);
			removeEventListener(Event.REMOVED, destroy);
		}
	}
}
package Misc
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import net.theyak.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class Whois extends Sprite
	{
		private var _alert:YakAlert;
		private var _dialog:YakDialog;
		private var _username:String;

		public function Whois(param1:String)
		{
			var username:String = param1;
			super();
			_username = username;
			var request:URLRequest = new URLRequest((g.phpPath + "Whois.php?u=") + (escape(username).replace(new RegExp("\\+", "g"), "%2B")));
			var variables:URLLoader = new URLLoader();
			variables.dataFormat = URLLoaderDataFormat.VARIABLES;
			variables.addEventListener(Event.COMPLETE, userLoaded);
			variables.addEventListener(IOErrorEvent.IO_ERROR, userLoadedError);
			variables.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			try
			{
				variables.load(request);
			}
			catch(err:SecurityError)
			{
				error("Security error");
			}
		}

		private function round(param1:String) : String
		{
			return YakMath.round_string(param1, 0);
		}

		private function userLoaded(param1:Event) : void
		{
			var _loc_3:uint = 0;
			var _loc_4:uint = 0;
			var _loc_5:uint = 0;
			var _loc_6:uint = 0;
			var _loc_7:uint = 0;
			var _loc_2:URLLoader = URLLoader(param1.target);
			if(_loc_2.data.error)
			{
				error(_loc_2.data.error);
			}
			else
			{
				_dialog = new YakDialog("Profile for " + _username, 425, 400);
				_dialog.addEventListener("DialogEvent", onDialogClosed);
				header("For The Win", 4);
				header("Countdown", 86);
				header("Ratings", 168);
				header("Badges", 230);
				field("Played", _loc_2.data.ftw_played, 20, 24, 14483456);
				field("Year", _loc_2.data.ftw_played_year, 120, 24, 14483456);
				field("Month", _loc_2.data.ftw_played_month, 220, 24, 14483456);
				field("Week", _loc_2.data.ftw_played_week, 320, 24, 14483456);
				field("Won", _loc_2.data.ftw_won, 20, 41, 12255232);
				field("Year", _loc_2.data.ftw_won_year, 120, 41, 12255232);
				field("Month", _loc_2.data.ftw_won_month, 220, 41, 12255232);
				field("Week", _loc_2.data.ftw_won_week, 320, 41, 12255232);
				field("Rating", round(_loc_2.data.ftw_rating), 20, 58, 10027008);
				field("Year", round(_loc_2.data.ftw_rating_year), 120, 58, 10027008);
				field("Month", round(_loc_2.data.ftw_rating_month), 220, 58, 10027008);
				field("Week", round(_loc_2.data.ftw_rating_week), 320, 58, 10027008);
				field("Played", _loc_2.data.cd_played, 20, 106, 14483456);
				field("Year", _loc_2.data.cd_played_year, 120, 106, 14483456);
				field("Month", _loc_2.data.cd_played_month, 220, 106, 14483456);
				field("Week", _loc_2.data.cd_played_week, 320, 106, 14483456);
				field("Won", _loc_2.data.cd_won, 20, 123, 12255232);
				field("Year", _loc_2.data.cd_won_year, 120, 123, 12255232);
				field("Month", _loc_2.data.cd_won_month, 220, 123, 12255232);
				field("Week", _loc_2.data.cd_won_week, 320, 123, 12255232);
				field("Rating", round(_loc_2.data.cd_rating), 20, 140, 10027008);
				field("Year", round(_loc_2.data.cd_rating_year), 120, 140, 10027008);
				field("Month", round(_loc_2.data.cd_rating_month), 220, 140, 10027008);
				field("Week", round(_loc_2.data.cd_rating_week), 320, 140, 10027008);
				field("Overall", round(_loc_2.data.rating), 20, 188, 14483456);
				field("Highest", round(_loc_2.data.rating_highest), 120, 188, 14483456);
				field("Lowest", round(_loc_2.data.rating_lowest), 220, 188, 14483456);
				_loc_3 = 0;
				_loc_4 = 0;
				_loc_5 = 0;
				if(uint(_loc_2.data.rating_highest) > 2250)
				{
					_loc_5 = 5;
				}
				else
				{
					if(uint(_loc_2.data.rating_highest) > 2000)
					{
						_loc_5 = 4;
					}
					else
					{
						if(uint(_loc_2.data.rating_highest) > 1750)
						{
							_loc_5 = 3;
						}
						else
						{
							if(uint(_loc_2.data.rating_highest) > 1500)
							{
								_loc_5 = 2;
							}
							else
							{
								if(uint(_loc_2.data.rating_highest) > 1325)
								{
									_loc_5 = 1;
								}
							}
						}
					}
				}
				_loc_6 = uint(_loc_2.data.cd_played) + uint(_loc_2.data.ftw_played);
				if(_loc_6 > 1500)
				{
					_loc_4 = 5;
				}
				else
				{
					if(_loc_6 > 1000)
					{
						_loc_4 = 4;
					}
					else
					{
						if(_loc_6 > 750)
						{
							_loc_4 = 3;
						}
						else
						{
							if(_loc_6 > 350)
							{
								_loc_4 = 2;
							}
							else
							{
								if(_loc_6 > 100)
								{
									_loc_4 = 1;
								}
							}
						}
					}
				}
				_loc_7 = uint(_loc_2.data.cd_won) + uint(_loc_2.data.ftw_won);
				if(_loc_7 > 1000)
				{
					_loc_3 = 5;
				}
				else
				{
					if(_loc_7 > 750)
					{
						_loc_3 = 4;
					}
					else
					{
						if(_loc_7 > 500)
						{
							_loc_3 = 3;
						}
						else
						{
							if(_loc_7 > 225)
							{
								_loc_3 = 2;
							}
							else
							{
								if(_loc_7 > 50)
								{
									_loc_3 = 1;
								}
							}
						}
					}
				}
				stars("Games Won", new StarWon(32, 32), _loc_3, 250);
				stars("Games Played", new StarGames(32, 32), _loc_4, 285);
				stars("Highest Rating", new StarRating(32, 32), _loc_5, 320);
				_dialog.center(g.scene.getScene());
				addChild(_dialog);
			}
		}

		private function stars(param1:String, param2:BitmapData, param3:uint, param4:uint)
		{
			var _loc_8:Bitmap = null;
			var _loc_5:TextField = new TextField();
			var _loc_6:TextFormat = new TextFormat();
			_loc_5.width = 130;
			_loc_5.text = param1;
			_loc_5.y = param4 + 6;
			_loc_6.align = "right";
			_loc_6.size = 14;
			_loc_6.bold = true;
			_loc_6.font = "_sans";
			_loc_5.setTextFormat(_loc_6);
			_dialog.canvas.addChild(_loc_5);
			var _loc_7:* = 135;
			while(param3 > 0)
			{
				_loc_8 = new Bitmap(param2);
				_loc_8.x = _loc_7;
				_loc_8.y = param4;
				_dialog.canvas.addChild(_loc_8);
				_loc_7 = _loc_7 + 36;
				param3 = param3 - 1;
			}
		}

		private function header(param1:String, param2:uint) : void
		{
			var _loc_3:TextField = new TextField();
			_loc_3.text = param1;
			_loc_3.y = param2;
			_loc_3.x = 4;
			_loc_3.width = 300;
			var _loc_4:TextFormat = new TextFormat();
			_loc_4.font = "_sans";
			_loc_4.size = 16;
			_loc_4.align = "left";
			_loc_4.bold = true;
			_loc_3.setTextFormat(_loc_4);
			_dialog.canvas.addChild(_loc_3);
		}

		private function field(param1:String, param2:String, param3:uint, param4:uint, param5:uint = 0)
		{
			var _loc_6:TextField = new TextField();
			var _loc_7:TextFormat = new TextFormat();
			var _loc_8:TextFormat = new TextFormat();
			_loc_6.x = param3;
			_loc_6.y = param4;
			_loc_6.width = 90;
			if(param2 != null)
			{
				_loc_6.text = " " + param1 + ": " + param2;
			}
			else
			{
				_loc_6.text = " " + param1 + ": ";
			}
			_loc_7.font = "_sans";
			_loc_7.size = 12;
			_loc_7.bold = true;
			_loc_7.color = param5;
			_loc_8.font = "_sans";
			_loc_8.color = param5;
			_loc_8.bold = false;
			_loc_6.setTextFormat(_loc_8, param1.length + 2, _loc_6.text.length);
			_loc_6.setTextFormat(_loc_7, 0, param1.length + 2);
			_loc_6.selectable = false;
			_dialog.canvas.addChild(_loc_6);
		}

		private function userLoadedError(param1:Event) : void
		{
			error("Load Error");
		}

		private function securityError(param1:Event) : void
		{
			error("A security error");
		}

		private function error(param1:String) : void
		{
			_alert = new YakAlert(param1, "Error", "OK");
			_alert.center(g.scene.getScene());
			_alert.addEventListener("AlertEvent", onAlertButton);
			_alert.addEventListener("DialogEvent", onAlertClosed);
			g.scene.getScene().addChild(_alert);
		}

		private function onAlertClosed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				_alert.removeEventListener("AlertEvent", onAlertButton);
				_alert.removeEventListener("DialogEvent", onAlertClosed);
				close(param1);
			}
		}

		private function onDialogClosed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				_dialog.removeEventListener("DialogEvent", onDialogClosed);
				close(param1);
			}
		}

		private function onAlertButton(param1:AlertEvent) : void
		{
			_alert.removeEventListener("AlertEvent", onAlertButton);
			_alert.removeEventListener("DialogEvent", onAlertClosed);
			close(param1);
		}

		private function close(param1:Event) : void
		{
			parent.removeChild(this);
		}
	}
}
