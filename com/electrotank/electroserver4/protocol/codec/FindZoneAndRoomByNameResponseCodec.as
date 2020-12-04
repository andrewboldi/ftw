package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindZoneAndRoomByNameResponseCodec extends MessageCodecImpl
	{
		public function FindZoneAndRoomByNameResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:Array = null;
			var _loc_2:FindZoneAndRoomByNameResponse = new FindZoneAndRoomByNameResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Number = param1.nextInteger(MessageConstants.ZONE_AND_ROOM_ID_LIST_LENGTH);
			var _loc_5:Array = new Array();
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_4)
			{
				_loc_7 = new Array();
				_loc_7[0] = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
				_loc_7[1] = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
				_loc_5.push(_loc_7);
				_loc_6 = _loc_6 + 1;
			}
			_loc_2.setRoomAndZoneList(_loc_5);
			return _loc_2;
		}
	}
}
