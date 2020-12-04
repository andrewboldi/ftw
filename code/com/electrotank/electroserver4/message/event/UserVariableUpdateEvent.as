package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class UserVariableUpdateEvent extends EventImpl
	{
		public static var VariableCreated:Number = 1;
		public static var VariableUpdated:Number = 2;
		public static var VariableDeleted:Number = 3;
		private var userId:String;
		private var actionId:Number;
		private var variable:UserVariable;
		private var _minorType:String;
		private var _user:User;
		private var variableName:String;

		public function UserVariableUpdateEvent()
		{
			super();
			setMessageType(MessageType.UserVariableUpdateEvent);
		}

		public function setVariableName(param1:String) : void
		{
			this.variableName = param1;
		}

		public function getVariableName() : String
		{
			return this.variableName;
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

		public function setVariable(param1:UserVariable) : void
		{
			variable = param1;
		}

		public function getVariable() : UserVariable
		{
			return variable;
		}
	}
}
