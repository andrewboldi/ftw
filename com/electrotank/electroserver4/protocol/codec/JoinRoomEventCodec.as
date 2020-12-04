package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class JoinRoomEventCodec extends MessageCodecImpl
	{
		public function JoinRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:JoinRoomEvent = new JoinRoomEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
			_loc_2.setRoomDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
			_loc_2.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
			_loc_2.setIsHidden(param1.nextBoolean());
			_loc_2.setHasPassword(param1.nextBoolean());
			_loc_2.setUsers(UserListCodec.decode(param1));
			var _loc_3:Array = new Array();
			_loc_3 = RoomVariableCodec.decode(param1);
			_loc_2.setRoomVariables(_loc_3);
			return _loc_2;
		}
	}
}
