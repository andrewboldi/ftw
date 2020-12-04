package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class UserListUpdateEvent extends EventImpl
	{
		public static var AddUser:Number = 0;
		public static var DeleteUser:Number = 1;
		public static var UpdateUser:Number = 2;
		public static var OperatorGranted:Number = 3;
		public static var OperatorRevoked:Number = 4;
		public static var SendingVideoStream:Number = 5;
		public static var StoppingVideoStream:Number = 6;
		private var roomId:Number;
		private var zoneId:Number;
		private var actionId:Number;
		private var userId:String;
		private var userName:String;
		private var userVariables:Array;
		private var _user:User;
		private var _room:Room;
		private var _minorType:String;
		private var isSendingVideo:Boolean;
		private var videoStreamName:String;

		public function UserListUpdateEvent()
		{
			super();
			setMessageType(MessageType.UserListUpdateEvent);
		}

		public function setIsSendingVideo(param1:Boolean) : void
		{
			this.isSendingVideo = param1;
		}

		public function setUser(param1:User) : void
		{
			user = param1;
		}

		public function getUser() : User
		{
			return user;
		}

		public function getIsSendingVideo() : Boolean
		{
			return this.isSendingVideo;
		}

		public function setVideoStreamName(param1:String) : void
		{
			this.videoStreamName = param1;
		}

		public function getVideoStreamName() : String
		{
			return this.videoStreamName;
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

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
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
