package com.electrotank.electroserver4.protocol.binary
{
	import com.electrotank.electroserver4.protocol.*;
	import flash.utils.*;

	public class BinaryMessageWriter extends Object implements MessageWriter
	{
		private var buffer:ByteArray;
		private var charset:String;

		final public static function dumpByteArray(param1:ByteArray) : String
		{
			var _loc_2:String = "";
			var _loc_3:int = 0;
			while(_loc_3 < param1.length)
			{
				_loc_2 = _loc_2 + (BinaryMessageWriter.Number(param1[_loc_3]).toString(16) + " ");
				_loc_3++;
			}
			return _loc_2;
		}

		public function BinaryMessageWriter()
		{
			super();
			buffer = new ByteArray();
			buffer.writeInt(0);
			charset = "utf-8";
		}

		public function getBuffer() : ByteArray
		{
			var _loc_1:uint = buffer.position;
			var _loc_2:uint = buffer.length;
			buffer.position = 0;
			buffer.writeInt(_loc_2 - 4);
			buffer.position = _loc_1;
			return buffer;
		}

		public function getMessage() : String
		{
			return buffer.toString();
		}

		public function getData() : String
		{
			return dumpByteArray(buffer);
		}

		public function writeBoolean(param1:Boolean) : void
		{
			buffer.writeBoolean(param1);
		}

		public function writeInteger(...restArguments) : void
		{
			var _loc_2:int = restArguments[0];
			buffer.writeInt(_loc_2);
		}

		public function writeLong(...restArguments) : void
		{
			throw new Error("Writing logs is not supported");
		}

		public function writeDouble(...restArguments) : void
		{
			var _loc_2:Number = restArguments[0];
			buffer.writeDouble(_loc_2);
		}

		public function writeCharacter(param1:String) : void
		{
			buffer.writeByte(0);
			buffer.writeUTFBytes(param1);
		}

		public function writeShort(...restArguments) : void
		{
			var _loc_2:int = restArguments[0];
			buffer.writeShort(_loc_2);
		}

		public function writeByte(param1:int) : void
		{
			buffer.writeByte(param1);
		}

		public function writeFloat(param1:Number) : void
		{
			buffer.writeFloat(param1);
		}

		public function writePrefixedString(param1:String, param2:Number) : void
		{
			writeString(param1);
		}

		public function writeString(param1:String) : void
		{
			buffer.writeUTF(param1);
		}

		public function writeIntegerArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeInteger(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeBooleanArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeBoolean(param1[_loc_3]);
				_loc_3++;
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
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeCharacter(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeDoubleArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeDouble(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeFloatArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeFloat(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeLongArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeLong(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeShortArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeShort(param1[_loc_3]);
				_loc_3++;
			}
		}

		public function writeStringArray(param1:Array) : void
		{
			var _loc_2:int = param1.length;
			writeInteger(_loc_2);
			var _loc_3:int = 0;
			while(_loc_3 < _loc_2)
			{
				writeString(param1[_loc_3]);
				_loc_3++;
			}
		}
	}
}
