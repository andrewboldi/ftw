package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CompositePluginMessageEventCodec extends MessageCodecImpl
	{
		public function CompositePluginMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:CompositePluginMessageEvent = new CompositePluginMessageEvent();
			_loc_2.setPluginName(param1.nextPrefixedString(MessageConstants.PLUGIN_PARM_NAME_PREFIX_LENGTH));
			_loc_2.setOriginZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setOriginRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			var _loc_3:Number = param1.nextInteger(MessageConstants.COMPOSITE_ESOBJECT_ARRAY_PREFIX_LENGTH);
			var _loc_4:Array = new Array();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3)
			{
				_loc_4.push(EsObjectCodec.decode(param1));
				_loc_5 = _loc_5 + 1;
			}
			_loc_2.setParameters(_loc_4);
			return _loc_2;
		}
	}
}
