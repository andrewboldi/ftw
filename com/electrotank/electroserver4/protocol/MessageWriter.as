package com.electrotank.electroserver4.protocol
{
	import flash.utils.*;

	public interface MessageWriter
	{
		function getData() : String;

		function writePrefixedString(param1:String, param2:Number) : void;

		function writeCharacter(param1:String) : void;

		function writeBoolean(param1:Boolean) : void;

		function writeInteger(...restArguments) : void;

		function writeString(param1:String) : void;

		function writeLong(...restArguments) : void;

		function writeFloat(param1:Number) : void;

		function writeDouble(...restArguments) : void;

		function writeShort(...restArguments) : void;

		function writeByte(param1:int) : void;

		function writeIntegerArray(param1:Array) : void;

		function writeStringArray(param1:Array) : void;

		function writeLongArray(param1:Array) : void;

		function writeFloatArray(param1:Array) : void;

		function writeDoubleArray(param1:Array) : void;

		function writeShortArray(param1:Array) : void;

		function writeByteArray(param1:ByteArray) : void;

		function writeCharacterArray(param1:Array) : void;

		function writeBooleanArray(param1:Array) : void;
	}
}
