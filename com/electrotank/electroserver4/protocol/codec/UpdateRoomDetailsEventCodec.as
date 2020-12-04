package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateRoomDetailsEventCodec extends MessageCodecImpl
	{
		public function UpdateRoomDetailsEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:UpdateRoomDetailsEvent = new UpdateRoomDetailsEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setRoomNameUpdate(param1.nextBoolean());
			if(_loc_2.isRoomNameUpdate())
			{
				_loc_2.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
			}
			_loc_2.setCapacityUpdate(param1.nextBoolean());
			if(_loc_2.isCapacityUpdate())
			{
				_loc_2.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
			}
			_loc_2.setDescriptionUpdate(param1.nextBoolean());
			if(_loc_2.isDescriptionUpdate())
			{
				_loc_2.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
			}
			_loc_2.setPasswordUpdate(param1.nextBoolean());
			_loc_2.setHiddenUpdate(param1.nextBoolean());
			if(_loc_2.isHiddenUpdate())
			{
				_loc_2.setHidden(param1.nextBoolean());
			}
			return _loc_2;
		}
	}
}
