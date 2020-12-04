package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class JoinRoomRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var password:String;
		private var isReceivingRoomListUpdates:Boolean;
		private var isReceivingUserListUpdates:Boolean;
		private var isReceivingRoomVariableUpdates:Boolean;
		private var isReceivingUserVariableUpdates:Boolean;
		private var isReceivingVideoEvents:Boolean;
		private var isReceivingRoomDetailUpdates:Boolean;
		private var room:Room;

		public function JoinRoomRequest()
		{
			super();
			setMessageType(MessageType.JoinRoomRequest);
			setRoomId(-1);
			setZoneId(-1);
			setIsReceivingRoomListUpdates(true);
			setIsReceivingRoomDetailUpdates(true);
			setIsReceivingUserListUpdates(true);
			setIsReceivingRoomVariableUpdates(true);
			setIsReceivingUserVariableUpdates(true);
			setIsReceivingVideoEvents(true);
		}

		public function setIsReceivingRoomDetailUpdates(param1:Boolean) : void
		{
			this.isReceivingRoomDetailUpdates = param1;
		}

		public function getIsReceivingRoomDetailUpdates() : Boolean
		{
			return isReceivingRoomDetailUpdates;
		}

		public function getRoom() : Room
		{
			return room;
		}

		public function getIsReceivingVideoEvents() : Boolean
		{
			return this.isReceivingVideoEvents;
		}

		public function setIsReceivingVideoEvents(param1:Boolean) : void
		{
			this.isReceivingVideoEvents = param1;
		}

		public function setIsReceivingRoomListUpdates(param1:Boolean) : void
		{
			isReceivingRoomListUpdates = param1;
		}

		public function getIsReceivingRoomListUpdates() : Boolean
		{
			return isReceivingRoomListUpdates;
		}

		public function setIsReceivingUserListUpdates(param1:Boolean) : void
		{
			isReceivingUserListUpdates = param1;
		}

		public function getIsReceivingUserListUpdates() : Boolean
		{
			return isReceivingUserListUpdates;
		}

		public function setIsReceivingRoomVariableUpdates(param1:Boolean) : void
		{
			isReceivingRoomVariableUpdates = param1;
		}

		public function getIsReceivingRoomVariableUpdates() : Boolean
		{
			return isReceivingRoomVariableUpdates;
		}

		public function setIsReceivingUserVariableUpdates(param1:Boolean) : void
		{
			isReceivingUserVariableUpdates = param1;
		}

		public function getIsReceivingUserVariableUpdates() : Boolean
		{
			return isReceivingUserVariableUpdates;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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

		public function setPassword(param1:String) : void
		{
			password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}
	}
}
