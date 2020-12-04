package net.theyak.chat
{
	import Misc.*;
	import com.adobe.utils.*;
	import fl.controls.*;
	import flash.utils.*;
	import net.theyak.util.*;

	public class Chat extends Object
	{
		private static var language_count:uint = 0;
		public static var ACTION_MESSAGE_CODE:Number = 253;
		public static var SYSTEM_MESSAGE_CODE:Number = 254;
		public var buffer:String = "";
		private var output:TextArea = null;
		private var cmdChar:String = "/";
		private var publicMessageColor:* = "#0000CC";
		private var noticeMessageColor:* = "#009900";
		private var privateMessageColor:* = "#CC0000";
		private var systemMessageColor:* = "#00CCCC";
		private var commands:Array;
		private var systemCommands:Array;
		private var history:Array;
		private var historyPointer:int = 0;
		public var ignores:Array;
		private var _muted:Boolean = false;
		private var _displayTime:Boolean = true;
		private var _displayChat:Boolean = true;
		public var activeRoomName:String;
		public var activeZoneName:String;
		private var language:Array;
		private var languageAnywhere:Array;
		private var languageWord:Array;

		public function Chat(param1:TextArea = null)
		{
			commands = new Array();
			systemCommands = new Array();
			history = new Array();
			ignores = new Array();
			language = new Array("It's sad that people swear. It's more sad that you are looking for the swears in the compiled code.");
			languageAnywhere = new Array("fuck", "dafuq", "cunt", "bastard", "nigger", "vagina", "penis", "f u c k", "p3n1s", "p3n!s", "nigger", "bitch", "shit", "f*ck", "asshole", "pussy", "dyke", "whore", "damnit", "omfg", "wtf", "retard", "faggot");
			languageWord = new Array("fuk", "fuq", "gay", "fuk", "ffs", "cock", "damn", "ass", "cum", "fag", "slut", "twat");
			super();
			this.output = param1;
			registerCommand("help", "help", "Display this help");
			registerCommand("me", "me", "<action> Perform an action");
			registerCommand("whisper", "whisper", "<username> <message> Send private message to user");
			registerCommand("w", "whisper", "Alias for /whisper");
			registerCommand("msg", "whisper", "Alias for /whisper");
			registerCommand("ignore", "ignore", "<username> Toggles ignore status for a user");
			registerCommand("ignorelist", "ignoreList", "List users you have ignored");
			registerCommand("clearchat", "clearchat", "Clears the chat area");
			registerCommand("cc", "clearchat", "Alias for /clearchat");
		}

		public function getOutput() : TextArea
		{
			return this.output;
		}

		public function setOutput(param1:TextArea) : void
		{
			this.output = param1;
			display();
		}

		public function clear() : void
		{
			output.text = "";
			buffer = "";
			output.invalidate();
		}

		public function send(param1:String, param2:String = null, param3:String = null) : void
		{
			var _loc_4:Object = null;
			var _loc_5:Boolean = false;
			var _loc_6:uint = 0;
			var _loc_7:Object = null;
			var _loc_8:String = null;
			if(param1 == null || _muted)
			{
				return;
			}
			if(param2 == null)
			{
				param2 = activeZoneName;
			}
			if(param3 == null)
			{
				param3 = activeRoomName;
			}
			param1 = StringUtil.trim(param1);
			if(param1.length > 255)
			{
				param1 = param1.substr(0, 255);
			}
			updateHistory(param1);
			if(param1.length == 0)
			{
				return;
			}
			if(param1.charAt(0) == cmdChar.charAt(0))
			{
				_loc_4 = parse(param1.substr(1));
				_loc_5 = false;
				_loc_6 = 0;
				while(_loc_6 < commands.length)
				{
					if(commands[_loc_6].command == _loc_4.command)
					{
						_loc_7 = commands[_loc_6].scope;
						_loc_8 = commands[_loc_6].funcName;
						var _loc_9:Object = _loc_7;
						_loc_9[_loc_8](_loc_4);
						_loc_5 = true;
						break;
					}
					_loc_6 = _loc_6 + 1;
				}
				if(!_loc_5)
				{
					noticeEvent("Invalid command: " + _loc_4.command);
				}
			}
			else
			{
				g.server.sendPublicMessage(param1, param2, param3);
			}
		}

		public function forceSend(param1:String, param2:String = null, param3:String = null)
		{
			var _loc_4:* = _muted;
			_muted = false;
			send(param1, param2, param3);
			_muted = _loc_4;
		}

		public function publicMessageEvent(param1:String, param2:String, param3:String, param4:String) : void
		{
			if(ignored(param1) < 0)
			{
				if(param2.charAt(0) <= "~")
				{
					if(param3 == activeZoneName && param4 == activeRoomName)
					{
						addBuffer("<font color=\"" + publicMessageColor + "\">" + param1 + "</font>: " + wrap_url(StringEx.htmlspecialchars(param2)));
					}
					else
					{
						addBuffer("<font color=\"" + publicMessageColor + "\">" + param1 + " (" + param3 + ":" + param4 + ")</font>: " + wrap_url(StringEx.htmlspecialchars(param2)));
					}
				}
				else
				{
					if(param2.charCodeAt(0) == ACTION_MESSAGE_CODE)
					{
						addBuffer("<font color=\"" + publicMessageColor + "\" >* " + param1 + " " + StringEx.htmlspecialchars(param2.substr(1)) + "</font>");
					}
					else
					{
						if(param2.charCodeAt(0) == SYSTEM_MESSAGE_CODE)
						{
							systemMessageEvent(param1, param2);
						}
					}
				}
				if(_displayChat)
				{
					display();
				}
			}
		}

		public function noticeEvent(param1:String) : void
		{
			addBuffer("<font color=\"" + noticeMessageColor + "\">" + StringEx.htmlspecialchars(param1) + "</font>&nbsp;", true);
			display();
		}

		public function privateMessageEvent(param1:String, param2:String) : void
		{
			if(param2.charCodeAt(0) == SYSTEM_MESSAGE_CODE)
			{
				systemMessageEvent(param1, param2);
			}
			else
			{
				if(ignored(param1) < 0)
				{
					addBuffer("<font color=\"" + privateMessageColor + "\">[" + param1 + "]</font> " + wrap_url(StringEx.htmlspecialchars(param2)));
					if(_displayChat)
					{
						display();
					}
				}
			}
		}

		public function systemMessageEvent(param1:String, param2:String) : void
		{
			var _loc_5:Object = null;
			var _loc_6:String = null;
			while(param2.charCodeAt(0) == SYSTEM_MESSAGE_CODE)
			{
				param2 = param2.substr(1);
			}
			param2 = StringUtil.trim(param2);
			var _loc_3:Object = parse(param2);
			var _loc_4:uint = 0;
			while(_loc_4 < systemCommands.length)
			{
				if(systemCommands[_loc_4].command == _loc_3.command)
				{
					_loc_5 = systemCommands[_loc_4].scope;
					_loc_6 = systemCommands[_loc_4].funcName;
					var _loc_7:Object = _loc_5;
					_loc_7[_loc_6](param1, _loc_3);
					break;
				}
				_loc_4 = _loc_4 + 1;
			}
		}

		public function whisper(param1:Object) : void
		{
			if(param1.str == undefined || param1.str.length <= 0 || param1.target == undefined || param1.target.length <= 0)
			{
				noticeEvent("Usage: " + param1.command + " <username> <msg>");
				return;
			}
			g.server.sendPrivateMessage(param1.target, param1.str);
			privateMessageEvent("To: " + param1.target, param1.str);
		}

		private function me(param1:Object) : void
		{
			if(param1.target == undefined || param1.target.length <= 0)
			{
				noticeEvent("Usage: " + param1.command + " <msg>");
				return;
			}
			g.server.sendPublicMessage((String.fromCharCode(ACTION_MESSAGE_CODE) + param1.target) + " " + param1.str, activeZoneName, activeRoomName);
		}

		protected function ignore(param1:Object) : Boolean
		{
			if(param1.target == undefined || param1.target.length <= 0)
			{
				noticeEvent("Usage: " + param1.command + " <username>");
				return false;
			}
			var _loc_2:int = ignored(param1.target);
			if(_loc_2 >= 0)
			{
				noticeEvent(param1.target + " removed from ignore list");
				ignores.splice(_loc_2, 1);
				return false;
			}
			noticeEvent(param1.target + " added to ignore list");
			ignores.push(param1.target.toLowerCase());
			return true;
		}

		protected function ignoreList(param1:Object) : void
		{
			noticeEvent("Currently ignored: " + (ignores.join(", ")));
		}

		public function ignored(param1:String) : int
		{
			param1 = param1.toLowerCase();
			var _loc_2:uint = 0;
			while(_loc_2 < ignores.length)
			{
				if(ignores[_loc_2] == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		private function clearchat(param1:Object) : void
		{
			clear();
		}

		public function help(param1:Object) : void
		{
			var _loc_3:String = null;
			var _loc_2:uint = 0;
			while(_loc_2 < commands.length)
			{
				if(commands[_loc_2].help != "hidden")
				{
					_loc_3 = (cmdChar + commands[_loc_2].command) + " ";
					if(commands[_loc_2].help != null)
					{
						_loc_3 = _loc_3 + commands[_loc_2].help;
					}
					noticeEvent(_loc_3);
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function completeName(param1:String, param2:String, param3:String) : String
		{
			var _loc_4:int = 0;
			if(param1.length <= 0)
			{
				return "";
			}
			var _loc_5:int = param1.length - 1;
			while(_loc_5 >= 0)
			{
				if(param1.charAt(_loc_5) == " ")
				{
					_loc_5++;
					break;
				}
				_loc_5 = _loc_5 - 1;
			}
			if(_loc_5 < 0)
			{
				_loc_5 = 0;
			}
			var _loc_6:String = param1.substr(_loc_5).toLowerCase();
			var _loc_7:Array = g.server.getUsersInRoom(param2, param3);
			var _loc_8:uint = 0;
			while(_loc_8 < _loc_7.length)
			{
				if((_loc_7[_loc_8].name.toLowerCase().substr(0, _loc_6.length)) == _loc_6)
				{
					if((_loc_7[_loc_8].name.indexOf(" ")) > -1)
					{
						return (param1.substr(0, param1.length - _loc_6.length)) + "\"" + _loc_7[_loc_8].name + "\"";
					}
					return (param1.substr(0, param1.length - _loc_6.length)) + _loc_7[_loc_8].name;
				}
				_loc_8 = _loc_8 + 1;
			}
			return param1;
		}

		public function parse(param1:String) : Object
		{
			var _loc_2:Object = new Object();
			_loc_2.command = "";
			_loc_2.target = "";
			_loc_2.str = "";
			if(param1 == null || param1.length == 0)
			{
				return _loc_2;
			}
			var _loc_3:int = 0;
			while(param1.charCodeAt(_loc_3) == cmdChar.charCodeAt(0) || param1.charCodeAt(_loc_3) <= 32 && _loc_3 < param1.length)
			{
				_loc_3++;
			}
			param1 = StringUtil.trim(param1);
			_loc_3 = 0;
			while(param1.charCodeAt(_loc_3) > 32 && _loc_3 < param1.length)
			{
				_loc_3++;
			}
			_loc_2.command = (param1.substr(0, _loc_3)).toLowerCase();
			while(param1.charCodeAt(_loc_3) <= 32 && _loc_3 < param1.length)
			{
				_loc_3++;
			}
			var _loc_4:Boolean = false;
			var _loc_5:Boolean = false;
			var _loc_6:int = _loc_3;
			if(_loc_6 < param1.length)
			{
				if(param1.charAt(_loc_6) == "\"")
				{
					_loc_6++;
					_loc_6++;
					_loc_4 = true;
				}
				while(_loc_4)
				{
					_loc_6++;
				}
				_loc_2.target = param1.charCodeAt(_loc_6) > 32 || param1.substr(_loc_6, _loc_6 - _loc_6);
				if(_loc_6 < param1.length)
				{
					_loc_2.str = StringUtil.trim(param1.substr(_loc_6));
				}
			}
			return _loc_2;
		}

		public function registerCommand(param1:String, param2:String, param3:String = null, param4:Object = null) : void
		{
			if(param4 == null)
			{
			}
			var _loc_5:Object = new Object();
			_loc_5.command = param1.toLowerCase();
			_loc_5.funcName = param2;
			_loc_5.scope = param4;
			_loc_5.help = param3;
			commands.push(_loc_5);
		}

		public function registerSystemCommand(param1:String, param2:String, param3:Object) : void
		{
			if(param3 == null)
			{
			}
			var _loc_4:Object = new Object();
			_loc_4.command = param1.toLowerCase();
			_loc_4.funcName = param2;
			_loc_4.scope = param3;
			systemCommands.push(_loc_4);
		}

		private function updateHistory(param1:String) : void
		{
			if(history.length >= 10)
			{
				history.splice(0, 1);
			}
			var _loc_2:Object = new Object();
			_loc_2.Text = param1;
			_loc_2.Time = getTimer();
			history.push(_loc_2);
			historyPointer = -1;
		}

		public function getPrevious() : String
		{
			if(history.length <= 0)
			{
				return "";
			}
			if(historyPointer < 0)
			{
				historyPointer = history.length;
			}
			var _loc_2:* = this.historyPointer - 1;
			this.historyPointer = _loc_2;
			if(historyPointer < 0)
			{
				historyPointer = history.length - 1;
			}
			return history[historyPointer].Text;
		}

		public function getNext() : String
		{
			if(historyPointer == -1 || historyPointer == (history.length - 1))
			{
				return "";
			}
			var _loc_2:* = this.historyPointer + 1;
			this.historyPointer = _loc_2;
			return history[historyPointer].Text;
		}

		public function checkFlood(param1:int, param2:int) : Boolean
		{
			var _loc_3:int = 0;
			_loc_3 = history.length;
			while(param1 && _loc_3 >= 0)
			{
				_loc_3 = _loc_3 - 1;
				param1 = param1 - 1;
			}
			if(_loc_3 < param1)
			{
				return false;
			}
			var _loc_4:int = history[_loc_3].Time;
			if((_loc_4 + (param2 * 1000)) > getTimer())
			{
				return true;
			}
			return false;
		}

		public function checkLanguage(param1:String) : uint
		{
			var _loc_4:uint = 0;
			param1 = param1.toLowerCase();
			var _loc_2:uint = 0;
			while(_loc_2 < languageAnywhere.length)
			{
				if(param1.indexOf(languageAnywhere[_loc_2]) >= 0)
				{
					var _loc_6:* = this.language_count + 1;
					this.language_count = _loc_6;
					return language_count;
				}
				_loc_2 = _loc_2 + 1;
			}
			var _loc_3:Array = param1.split(" ");
			_loc_2 = 0;
			while(_loc_2 < languageWord.length)
			{
				_loc_4 = 0;
				while(_loc_4 < _loc_3.length)
				{
					if(_loc_3[_loc_4].toLowerCase() == languageWord[_loc_2])
					{
						var _loc_6:* = this.language_count + 1;
						this.language_count = _loc_6;
						return language_count;
					}
					_loc_4 = _loc_4 + 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return 0;
		}

		private function addBuffer(param1:String, param2:Boolean = false) : void
		{
			if(buffer.length > 0)
			{
				buffer = buffer + "\n";
			}
			buffer = buffer + (getTime() + " ");
			buffer = buffer + param1;
		}

		public function set mute(param1:Boolean) : void
		{
			_muted = param1;
		}

		public function get mute() : Boolean
		{
			return _muted;
		}

		public function set displayTime(param1:Boolean) : void
		{
			_displayTime = param1;
		}

		public function get displayTime() : Boolean
		{
			return _displayTime;
		}

		public function set displayChat(param1:Boolean) : void
		{
			_displayChat = param1;
			if(param1 == true)
			{
				display();
			}
		}

		public function get displayChat() : Boolean
		{
			return _displayChat;
		}

		private function getTime() : String
		{
			var _loc_1:Date = null;
			var _loc_2:String = null;
			if(_displayTime)
			{
				_loc_1 = new Date();
				_loc_2 = "[" + _loc_1.getHours() + ":";
				if(_loc_1.getMinutes() < 10)
				{
					_loc_2 = _loc_2 + "0" + _loc_1.getMinutes() + "] ";
				}
				else
				{
					_loc_2 = _loc_2 + (_loc_1.getMinutes() + "] ");
				}
				return _loc_2;
			}
			else
			{
				return "";
			}
		}

		private function display() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:Boolean = false;
			if(buffer.length > 32768)
			{
				buffer = buffer.substr(4096);
				_loc_1 = buffer.indexOf("<font");
				if(_loc_1 > -1)
				{
					buffer = buffer.substr(_loc_1);
				}
			}
			if(output)
			{
				_loc_2 = output.verticalScrollPosition == output.maxVerticalScrollPosition;
				output.htmlText = buffer;
			}
		}

		public function wrap_url(param1:String) : String
		{
			var _loc_3:int = 0;
			var _loc_4:String = null;
			var _loc_5:String = null;
			var _loc_2:int = param1.indexOf("http://");
			if(_loc_2 < 0)
			{
				_loc_2 = param1.indexOf("https://");
			}
			if(_loc_2 >= 0)
			{
				_loc_3 = param1.indexOf(" ", _loc_2);
				if(_loc_3 < 6)
				{
					_loc_3 = param1.length;
				}
				_loc_4 = param1.substr(_loc_2, _loc_3 - _loc_2);
				_loc_4 = _loc_4.replace(new RegExp("[\\\"]", "g"), "");
				_loc_5 = "<a target=\"_blank\" href=\"" + _loc_4 + "\"><u>" + _loc_4 + "</u></a>";
				param1 = (param1.substr(0, _loc_2)) + _loc_5 + (param1.substr(_loc_3, param1.length - _loc_3));
			}
			return param1;
		}
	}
}
