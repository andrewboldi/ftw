package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserEvictedFromRoomEventCodec extends MessageCodecImpl
	{
		public function UserEvictedFromRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:UserEvictedFromRoomEvent = new UserEvictedFromRoomEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setReason(param1.nextPrefixedString(MessageConstants.ROOM_EVICTION_REASON_PREFIX_LENGTH));
			_loc_2.setBan(param1.nextBoolean());
			if(_loc_2.isBan())
			{
				_loc_2.setDuration(param1.nextInteger(MessageConstants.ROOM_BAN_DURATION_LENGTH));
			}
			return _loc_2;
		}
	}
}
