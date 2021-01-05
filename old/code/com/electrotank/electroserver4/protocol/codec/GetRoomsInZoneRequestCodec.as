package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetRoomsInZoneRequestCodec extends MessageCodecImpl
	{
		public function GetRoomsInZoneRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetRoomsInZoneRequest = GetRoomsInZoneRequest(param2);
			if(_loc_3.getZoneId() != -1)
			{
				param1.writeBoolean(true);
				param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
				param1.writePrefixedString(_loc_3.getZoneName(), MessageConstants.ZONE_NAME_PREFIX_LENGTH);
			}
		}
	}
}
