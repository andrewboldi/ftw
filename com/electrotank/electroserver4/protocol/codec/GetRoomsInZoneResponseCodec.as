package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.room.*;

	public class GetRoomsInZoneResponseCodec extends MessageCodecImpl
	{
		public function GetRoomsInZoneResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Room = null;
			var _loc_2:GetRoomsInZoneResponse = new GetRoomsInZoneResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			if(param1.nextBoolean())
			{
				_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			}
			else
			{
				_loc_2.setZoneName(param1.nextPrefixedString(MessageConstants.ZONE_NAME_PREFIX_LENGTH));
			}
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_COUNT_LENGTH);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = new Room();
				_loc_6.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
				_loc_6.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
				_loc_6.setUserCount(param1.nextInteger(MessageConstants.USER_COUNT_LENGTH));
				_loc_6.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
				_loc_6.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
				_loc_6.setHasPassword(param1.nextBoolean());
				_loc_2.addRoom(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
