package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class GetRoomsInZoneResponse extends ResponseImpl
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var rooms:Array;

		public function GetRoomsInZoneResponse()
		{
			super();
			setMessageType(MessageType.GetRoomsInZoneResponse);
			rooms = new Array();
			setZoneId(-1);
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function addRoom(param1:Room) : void
		{
			getRooms().push(param1);
		}

		public function getRooms() : Array
		{
			return rooms;
		}
	}
}
