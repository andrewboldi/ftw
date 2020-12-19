package com.adobe.serialization.json
{
	public class JSON extends Object
	{
		final public static function encode(param1:Object) : String
		{
			var _loc_2:JSONEncoder = new JSONEncoder(param1);
			return _loc_2.getString();
		}

		final public static function decode(param1:String)
		{
			var _loc_2:JSONDecoder = new JSONDecoder(param1);
			return _loc_2.getValue();
		}

		public function JSON()
		{
			super();
		}
	}
}
package com.adobe.serialization.json
{
	public class JSONDecoder extends Object
	{
		private var value:*;
		private var tokenizer:JSONTokenizer;
		private var token:JSONToken;

		public function JSONDecoder(param1:String)
		{
			super();
			tokenizer = new JSONTokenizer(param1);
			nextToken();
			value = parseValue();
		}

		public function getValue()
		{
			return value;
		}

		private function nextToken() : JSONToken
		{
			var _loc_1:getNextToken = tokenizer.getNextToken();
			token = _loc_1;
			return _loc_1;
		}

		private function parseArray() : Array
		{
			var _loc_1:Array = new Array();
			nextToken();
			if(token.type == JSONTokenType.RIGHT_BRACKET)
			{
				return _loc_1;
			}
			while(true)
			{
				_loc_1.push(parseValue());
				nextToken();
				if(token.type == JSONTokenType.RIGHT_BRACKET)
				{
					return _loc_1;
				}
				if(token.type == JSONTokenType.COMMA)
				{
					nextToken();
					break;
				}
				tokenizer.parseError("Expecting ] or , but found " + token.value);
			}
			return null;
		}

		private function parseObject() : Object
		{
			var _loc_2:String = null;
			var _loc_1:Object = new Object();
			nextToken();
			if(token.type == JSONTokenType.RIGHT_BRACE)
			{
				return _loc_1;
			}
			while(true)
			{
				if(token.type == JSONTokenType.STRING)
				{
					_loc_2 = String(token.value);
					nextToken();
					if(token.type == JSONTokenType.COLON)
					{
						nextToken();
						_loc_1[_loc_2] = parseValue();
						nextToken();
						if(token.type == JSONTokenType.RIGHT_BRACE)
						{
							return _loc_1;
						}
						if(token.type == JSONTokenType.COMMA)
						{
							nextToken();
						}
						else
						{
							tokenizer.parseError("Expecting } or , but found " + token.value);
						}
					}
					else
					{
						tokenizer.parseError("Expecting : but found " + token.value);
					}
					break;
				}
				tokenizer.parseError("Expecting string but found " + token.value);
			}
			return null;
		}

		private function parseValue() : Object
		{
			switch(token.type)
			{
			case JSONTokenType.LEFT_BRACE:
				return parseObject();
			case JSONTokenType.LEFT_BRACKET:
				return parseArray();
			case JSONTokenType.STRING:
				return token.value;
			case JSONTokenType.NUMBER:
				return token.value;
			case JSONTokenType.TRUE:
				return token.value;
			case JSONTokenType.FALSE:
				return token.value;
			case JSONTokenType.NULL:
				return token.value;
			default:
				tokenizer.parseError("Unexpected " + token.value);
				break;
			}
			return null;
		}
	}
}
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
package com.adobe.serialization.json
{
	public class JSONParseError extends Error
	{
		private var _location:int;
		private var _text:String;

		public function JSONParseError(param1:String = "", param2:int = 0, param3:String = "")
		{
			super(param1);
			_location = param2;
			_text = param3;
		}

		public function get location() : int
		{
			return _location;
		}

		public function get text() : String
		{
			return _text;
		}
	}
}
package com.adobe.serialization.json
{
	public class JSONToken extends Object
	{
		private var _type:int;
		private var _value:Object;

		public function JSONToken(param1:int = -1, param2:Object = null)
		{
			super();
			_type = param1;
			_value = param2;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(param1:int) : void
		{
			_type = param1;
		}

		public function get value() : Object
		{
			return _value;
		}

		public function set value(param1:Object) : void
		{
			_value = param1;
		}
	}
}
package com.adobe.serialization.json
{
	public class JSONTokenizer extends Object
	{
		private var obj:Object;
		private var jsonString:String;
		private var loc:int;
		private var ch:String;

		public function JSONTokenizer(param1:String)
		{
			super();
			jsonString = param1;
			loc = 0;
			nextChar();
		}

		public function getNextToken() : JSONToken
		{
			var _loc_2:String = null;
			var _loc_3:String = null;
			var _loc_4:String = null;
			var _loc_1:JSONToken = new JSONToken();
			skipIgnored();
			switch(ch)
			{
			case "{":
				_loc_1.type = JSONTokenType.LEFT_BRACE;
				_loc_1.value = "{";
				nextChar();
				break;
			case "}":
				_loc_1.type = JSONTokenType.RIGHT_BRACE;
				_loc_1.value = "}";
				nextChar();
				break;
			case "[":
				_loc_1.type = JSONTokenType.LEFT_BRACKET;
				_loc_1.value = "[";
				nextChar();
				break;
			case "]":
				_loc_1.type = JSONTokenType.RIGHT_BRACKET;
				_loc_1.value = "]";
				nextChar();
				break;
			case ",":
				_loc_1.type = JSONTokenType.COMMA;
				_loc_1.value = ",";
				nextChar();
				break;
			case ":":
				_loc_1.type = JSONTokenType.COLON;
				_loc_1.value = ":";
				nextChar();
				break;
			case "t":
				_loc_2 = "t" + nextChar() + nextChar() + nextChar();
				if(_loc_2 == "true")
				{
					_loc_1.type = JSONTokenType.TRUE;
					_loc_1.value = true;
					nextChar();
				}
				else
				{
					parseError("Expecting 'true' but found " + _loc_2);
				}
				break;
			case "f":
				_loc_3 = "f" + nextChar() + nextChar() + nextChar() + nextChar();
				if(_loc_3 == "false")
				{
					_loc_1.type = JSONTokenType.FALSE;
					_loc_1.value = false;
					nextChar();
				}
				else
				{
					parseError("Expecting 'false' but found " + _loc_3);
				}
				break;
			case "n":
				_loc_4 = "n" + nextChar() + nextChar() + nextChar();
				if(_loc_4 == "null")
				{
					_loc_1.type = JSONTokenType.NULL;
					_loc_1.value = null;
					nextChar();
				}
				else
				{
					parseError("Expecting 'null' but found " + _loc_4);
				}
				break;
			case "\"":
				_loc_1 = readString();
				break;
			default:
				if(isDigit(ch) || ch == "-")
				{
					_loc_1 = readNumber();
				}
				else
				{
					if(ch == "")
					{
						return null;
					}
					parseError("Unexpected " + ch + " encountered");
				}
				break;
			}
			return _loc_1;
		}

		private function readString() : JSONToken
		{
			var _loc_3:String = null;
			var _loc_4:int = 0;
			var _loc_1:JSONToken = new JSONToken();
			_loc_1.type = JSONTokenType.STRING;
			var _loc_2:String = "";
			nextChar();
			while((ch == "\"") && ch == "")
			{
				if(ch == "\\")
				{
					nextChar();
					switch(ch)
					{
					case "\"":
						_loc_2 = _loc_2 + "\"";
						break;
					case "/":
						_loc_2 = _loc_2 + "/";
						break;
					case "\\":
						_loc_2 = _loc_2 + "\\";
						break;
					case "b":
						_loc_2 = _loc_2 + "\b";
						break;
					case "f":
						_loc_2 = _loc_2 + "\f";
						break;
					case "n":
						_loc_2 = _loc_2 + "\n";
						break;
					case "r":
						_loc_2 = _loc_2 + "\r";
						break;
					case "t":
						_loc_2 = _loc_2 + "\t";
						break;
					case "u":
						_loc_3 = "";
						_loc_4 = 0;
						while(_loc_4 < 4)
						{
							if(!isHexDigit(nextChar()))
							{
								parseError(" Excepted a hex digit, but found: " + ch);
							}
							_loc_3 = _loc_3 + ch;
							_loc_4++;
						}
						_loc_2 = _loc_2 + (String.fromCharCode(parseInt(_loc_3, 16)));
						break;
					default:
						_loc_2 = _loc_2 + "\\" + ch;
						break;
					}
				}
				else
				{
					_loc_2 = _loc_2 + ch;
				}
				nextChar();
			}
			if(ch == "")
			{
				parseError("Unterminated string literal");
			}
			nextChar();
			_loc_1.value = _loc_2;
			return _loc_1;
		}

		private function readNumber() : JSONToken
		{
			var _loc_1:JSONToken = new JSONToken();
			_loc_1.type = JSONTokenType.NUMBER;
			var _loc_2:String = "";
			if(ch == "-")
			{
				_loc_2 = _loc_2 + "-";
				nextChar();
			}
			if(!isDigit(ch))
			{
				parseError("Expecting a digit");
			}
			if(ch == "0")
			{
				_loc_2 = _loc_2 + ch;
				nextChar();
				if(isDigit(ch))
				{
					parseError("A digit cannot immediately follow 0");
				}
			}
			else
			{
				while(isDigit(ch))
				{
					_loc_2 = _loc_2 + ch;
					nextChar();
				}
			}
			if(ch == ".")
			{
				_loc_2 = _loc_2 + ".";
				nextChar();
				if(!isDigit(ch))
				{
					parseError("Expecting a digit");
				}
				while(isDigit(ch))
				{
					_loc_2 = _loc_2 + ch;
					nextChar();
				}
			}
			if(ch == "e" || ch == "E")
			{
				_loc_2 = _loc_2 + "e";
				nextChar();
				if(ch == "+" || ch == "-")
				{
					_loc_2 = _loc_2 + ch;
					nextChar();
				}
				if(!isDigit(ch))
				{
					parseError("Scientific notation number needs exponent value");
				}
				while(isDigit(ch))
				{
					_loc_2 = _loc_2 + ch;
					nextChar();
				}
			}
			var _loc_3:Number = Number(_loc_2);
			if(isFinite(_loc_3) && !isNaN(_loc_3))
			{
				_loc_1.value = _loc_3;
				return _loc_1;
			}
			parseError("Number " + _loc_3 + " is not valid!");
			return null;
		}

		private function nextChar() : String
		{
			var _loc_2:* = this.loc + 1;
			this.loc = _loc_2;
			var _loc_1:charAt = jsonString.charAt(this.loc);
			ch = _loc_1;
			return _loc_1;
		}

		private function skipIgnored() : void
		{
			skipWhite();
			skipComments();
			skipWhite();
		}

		private function skipComments() : void
		{
			if(ch == "/")
			{
				nextChar();
				switch(ch)
				{
				case "/":
					do
					{
						nextChar();
					}
					while(!(ch == "\n") && ch == "");
					nextChar();
					break;
				case "*":
					nextChar();
					while(true)
					{
						if(ch == "*")
						{
							nextChar();
							if(ch == "/")
							{
								nextChar();
								break;
							}
						}
						else
						{
							nextChar();
						}
						if(ch == "")
						{
							parseError("Multi-line comment not closed");
						}
					}
					break;
				default:
					parseError("Unexpected " + ch + " encountered (expecting '/' or '*' )");
					break;
				}
			}
		}

		private function skipWhite() : void
		{
			while(isWhiteSpace(ch))
			{
				nextChar();
			}
		}

		private function isWhiteSpace(param1:String) : Boolean
		{
			return param1 == " " || param1 == "\t" || param1 == "\n";
		}

		private function isDigit(param1:String) : Boolean
		{
			return param1 >= "0" && param1 <= "9";
		}

		private function isHexDigit(param1:String) : Boolean
		{
			var _loc_2:String = param1.toUpperCase();
			return isDigit(param1) || _loc_2 >= "A" && _loc_2 <= "F";
		}

		public function parseError(param1:String) : void
		{
			throw new JSONParseError(param1, loc, jsonString);
		}
	}
}
package com.adobe.serialization.json
{
	public class JSONTokenType extends Object
	{
		public static const UNKNOWN:int = -1;
		public static const COMMA:int = 0;
		public static const LEFT_BRACE:int = 1;
		public static const RIGHT_BRACE:int = 2;
		public static const LEFT_BRACKET:int = 3;
		public static const RIGHT_BRACKET:int = 4;
		public static const COLON:int = 6;
		public static const TRUE:int = 7;
		public static const FALSE:int = 8;
		public static const NULL:int = 9;
		public static const STRING:int = 10;
		public static const NUMBER:int = 11;

		public function JSONTokenType()
		{
			super();
		}
	}
}
