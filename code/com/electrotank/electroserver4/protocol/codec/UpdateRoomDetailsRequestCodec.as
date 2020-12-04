package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateRoomDetailsRequestCodec extends MessageCodecImpl
	{
		public function UpdateRoomDetailsRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:UpdateRoomDetailsRequest = UpdateRoomDetailsRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeBoolean(_loc_3.isRoomNameUpdate());
			if(_loc_3.isRoomNameUpdate())
			{
				param1.writePrefixedString(_loc_3.getRoomName(), MessageConstants.ROOM_NAME_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isCapacityUpdate());
			if(_loc_3.isCapacityUpdate())
			{
				param1.writeInteger(_loc_3.getCapacity(), MessageConstants.ROOM_CAPACITY_LENGTH);
			}
			param1.writeBoolean(_loc_3.isDescriptionUpdate());
			if(_loc_3.isDescriptionUpdate())
			{
				param1.writePrefixedString(_loc_3.getDescription(), MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isPasswordUpdate());
			if(_loc_3.isPasswordUpdate())
			{
				param1.writePrefixedString(_loc_3.getPassword(), MessageConstants.ROOM_PASSWORD_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isHiddenUpdate());
			if(_loc_3.isHiddenUpdate())
			{
				param1.writeBoolean(_loc_3.getHidden());
			}
		}
	}
}
