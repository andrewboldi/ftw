package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class JoinRoomEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var roomName:String;
		private var zoneName:String;
		private var roomDescription:String;
		private var users:Array;
		private var roomVariables:Array;
		private var capacity:Number;
		private var isHidden:Boolean;
		private var hasPassword:Boolean;
		private var _room:Room;

		public function JoinRoomEvent()
		{
			super();
			setMessageType(MessageType.JoinRoomEvent);
			roomVariables = new Array();
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function setCapacity(param1:Number) : void
		{
			capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setIsHidden(param1:Boolean) : void
		{
			isHidden = param1;
		}

		public function getIsHidden() : Boolean
		{
			return isHidden;
		}

		public function setHasPassword(param1:Boolean) : void
		{
			hasPassword = param1;
		}

		public function getHasPassword() : Boolean
		{
			return hasPassword;
		}

		public function setRoomVariables(param1:Array) : void
		{
			roomVariables = param1;
		}

		public function getRoomVariables() : Array
		{
			return roomVariables;
		}

		public function setUsers(param1:Array) : void
		{
			users = param1;
		}

		public function getUsers() : Array
		{
			return users;
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

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setRoomName(param1:String) : void
		{
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		public function setRoomDescription(param1:String) : void
		{
			roomDescription = param1;
		}

		public function getRoomDescription() : String
		{
			return roomDescription;
		}
	}
}
