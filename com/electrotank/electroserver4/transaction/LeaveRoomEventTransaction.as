package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;
	import com.electrotank.electroserver4.zone.*;

	public class LeaveRoomEventTransaction extends TransactionImpl
	{
		public function LeaveRoomEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:LeaveRoomEvent = LeaveRoomEvent(param1);
			var _loc_4:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			var _loc_5:Room = _loc_4.getRoomById(_loc_3.getRoomId());
			_loc_5.setIsJoined(false);
			_loc_4.removeJoinedRoom(_loc_5);
			var _loc_6:UserManager = param2.getUserManager();
			var _loc_7:Number = 0;
			while(_loc_7 < _loc_5.getUsers().length)
			{
				_loc_6.removeReference(_loc_5.getUsers()[_loc_7]);
				_loc_7 = _loc_7 + 1;
			}
			_loc_3.room = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
