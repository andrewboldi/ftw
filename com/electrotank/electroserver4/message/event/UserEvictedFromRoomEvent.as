package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class UserEvictedFromRoomEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var reason:String;
		private var ban:Boolean;
		private var duration:Number;
		private var _user:User;

		public function UserEvictedFromRoomEvent()
		{
			super();
			setMessageType(MessageType.UserEvictedFromRoomEvent);
			ban = false;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function isBan() : Boolean
		{
			return ban;
		}

		public function setBan(param1:Boolean) : void
		{
			ban = param1;
		}

		public function setDuration(param1:Number) : void
		{
			duration = param1;
		}

		public function getDuration() : Number
		{
			return duration;
		}

		public function setReason(param1:String) : void
		{
			reason = param1;
		}

		public function getReason() : String
		{
			return reason;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
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
