package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class UserListUpdateEventTransaction extends TransactionImpl
	{
		public function UserListUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:String = null;
			var _loc_7:User = null;
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:UserVariable = null;
			var _loc_3:UserListUpdateEvent = UserListUpdateEvent(param1);
			var _loc_4:Number = _loc_3.getActionId();
			var _loc_5:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			var _loc_8:UserManager = param2.getUserManager();
			if(_loc_4 == UserListUpdateEvent.AddUser)
			{
				_loc_7 = new User();
				_loc_7.setUserId(_loc_3.getUserId());
				_loc_7.setUserName(_loc_3.getUserName());
				_loc_7.setUserVariables(_loc_3.getUserVariables());
				if(_loc_8.doesUserExist(_loc_7.getUserId()))
				{
					_loc_9 = _loc_7.getUserVariables();
					_loc_7 = _loc_8.getUserById(_loc_7.getUserId());
					_loc_10 = 0;
					while(_loc_10 < _loc_9.length)
					{
						_loc_11 = _loc_9[_loc_10];
						_loc_7.addUserVariable(_loc_11);
						_loc_10 = _loc_10 + 1;
					}
				}
				else
				{
					_loc_8.addUser(_loc_7);
				}
				_loc_8.addReference(_loc_7);
				_loc_5.addUser(_loc_7);
				_loc_6 = "userjoined";
			}
			else
			{
				if(_loc_4 == UserListUpdateEvent.DeleteUser)
				{
					_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
					_loc_5.removeUser(_loc_3.getUserId());
					_loc_8.removeReference(_loc_7);
					_loc_6 = "userleft";
				}
				else
				{
					if(_loc_4 == UserListUpdateEvent.UpdateUser)
					{
						_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
						trace("TODO: UpdateUser not handled in UserListUpdateEventTransaction");
					}
					else
					{
						if(_loc_4 == UserListUpdateEvent.OperatorGranted)
						{
							_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
							trace("TODO: OperatorGranted not handled in UserListUpdateEventTransaction");
						}
						else
						{
							if(_loc_4 == UserListUpdateEvent.OperatorRevoked)
							{
								_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
								trace("TODO: OperatorRevoked not handled in UserListUpdateEventTransaction");
							}
							else
							{
								if(_loc_4 == UserListUpdateEvent.SendingVideoStream)
								{
									_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
									_loc_7.setIsSendingVideo(true);
									_loc_7.setVideoStreamName(_loc_3.getVideoStreamName());
								}
								else
								{
									if(_loc_4 == UserListUpdateEvent.StoppingVideoStream)
									{
										_loc_7 = _loc_8.getUserById(_loc_3.getUserId());
										_loc_7.setIsSendingVideo(false);
									}
								}
							}
						}
					}
				}
			}
			_loc_3.setUserName(_loc_7.getUserName());
			_loc_3.setUser(_loc_7);
			_loc_3.user = _loc_7;
			_loc_3.minorType = _loc_6;
			_loc_3.room = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
