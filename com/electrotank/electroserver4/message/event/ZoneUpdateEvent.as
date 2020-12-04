package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class ZoneUpdateEvent extends EventImpl
	{
		public static var AddRoom:Number = 0;
		public static var DeleteRoom:Number = 1;
		public static var UpdateRoom:Number = 2;
		private var zoneId:Number;
		private var roomId:Number;
		private var actionId:Number;
		private var roomCount:Number;
		private var __room:Room;
		private var _room:Room;
		private var _minorType:String;
		private var _zone:Zone;

		public function ZoneUpdateEvent()
		{
			super();
			setMessageType(MessageType.ZoneUpdateEvent);
		}

		public function set zone(param1:Zone) : void
		{
			_zone = param1;
		}

		public function get zone() : Zone
		{
			return _zone;
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function setRoom(param1:Room) : void
		{
			__room = param1;
		}

		public function getRoom() : Room
		{
			return __room;
		}

		public function setRoomCount(param1:Number) : void
		{
			roomCount = param1;
		}

		public function getRoomCount() : Number
		{
			return roomCount;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
