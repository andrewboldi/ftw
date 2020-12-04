package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.user.*;

	public class UserVariableUpdateEventTransaction extends TransactionImpl
	{
		public function UserVariableUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_7:UserVariable = null;
			var _loc_8:String = null;
			var _loc_3:UserVariableUpdateEvent = UserVariableUpdateEvent(param1);
			var _loc_4:UserManager = param2.getUserManager();
			var _loc_5:User = _loc_4.getUserById(_loc_3.getUserId());
			var _loc_6:Number = _loc_3.getActionId();
			if(_loc_6 == UserVariableUpdateEvent.VariableCreated)
			{
				_loc_8 = "created";
				_loc_7 = new UserVariable(_loc_3.getVariableName(), _loc_3.getVariable().getValue());
				_loc_5.addUserVariable(_loc_7);
			}
			else
			{
				if(_loc_6 == UserVariableUpdateEvent.VariableUpdated)
				{
					_loc_8 = "updated";
					_loc_7 = _loc_5.getUserVariable(_loc_3.getVariableName());
					_loc_7.setValue(_loc_3.getVariable().getValue());
				}
				else
				{
					if(_loc_6 == UserVariableUpdateEvent.VariableDeleted)
					{
						_loc_8 = "deleted";
						_loc_7 = _loc_5.getUserVariable(_loc_3.getVariableName());
						_loc_5.removeUserVariable(_loc_3.getVariableName());
					}
				}
			}
			_loc_3.user = _loc_5;
			_loc_3.minorType = _loc_8;
			param2.dispatchEvent(_loc_3);
		}
	}
}
