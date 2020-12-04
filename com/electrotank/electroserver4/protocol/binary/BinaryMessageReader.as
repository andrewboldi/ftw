package com.electrotank.electroserver4.protocol.binary
{
	import com.electrotank.electroserver4.protocol.*;
	import flash.utils.*;

	public class BinaryMessageReader extends Object implements MessageReader
	{
		private var buffer:ByteArray;
		private var charset:String;

		public function BinaryMessageReader()
		{
			super();
			charset = "utf-8";
		}

		public function setBuffer(param1:ByteArray) : void
		{
			this.buffer = param1;
		}

		public function nextBoolean() : Boolean
		{
			return buffer.readBoolean();
		}

		public function nextInteger(...restArguments) : int
		{
			return _nextInteger();
		}

		private function _nextInteger() : int
		{
			return buffer.readInt();
		}

		public function nextLong(...restArguments) : String
		{
			var _loc_4:String = null;
			var _loc_2:String = "";
			var _loc_3:int = 0;
			while(_loc_3 < 8)
			{
				_loc_4 = buffer.readByte().toString(16);
				if(_loc_4.length == 1)
				{
					_loc_4 = "0" + _loc_4;
				}
				_loc_2 = _loc_2 + _loc_4;
				_loc_3++;
			}
			return _loc_2;
		}

		private function _nextLong() : String
		{
			return buffer.readUTF();
		}

		public function nextDouble(...restArguments) : Number
		{
			return _nextDouble();
		}

		private function _nextDouble() : Number
		{
			return buffer.readDouble();
		}

		public function nextShort(...restArguments) : Number
		{
			return Number(_nextShort());
		}

		private function _nextShort() : int
		{
			return buffer.readShort();
		}

		public function nextCharacter() : String
		{
			buffer.readByte();
			return buffer.readUTFBytes(1);
		}

		public function nextByte() : int
		{
			return buffer.readByte();
		}

		public function nextFloat() : Number
		{
			return buffer.readFloat();
		}

		public function nextPrefixedString(param1:Number) : String
		{
			return nextString();
		}

		public function nextString(...restArguments) : String
		{
			return buffer.readUTF();
		}

		public function nextIntegerArray(...restArguments) : Array
		{
			var _loc_2:int = _nextInteger();
			var _loc_3:Array = new Array(_loc_2);
			var _loc_4:int = 0;
			while(_loc_4 < _loc_2)
			{
				_loc_3[_loc_4] = _nextInteger();
				_loc_4++;
			}
			return _loc_3;
		}

		public function nextBooleanArray() : Array
		{
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
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
			var _loc_1:int = _nextInteger();
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
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
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
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = _nextDouble();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextFloatArray() : Array
		{
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
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
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = _nextLong();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextShortArray() : Array
		{
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = _nextShort();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function nextStringArray() : Array
		{
			var _loc_1:int = _nextInteger();
			var _loc_2:Array = new Array(_loc_1);
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_1)
			{
				_loc_2[_loc_3] = nextString();
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}
	}
}
