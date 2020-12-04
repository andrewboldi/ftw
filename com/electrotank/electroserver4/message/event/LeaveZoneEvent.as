package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class LeaveZoneEvent extends EventImpl
	{
		private var zoneId:Number;
		private var _zone:Zone;

		public function LeaveZoneEvent()
		{
			super();
			setMessageType(MessageType.LeaveZoneEvent);
		}

		public function set zone(param1:Zone) : void
		{
			_zone = param1;
		}

		public function get zone() : Zone
		{
			return _zone;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
