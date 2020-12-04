package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LeaveZoneEventCodec extends MessageCodecImpl
	{
		public function LeaveZoneEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:LeaveZoneEvent = new LeaveZoneEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			return _loc_2;
		}
	}
}
