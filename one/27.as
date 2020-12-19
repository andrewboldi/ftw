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
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class ClientIdleEventTransaction extends TransactionImpl
	{
		public function ClientIdleEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:ClientIdleEvent = ClientIdleEvent(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class CompositePluginMessageEventTransaction extends TransactionImpl
	{
		public function CompositePluginMessageEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_7:PluginMessageEvent = null;
			var _loc_3:CompositePluginMessageEvent = CompositePluginMessageEvent(param1);
			var _loc_4:Array = new Array();
			var _loc_5:Array = _loc_3.getParameters();
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_5.length)
			{
				_loc_7 = new PluginMessageEvent();
				_loc_7.setPluginName(_loc_3.getPluginName());
				_loc_7.setOriginRoomId(_loc_3.getOriginRoomId());
				_loc_7.setOriginZoneId(_loc_3.getOriginZoneId());
				_loc_7.setEsObject(_loc_5[_loc_6]);
				_loc_4.push(_loc_7);
				_loc_6 = _loc_6 + 1;
			}
			param2.processCompositeMessages(_loc_4);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class ConnectionEventTransaction extends TransactionImpl
	{
		public function ConnectionEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:ConnectionEvent = ConnectionEvent(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class CreateOrJoinGameResponseTransaction extends TransactionImpl
	{
		public function CreateOrJoinGameResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:CreateOrJoinGameResponse = CreateOrJoinGameResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class FindGamesResponseTransaction extends TransactionImpl
	{
		public function FindGamesResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:FindGamesResponse = FindGamesResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class FindZoneAndRoomByNameResponseTransaction extends TransactionImpl
	{
		public function FindZoneAndRoomByNameResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:FindZoneAndRoomByNameResponse = FindZoneAndRoomByNameResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;

	public class GateWayKickUserRequestTransaction extends TransactionImpl
	{
		public function GateWayKickUserRequestTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GateWayKickUserRequest = GateWayKickUserRequest(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class GenericErrorResponseTransaction extends TransactionImpl
	{
		public function GenericErrorResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GenericErrorResponse = GenericErrorResponse(param1);
			param2.handleError(_loc_3);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class GetRoomsInZoneResponseTransaction extends TransactionImpl
	{
		public function GetRoomsInZoneResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:Room = null;
			var _loc_3:GetRoomsInZoneResponse = GetRoomsInZoneResponse(param1);
			var _loc_4:Zone = new Zone();
			if(_loc_3.getZoneId() != -1)
			{
				_loc_4.setZoneId(_loc_3.getZoneId());
			}
			else
			{
				_loc_4.setZoneName(_loc_3.getZoneName());
			}
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3.getRooms().length)
			{
				_loc_6 = _loc_3.getRooms()[_loc_5];
				_loc_6.setZone(_loc_4);
				_loc_5 = _loc_5 + 1;
			}
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class GetUserCountResponseTransaction extends TransactionImpl
	{
		public function GetUserCountResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GetUserCountResponse = GetUserCountResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class GetUsersInRoomResponseTransaction extends TransactionImpl
	{
		public function GetUsersInRoomResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GetUsersInRoomResponse = GetUsersInRoomResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class GetUserVariablesResponseTransaction extends TransactionImpl
	{
		public function GetUserVariablesResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GetUserVariablesResponse = GetUserVariablesResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class GetZonesResponseTransaction extends TransactionImpl
	{
		public function GetZonesResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:GetZonesResponse = GetZonesResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
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
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class JoinZoneEventTransaction extends TransactionImpl
	{
		public function JoinZoneEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:Room = null;
			var _loc_3:JoinZoneEvent = JoinZoneEvent(param1);
			var _loc_4:Zone = new Zone();
			_loc_4.setZoneId(_loc_3.getZoneId());
			_loc_4.setZoneName(_loc_3.getZoneName());
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3.getRooms().length)
			{
				_loc_6 = _loc_3.getRooms()[_loc_5];
				_loc_4.addRoom(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			param2.getZoneManager().addZone(_loc_4);
			_loc_3.zone = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
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
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.zone.*;

	public class LeaveZoneEventTransaction extends TransactionImpl
	{
		public function LeaveZoneEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:LeaveZoneEvent = LeaveZoneEvent(param1);
			var _loc_4:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			param2.getZoneManager().removeZone(_loc_4.getZoneId());
			_loc_3.zone = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class LoginResponseTransaction extends TransactionImpl
	{
		public function LoginResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:LoginResponse = LoginResponse(param1);
			param2.handleLoginResponse(_loc_3);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class PluginMessageEventTransaction extends TransactionImpl
	{
		public function PluginMessageEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:PluginMessageEvent = PluginMessageEvent(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
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
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;

	public class RoomVariableUpdateEventTransaction extends TransactionImpl
	{
		public function RoomVariableUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_5:RoomVariable = null;
			var _loc_6:String = null;
			var _loc_3:RoomVariableUpdateEvent = RoomVariableUpdateEvent(param1);
			var _loc_4:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			var _loc_7:Number = _loc_3.getUpdateAction();
			if(_loc_7 == RoomVariableUpdateEvent.VariableCreated)
			{
				_loc_6 = "created";
			}
			else
			{
				if(_loc_7 == RoomVariableUpdateEvent.VariableUpdated)
				{
					_loc_6 = "updated";
				}
				else
				{
					if(_loc_7 == RoomVariableUpdateEvent.VariableDeleted)
					{
						_loc_6 = "deleted";
					}
				}
			}
			if(_loc_7 == RoomVariableUpdateEvent.VariableCreated)
			{
				_loc_5 = new RoomVariable(_loc_3.getName(), _loc_3.getValue(), _loc_3.getPersistent(), _loc_3.getLocked());
				_loc_4.addRoomVariable(_loc_5);
			}
			_loc_5 = _loc_4.getRoomVariable(_loc_3.getName());
			if(_loc_3.getValueChanged())
			{
				_loc_5.setValue(_loc_3.getValue());
			}
			if(_loc_3.getLockChanged())
			{
				_loc_5.setLocked(_loc_3.getLocked());
			}
			if(_loc_7 == RoomVariableUpdateEvent.VariableDeleted)
			{
				_loc_4.removeRoomVariable(_loc_3.getName());
			}
			_loc_3.room = _loc_4;
			_loc_3.minorType = _loc_6;
			_loc_3.variable = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;

	public interface Transaction
	{
		function execute(param1:Message, param2:ElectroServer) : void;
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.message.*;

	public class TransactionHandler extends Object
	{
		private var mapper:Object;

		public function TransactionHandler()
		{
			super();
			mapper = new Object();
			register(MessageType.ConnectionEvent, Transaction(new ConnectionEventTransaction()));
			register(MessageType.LoginResponse, Transaction(new LoginResponseTransaction()));
			register(MessageType.JoinRoomEvent, Transaction(new JoinRoomEventTransaction()));
			register(MessageType.JoinZoneEvent, Transaction(new JoinZoneEventTransaction()));
			register(MessageType.ClientIdleEvent, Transaction(new ClientIdleEventTransaction()));
			register(MessageType.PublicMessageEvent, Transaction(new PublicMessageEventTransaction()));
			register(MessageType.PrivateMessageEvent, Transaction(new PrivateMessageEventTransaction()));
			register(MessageType.ZoneUpdateEvent, Transaction(new ZoneUpdateEventTransaction()));
			register(MessageType.GetZonesResponse, Transaction(new GetZonesResponseTransaction()));
			register(MessageType.GetUsersInRoomResponse, Transaction(new GetUsersInRoomResponseTransaction()));
			register(MessageType.GenericErrorResponse, Transaction(new GenericErrorResponseTransaction()));
			register(MessageType.GetUserCountResponse, Transaction(new GetUserCountResponseTransaction()));
			register(MessageType.GetRoomsInZoneResponse, Transaction(new GetRoomsInZoneResponseTransaction()));
			register(MessageType.LeaveRoomEvent, Transaction(new LeaveRoomEventTransaction()));
			register(MessageType.LeaveZoneEvent, Transaction(new LeaveZoneEventTransaction()));
			register(MessageType.UserListUpdateEvent, Transaction(new UserListUpdateEventTransaction()));
			register(MessageType.RoomVariableUpdateEvent, Transaction(new RoomVariableUpdateEventTransaction()));
			register(MessageType.UserVariableUpdateEvent, Transaction(new UserVariableUpdateEventTransaction()));
			register(MessageType.BuddyStatusUpdatedEvent, Transaction(new BuddyStatusUpdatedEventTransaction()));
			register(MessageType.UserEvictedFromRoomEvent, Transaction(new UserEvictedFromRoomEventTransaction()));
			register(MessageType.UpdateRoomDetailsEvent, Transaction(new UpdateRoomDetailsEventTransaction()));
			register(MessageType.FindZoneAndRoomByNameResponse, Transaction(new FindZoneAndRoomByNameResponseTransaction()));
			register(MessageType.PluginMessageEvent, Transaction(new PluginMessageEventTransaction()));
			register(MessageType.CompositePluginMessageEvent, Transaction(new CompositePluginMessageEventTransaction()));
			register(MessageType.ValidateAdditionalLoginRequest, Transaction(new ValidateAdditionalLoginRequestTransaction()));
			register(MessageType.CreateOrJoinGameResponse, Transaction(new CreateOrJoinGameResponseTransaction()));
			register(MessageType.FindGamesResponse, Transaction(new FindGamesResponseTransaction()));
			register(MessageType.GetUserVariablesResponse, Transaction(new GetUserVariablesResponseTransaction()));
			register(MessageType.GateWayKickUserRequest, Transaction(new GateWayKickUserRequestTransaction()));
		}

		public function getTransaction(param1:MessageType) : Transaction
		{
			var _loc_2:Transaction = mapper[param1.getMessageTypeName()];
			if(_loc_2 == null)
			{
				trace("Error: Tried to find a Transaction for " + param1.getMessageTypeName() + " and none was was registered.");
			}
			return _loc_2;
		}

		private function register(param1:MessageType, param2:Transaction) : void
		{
			mapper[param1.getMessageTypeName()] = param2;
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;

	public class TransactionImpl extends Object implements Transaction
	{
		public function TransactionImpl()
		{
			super();
		}

		public function execute(param1:Message, param2:ElectroServer) : void
		{
			trace("Error: 'execute' method not overwritten in transaction for " + param1.getMessageType().getMessageTypeName());
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;

	public class UpdateRoomDetailsEventTransaction extends TransactionImpl
	{
		public function UpdateRoomDetailsEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:UpdateRoomDetailsEvent = UpdateRoomDetailsEvent(param1);
			var _loc_4:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			if(_loc_3.isHiddenUpdate())
			{
				_loc_4.setIsHidden(_loc_3.getHidden());
			}
			if(_loc_3.isDescriptionUpdate())
			{
				_loc_4.setDescription(_loc_3.getDescription());
			}
			if(_loc_3.isCapacityUpdate())
			{
				_loc_4.setCapacity(_loc_3.getCapacity());
			}
			if(_loc_3.isRoomNameUpdate())
			{
				_loc_4.setRoomName(_loc_3.getRoomName());
			}
			if(_loc_3.isPasswordUpdate())
			{
			}
			_loc_3.room = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.user.*;

	public class UserEvictedFromRoomEventTransaction extends TransactionImpl
	{
		public function UserEvictedFromRoomEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:UserEvictedFromRoomEvent = UserEvictedFromRoomEvent(param1);
			var _loc_4:UserManager = param2.getUserManager();
			var _loc_5:User = _loc_4.getUserById(_loc_3.getUserId());
			_loc_3.user = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
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
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;

	public class ValidateAdditionalLoginRequestTransaction extends TransactionImpl
	{
		public function ValidateAdditionalLoginRequestTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:ValidateAdditionalLoginRequest = ValidateAdditionalLoginRequest(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class ZoneUpdateEventTransaction extends TransactionImpl
	{
		public function ZoneUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_5:String = null;
			var _loc_6:Room = null;
			var _loc_3:ZoneUpdateEvent = ZoneUpdateEvent(param1);
			var _loc_4:Number = _loc_3.getActionId();
			if(_loc_4 == ZoneUpdateEvent.AddRoom)
			{
				_loc_6 = _loc_3.getRoom();
				_loc_6.setZone(param2.getZoneManager().getZoneById(_loc_3.getZoneId()));
				param2.getZoneManager().getZoneById(_loc_3.getZoneId()).addRoom(_loc_6);
				_loc_5 = "roomcreated";
			}
			else
			{
				if(_loc_4 == ZoneUpdateEvent.DeleteRoom)
				{
					_loc_6 = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
					param2.getZoneManager().getZoneById(_loc_3.getZoneId()).removeRoom(_loc_3.getRoomId());
					_loc_5 = "roomdeleted";
				}
				else
				{
					if(_loc_4 == ZoneUpdateEvent.UpdateRoom)
					{
						_loc_6 = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
						param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId()).setUserCount(_loc_3.getRoomCount());
						_loc_5 = "roomupdated";
					}
				}
			}
			var _loc_7:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			_loc_3.room = _loc_6;
			_loc_3.zone = _loc_7;
			_loc_3.minorType = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
