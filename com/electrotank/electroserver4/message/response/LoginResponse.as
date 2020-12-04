package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class LoginResponse extends ResponseImpl
	{
		private var accepted:Boolean;
		private var esError:EsError;
		private var esObject:EsObject;
		private var userName:String;
		private var userId:String;
		private var userVariables:Array;
		private var buddies:Object;

		public function LoginResponse()
		{
			super();
			setMessageType(MessageType.LoginResponse);
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function setBuddies(param1:Object) : void
		{
			buddies = param1;
		}

		public function getBuddies() : Object
		{
			return buddies;
		}

		public function setUserId(param1:String) : void
		{
			this.userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function get success() : Boolean
		{
			return getAccepted();
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setAccepted(param1:Boolean) : void
		{
			accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}

		public function setEsError(param1:EsError) : void
		{
			esError = param1;
		}

		public function getEsError() : EsError
		{
			return esError;
		}
	}
}
