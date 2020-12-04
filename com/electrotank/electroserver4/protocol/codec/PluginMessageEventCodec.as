package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PluginMessageEventCodec extends MessageCodecImpl
	{
		public function PluginMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_3:EsObject = null;
			var _loc_2:PluginMessageEvent = new PluginMessageEvent();
			_loc_2.setPluginName(param1.nextPrefixedString(MessageConstants.PLUGIN_PARM_NAME_PREFIX_LENGTH));
			_loc_2.setSentToRoom(param1.nextBoolean());
			if(_loc_2.wasSentToRoom())
			{
				_loc_2.setDestinationZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_2.setDestinationRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			}
			_loc_2.setIsRoomLevelPlugin(param1.nextBoolean());
			if(_loc_2.getIsRoomLevelPlugin())
			{
				_loc_2.setOriginZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_2.setOriginRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			}
			if(param1.nextBoolean())
			{
				_loc_3 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_3);
			}
			return _loc_2;
		}
	}
}
