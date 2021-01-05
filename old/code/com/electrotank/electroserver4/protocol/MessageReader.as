package com.electrotank.electroserver4.protocol
{
	import flash.utils.*;

	public interface MessageReader
	{
		function nextPrefixedString(param1:Number) : String;

		function nextCharacter() : String;

		function nextBoolean() : Boolean;

		function nextString(...restArguments) : String;

		function nextShort(...restArguments) : Number;

		function nextInteger(...restArguments) : int;

		function nextLong(...restArguments) : String;

		function nextDouble(...restArguments) : Number;

		function nextFloat() : Number;

		function nextByte() : int;

		function nextIntegerArray(...restArguments) : Array;

		function nextStringArray() : Array;

		function nextCharacterArray() : Array;

		function nextBooleanArray() : Array;

		function nextShortArray() : Array;

		function nextLongArray() : Array;

		function nextDoubleArray() : Array;

		function nextFloatArray() : Array;

		function nextByteArray() : ByteArray;
	}
}
