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
