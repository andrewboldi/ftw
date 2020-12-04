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
