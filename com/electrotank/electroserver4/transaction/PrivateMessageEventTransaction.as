package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.user.*;

	public class PrivateMessageEventTransaction extends TransactionImpl
	{
		public function PrivateMessageEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:PrivateMessageEvent = PrivateMessageEvent(param1);
			var _loc_4:UserManager = param2.getUserManager();
			var _loc_5:User = new User();
			_loc_5.setUserId(_loc_3.getUserId());
			_loc_5.setUserName(_loc_3.getUserName());
			if(_loc_4.doesUserExist(_loc_5.getUserId()))
			{
				_loc_5 = _loc_4.getUserById(_loc_5.getUserId());
			}
			_loc_3.user = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
