package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GetUserVariablesResponse extends ResponseImpl
	{
		private var userVariables:Array;
		private var userVariablesByName:Object;
		private var userName:String;

		public function GetUserVariablesResponse()
		{
			super();
			setMessageType(MessageType.GetUserVariablesResponse);
			userVariables = new Array();
			userVariablesByName = new Object();
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function addVariable(param1:String, param2:EsObject) : void
		{
			var _loc_3:UserVariable = new UserVariable(param1, param2);
			userVariablesByName[param1] = _loc_3;
			userVariables.push(_loc_3);
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function getUserVariableByName(param1:String) : UserVariable
		{
			return userVariablesByName[param1];
		}

		public function doesUserVariableExist(param1:String) : Boolean
		{
			return !(userVariablesByName[param1] == null);
		}
	}
}
