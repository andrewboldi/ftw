package com.adobe.utils
{
	public class StringUtil extends Object
	{
		final public static function stringsAreEqual(param1:String, param2:String, param3:Boolean) : Boolean
		{
			if(param3)
			{
				return param1 == param2;
			}
			return param1.toUpperCase() == param2.toUpperCase();
		}

		final public static function trim(param1:String) : String
		{
			return StringUtil.ltrim(StringUtil.rtrim(param1));
		}

		final public static function ltrim(param1:String) : String
		{
			var _loc_2:Number = param1.length;
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				if(param1.charCodeAt(_loc_3) > 32)
				{
					return param1.substring(_loc_3);
				}
				_loc_3 = _loc_3 + 1;
			}
			return "";
		}

		final public static function rtrim(param1:String) : String
		{
			var _loc_2:Number = param1.length;
			var _loc_3:Number = _loc_2;
			while(_loc_3 > 0)
			{
				if((param1.charCodeAt(_loc_3 - 1)) > 32)
				{
					return param1.substring(0, _loc_3);
				}
				_loc_3 = _loc_3 - 1;
			}
			return "";
		}

		final public static function beginsWith(param1:String, param2:String) : Boolean
		{
			return param2 == (param1.substring(0, param2.length));
		}

		final public static function endsWith(param1:String, param2:String) : Boolean
		{
			return param2 == (param1.substring(param1.length - param2.length));
		}

		final public static function remove(param1:String, param2:String) : String
		{
			return StringUtil.replace(param1, param2, "");
		}

		final public static function replace(param1:String, param2:String, param3:String) : String
		{
			var _loc_9:int = NaN;
			var _loc_4:String = new String();
			var _loc_5:Boolean = false;
			var _loc_6:Number = param1.length;
			var _loc_7:Number = param2.length;
			var _loc_8:Number = 0;
			while(_loc_8 < _loc_6)
			{
				if(param1.charAt(_loc_8) == param2.charAt(0))
				{
					_loc_5 = true;
					_loc_9 = 0;
					while(_loc_9 < _loc_7)
					{
						if((param1.charAt(_loc_8 + _loc_9)) != param2.charAt(_loc_9))
						{
							_loc_5 = false;
							break;
						}
						_loc_9 = _loc_9 + 1;
					}
				}
				_loc_4 = _loc_4 + param1.charAt(_loc_8);
				_loc_8 = _loc_8 + 1;
			}
			return _loc_4;
		}

		public function StringUtil()
		{
			super();
		}
	}
}
