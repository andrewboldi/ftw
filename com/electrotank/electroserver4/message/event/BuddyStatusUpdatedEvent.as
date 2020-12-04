package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class BuddyStatusUpdatedEvent extends EventImpl
	{
		public static var LoggedIn:Number = 0;
		public static var LoggedOut:Number = 1;
		private var actionId:Number;
		private var userId:String;
		private var userName:String;
		private var user:User;
		private var esObject:EsObject;
		private var hasEsObject:Boolean;

		public function BuddyStatusUpdatedEvent()
		{
			super();
			setMessageType(MessageType.BuddyStatusUpdatedEvent);
		}

		public function setHasEsObject(param1:Boolean) : void
		{
			hasEsObject = param1;
		}

		public function getHasEsObject() : Boolean
		{
			return hasEsObject;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setUser(param1:User) : void
		{
			user = param1;
		}

		public function getUser() : User
		{
			return user;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}
	}
}
