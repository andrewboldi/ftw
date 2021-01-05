package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PublicMessageRequestCodec extends MessageCodecImpl
	{
		public function PublicMessageRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:PublicMessageRequest = PublicMessageRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getMessage(), MessageConstants.PUBLIC_MESSAGE_PREFIX_LENGTH);
			var _loc_4:EsObject = _loc_3.getEsObject();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
		}
	}
}
