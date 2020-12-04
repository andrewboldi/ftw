package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class EvictUserFromRoomRequestCodec extends MessageCodecImpl
	{
		public function EvictUserFromRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:EvictUserFromRoomRequest = EvictUserFromRoomRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeLong(_loc_3.getUserId(), MessageConstants.USER_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getReason(), MessageConstants.ROOM_EVICTION_REASON_PREFIX_LENGTH);
			param1.writeBoolean(_loc_3.isBan());
			if(_loc_3.isBan())
			{
				param1.writeInteger(_loc_3.getDuration(), MessageConstants.ROOM_BAN_DURATION_LENGTH);
			}
		}
	}
}
