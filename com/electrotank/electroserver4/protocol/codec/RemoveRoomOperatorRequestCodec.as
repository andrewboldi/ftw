package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RemoveRoomOperatorRequestCodec extends MessageCodecImpl
	{
		public function RemoveRoomOperatorRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:RemoveRoomOperatorRequest = RemoveRoomOperatorRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeLong(_loc_3.getUserId(), MessageConstants.USER_ID_LENGTH);
		}
	}
}
