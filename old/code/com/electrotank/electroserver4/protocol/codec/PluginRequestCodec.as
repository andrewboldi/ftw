package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PluginRequestCodec extends MessageCodecImpl
	{
		public function PluginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:PluginRequest = PluginRequest(param2);
			param1.writePrefixedString(_loc_3.getPluginName(), MessageConstants.PLUGIN_NAME_PREFIX_LENGTH);
			param1.writeBoolean(_loc_3.wasSentToRoom());
			if(_loc_3.wasSentToRoom())
			{
				param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
				param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			}
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
