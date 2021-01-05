package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class PublicMessageEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var userName:String;
		private var message:String;
		private var esObject:EsObject;
		private var userNameIncluded:Boolean;
		private var _user:User;
		private var _room:Room;

		public function PublicMessageEvent()
		{
			super();
			setMessageType(MessageType.PublicMessageEvent);
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserNameIncluded(param1:Boolean) : void
		{
			userNameIncluded = param1;
		}

		public function isUserNameIncluded() : Boolean
		{
			return userNameIncluded;
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

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setMessage(param1:String) : void
		{
			message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}
	}
}
