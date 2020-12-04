package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class UpdateRoomDetailsEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var roomNameUpdate:Boolean;
		private var roomName:String;
		private var capacityUpdate:Boolean;
		private var capacity:Number;
		private var descriptionUpdate:Boolean;
		private var description:String;
		private var passwordUpdate:Boolean;
		private var password:String;
		private var hiddenUpdate:Boolean;
		private var hidden:Boolean;
		private var _room:Room;

		public function UpdateRoomDetailsEvent()
		{
			super();
			setMessageType(MessageType.UpdateRoomDetailsEvent);
			setHiddenUpdate(false);
			setPasswordUpdate(false);
			setDescriptionUpdate(false);
			setCapacityUpdate(false);
			setRoomNameUpdate(false);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function setHidden(param1:Boolean) : void
		{
			setHiddenUpdate(true);
			hidden = param1;
		}

		public function getHidden() : Boolean
		{
			return hidden;
		}

		public function setHiddenUpdate(param1:Boolean) : void
		{
			hiddenUpdate = param1;
		}

		public function isHiddenUpdate() : Boolean
		{
			return hiddenUpdate;
		}

		public function getPassword() : String
		{
			return password;
		}

		public function setPassword(param1:String) : void
		{
			setPasswordUpdate(true);
			password = param1;
		}

		public function isPasswordUpdate() : Boolean
		{
			return passwordUpdate;
		}

		public function setPasswordUpdate(param1:Boolean) : void
		{
			passwordUpdate = param1;
		}

		public function setDescription(param1:String) : void
		{
			setDescriptionUpdate(true);
			description = param1;
		}

		public function getDescription() : String
		{
			return description;
		}

		public function setDescriptionUpdate(param1:Boolean) : void
		{
			descriptionUpdate = param1;
		}

		public function isDescriptionUpdate() : Boolean
		{
			return descriptionUpdate;
		}

		public function setCapacity(param1:Number) : void
		{
			setCapacityUpdate(true);
			capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setCapacityUpdate(param1:Boolean) : void
		{
			capacityUpdate = param1;
		}

		public function isCapacityUpdate() : Boolean
		{
			return capacityUpdate;
		}

		public function setRoomName(param1:String) : void
		{
			setRoomNameUpdate(true);
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		public function setRoomNameUpdate(param1:Boolean) : void
		{
			roomNameUpdate = param1;
		}

		public function isRoomNameUpdate() : Boolean
		{
			return roomNameUpdate;
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
