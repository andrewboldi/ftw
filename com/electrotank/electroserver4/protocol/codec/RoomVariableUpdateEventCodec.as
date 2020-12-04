package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RoomVariableUpdateEventCodec extends MessageCodecImpl
	{
		public function RoomVariableUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:RoomVariableUpdateEvent = new RoomVariableUpdateEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUpdateAction(param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH));
			_loc_2.setName(param1.nextPrefixedString(MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH));
			if(_loc_2.getUpdateAction() != RoomVariableUpdateEvent.VariableDeleted)
			{
				_loc_2.setValueChanged(param1.nextBoolean());
				if(_loc_2.getValueChanged())
				{
					_loc_2.setValue(EsObjectCodec.decode(param1));
				}
				_loc_2.setLockChanged(param1.nextBoolean());
				if(_loc_2.getLockChanged())
				{
					_loc_2.setLocked(param1.nextBoolean());
				}
				if(_loc_2.getUpdateAction() == RoomVariableUpdateEvent.VariableCreated)
				{
					_loc_2.setPersistent(param1.nextBoolean());
				}
			}
			return _loc_2;
		}
	}
}
