package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;
	import com.electrotank.electroserver4.zone.*;

	public class JoinRoomEventTransaction extends TransactionImpl
	{
		public function JoinRoomEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_5:Room = null;
			var _loc_8:User = null;
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:UserVariable = null;
			var _loc_3:JoinRoomEvent = JoinRoomEvent(param1);
			var _loc_4:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			if(_loc_4.doesRoomExist(_loc_3.getRoomId()))
			{
				_loc_5 = _loc_4.getRoomById(_loc_3.getRoomId());
			}
			else
			{
				_loc_5 = new Room();
				_loc_5.setZoneId(_loc_3.getZoneId());
				_loc_5.setRoomId(_loc_3.getRoomId());
				_loc_5.setRoomName(_loc_3.getRoomName());
				_loc_5.setCapacity(_loc_3.getCapacity());
				_loc_5.setHasPassword(_loc_3.getHasPassword());
				_loc_5.setDescription(_loc_3.getRoomDescription());
				_loc_5.setUserCount(_loc_3.getUsers().length);
				_loc_4.addRoom(_loc_5);
			}
			_loc_5.setIsJoined(true);
			_loc_4.addJoinedRoom(_loc_5);
			_loc_5.setZone(param2.getZoneManager().getZoneById(_loc_3.getZoneId()));
			_loc_3.room = _loc_5;
			_loc_3.setZoneName(_loc_4.getZoneName());
			var _loc_6:UserManager = param2.getUserManager();
			var _loc_7:Number = 0;
			while(_loc_7 < _loc_3.getUsers().length)
			{
				_loc_8 = _loc_3.getUsers()[_loc_7];
				if(_loc_6.doesUserExist(_loc_8.getUserId()))
				{
					_loc_9 = _loc_8.getUserVariables();
					_loc_8 = _loc_6.getUserById(_loc_8.getUserId());
					_loc_10 = 0;
					while(_loc_10 < _loc_9.length)
					{
						_loc_11 = _loc_9[_loc_10];
						_loc_8.addUserVariable(_loc_11);
						_loc_10 = _loc_10 + 1;
					}
				}
				else
				{
					_loc_6.addUser(_loc_8);
				}
				_loc_6.addReference(_loc_8);
				_loc_5.addUser(_loc_8);
				_loc_7 = _loc_7 + 1;
			}
			_loc_5.setRoomVariables(_loc_3.getRoomVariables());
			param2.dispatchEvent(_loc_3);
		}
	}
}
