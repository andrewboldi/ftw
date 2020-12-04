package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class UpdateRoomDetailsRequest extends RequestImpl
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

		public function UpdateRoomDetailsRequest()
		{
			super();
			setMessageType(MessageType.UpdateRoomDetailsRequest);
			setHiddenUpdate(false);
			setPasswordUpdate(false);
			setDescriptionUpdate(false);
			setCapacityUpdate(false);
			setRoomNameUpdate(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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

		private function setHiddenUpdate(param1:Boolean) : void
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
			this.password = param1;
		}

		public function isPasswordUpdate() : Boolean
		{
			return passwordUpdate;
		}

		private function setPasswordUpdate(param1:Boolean) : void
		{
			passwordUpdate = param1;
		}

		public function setDescription(param1:String) : void
		{
			setDescriptionUpdate(true);
			this.description = param1;
		}

		public function getDescription() : String
		{
			return description;
		}

		private function setDescriptionUpdate(param1:Boolean) : void
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
			this.capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		private function setCapacityUpdate(param1:Boolean) : void
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
			this.roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		private function setRoomNameUpdate(param1:Boolean) : void
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
