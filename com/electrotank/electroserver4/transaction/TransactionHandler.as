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
