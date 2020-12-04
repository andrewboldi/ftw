package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class PublicMessageEventTransaction extends TransactionImpl
	{
		public function PublicMessageEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:User = null;
			var _loc_3:PublicMessageEvent = PublicMessageEvent(param1);
			var _loc_4:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			var _loc_5:UserManager = param2.getUserManager();
			if(_loc_5.doesUserExist(_loc_3.getUserId()))
			{
				_loc_6 = _loc_5.getUserById(_loc_3.getUserId());
				_loc_3.setUserName(_loc_6.getUserName());
			}
			else
			{
				_loc_6 = new User();
				_loc_6.setUserId(_loc_3.getUserId());
				if(_loc_3.isUserNameIncluded())
				{
					_loc_6.setUserName(_loc_3.getUserName());
				}
			}
			_loc_3.user = _loc_6;
			_loc_3.room = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
