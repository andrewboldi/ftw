package net.theyak.util
{
	import flash.net.*;

	public class Net extends Object
	{
		final public static function callServer(param1:String) : void
		{
			var url:String = param1;
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			try
			{
				loader.load(request);
			}
			catch(error:SecurityError)
			{
			}
		}

		final public static function getURL(param1:String, param2:String = null) : void
		{
			var url:String = param1;
			var window:String = param2;
			var req:URLRequest = new URLRequest(url);
			try
			{
				Net.navigateToURL(req, window);
			}
			catch(e:Error)
			{
				Net.trace("Navigate to URL failed", e.message);
			}
		}

		public function Net()
		{
			super();
		}
	}
}
package net.theyak.util
{
	public class StringEx extends Object
	{
		final public static function toAscii(param1:String) : String
		{
			var _loc_3:uint = 0;
			var _loc_2:int = param1.length - 1;
			while(_loc_2 >= 0)
			{
				_loc_3 = param1.charCodeAt(_loc_2);
				if(_loc_3 >= 127 || _loc_3 < 32)
				{
					if(_loc_2 == (param1.length - 1))
					{
						param1 = param1.substr(0, param1.length - 1);
					}
					else
					{
						if(_loc_2 == 0)
						{
							param1 = param1.substr(1);
						}
						else
						{
							param1 = (param1.substr(0, _loc_2)) + (param1.substr(_loc_2 + 1));
						}
					}
				}
				_loc_2 = _loc_2 - 1;
			}
			return param1;
		}

		final public static function remove_triplets(param1:String) : String
		{
			var _loc_3:uint = 0;
			var _loc_2:int = param1.length - 1;
			return param1;
			return param1;
		}

		final public static function remove_duplicates(param1:String, param2:uint = 3)
		{
			var _loc_4:uint = 0;
			var _loc_3:int = param1.length - 1;
			var _loc_5:uint = 0;
			var _loc_6:uint = 0;
			if(param2 >= param1.length)
			{
				return param1;
			}
			while(_loc_3 >= 0)
			{
				_loc_4 = param1.charCodeAt(_loc_3);
				if(_loc_4 == _loc_5)
				{
					_loc_6 = _loc_6 + 1;
					if(_loc_6 >= param2)
					{
						if(_loc_3 == (param1.length - 1))
						{
							param1 = param1.substr(0, param1.length - 1);
						}
						else
						{
							if(_loc_3 == 0)
							{
								param1 = param1.substr(1);
							}
							else
							{
								param1 = (param1.substr(0, _loc_3)) + (param1.substr(_loc_3 + 1));
							}
						}
					}
				}
				else
				{
					_loc_6 = 0;
				}
				_loc_5 = _loc_4;
				_loc_3 = _loc_3 - 1;
			}
			return param1;
		}

		final public static function replace(param1:String, param2:String, param3:String) : String
		{
			var _loc_5:* = undefined;
			var _loc_6:* = undefined;
			var _loc_7:* = undefined;
			var _loc_4:Number = 0;
			while(_loc_4 < param3.length)
			{
				_loc_5 = param3.indexOf(param1, _loc_4);
				if(_loc_5 == -1)
				{
					break;
					break;
				}
				_loc_6 = param3.substr(0, _loc_5);
				_loc_7 = param3.substr(_loc_5 + param1.length, param3.length);
				param3 = (_loc_6 + param2) + _loc_7;
				_loc_4 = _loc_6.length + param2.length;
			}
			return param3;
		}

		final public static function htmlspecialchars(param1:String) : String
		{
			var _loc_2:String = null;
			_loc_2 = StringEx.replace("&", "&amp;", param1);
			_loc_2 = StringEx.replace("<", "&lt;", _loc_2);
			_loc_2 = StringEx.replace(">", "&gt;", _loc_2);
			return _loc_2;
		}

		final public static function isCodeAlphaNumeric(param1:Number) : Boolean
		{
			if(param1 >= 48 && param1 <= 57 || param1 >= 65 && param1 <= 90 || param1 >= 97 && param1 <= 122)
			{
				return true;
			}
			return false;
		}

		public function StringEx()
		{
			super();
		}
	}
}
