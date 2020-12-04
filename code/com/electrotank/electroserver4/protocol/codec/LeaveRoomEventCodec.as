package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LeaveRoomEventCodec extends MessageCodecImpl
	{
		public function LeaveRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:LeaveRoomEvent = new LeaveRoomEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_4);
			return _loc_2;
		}
	}
}
