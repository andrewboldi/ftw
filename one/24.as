package com.electrotank.electroserver4.protocol.text
{
	import com.electrotank.electroserver4.protocol.*;
	import flash.utils.*;

	public class StringMessageReader extends Object implements MessageReader
	{
		private var data:String;
		private var currentPosition:Number;

		public function StringMessageReader()
		{
			super();
			setCurrentPosition(0);
		}

		public function setMessage(param1:String) : void
		{
			data = param1;
		}

		public function getMessage() : String
		{
			return data;
		}

		public function nextPrefixedString(param1:Number) : String
		{
			var _loc_2:int = nextInteger(param1);
			var _loc_3:String = _nextString(_loc_2);
			return _loc_3;
		}

		public function nextString(...restArguments) : String
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			var _loc_4:String = null;
			if(restArguments.length == 0)
			{
				_loc_2 = _nextPrefix();
				return nextPrefixedString(_loc_2);
			}
			_loc_3 = restArguments[0];
			_loc_4 = _nextString(_loc_3);
			return _loc_4;
		}

		private function trim(param1:String) : String
		{
			var _loc_2:String = " ";
			while((param1.substr(0, 1)) == _loc_2)
			{
				param1 = param1.substr(1);
			}
			return param1;
		}

		public function nextInteger(...restArguments) : int
		{
			var _loc_2:String = null;
			var _loc_3:int = 0;
			if(restArguments.length == 1)
			{
				_loc_2 = _nextString(restArguments[0]);
				_loc_3 = parseInt(_loc_2);
				return _loc_3;
			}
			return nextInteger(_nextPrefix());
		}

		public function nextLong(...restArguments) : String
		{
			if(restArguments.length == 1)
			{
				return _nextString(restArguments[0]);
			}
			return nextLong(_nextPrefix());
		}

		public function nextDouble(...restArguments) : Number
		{
			if(restArguments.length == 1)
			{
				return parseFloat(trim(_nextString(restArguments[0])));
			}
			return nextDouble(_nextPrefix());
		}

		public function nextShort(...restArguments) : Number
		{
			var _loc_2:int = NaN;
			var _loc_3:String = null;
			var _loc_4:String = null;
			var _loc_5:int = NaN;
			var _loc_6:int = NaN;
			if(restArguments.length == 1)
			{
				_loc_2 = restArguments[0];
				_loc_3 = _nextString(_loc_2);
				_loc_4 = trim(_loc_3);
				return parseInt(_loc_4);
			}
			_loc_5 = _nextPrefix();
			_loc_6 = nextShort(_loc_5);
			return _loc_6;
		}

		public function nextCharacter() : String
		{
			var _loc_1:String = _nextString(1);
			return _loc_1.charAt(0);
		}

		public function nextBoolean() : Boolean
		{
			var _loc_1:Boolean = false;
			var _loc_2:int = nextInteger(1);
			if(_loc_2 == 1)
			{
				_loc_1 = true;
			}
			return _loc_1;
		}

		public function nextByte() : int
		{
			var _loc_1:int = int("0x" + nextString());
			return _loc_1;
		}

		public function nextFloat() : Number
		{
			return parseFloat(trim(_nextString(_nextPrefix())));
		}

		public function nextIntegerArray(...restArguments) : Array
		{
			var _loc_2:Array = null;
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			var _loc_6:int = NaN;
			if(restArguments.length == 2)
			{
				_loc_4 = restArguments[0];
				_loc_5 = restArguments[1];
				_loc_2 = new Array();
				_loc_3 = 0;
				while(_loc_3 < _loc_4)
				{
					_loc_2[_loc_3] = nextInteger(_loc_5);
					_loc_3 = _loc_3 + 1;
				}
				return _loc_2;
			}
			else
			{
				_loc_6 = _nextArrayPrefix();
				_loc_2 = new Array();
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_2[_loc_3] = nextInteger();
					_loc_3 = _loc_3 + 1;
				}
				return _loc_2;
			}
		}

		public function nextBooleanArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextBoolean();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextByteArray() : ByteArray
		{
			var _loc_1:int = nextInteger();
			var _loc_2:ByteArray = new ByteArray();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextByte();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextCharacterArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextCharacter();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextDoubleArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			trace("count: " + _loc_1);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextDouble();
				_loc_3 = _loc_3 + 1;
			}
			trace(_loc_2);
			return _loc_2;
		}

		public function nextFloatArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextFloat();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextLongArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextLong();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextShortArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextShort();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextStringArray() : Array
		{
			var _loc_1:Number = _nextArrayPrefix();
			var _loc_2:Array = new Array();
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextString();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function getData() : String
		{
			return data;
		}

		public function setData(param1:String) : void
		{
			data = param1;
		}

		public function getCurrentPosition() : Number
		{
			return currentPosition;
		}

		public function setCurrentPosition(param1:Number) : void
		{
			currentPosition = param1;
		}

		private function _nextString(param1:Number) : String
		{
			if(data.length < (currentPosition + param1))
			{
				trace("Requested string is longer than available data");
			}
			var _loc_2:String = data.substring(currentPosition, currentPosition + param1);
			currentPosition = currentPosition + param1;
			return _loc_2;
		}

		private function _nextPrefix() : Number
		{
			var _loc_1:String = nextCharacter();
			return parseInt(_loc_1, 36);
		}

		private function _nextArrayPrefix() : int
		{
			return nextInteger(_nextPrefix());
		}
	}
}
package com.electrotank.electroserver4.protocol.text
{
	import com.electrotank.electroserver4.protocol.*;
	import flash.utils.*;

	public class StringMessageWriter extends Object implements MessageWriter
	{
		private var data:String;
		private var pads_arr:Array;

		public function StringMessageWriter()
		{
			super();
			pads_arr = ["", " ", "  ", "   ", "    ", "     ", "      ", "       ", "        ", "         ", "          ", "           ", "            ", "             ", "              ", "               ", "                ", "                 ", "                  ", "                   "];
			setMessage("");
		}

		public function setMessage(param1:String) : void
		{
			data = param1;
		}

		public function getMessage() : String
		{
			return data;
		}

		private function pad(param1:String, param2:Number) : String
		{
			var _loc_3:Number = param2 - param1.length;
			param1 = pads_arr[_loc_3] + param1;
			return param1;
		}

		public function append(param1:String) : void
		{
			data = data + param1;
		}

		public function writeCharacter(param1:String) : void
		{
			append(param1);
		}

		public function writePrefixedString(param1:String, param2:Number) : void
		{
			if(param1 == null)
			{
				param1 = "";
			}
			if(param2 > 0)
			{
				writeInteger(param1.length, param2);
			}
			append(param1);
		}

		private function trim(param1:String) : String
		{
			var _loc_2:String = " ";
			while((param1.substr(0, 1)) == _loc_2)
			{
				param1 = param1.substr(1);
			}
			return param1;
		}

		public function writeString(param1:String) : void
		{
			if(param1 == null)
			{
				return;
			}
			var _loc_2:String = trim(param1);
			writeInteger(_loc_2.length);
			append(_loc_2);
		}

		public function writeInteger(...restArguments) : void
		{
			var _loc_4:int = NaN;
			var _loc_2:int = restArguments[0];
			var _loc_3:String = _loc_2.toString();
			if(restArguments.length == 2)
			{
				_loc_4 = restArguments[1];
				if(_loc_3.length > _loc_4)
				{
					trace("Integer is longer then the specified length");
				}
				append(pad(_loc_3, _loc_4));
			}
			else
			{
				_writePrefix(_loc_3.length);
				append(_loc_3);
			}
		}

		public function writeLong(...restArguments) : void
		{
			var _loc_4:int = NaN;
			var _loc_2:String = restArguments[0];
			var _loc_3:String = _loc_2.toString();
			if(restArguments.length == 2)
			{
				_loc_4 = restArguments[1];
				if(_loc_3.length > _loc_4)
				{
					trace("Long is longer then the specified length");
				}
				append(pad(_loc_3, _loc_4));
			}
			else
			{
				_writePrefix(_loc_3.length);
				append(_loc_3);
			}
		}

		public function writeDouble(...restArguments) : void
		{
			var _loc_4:int = NaN;
			var _loc_2:Number = restArguments[0];
			var _loc_3:String = _loc_2.toString();
			if(restArguments.length == 2)
			{
				_loc_4 = restArguments[1];
				if(_loc_3.length > _loc_4)
				{
					trace("Double is longer then the specified length");
				}
				append(pad(_loc_3, _loc_4));
			}
			else
			{
				_writePrefix(_loc_3.length);
				append(_loc_3);
			}
		}

		public function writeBoolean(param1:Boolean) : void
		{
			if(param1)
			{
				append("1");
			}
			else
			{
				append("0");
			}
		}

		public function writeShort(...restArguments) : void
		{
			var _loc_4:int = NaN;
			var _loc_2:Number = restArguments[0];
			var _loc_3:String = _loc_2.toString();
			if(restArguments.length == 2)
			{
				_loc_4 = restArguments[1];
				if(_loc_3.length > _loc_4)
				{
					trace("Integer is longer then the specified length");
				}
				append(pad(_loc_3, _loc_4));
			}
			else
			{
				_writePrefix(_loc_3.length);
				append(_loc_3);
			}
		}

		public function writeByte(param1:int) : void
		{
			var _loc_2:String = param1.toString(16);
			if(_loc_2.length < 2)
			{
				_loc_2 = "0" + _loc_2;
			}
			writeString(_loc_2);
		}

		public function writeFloat(param1:Number) : void
		{
			var _loc_2:String = param1.toString();
			_writePrefix(_loc_2.length);
			append(_loc_2);
		}

		public function writeIntegerArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeInteger(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeBooleanArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeBoolean(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeByteArray(param1:ByteArray) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeByte(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeCharacterArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeCharacter(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeDoubleArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeDouble(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeFloatArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeFloat(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeLongArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeLong(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeShortArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeShort(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function writeStringArray(param1:Array) : void
		{
			var _loc_2:Number = param1.length;
			_writeArrayPrefix(_loc_2);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2)
			{
				writeString(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		public function getData() : String
		{
			return data;
		}

		public function setData(param1:String) : void
		{
			data = param1;
		}

		private function _writePrefix(param1:Number) : void
		{
			append(param1.toString(36));
		}

		private function _writeArrayPrefix(param1:Number) : void
		{
			_writePrefix(param1.toString().length);
			append(param1.toString());
		}
	}
}
