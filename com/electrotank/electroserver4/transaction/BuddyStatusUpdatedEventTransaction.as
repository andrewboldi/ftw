package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.user.*;

	public class BuddyStatusUpdatedEventTransaction extends TransactionImpl
	{
		public function BuddyStatusUpdatedEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:String = null;
			var _loc_3:BuddyStatusUpdatedEvent = BuddyStatusUpdatedEvent(param1);
			var _loc_4:UserManager = param2.getUserManager();
			var _loc_5:User = new User();
			_loc_5.setUserId(_loc_3.getUserId());
			_loc_5.setUserName(_loc_3.getUserName());
			if(_loc_4.doesUserExist(_loc_5.getUserId()))
			{
				_loc_5 = _loc_4.getUserById(_loc_5.getUserId());
			}
			else
			{
				_loc_4.addUser(_loc_5);
			}
			if(_loc_3.getActionId() == BuddyStatusUpdatedEvent.LoggedIn)
			{
				_loc_4.addReference(_loc_5);
				_loc_6 = "loggedIn";
			}
			else
			{
				if(_loc_3.getActionId() == BuddyStatusUpdatedEvent.LoggedOut)
				{
					_loc_4.removeReference(_loc_5);
					_loc_6 = "loggedOut";
				}
			}
			_loc_3.setUser(_loc_5);
			param2.dispatchEvent(_loc_3);
		}
	}
}
