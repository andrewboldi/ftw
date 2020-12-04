package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PrivateMessageRequest extends RequestImpl
	{
		private var message:String;
		private var pairs:Array;
		private var users:Array;
		private var userNames:Array;
		private var esObject:EsObject;

		public function PrivateMessageRequest()
		{
			super();
			setMessageType(MessageType.PrivateMessageRequest);
			setUsers(new Array());
			setUserNames(new Array());
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getUsers().length == 0 && getUserNames().length == 0)
			{
				_loc_2.push("getUsers() is empty.");
			}
			if(getUsers() == null)
			{
				_loc_2.push("getUsers() returned null.");
			}
			if(getMessage() == null)
			{
				_loc_2.push("getMessage() returned null.");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserNames(param1:Array) : void
		{
			userNames = param1;
		}

		public function getUserNames() : Array
		{
			return userNames;
		}

		public function setUsers(param1:Array) : void
		{
			this.users = param1;
		}

		public function getUsers() : Array
		{
			return users;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setMessage(param1:String) : void
		{
			this.message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}
	}
}
