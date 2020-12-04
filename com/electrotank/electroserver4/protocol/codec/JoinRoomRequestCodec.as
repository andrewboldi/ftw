package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class JoinRoomRequestCodec extends MessageCodecImpl
	{
		public function JoinRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:JoinRoomRequest = JoinRoomRequest(param2);
			var _loc_4:Number = _loc_3.getZoneId();
			var _loc_5:Number = _loc_3.getRoomId();
			var _loc_6:String = _loc_3.getPassword();
			var _loc_7:Boolean = _loc_3.getIsReceivingRoomListUpdates();
			var _loc_8:Boolean = _loc_3.getIsReceivingRoomDetailUpdates();
			var _loc_9:Boolean = _loc_3.getIsReceivingUserListUpdates();
			var _loc_10:Boolean = _loc_3.getIsReceivingRoomVariableUpdates();
			var _loc_11:Boolean = _loc_3.getIsReceivingUserVariableUpdates();
			var _loc_12:Boolean = _loc_3.getIsReceivingVideoEvents();
			param1.writeInteger(_loc_4, MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_5, MessageConstants.ROOM_ID_LENGTH);
			if((_loc_6 == null) && _loc_6 == "")
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_6, MessageConstants.ROOM_PASSWORD_PREFIX_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
			}
			param1.writeBoolean(_loc_7);
			param1.writeBoolean(_loc_8);
			param1.writeBoolean(_loc_9);
			param1.writeBoolean(_loc_10);
			param1.writeBoolean(_loc_11);
			param1.writeBoolean(_loc_12);
		}
	}
}
