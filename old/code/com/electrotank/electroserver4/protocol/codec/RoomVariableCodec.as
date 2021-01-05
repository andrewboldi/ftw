package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RoomVariableCodec extends Object
	{
		final public static function encode(param1:MessageWriter, param2:Array) : void
		{
			var _loc_4:RoomVariable = null;
			param1.writeInteger(param2.length, MessageConstants.ROOM_VARIABLE_COUNT_LENGTH);
			var _loc_3:Number = 0;
			while(_loc_3 < param2.length)
			{
				_loc_4 = param2[_loc_3];
				param1.writePrefixedString(_loc_4.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
				EsObjectCodec.encode(param1, _loc_4.getValue());
				param1.writeBoolean(_loc_4.getLocked());
				param1.writeBoolean(_loc_4.getPersistent());
				_loc_3 = _loc_3 + 1;
			}
		}

		final public static function decode(param1:MessageReader) : Array
		{
			var _loc_5:String = null;
			var _loc_6:EsObject = null;
			var _loc_7:Boolean = false;
			var _loc_8:Boolean = false;
			var _loc_9:RoomVariable = null;
			var _loc_2:Array = new Array();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ROOM_VARIABLE_COUNT_LENGTH);
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = param1.nextPrefixedString(MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
				_loc_6 = EsObjectCodec.decode(param1);
				_loc_7 = param1.nextBoolean();
				_loc_8 = param1.nextBoolean();
				_loc_9 = new RoomVariable(_loc_5, _loc_6, _loc_7, _loc_8);
				_loc_2.push(_loc_9);
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		public function RoomVariableCodec()
		{
			super();
		}
	}
}
