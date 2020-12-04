package com.adobe.serialization.json
{
	import flash.utils.*;

	public class JSONEncoder extends Object
	{
		private var jsonString:String;

		public function JSONEncoder(param1:*)
		{
			super();
			jsonString = convertToString(param1);
		}

		public function getString() : String
		{
			return jsonString;
		}

		private function convertToString(param1:*) : String
		{
			if(param1 is String)
			{
				return escapeString(param1);
			}
			if(param1 is Number)
			{
				return isFinite(param1) ? param1.toString() : "null";
			}
			else
			{
				if(param1 is Boolean)
				{
					return param1 ? "true" : "false";
				}
				else
				{
					if(param1 is Array)
					{
						return arrayToString(param1);
					}
					if(!(param1 is Object && param1 == null))
					{
						return objectToString(param1);
					}
				}
			}
			return "null";
		}

		private function escapeString(param1:String) : String
		{
			var _loc_3:String = null;
			var _loc_6:String = null;
			var _loc_7:String = null;
			var _loc_2:String = "";
			var _loc_4:Number = param1.length;
			var _loc_5:int = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_3 = param1.charAt(_loc_5);
				switch(_loc_3)
				{
				case "\"":
					_loc_2 = _loc_2 + "\\\"";
					break;
				case "\\":
					_loc_2 = _loc_2 + "\\\\";
					break;
				case "\b":
					_loc_2 = _loc_2 + "\\b";
					break;
				case "\f":
					_loc_2 = _loc_2 + "\\f";
					break;
				case "\n":
					_loc_2 = _loc_2 + "\\n";
					break;
				case "\r":
					_loc_2 = _loc_2 + "\\r";
					break;
				case "\t":
					_loc_2 = _loc_2 + "\\t";
					break;
				default:
					if(_loc_3 < " ")
					{
						_loc_6 = _loc_3.charCodeAt(0).toString(16);
						_loc_7 = _loc_6.length == 2 ? "00" : "000";
						_loc_2 = _loc_2 + "\\u" + _loc_7 + _loc_6;
					}
					else
					{
						_loc_2 = _loc_2 + _loc_3;
					}
					break;
				}
				_loc_5++;
			}
			return "\"" + _loc_2 + "\"";
		}

		private function arrayToString(param1:Array) : String
		{
			var _loc_2:String = "";
			var _loc_3:int = 0;
			while(_loc_3 < param1.length)
			{
				if(_loc_2.length > 0)
				{
					_loc_2 = _loc_2 + ",";
				}
				_loc_2 = _loc_2 + convertToString(param1[_loc_3]);
				_loc_3++;
			}
			return "[" + _loc_2 + "]";
		}

		private function objectToString(param1:Object) : String
		{
			var value:Object = null;
			var key:String = null;
			var v:XML = null;
			var o:Object = param1;
			var s:String = "";
			var classInfo:XML = describeType(o);
			if(classInfo.@name.toString() == "Object")
			{
				var _loc_3:int = 0;
				var _loc_4:* = o;
				for each(key in _loc_4)
				{
					value = o[key];
					if(value is Function)
					{
						continue;
					}
					if(s.length > 0)
					{
						s = s + ",";
					}
					s = s + (escapeString(key) + ":") + convertToString(value);
				}
			}
			else
			{
				var _loc_3:int = 0;
				var _loc_6:int = 0;
				var _loc_7:* = classInfo.descendants();
				var _loc_5:Boolean = new XMLList("");
				for each(_loc_8 in _loc_7)
				{
					var _loc_9:Object = _loc_8;
					with(_loc_9)
					{
						if(name() == "variable" || name() == "accessor")
						{
							_loc_5[_loc_6] = _loc_9;
						}
					}
				}
				var _loc_4:* = _loc_5;
				for each(v in _loc_4)
				{
					if(s.length > 0)
					{
						s = s + ",";
					}
					s = s + (escapeString(v.@name.toString()) + ":") + convertToString(o[v.@name]);
				}
			}
			return "{" + s + "}";
		}
	}
}
