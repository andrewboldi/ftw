package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserVariablesRequest extends RequestImpl
	{
		private var userName:String;
		private var userVariableNames:Array;

		public function GetUserVariablesRequest()
		{
			super();
			setMessageType(MessageType.GetUserVariablesRequest);
			userVariableNames = new Array();
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getUserName() == null)
			{
				_loc_2.push("A username must be specified.");
			}
			if(_loc_2.length != 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return this.userName;
		}

		public function addUserVariableName(param1:String) : void
		{
			getUserVariableNames().push(param1);
		}

		public function getUserVariableNames() : Array
		{
			return userVariableNames;
		}
	}
}
