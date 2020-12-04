package Lobby
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class Status extends Sprite
	{
		public static var class_name:* = "Lobby.Status";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var _alert:YakAlert;
		private var _username:String;
		private var _reason:TextInput;
		private var _time:TextInput;
		public var variables:URLLoader;

		public function Status(param1:String)
		{
			var username:String = param1;
			variables = new URLLoader();
			super();
			var _loc_4:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_4;
			instance_number = instance_number_counter;
			_username = username;
			var request:URLRequest = new URLRequest((g.URLPath + "PHP/Status.php?u=") + escape(username));
			variables.dataFormat = URLLoaderDataFormat.VARIABLES;
			EventManager.add(variables, Event.COMPLETE, userLoaded);
			EventManager.add(variables, IOErrorEvent.IO_ERROR, userLoadedError);
			EventManager.add(variables, SecurityErrorEvent.SECURITY_ERROR, securityError);
			try
			{
				variables.load(request);
			}
			catch(err:SecurityError)
			{
				error("Security error");
			}
		}

		private function userLoaded(param1:Event) : void
		{
			var _loc_3:Boolean = false;
			var _loc_4:Boolean = false;
			var _loc_5:* = undefined;
			var _loc_6:* = undefined;
			remove_url_loader_listeners();
			var _loc_2:URLLoader = URLLoader(param1.target);
			if(_loc_2.data.error)
			{
				error(_loc_2.data.error);
			}
			else
			{
				_loc_3 = g.user.access < 100 || _loc_2.data.banned == "true";
				_loc_4 = _loc_2.data.muted == "true";
				_loc_5 = _loc_4 ? "Unmute" : "Mute";
				_loc_6 = "Ban";
				if(g.user.access >= 255)
				{
					_alert = new YakAlert("", "Status for " + _username, _loc_5, _loc_6);
				}
				else
				{
					_alert = new YakAlert("", "Status for " + _username, _loc_5);
				}
				_alert.center(g.scene.getScene());
				add_alert_listeners();
				field("Muted", "No", 20, 20);
				field("Banned", "No", 20, 40);
				_reason = new TextInput();
				_time = new TextInput();
				if(!_loc_4 || !_loc_3)
				{
					field("Reason", "", 20, 60);
					_reason.x = 75;
					_reason.y = 60;
					_reason.setSize(200, 20);
					_reason.mouseEnabled = false;
					_alert.canvas.addChild(_reason);
					field("Minutes", "", 20, 86);
					_time.x = 75;
					_time.y = 86;
					_time.setSize(30, 20);
					_alert.canvas.addChild(_time);
				}
				addChild(_alert);
			}
		}

		private function field(param1:String, param2:String, param3:uint, param4:uint, param5:uint = 0)
		{
			var _loc_6:TextField = new TextField();
			var _loc_7:TextFormat = new TextFormat();
			var _loc_8:TextFormat = new TextFormat();
			_loc_6.x = param3;
			_loc_6.y = param4;
			_loc_6.autoSize = "left";
			_loc_6.text = " " + param1 + ": " + param2;
			_loc_7.font = "_sans";
			_loc_7.size = 12;
			_loc_7.bold = true;
			_loc_7.color = param5;
			_loc_8.font = "_sans";
			_loc_8.color = param5;
			_loc_8.bold = false;
			_loc_6.setTextFormat(_loc_8, param1.length + 2, _loc_6.text.length);
			_loc_6.setTextFormat(_loc_7, 0, param1.length + 2);
			_alert.canvas.addChild(_loc_6);
		}

		private function userLoadedError(param1:Event) : void
		{
			remove_url_loader_listeners();
			error("Load Error");
		}

		private function securityError(param1:Event) : void
		{
			remove_url_loader_listeners();
			error("A security error");
		}

		private function error(param1:String) : void
		{
			_alert = new YakAlert(param1, "Error", "OK");
			_alert.center(g.scene.getScene());
			add_alert_listeners();
			g.scene.getScene().addChild(_alert);
		}

		private function onAlertClosed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function onAlertButton(param1:AlertEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:String = "";
			switch(param1.button)
			{
			case "Mute":
				if(_time.text.length > 0)
				{
					_loc_2 = parseInt(_time.text);
				}
				if(_loc_2 <= 0)
				{
					_loc_2 = 240;
				}
				if(_reason.text.length > 0)
				{
					_loc_3 = _reason.text;
				}
				g.server.toServerPlugin(g.auxiliary, "Mute", {name:_username, time:_loc_2, reason:_loc_3});
				g.chat.noticeEvent("User " + _username + " muted for " + _loc_2 + " minutes.");
				break;
			case "Ban":
				if(_time.text.length > 0)
				{
					_loc_2 = parseInt(_time.text);
				}
				if(_loc_2 <= 0)
				{
					_loc_2 = 2880;
				}
				if(_reason.text.length > 0)
				{
					_loc_3 = _reason.text;
				}
				g.server.toServerPlugin(g.auxiliary, "Ban", {name:_username, time:_loc_2, reason:_loc_3});
				g.chat.noticeEvent("User " + _username + " banned for " + _loc_2 + " minutes.");
				break;
			case "Unban":
				g.server.toServerPlugin(g.auxiliary, "Unban", {name:_username});
				g.chat.noticeEvent("User " + _username + " no longer banned");
				break;
			case "Unmute":
				g.server.toServerPlugin(g.auxiliary, "Unmute", {name:_username});
				g.chat.noticeEvent("User " + _username + " no longer muted");
				break;
			default:
				break;
			}
		}

		private function add_alert_listeners()
		{
			EventManager.add(_alert, "AlertEvent", onAlertButton);
			EventManager.add(_alert, "DialogEvent", onAlertClosed);
			EventManager.add(_alert, Event.REMOVED_FROM_STAGE, on_alert_removed_from_stage);
		}

		private function on_alert_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(_alert, "AlertEvent", onAlertButton);
			EventManager.remove(_alert, "DialogEvent", onAlertClosed);
			EventManager.remove(_alert, Event.REMOVED_FROM_STAGE, on_alert_removed_from_stage);
		}

		private function remove_url_loader_listeners()
		{
			EventManager.remove(variables, Event.COMPLETE, userLoaded);
			EventManager.remove(variables, IOErrorEvent.IO_ERROR, userLoadedError);
			EventManager.remove(variables, SecurityErrorEvent.SECURITY_ERROR, securityError);
		}

		private function close(param1:Event) : void
		{
			on_alert_removed_from_stage(param1);
			remove_url_loader_listeners();
			parent.removeChild(this);
		}
	}
}
