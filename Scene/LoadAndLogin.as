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
