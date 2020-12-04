package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class PrivateMessageEvent extends EventImpl
	{
		private var userId:String;
		private var userName:String;
		private var message:String;
		private var esObject:EsObject;
		private var _user:User;

		public function PrivateMessageEvent()
		{
			super();
			setMessageType(MessageType.PrivateMessageEvent);
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
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
