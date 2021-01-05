package Lobby
{
	import Misc.*;
	import fl.motion.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class UserInformation extends Sprite
	{
		public static var class_name:* = "Lobby.UserInformation";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var _games_today:TextField;
		private var _current_rating:TextField;
		private var _login_rating:TextField;
		private var _login_box:WhiteBox = null;

		public function UserInformation()
		{
			var _loc_4:uint = 0;
			var _loc_5:Color = null;
			super();
			var _loc_7:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_7;
			instance_number = instance_number_counter;
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.bold = true;
			_loc_1.font = "_sans";
			var _loc_2:TextField = new TextField();
			_loc_2.x = 3;
			_loc_2.y = 3;
			_loc_2.width = 190;
			_loc_2.height = 22;
			_loc_2.selectable = false;
			_loc_2.text = "Games Today";
			_loc_2.setTextFormat(_loc_1);
			addChild(_loc_2);
			if(g.user.access > 0)
			{
				_loc_2 = new TextField();
				_loc_2.x = 3;
				_loc_2.y = 21;
				_loc_2.width = 190;
				_loc_2.height = 22;
				_loc_2.text = "Rating at login";
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
				_loc_2 = new TextField();
				_loc_2.x = 3;
				_loc_2.y = 39;
				_loc_2.width = 190;
				_loc_2.height = 22;
				_loc_2.text = "Current Rating";
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
			}
			else
			{
				_login_box = new WhiteBox();
				_login_box.x = 0;
				_login_box.y = 45;
				_login_box.width = 190;
				_login_box.height = 20;
				_loc_4 = 11388412;
				_loc_5 = new Color();
				_loc_5.setTint(_loc_4, 0.80);
				_login_box.transform.colorTransform = _loc_5;
				addChild(_login_box);
				EventManager.add(_login_box, MouseEvent.CLICK, on_login);
				_loc_1 = new TextFormat();
				_loc_1.color = 16777215;
				_loc_1.bold = true;
				_loc_1.align = "center";
				_loc_1.font = "_sans";
				_loc_2 = new TextField();
				_loc_2.width = 190;
				_loc_2.height = 20;
				_loc_2.x = 0;
				_loc_2.y = 45;
				_loc_2.text = "Login / Register";
				_loc_2.selectable = false;
				_loc_2.mouseEnabled = false;
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
			}
			var _loc_3:TextFormat = new TextFormat();
			_loc_3.align = "right";
			_loc_3.font = "_sans";
			_games_today = new TextField();
			_games_today.defaultTextFormat = _loc_3;
			_games_today.text = String(g.user.gamesToday);
			_games_today.x = 0;
			_games_today.y = 3;
			_games_today.width = 186;
			_games_today.height = 22;
			_games_today.selectable = false;
			addChild(_games_today);
			if(g.user.access > 0)
			{
				_login_rating = new TextField();
				_login_rating.defaultTextFormat = _loc_3;
				_login_rating.text = g.user.login_rating_display;
				_login_rating.x = 0;
				_login_rating.y = 21;
				_login_rating.width = 186;
				_login_rating.height = 22;
				_login_rating.selectable = false;
				addChild(_login_rating);
				_current_rating = new TextField();
				_current_rating.defaultTextFormat = _loc_3;
				_current_rating.text = g.user.current_rating_display;
				_current_rating.x = 0;
				_current_rating.y = 39;
				_current_rating.width = 186;
				_current_rating.height = 22;
				_current_rating.selectable = false;
				addChild(_current_rating);
			}
		}

		public function set games_today(param1:uint) : void
		{
			_games_today.text = String(param1);
		}

		public function set rating(param1:String) : void
		{
			this.current_rating = param1;
		}

		public function set current_rating(param1:String) : void
		{
			if(param1 == "")
			{
				_current_rating.text = g.user.current_rating_display;
			}
			else
			{
				_current_rating.text = param1;
			}
		}

		public function set login_rating(param1:String) : void
		{
			if(param1 == "")
			{
				_login_rating.text = g.user.login_rating_display;
			}
			else
			{
				_login_rating.text = param1;
			}
		}

		private function on_login(param1:MouseEvent) : void
		{
			navigateToURL(new URLRequest("http://" + g.host + "/user/login.php"), "_self");
		}

		public function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(_login_box, MouseEvent.CLICK, on_login);
		}
	}
}
