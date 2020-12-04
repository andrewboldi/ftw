package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindZoneAndRoomByNameRequestCodec extends MessageCodecImpl
	{
		public function FindZoneAndRoomByNameRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:FindZoneAndRoomByNameRequest = FindZoneAndRoomByNameRequest(param2);
			param1.writePrefixedString(_loc_3.getZoneName(), MessageConstants.ZONE_NAME_PREFIX_LENGTH);
			param1.writePrefixedString(_loc_3.getRoomName(), MessageConstants.ROOM_NAME_PREFIX_LENGTH);
		}
	}
}
