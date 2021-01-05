package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class JoinZoneEvent extends EventImpl
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var rooms:Array;
		private var _zone:Zone;

		public function JoinZoneEvent()
		{
			super();
			setMessageType(MessageType.JoinZoneEvent);
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

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setRooms(param1:Array) : void
		{
			rooms = param1;
		}

		public function getRooms() : Array
		{
			return rooms;
		}
	}
}
