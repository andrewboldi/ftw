package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class GetUsersInRoomResponse extends ResponseImpl
	{
		private var users:Array;
		private var roomId:Number;
		private var zoneId:Number;

		public function GetUsersInRoomResponse()
		{
			super();
			setMessageType(MessageType.GetUsersInRoomResponse);
		}

		public function setUsers(param1:Array) : void
		{
			users = param1;
		}

		public function getUsers() : Array
		{
			return users;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
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
