package Scene
{
	import Misc.*;
	import com.adobe.utils.*;
	import fl.controls.*;
	import fl.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	import net.theyak.util.*;

	public class BaseChat extends Sprite
	{
		public static var class_name:* = "Scene.BaseChat";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		protected var _tOutput:TextArea;
		public var _tInput:TextInput;
		protected var _tAlert:TextArea;
		protected var _cbPhrases:ComboBox;
		protected var _btnPhrases:Button;
		protected var _muted:Boolean;
		protected var _lastMessage:int;

		public function BaseChat()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.size = g.user.font_size;
			_loc_1.font = g.user.font;
			_loc_1.leading = g.user.leading;
			_tOutput = new TextArea();
			_tOutput.setSize(501, 129);
			_tOutput.x = 10;
			_tOutput.y = 379;
			_tOutput.editable = false;
			_tOutput.setStyle("textFormat", _loc_1);
			addChild(_tOutput);
			_tInput = new TextInput();
			_tInput.setSize(501, 22);
			_tInput.x = 10;
			_tInput.y = 507.90;
			_tInput.maxChars = 256;
			addChild(_tInput);
			_cbPhrases = new ComboBox();
			_cbPhrases.x = 10;
			_cbPhrases.y = 507.90;
			_cbPhrases.setSize(451, 22);
			_cbPhrases.restrict = "";
			_cbPhrases.addItem({label:"", data:0});
			_cbPhrases.addItem({label:"Hello", data:1});
			_cbPhrases.addItem({label:"Game anyone?", data:2});
			_cbPhrases.addItem({label:"Countdown anyone?", data:3});
			_cbPhrases.addItem({label:"Yes", data:4});
			_cbPhrases.addItem({label:"No", data:5});
			_cbPhrases.addItem({label:"I'll play", data:6});
			_cbPhrases.addItem({label:"Bye", data:7});
			_cbPhrases.addItem({label:"Good game", data:8});
			_cbPhrases.addItem({label:"Sorry, I'm muted", data:9});
			_cbPhrases.addItem({label:"/version", data:10});
			_cbPhrases.addItem({label:"/history", data:11});
			_cbPhrases.addItem({label:"/clearchat", data:12});
			addChild(_cbPhrases);
			_cbPhrases.visible = false;
			_cbPhrases.enabled = false;
			_btnPhrases = new Button();
			_btnPhrases.emphasized = true;
			_btnPhrases.label = "Send";
			_btnPhrases.visible = false;
			_btnPhrases.enabled = false;
			_btnPhrases.setSize(50, 20);
			_btnPhrases.x = 461;
			_btnPhrases.y = 508.90;
			EventManager.add(_btnPhrases, MouseEvent.CLICK, sendText, "BaseChat._btnPhrases");
			addChild(_btnPhrases);
			_tAlert = new TextArea();
			_tAlert.setSize(190, 132);
			_tAlert.x = 520;
			_tAlert.y = 398;
			_tAlert.editable = false;
			_tAlert.setStyle("textFormat", _loc_1);
			addChild(_tAlert);
		}

		public function refresh_userlist() : void
		{
		}

		protected function do_private_message(param1:String) : void
		{
		}

		private function sendText(param1:MouseEvent) : void
		{
			var _loc_2:String = null;
			if(_muted)
			{
				if(_lastMessage < (getTimer() - 20000))
				{
					_loc_2 = StringUtil.trim(_cbPhrases.text);
				}
				else
				{
					return;
				}
				_lastMessage = getTimer();
				_cbPhrases.selectedIndex = 0;
				_cbPhrases.text = "";
			}
			else
			{
				_loc_2 = StringUtil.trim(_tInput.text);
				_tInput.text = "";
			}
			if(_loc_2.length > 1)
			{
				g.chat.forceSend(_loc_2);
			}
		}

		private function on_chat_key(param1:KeyboardEvent) : void
		{
			var _loc_2:String = null;
			var _loc_3:Array = null;
			var _loc_4:uint = 0;
			if(_muted == false)
			{
				if(param1.ctrlKey)
				{
					if(param1.charCode == Keyboard.ENTER)
					{
						_loc_2 = StringEx.remove_duplicates(StringEx.toAscii(StringUtil.trim(_tInput.text)), 5);
						if(_loc_2.length > 0)
						{
							do_private_message(_loc_2);
						}
						_tInput.text = "";
					}
					else
					{
						if(param1.keyCode == Keyboard.HOME)
						{
							_tOutput.verticalScrollPosition = 0;
							_tOutput.invalidate();
						}
						else
						{
							if(param1.keyCode == Keyboard.END)
							{
								_tOutput.verticalScrollPosition = _tOutput.maxVerticalScrollPosition;
								_tOutput.invalidate();
							}
							else
							{
								if(param1.keyCode == Keyboard.UP)
								{
									_tInput.text = g.chat.getPrevious();
									_tInput.setSelection(_tInput.text.length, _tInput.text.length);
								}
								else
								{
									if(param1.keyCode == Keyboard.DOWN)
									{
										_tInput.text = g.chat.getNext();
										_tInput.setSelection(_tInput.text.length, _tInput.text.length);
									}
									else
									{
										if(param1.keyCode == Keyboard.PAGE_DOWN)
										{
											_tInput.text = "";
										}
										else
										{
											if(param1.keyCode == Keyboard.RIGHT)
											{
												_tInput.text = g.chat.completeName(_tInput.text, g.activeZoneName, g.activeRoomName);
												_tInput.setSelection(_tInput.text.length, _tInput.text.length);
											}
											else
											{
											}
										}
									}
								}
							}
						}
					}
				}
				else
				{
					if(param1.charCode == Keyboard.ENTER)
					{
						_loc_2 = param1.keyCode == Keyboard.LEFT && g.user.access >= 255 && StringEx.remove_duplicates(StringEx.toAscii(StringUtil.trim(_tInput.text)), 5);
						g.chat.send(_loc_2);
						_tInput.text = "";
					}
				}
			}
		}

		public function on_private_message_event(param1:Object) : void
		{
			g.chat.privateMessageEvent(param1.from, param1.message);
		}

		public function on_public_message_event(param1:Object) : void
		{
			g.chat.publicMessageEvent(param1.name, param1.message, param1.zonename, param1.roomname);
		}

		public function onZoneList(param1:Object) : void
		{
			g.chat.noticeEvent(param1.zones);
		}

		public function onMute(param1:Boolean = true) : void
		{
			_muted = param1;
			_tInput.enabled = !param1;
			_tInput.visible = !param1;
			_cbPhrases.visible = param1;
			_cbPhrases.enabled = param1;
			_btnPhrases.visible = param1;
			_btnPhrases.enabled = param1;
			_lastMessage = getTimer() - 60000;
		}

		public function onUnmute() : void
		{
			_muted = false;
			_tInput.visible = true;
			_tInput.enabled = true;
			_tInput.setFocus();
			_cbPhrases.visible = false;
			_cbPhrases.enabled = false;
			_btnPhrases.visible = false;
			_btnPhrases.enabled = false;
		}

		public function onRoomsInZone(param1:Object) : void
		{
			g.chat.noticeEvent("Rooms in zone " + param1.zonename);
			g.chat.noticeEvent(param1.rooms);
		}

		public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "pm":
				g.chat.privateMessageEvent(param1.response.n, param1.response.m);
				break;
			case "Notice":
				g.chat.noticeEvent(param1.response.message);
				break;
			case "Alert":
				if(_tAlert.text.length > 2)
				{
					_tAlert.text = _tAlert.text + "\n" + param1.response.m;
				}
				else
				{
					_tAlert.text = param1.response.m;
				}
				_tAlert.validateNow();
				_tAlert.verticalScrollPosition = _tAlert.maxVerticalScrollPosition;
				break;
			case "Broadcast":
				if(_tAlert.text.length > 2)
				{
					_tAlert.text = _tAlert.text + "\n" + param1.response.m;
				}
				else
				{
					_tAlert.text = param1.response.m;
				}
				_tAlert.validateNow();
				_tAlert.verticalScrollPosition = _tAlert.maxVerticalScrollPosition;
				break;
			case "error":
				if(g.scene.activeScene == "FTW" || g.scene.activeScene == "Countdown")
				{
					if(param1.response.number == 1)
					{
						g.chat.noticeEvent("Sorry, an error occured creating the game. Please try again in a few minutes.");
					}
					else
					{
						g.chat.noticeEvent("Sorry, an error occured");
					}
					g.scene.lobby();
				}
				break;
			default:
				break;
			}
		}

		protected function on_enter(param1:ComponentEvent) : void
		{
			g.chat.send(StringUtil.trim(_tInput.text));
			_tInput.text = "";
		}

		protected function on_added(param1:Event) : void
		{
		}

		protected function on_added_to_stage(param1:Event) : void
		{
			g.server.addEventListener("privateMessage", "on_private_message_event", this);
			g.server.addEventListener("publicMessage", "on_public_message_event", this);
			g.server.addEventListener("zoneList", "onZoneList", this);
			g.server.addEventListener("roomsInZone", "onRoomsInZone", this);
			if(g.user.access > 0)
			{
				_tInput.setFocus();
				EventManager.add(_tInput, KeyboardEvent.KEY_DOWN, on_chat_key);
			}
			g.chat.setOutput(_tOutput);
			if(g.user.muted)
			{
				onMute();
			}
		}

		protected function on_removed(param1:Event) : void
		{
		}

		protected function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(_btnPhrases, MouseEvent.CLICK, sendText);
			EventManager.remove(_tInput, KeyboardEvent.KEY_DOWN, on_chat_key);
			g.server.removeEventListener("privateMessage", "on_private_message_event", this);
			g.server.removeEventListener("publicMessage", "on_public_message_event", this);
			g.server.removeEventListener("zoneList", "onZoneList", this);
			g.server.removeEventListener("roomsInZone", "onRoomsInZone", this);
		}
	}
}
package Scene
{
	import fl.controls.*;
	import flash.display.*;

	dynamic public class DebugPanel extends Sprite
	{
		public var _text:TextArea;

		public function DebugPanel()
		{
			super();
		}
	}
}
package Scene
{
	import Misc.*;
	import com.adobe.serialization.json.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	import net.theyak.net.*;
	import net.theyak.util.*;

	public class LoadAndLogin extends Sprite
	{
		private var socket:Socket;
		private var real_ip:String;
		private var proxy_check:Boolean;
		private var _URLLoader:URLLoader;
		private var introMessage:String = "Welcome to <i>For the Win!</i>";
		private var ignores:Array;
		private var connectionInterval:uint = 0;
		private var loginTicker:uint = 0;
		private var loginInterval:uint = 0;
		public var _tText:TextField;
		public var _tReason:TextField;
		public var _tExpires:TextField;

		public function LoadAndLogin()
		{
			super();
			loginTicker = 0;
			loadConfiguration();
		}

		public function set text(param1:String) : void
		{
			_tText.htmlText = param1;
		}

		public function loadConfiguration() : void
		{
			text = "Loading configuration...";
			var now:Date = new Date();
			function _func_2834(param1:Event)
			{
				text = "<b>Error loading configuration. Try refresh (F5).</b>";
			}
			var xmlLoader:XMLLoader = new XMLLoader("/m/ftw/ftw-config.php?t=" + now.valueOf().toString(), loadedConfiguration, {ioError:_func_2834, securityError:securityError});
		}

		private function loadedConfiguration(param1:XML) : void
		{
			var _loc_3:RegExp = null;
			var _loc_4:Object = null;
			text = "Configuration loaded. Loading user data.";
			if(param1["server-port"] != undefined)
			{
				g.port = param1["server-port"];
			}
			if(param1["server-ip"] != undefined)
			{
				g.ip = param1["server-ip"];
			}
			if(param1["php-path"] != undefined)
			{
				g.phpPath = param1["php-path"];
			}
			if(param1["latex-path"] != undefined)
			{
				g.latexPath = param1["latex-path"];
			}
			var _loc_2:* = "";
			if(param1["host"] == undefined)
			{
				_loc_3 = new RegExp("http://(www|).*?.(com|org|net)", "i");
				_loc_4 = _loc_3.exec(this.loaderInfo.url);
				_loc_2 = _loc_4[0];
			}
			else
			{
				_loc_2 = param1["host"];
			}
			g.phpPath = _loc_2 + "/m/ftw/php/";
			g.host = _loc_2.replace("http://", "");
			g.host = g.host.replace("https://", "");
			g.remote = g.host;
			g.URLPath = _loc_2 + g.root;
			loadUserConfig();
		}

		private function loadUserConfig() : void
		{
			text = g.phpPath + "user_config.php";
			function _func_2837(param1:Event)
			{
				text = "<b>Error loading configuration. Try refresh (F5).</b>";
			}
			var loader:JSONLoader = new JSONLoader(g.phpPath + "user_config.php", loadedUserConfig, {ioError:_func_2837, securityError:securityError});
		}

		private function loadedUserConfig(param1:*) : void
		{
			if(param1["background"] != undefined)
			{
				g.scene.background = param1["background"];
			}
			loadUserInformation();
		}

		private function loadUserInformation() : void
		{
			text = "Loading user information...";
			var _loc_1:queryLoader = new queryLoader(g.phpPath + "Login.php", userLoaded, {ioError:userLoadedError, securityError:securityError});
		}

		private function userLoaded(param1:*) : void
		{
			if((String(param1).substr(0, 8)) == "%3Cbr%20")
			{
				g.scene.debug(unescape(String(param1)));
				trace(unescape(String(param1)));
				text = "Error retrieving user data from server.";
				return;
			}
			text = "User information loaded";
			g.user.id = param1.user_id;
			g.user.token = param1.token;
			g.user.name = param1.username;
			g.user.current_rating = Number(param1.rating);
			g.user.login_rating = Number(param1.rating);
			g.user.access = param1.access;
			g.user.muted = param1.muted == "1";
			g.user.gameChat = param1.gameChat == "1";
			g.user.lobbyChat = param1.lobbyChat == "1";
			g.user.showTime = param1.showTime == "1";
			g.user.gamesToday = param1.gamesToday;
			g.user.ip = param1.ip;
			g.user.gameNumber = param1.gameNumber;
			g.user.font = param1.font_face;
			g.user.font_size = param1.font_size;
			g.user.leading = param1.leading;
			g.user.flood_mute = param1.flood_mute;
			g.user.s3 = param1.s3 == "1";
			g.game.id = param1.gameNumber;
			g.debug = param1.debug == "1";
			proxy_check = param1.proxy_check == "1";
			ignores = new Array();
			var _loc_2:uint = 0;
			while(param1["ignore" + String(_loc_2)])
			{
				ignores.push(param1["ignore" + String(_loc_2)]);
				_loc_2 = _loc_2 + 1;
			}
			if(param1.intro != null)
			{
				introMessage = param1.intro;
			}
			if(param1.banned == "1")
			{
				text = "<b>You have been banned</b>";
				if(param1.reason != null)
				{
					_tReason.text = param1.reason;
				}
				if(param1.expires != null)
				{
					_tExpires.text = param1.expires;
				}
			}
			else
			{
				if(param1.muted == "1")
				{
					introMessage = introMessage + " You are currently muted";
					if(!(param1.reason == null) && param1.reason.length > 0)
					{
						introMessage = introMessage + " (" + param1.reason + ")";
					}
					introMessage = introMessage + ".";
					param1.expires;
					if(param1.expires && param1.expires.length > 0)
					{
						introMessage = introMessage + " Mute will expire on " + param1.expires + ".";
					}
					param1.expiresSeconds;
					if(param1.expiresSeconds && param1.expiresSeconds.length > 0)
					{
						g.server.setMuteInterval(param1.expiresSeconds);
					}
				}
				if(proxy_check)
				{
					proxycheck();
				}
				else
				{
					connectToServer();
				}
			}
		}

		private function userLoadedError(param1:IOErrorEvent) : void
		{
			text = "<b>Unable to load user information. Try refresh (F5).</b>";
		}

		private function proxycheck() : void
		{
			Security.loadPolicyFile("xmlsocket://76.12.70.148:5555");
			socket = new Socket("76.12.70.148", 5555);
			socket.addEventListener(Event.CLOSE, proxy_close_handler);
			socket.addEventListener(Event.CONNECT, proxy_connect_handler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, proxy_security_error_handler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, proxy_data_handler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, proxy_io_error_handler);
		}

		private function proxy_remove_events() : void
		{
			socket.removeEventListener(Event.CLOSE, proxy_close_handler);
			socket.removeEventListener(Event.CONNECT, proxy_connect_handler);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, proxy_security_error_handler);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, proxy_data_handler);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, proxy_io_error_handler);
		}

		private function proxy_close_handler(param1:Event) : void
		{
			proxy_remove_events();
			socket.close();
			connectToServer();
		}

		private function proxy_connect_handler(param1:Event) : void
		{
			socket.writeUTFBytes("{\"__c\":\"ip\"}\n");
			socket.flush();
		}

		private function proxy_security_error_handler(param1:Event) : void
		{
			proxy_close_handler(param1);
		}

		private function proxy_io_error_handler(param1:Event) : void
		{
			proxy_close_handler(param1);
		}

		private function proxy_data_handler(param1:Event) : void
		{
			var _loc_3:Object = null;
			var _loc_4:String = null;
			var _loc_2:String = socket.readUTFBytes(socket.bytesAvailable);
			if(_loc_2.indexOf("\"ip\"") > 0)
			{
				_loc_3 = JSON.decode(_loc_2);
				if(_loc_3.ip != g.user.ip)
				{
					_loc_4 = (g.user.name + " (") + g.user.id + ") ";
					_loc_4 = _loc_4 + "IP addresses do not match. PHP: " + g.user.ip;
					_loc_4 = _loc_4 + " Flash: " + _loc_3.ip;
					Net.callServer((g.URLPath + "PHP/log.php?msg=") + _loc_4);
				}
			}
			proxy_close_handler(param1);
		}

		private function connectToServer() : void
		{
			if(g.user.access >= 255)
			{
				text = "Connecting to server..." + g.ip + ":" + g.port;
			}
			else
			{
				text = "Connecting to server...";
			}
			connectionInterval = setInterval(failed_connect, 6000);
			g.server.addEventListener("connection", "on_connection_event", this);
			g.server.connect(g.ip, g.port);
		}

		public function on_connection_event(param1:Object) : void
		{
			if(connectionInterval)
			{
				clearInterval(connectionInterval);
			}
			if(param1.connected)
			{
				g.server.removeEventListener("connection", "onConnectionEvent", this);
				text = "Connected to server";
				g.server.addEventListener("login", "onLoginResponse", this);
				g.server.login(g.user.name, g.user.token);
			}
			else
			{
				text = "<b>Unable to connect to server. Please try again later.</b>";
			}
		}

		private function failed_connect() : void
		{
			on_connection_event({connected:false});
		}

		private function socket_close_handler(param1:Event) : void
		{
			text = "socket close";
		}

		private function socket_connect_handler(param1:Event) : void
		{
			text = "socket connect";
		}

		private function security_error_handler(param1:Event) : void
		{
			text = param1.toString();
			socket.removeEventListener(Event.CLOSE, socket_close_handler);
			socket.removeEventListener(Event.CONNECT, socket_connect_handler);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, security_error_handler);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, socket_data_handler);
			g.scene.debug(param1.toString());
		}

		private function socket_data_handler(param1:Event) : void
		{
			text = "data " + param1.toString();
			real_ip = socket.readUTFBytes(socket.bytesAvailable);
		}

		public function onLoginResponse(param1:Object) : void
		{
			if(param1.success)
			{
				g.server.addEventListener("pluginMessage", "onPluginMessageEvent", this);
				g.server.removeEventListener("login", "onLoginResponse", this);
				text = "Loading user information";
				g.server.toServerPlugin(g.manager, "getUser", {token:g.user.token, userId:g.user.id, username:g.user.name});
			}
			else
			{
				text = "Username in use. The user has been kicked off.\nPlease click refresh (F5) to re-try login.";
				g.server.disconnectAndReset();
				if(loginTicker >= 10)
				{
					text = "Login failed. Please try again later.</b>";
					loginTicker = 0;
				}
				else
				{
					loginInterval = setInterval(retryLogin, 1000);
				}
			}
		}

		public function onPluginMessageEvent(param1:Object) : void
		{
			var _loc_2:EsObject = new EsObject();
			switch(param1.response.Action)
			{
			case "UserValidated":
				onUserValidated(param1.response);
				break;
			case "UserNotValidated":
				onNotValidated();
				break;
			default:
				break;
			}
		}

		public function onNotValidated() : void
		{
			g.server.removeEventListener("pluginMessage", "onPluginMessageEvent", this);
			text = "Sorry, we were unable to validate your account.";
			_tReason.text = "We are unable to log you in to For the Win!";
		}

		public function onUserValidated(param1:Object) : void
		{
			g.server.removeEventListener("pluginMessage", "onPluginMessageEvent", this);
			text = "Logged in as " + g.user.name;
			g.user.access = parseInt(param1.access, 10);
			g.user.login_rating = param1.rating;
			g.server.setUserVariable("rating", param1.rating);
			g.server.setUserVariable("away", "false");
			g.chat = new Chat();
			g.chat.buffer = introMessage;
			g.chat.mute = g.user.muted;
			g.chat.displayTime = g.user.showTime;
			g.chat.ignores = ignores;
			g.chat.flood_mute = g.user.flood_mute;
			g.server.startPingPong();
			dispatchEvent(new Event("connected"));
		}

		public function retryLogin() : void
		{
			var _loc_2:* = this.loginTicker + 1;
			this.loginTicker = _loc_2;
			if(loginTicker == 5 || loginTicker == 10)
			{
				text = "Attempting login";
				clearInterval(loginInterval);
				connectToServer();
			}
			else
			{
				text = "Username in use. Retry in " + (6 - (loginTicker % 5)) + " seconds...";
			}
		}

		private function securityError(param1:SecurityErrorEvent)
		{
			text = "<b>Security Error. Probably a domain name messed up in config.</b>";
		}
	}
}
package Scene
{
	import Game.*;
	import Misc.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import net.theyak.ui.*;

	public class Lobby extends BaseChat
	{
		public static var class_name:* = "Scene.Lobby";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		public var userlist:Userlist;
		public var _tUsers:TextField;
		public var username:TextField;
		public var _userInfo:UserInformation;
		public var _gameGrid:GameGrid;
		public var _gameGridBackground:Sprite;
		public var _mcCover:Sprite;
		public var _separator:Sprite;
		public var _bNewGame:RedButton;
		public var _bCountdown:RedButton;
		public var _bReview:RedButton;
		private var new_game_box:NewGame;
		private var new_countdown_box:NewCountdown;
		private var review_box:Review;

		public function Lobby()
		{
			super();
			var _loc_5:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_5;
			instance_number = instance_number_counter;
			_mcCover.visible = false;
			g.chat.displayChat = g.user.lobbyChat;
			EventManager.add(this, Event.ADDED, on_added);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(_separator, MouseEvent.MOUSE_DOWN, moveSeparator, "Move separator");
			EventManager.add(this, MouseEvent.MOUSE_UP, stopSeparator, "Stop Separator");
			EventManager.add(userlist, MouseEvent.DOUBLE_CLICK, whois, "Whois user");
			_bNewGame.tText.text = "New Game";
			_bReview.tText.text = "Review";
			_bCountdown.tText.text = "Countdown";
			var _loc_1:Array = [8388608, 13369344];
			if(g.user.name == "ilovepink")
			{
				_loc_1 = [16738047, 16764159];
			}
			var _loc_2:Array = [1, 1];
			var _loc_3:Array = [0, 255];
			tab(10, 35, 501, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 380, 190, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 128, 190, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 35, 190, 18, 6, _loc_1, _loc_2, _loc_3);
		}

		private function tab(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Array, param7:Array, param8:Array)
		{
			var _loc_9:Graphics = this.graphics;
			var _loc_10:Matrix = new Matrix();
			_loc_10.createGradientBox(param3, param4, Math.PI / 2, 0, param2);
			_loc_9.beginGradientFill(GradientType.LINEAR, param6, param7, param8, _loc_10, SpreadMethod.PAD);
			_loc_9.moveTo(param1 + param5, param2);
			_loc_9.lineTo((param1 + param3) - param5, param2);
			_loc_9.curveTo(param1 + param3, param2, param1 + param3, param2 + param5);
			_loc_9.lineTo(param1 + param3, param2 + param4);
			_loc_9.lineTo(param1, param2 + param4);
			_loc_9.lineTo(param1, param2 + param5);
			_loc_9.curveTo(param1, param2, param1 + param5, param2);
			_loc_9.endFill();
		}

		private function whois(param1:MouseEvent) : void
		{
			var _loc_3:Whois = null;
			var _loc_2:String = userlist.getSelectedUser();
			if(_loc_2 != null)
			{
				_loc_3 = new Whois(_loc_2);
				g.scene.getScene().addChild(_loc_3);
			}
		}

		public function display_grid_info() : void
		{
			g.chat.noticeEvent(_gameGrid.toString());
		}

		private function moveSeparator(param1:MouseEvent) : void
		{
			EventManager.add(_separator, Event.ENTER_FRAME, separator_move, "_sperator:moveIt");
			Sprite(_separator).startDrag(false, new Rectangle(10, 175, 540, 198));
		}

		private function separator_move(param1:Event) : void
		{
			_tOutput.y = _separator.y + 8;
			_tOutput.setSize(_tOutput.width, 510 - _tOutput.y);
			_gameGrid._spGames.setSize(GameGrid(_gameGrid).width, _tOutput.y - 63);
			_gameGridBackground.height = _gameGrid._spGames.height;
			_separator.x = 10;
		}

		private function stopSeparator(param1:MouseEvent) : void
		{
			EventManager.remove(_separator, Event.ENTER_FRAME, separator_move);
			Sprite(_separator).stopDrag();
		}

		public function on_join_room(param1:Object) : void
		{
			var _loc_2:Array = null;
			var _loc_3:uint = 0;
			if(param1.zonename == "FTW")
			{
				enable_buttons();
				_loc_2 = param1.users;
				userlist.clear();
				_loc_3 = 0;
				while(_loc_3 < _loc_2.length)
				{
					if(!_loc_2[_loc_3].getVariable("hidden") || _loc_2[_loc_3].getVariable("hidden") == "false")
					{
						userlist.addUser(_loc_2[_loc_3].name, _loc_2[_loc_3].getVariable("rating"), _loc_2[_loc_3].getVariable("away") == "true");
					}
					_loc_3 = _loc_3 + 1;
				}
				g.activeZoneName = param1.zonename;
				g.activeRoomName = param1.roomname;
				_tUsers.text = "Users in " + param1.roomname;
			}
		}

		public function onLeaveRoomEvent(param1:Object) : void
		{
			userlist.clear();
			var _loc_2:Array = g.server.getRoomList();
			if(_loc_2.length > 0)
			{
				g.activeZoneName = _loc_2[0].zonename;
				g.activeRoomName = _loc_2[0].roomname;
				refresh_userlist();
				g.chat.noticeEvent("Now chatting in room " + g.activeZoneName + ":" + g.activeRoomName);
			}
		}

		public function onUserListUpdate(param1:Object) : void
		{
			if(param1.roomname == g.activeRoomName && param1.zonename == g.activeZoneName)
			{
				if(param1.action == "add")
				{
					userlist.addUser(param1.user.name, param1.user.getVariable("rating"), false);
				}
				else
				{
					if(param1.action == "remove")
					{
						userlist.removeUser(param1.user.name);
					}
				}
			}
		}

		override protected function do_private_message(param1:String) : void
		{
			var _loc_2:String = userlist.getSelectedUser();
			if(!(_loc_2 == null) && param1.length > 0)
			{
				g.chat.whisper({command:"whisper", target:_loc_2, str:param1});
			}
		}

		override public function refresh_userlist() : void
		{
			userlist.clear();
			var _loc_1:Array = g.server.getUsersInRoom(g.activeZoneName, g.activeRoomName);
			var _loc_2:uint = 0;
			while(_loc_2 < _loc_1.length)
			{
				userlist.addUser(_loc_1[_loc_2].name, _loc_1[_loc_2].getVariable("rating"), _loc_1[_loc_2].getVariable("away") == "true");
				_loc_2 = _loc_2 + 1;
			}
			_tUsers.text = "Users in " + g.activeRoomName;
		}

		public function setAway(param1:String, param2:String) : void
		{
			userlist.setAway(param1, param2 == "true");
		}

		public function setRating(param1:String, param2:Number) : void
		{
			if(param1 == g.user.name)
			{
				_userInfo.current_rating = String(param2);
			}
			userlist.setRating(param1, param2);
		}

		override public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "update":
				_gameGrid.update(uint(param1.response.id), uint(param1.response.s), uint(param1.response.p), uint(param1.response.of), uint(param1.response.pl));
				break;
			case "remove":
				_gameGrid.remove_game(int(param1.response.id));
				break;
			case "game_list":
				_gameGrid.game_list(param1.response.games);
				break;
			case "new_game":
				_gameGrid.new_game(param1.response.id, param1.response.name, param1.response.type, uint(param1.response.scoring), uint(param1.response.problems));
				break;
			default:
				super.on_plugin_message(param1);
				break;
			}
		}

		private function enable_buttons() : void
		{
			if(g.game.last_problem_number_displayed > 0 && g.game.problems.length > 0)
			{
				EventManager.add(_bReview, MouseEvent.CLICK, on_review, "Scene.Lobby._bReview");
				_bReview.alpha = 1;
			}
			else
			{
				_bReview.alpha = 0.20;
			}
			if(g.user.id > 0)
			{
				EventManager.add(_bNewGame, MouseEvent.CLICK, on_ftw, "Scene.Lobby._bNewGame");
				EventManager.add(_bCountdown, MouseEvent.CLICK, on_countdown, "Scene.Lobby._bCountdown");
				_bNewGame.alpha = 1;
				_bCountdown.alpha = 1;
			}
			else
			{
				_bNewGame.visible = false;
				_bCountdown.visible = false;
				_bReview.x = _bNewGame.x;
			}
		}

		private function disable_buttons() : void
		{
			EventManager.remove(_bReview, MouseEvent.CLICK, on_review);
			EventManager.remove(_bNewGame, MouseEvent.CLICK, on_ftw);
			EventManager.remove(_bCountdown, MouseEvent.CLICK, on_countdown);
			_bNewGame.alpha = 0.20;
			_bCountdown.alpha = 0.20;
			_bReview.alpha = 0.20;
		}

		private function on_ftw_removed(param1:Event) : void
		{
			EventManager.remove(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			enable_buttons();
		}

		private function on_ftw(param1:MouseEvent) : void
		{
			disable_buttons();
			new_game_box = new NewGame();
			EventManager.add(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			addChild(new_game_box);
		}

		private function on_countdown_removed(param1:Event) : void
		{
			EventManager.remove(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
			enable_buttons();
		}

		public function on_countdown(param1:MouseEvent) : void
		{
			disable_buttons();
			if(param1.shiftKey)
			{
				EventManager.remove(_bCountdown, MouseEvent.CLICK, on_countdown);
				new_countdown_box = new NewCountdown();
				EventManager.add(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
				addChild(new_countdown_box);
			}
			else
			{
				g.game.reset();
				g.game.type = "Countdown";
				g.game.max_players = 2;
				g.game.problem_count = 20;
				g.game.time_per_problem = 45;
				g.game.rated = true;
				g.game.sprint = true;
				g.game.target = false;
				g.game.team = true;
				g.game.countdown = true;
				g.game.school = true;
				g.game.chapter = true;
				g.game.state = true;
				g.game.national = true;
				g.game.amc8 = true;
				g.game.scoring_method = ScoringType.COUNTDOWN;
				g.game.password = "";
				g.replay = g.game.clone();
				g.game.create();
			}
		}

		private function on_review_removed(param1:Event) : void
		{
			enable_buttons();
			EventManager.remove(review_box, Event.REMOVED_FROM_STAGE, on_review_removed);
			_bReview.alpha = 1;
		}

		public function on_review(param1:Object) : void
		{
			var _loc_2:Boolean = false;
			var _loc_3:uint = 0;
			var _loc_4:YakAlert = null;
			g.game.problems;
			if(g.game.problems && !_gameGrid.is_game(g.game.id) && g.game.last_problem_number_displayed > 0)
			{
				_loc_2 = false;
				_loc_3 = 0;
				while(_loc_3 <= g.game.last_problem_number_displayed)
				{
					if(g.game.problems[_loc_3])
					{
						_loc_2 = true;
						break;
					}
					_loc_3 = _loc_3 + 1;
				}
				_loc_4 = new YakAlert("There are no problems to review.", "Review Game", "OK");
				_loc_4.center(g.scene.getScene());
				g.scene.getScene().addChild(_loc_4);
			}
			else
			{
				if(!g.game.problems || g.game.last_problem_number_displayed <= 0)
				{
					_loc_4 = new YakAlert("There are no problems to view.", "Review Game", "OK");
					_loc_4.center(g.scene.getScene());
					g.scene.getScene().addChild(_loc_4);
				}
				else
				{
					_loc_4 = new YakAlert("Please wait for game to finish before reviewing. If you start or join another game before the game finishes, you will no longer be able to review the game.", "Review Game", "OK");
					_loc_4.center(g.scene.getScene());
					g.scene.getScene().addChild(_loc_4);
				}
			}
		}

		override protected function on_added(param1:Event) : void
		{
			if(param1.eventPhase == EventPhase.AT_TARGET)
			{
				super.on_added(param1);
				EventManager.remove(this, Event.ADDED, on_added);
			}
		}

		override protected function on_added_to_stage(param1:Event) : void
		{
			disable_buttons();
			username.text = g.user.name;
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			super.on_added_to_stage(param1);
			g.server.addEventListener("userListUpdate", "onUserListUpdate", this);
			g.server.addEventListener("joinRoom", "on_join_room", this);
			g.server.addEventListener("leaveRoom", "onLeaveRoomEvent", this);
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			g.server.toServerPlugin(g.manager, "get_games", {zone:g.activeZoneName});
			g.activeZoneName = "FTW";
			g.activeRoomName = "Lobby";
			g.server.joinRoom(g.activeZoneName, g.activeRoomName);
			var _loc_2:GlowFilter = new GlowFilter(0, 0.10, 16, 16, 0, 3, false, false);
			_bNewGame.filters = new Array(_loc_2);
			_bCountdown.filters = new Array(_loc_2);
			_bReview.filters = new Array(_loc_2);
		}

		override protected function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED, on_added);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, MouseEvent.MOUSE_UP, stopSeparator);
			EventManager.remove(_separator, MouseEvent.MOUSE_DOWN, moveSeparator);
			EventManager.remove(_separator, Event.ENTER_FRAME, separator_move);
			EventManager.remove(userlist, MouseEvent.DOUBLE_CLICK, whois);
			EventManager.remove(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			EventManager.remove(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
			EventManager.remove(review_box, Event.REMOVED_FROM_STAGE, on_review_removed);
			disable_buttons();
			g.server.removeEventListener("userListUpdate", "onUserListUpdate", this);
			g.server.removeEventListener("joinRoom", "on_join_room", this);
			g.server.removeEventListener("leaveRoom", "onLeaveRoomEvent", this);
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			super.on_removed_from_stage(param1);
		}
	}
}
package Scene
{
	import Game.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;

	public class Manager extends Object
	{
		private var stage:Sprite;
		private var ldr:Loader;
		private var debugPanel:DebugPanel;
		public var activeScene:String = "";
		public var isReceivingPluginMessages:Boolean = false;

		public function Manager(param1:Sprite)
		{
			super();
			this.stage = param1;
			while(param1.numChildren > 0)
			{
				param1.removeChildAt(0);
			}
			param1.addChild(new Background());
			param1.addChild(new Background());
			debugPanel = new DebugPanel();
			debugPanel.y = 540;
			debugPanel.visible = false;
			param1.addChild(debugPanel);
		}

		public function loader()
		{
			activeScene = "Loader";
			remove();
			var _loc_1:DisplayObject = stage.addChildAt(new LoadAndLogin(), 1);
			_loc_1.visible = true;
		}

		public function message(param1:String) : void
		{
			activeScene = "Message";
			remove();
			stage.addChildAt(new Message(param1), 1);
		}

		public function lobby()
		{
			activeScene = "Lobby";
			remove();
			stage.addChildAt(new Lobby(), 1);
		}

		public function ftw()
		{
			activeScene = "FTW";
			remove();
			stage.addChildAt(new FTW(), 1);
		}

		public function countdown()
		{
			activeScene = "Countdown";
			remove();
			stage.addChildAt(new Countdown(), 1);
		}

		public function race()
		{
			activeScene = "Race";
			remove();
		}

		public function reconnect()
		{
			activeScene = "Reconnect";
			remove();
			stage.addChildAt(new Reconnect(), 1);
		}

		public function reconnect2() : void
		{
			activeScene = "Reconnect";
			remove();
			stage.addChildAt(new Reconnect2(), 1);
		}

		public function set background(param1:String) : void
		{
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			var _loc_2:URLRequest = new URLRequest(param1);
			ldr.load(_loc_2);
		}

		private function backgroundDisplay(param1:Event) : void
		{
			ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			ldr.width = this.stage.width;
			ldr.height = this.stage.height;
			this.stage.removeChildAt(0);
			this.stage.addChildAt(ldr, 0);
		}

		private function backgroundError(param1:Event) : void
		{
			ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			debug("Unable to load background");
		}

		private function remove() : void
		{
			if(stage.numChildren > 1)
			{
				stage.removeChildAt(1);
			}
		}

		public function getScene() : Sprite
		{
			return Sprite(stage.getChildAt(1));
		}

		public function debug(param1:String, param2:String = null) : void
		{
			var _loc_3:Date = null;
			var _loc_4:String = null;
			if(debugPanel != null)
			{
				_loc_3 = new Date();
				_loc_4 = "[" + _loc_3.toString() + "] ";
				if(param2 == null)
				{
					debugPanel._text.htmlText = debugPanel._text.htmlText + (_loc_4 + param1) + "\n";
				}
				else
				{
					debugPanel._text.htmlText = debugPanel._text.htmlText + (_loc_4 + "<font color=\"") + param2 + "\">" + param1 + "</font>\n";
				}
				debugPanel._text.verticalScrollPosition = debugPanel._text.maxVerticalScrollPosition;
				debugPanel._text.invalidate();
			}
			else
			{
				trace("Debug panel is null: " + param1);
			}
		}
	}
}
package Scene
{
	import flash.display.*;
	import flash.text.*;

	public class Message extends Sprite
	{
		public var _tText:TextField;

		public function Message(param1:String = null)
		{
			super();
			if(param1 != null)
			{
				this.message = param1;
			}
		}

		public function set message(param1:String) : void
		{
			_tText.text = param1;
		}
	}
}
package Scene
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;

	public class Reconnect extends Sprite
	{
		public var _bReconnect:Button;

		public function Reconnect()
		{
			super();
			_bReconnect.addEventListener(MouseEvent.CLICK, attemptConnection);
			__setProp__bReconnect_Reconnect_Layer1_0();
		}

		private function attemptConnection(param1:MouseEvent) : void
		{
			_bReconnect.removeEventListener(MouseEvent.CLICK, attemptConnection);
			g.server.reset();
			g.server.connect();
		}

		public function __setProp__bReconnect_Reconnect_Layer1_0()
		{
			try
			{
				_bReconnect["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_bReconnect.emphasized = false;
			_bReconnect.enabled = true;
			_bReconnect.label = "Try to Reconnect";
			_bReconnect.labelPlacement = "right";
			_bReconnect.selected = false;
			_bReconnect.toggle = false;
			_bReconnect.visible = true;
			try
			{
				_bReconnect["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
package Scene
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class Reconnect2 extends Sprite
	{
		public var _bReconnect:Button;
		public var _tText:TextField;
		private var _interval:uint;

		public function Reconnect2()
		{
			super();
			_tText.text = "Lost connection to server - trying to reconnect";
			_interval = setInterval(failedConnect, 5000);
			g.server.reset();
			g.server.addEventListener("connection", "reconnection", this);
			g.server.addEventListener("reconnection", "reconnection", this);
			g.server.connect();
			_bReconnect.visible = false;
			_bReconnect.label = "Try to Reconnect";
		}

		public function reconnection(param1:Object) : void
		{
			g.scene.debug("reconnection");
			if(_interval)
			{
				clearInterval(_interval);
				_interval = 0;
			}
			g.server.removeEventListener("reconnection", "reconnection", this);
			g.server.removeEventListener("connection", "reconnection", this);
			if(param1.connected)
			{
				g.server.addEventListener("login", "loginResponse", this);
				_tText.text = "Connected. Logging in...";
				g.server.login(g.user.name, g.user.token);
			}
			else
			{
				_tText.text = "The server has gone down.";
				_bReconnect.visible = true;
				_bReconnect.addEventListener(MouseEvent.CLICK, attemptConnection);
			}
		}

		public function failedConnect() : void
		{
			g.scene.debug("failedConnect");
			reconnection({connected:false});
		}

		public function loginResponse(param1:Object)
		{
			g.scene.debug("login response");
			g.server.removeEventListener("login", "loginResponse", this);
			g.server.setUserVariable("rating", String(g.user.current_rating));
			g.server.setUserVariable("away", "false");
			g.scene.lobby();
		}

		private function attemptConnection(param1:MouseEvent) : void
		{
			g.scene.debug("attemptConnection");
			_bReconnect.removeEventListener(MouseEvent.CLICK, attemptConnection);
			g.server.addEventListener("reconnection", "reconnection", this);
			g.server.addEventListener("connection", "reconnection", this);
			g.server.reset();
			g.server.connect();
		}
	}
}
