package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.room.*;

	public class ZoneUpdateEventCodec extends MessageCodecImpl
	{
		public function ZoneUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Room = null;
			var _loc_7:int = NaN;
			var _loc_2:ZoneUpdateEvent = new ZoneUpdateEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_4);
			var _loc_5:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_5);
			if(_loc_4 == ZoneUpdateEvent.AddRoom)
			{
				_loc_6 = new Room();
				_loc_6.setZoneId(_loc_3);
				_loc_6.setRoomId(_loc_5);
				_loc_6.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
				_loc_6.setUserCount(param1.nextInteger(MessageConstants.USER_COUNT_LENGTH));
				_loc_6.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
				_loc_6.setHasPassword(param1.nextBoolean());
				_loc_6.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
				_loc_2.setRoom(_loc_6);
			}
			if(_loc_4 != ZoneUpdateEvent.DeleteRoom)
			{
				_loc_7 = param1.nextInteger(MessageConstants.ROOM_COUNT_LENGTH);
				_loc_2.setRoomCount(_loc_7);
			}
			return _loc_2;
		}
	}
}
