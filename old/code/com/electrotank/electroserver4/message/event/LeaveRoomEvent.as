package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class LeaveRoomEvent extends EventImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var _room:Room;

		public function LeaveRoomEvent()
		{
			super();
			setMessageType(MessageType.LeaveRoomEvent);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
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
