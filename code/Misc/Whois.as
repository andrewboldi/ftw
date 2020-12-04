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
