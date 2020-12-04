package com.electrotank.electroserver4.message
{
	public class MessageType extends Object
	{
		private static var messageTypes:Array = new Array();
		public static var LoginRequest:MessageType = new MessageType("L", "LoginRequest", true, false, false);
		public static var AdditionalLoginRequest:MessageType = new MessageType("$", "LoginRequest", true, false, false);
		public static var LogoutRequest:MessageType = new MessageType("l", "LogoutRequest", true, false, false);
		public static var GetUsersInRoomRequest:MessageType = new MessageType("k", "GetUsersInRoomRequest", true, false, false);
		public static var PluginRequest:MessageType = new MessageType("C", "PluginRequest", true, false, false);
		public static var ValidateAdditionalLoginRequest:MessageType = new MessageType("%", "ValidateAdditionalLoginRequest", true, false, false);
		public static var FindZoneAndRoomByNameRequest:MessageType = new MessageType("D", "FindZoneAndRoomByNameRequest", true, false, false);
		public static var UpdateRoomDetailsRequest:MessageType = new MessageType("h", "UpdateRoomDetailsRequest", true, false, false);
		public static var EvictUserFromRoomRequest:MessageType = new MessageType("S", "EvictUserFromRoomRequest", true, false, false);
		public static var AddRoomOperatorRequest:MessageType = new MessageType("A", "AddRoomOperatorRequest", true, false, false);
		public static var RemoveRoomOperatorRequest:MessageType = new MessageType("B", "RemoveRoomOperatorRequest", true, false, false);
		public static var AddBuddyRequest:MessageType = new MessageType("K", "AddBuddyRequest", true, false, false);
		public static var RemoveBuddyRequest:MessageType = new MessageType("M", "RemoveBuddyRequest", true, false, false);
		public static var GetUserCountRequest:MessageType = new MessageType("0", "GetUserCountRequest", true, false, false);
		public static var DeleteUserVariableRequest:MessageType = new MessageType("H", "DeleteUserVariableRequest", true, false, false);
		public static var UpdateRoomVariableRequest:MessageType = new MessageType("o", "UpdateRoomVariableRequest", true, false, false);
		public static var UpdateUserVariableRequest:MessageType = new MessageType("I", "UpdateUserVariableRequest", true, false, false);
		public static var DeleteRoomVariableRequest:MessageType = new MessageType("N", "DeleteRoomVariableRequest", true, false, false);
		public static var CreateRoomVariableRequest:MessageType = new MessageType("n", "CreateRoomVariableRequest", true, false, false);
		public static var LeaveRoomRequest:MessageType = new MessageType("v", "LeaveRoomRequest", true, false, false);
		public static var CreateRoomRequest:MessageType = new MessageType("Q", "CreateRoomRequest", true, false, false);
		public static var PublicMessageRequest:MessageType = new MessageType("P", "PublicMessageRequest", true, false, false);
		public static var PrivateMessageRequest:MessageType = new MessageType("p", "PrivateMessageRequest", true, false, false);
		public static var GetRoomsInZoneRequest:MessageType = new MessageType("t", "GetRoomsInZoneRequest", true, false, false);
		public static var JoinRoomRequest:MessageType = new MessageType("J", "JoinRoomRequest", true, false, false);
		public static var GetZonesRequest:MessageType = new MessageType("s", "GetZonesRequest", true, false, false);
		public static var CreateOrJoinGameRequest:MessageType = new MessageType("(", "CreateOrJoinGameRequest", true, false, false);
		public static var FindGamesRequest:MessageType = new MessageType("*", "FindGamesRequest", true, false, false);
		public static var GetUserVariablesRequest:MessageType = new MessageType("+", "GetUserVariablesRequest", true, false, false);
		public static var GateWayKickUserRequest:MessageType = new MessageType("^", "GateWayKickUserRequest", true, false, false);
		public static var LoginResponse:MessageType = new MessageType("m", "LoginResponse", false, true, false);
		public static var GetUsersInRoomResponse:MessageType = new MessageType("F", "GetUsersInRoomResponse", false, true, false);
		public static var GetUserCountResponse:MessageType = new MessageType("1", "GetUserCountResponse", false, true, false);
		public static var GetZonesResponse:MessageType = new MessageType("b", "GetZonesResponse", false, true, false);
		public static var GetRoomsInZoneResponse:MessageType = new MessageType("d", "GetRoomsInZoneResponse", false, true, false);
		public static var GenericErrorResponse:MessageType = new MessageType("e", "GenericErrorResponse", false, true, false);
		public static var FindZoneAndRoomByNameResponse:MessageType = new MessageType("g", "FindZoneAndRoomByNameResponse", false, true, false);
		public static var ValidateAdditionalLoginResponse:MessageType = new MessageType("&", "ValidateAdditionalLoginResponse", false, true, false);
		public static var CreateOrJoinGameResponse:MessageType = new MessageType("_", "CreateOrJoinGameResponse", false, true, false);
		public static var FindGamesResponse:MessageType = new MessageType(")", "FindGamesResponse", false, true, false);
		public static var GetUserVariablesResponse:MessageType = new MessageType("=", "GetUserVariablesResponse", false, true, false);
		public static var ConnectionEvent:MessageType = new MessageType("c", "ConnectionEvent", false, false, true);
		public static var ClientIdleEvent:MessageType = new MessageType("i", "ClientIdleEvent", false, false, true);
		public static var JoinRoomEvent:MessageType = new MessageType("R", "JoinRoomEvent", false, false, true);
		public static var JoinZoneEvent:MessageType = new MessageType("Z", "JoinZoneEvent", false, false, true);
		public static var PublicMessageEvent:MessageType = new MessageType("a", "PublicMessagEvent", false, false, true);
		public static var PrivateMessageEvent:MessageType = new MessageType("r", "PrivateMessagEvent", false, false, true);
		public static var ZoneUpdateEvent:MessageType = new MessageType("V", "ZoneUpdateEvent", false, false, true);
		public static var LeaveRoomEvent:MessageType = new MessageType("W", "LeaveRoomEvent", false, false, true);
		public static var LeaveZoneEvent:MessageType = new MessageType("X", "LeaveZoneEvent", false, false, true);
		public static var UserListUpdateEvent:MessageType = new MessageType("U", "UserListUpdateEvent", false, false, true);
		public static var RoomVariableUpdateEvent:MessageType = new MessageType("q", "RoomVariableUpdateEvent", false, false, true);
		public static var UserVariableUpdateEvent:MessageType = new MessageType("Y", "UserVariableUpdateEvent", false, false, true);
		public static var BuddyStatusUpdatedEvent:MessageType = new MessageType("O", "BuddyStatusUpdatedEvent", false, false, true);
		public static var UserEvictedFromRoomEvent:MessageType = new MessageType("T", "UserEvictedFromRoomEvent", false, false, true);
		public static var UpdateRoomDetailsEvent:MessageType = new MessageType("E", "UpdateRoomDetailsEvent", false, false, true);
		public static var PluginMessageEvent:MessageType = new MessageType("f", "PluginMessageEvent", false, false, true);
		public static var CompositePluginMessageEvent:MessageType = new MessageType("G", "CompositePluginMessageEvent", false, false, true);
		public static var ConnectionClosedEvent:MessageType = new MessageType("|ConnectionClosedEvent", "ConnectionClosedEvent", false, false, true);
		public static var RtmpConnectionEvent:MessageType = new MessageType("|RtmpConnectionEvent", "RtmpConnectionEvent", false, false, true);
		public static var RtmpConnectionClosedEvent:MessageType = new MessageType("|RtmpConnectionClosedEvent", "RtmpConnectionClosedEvent", false, false, true);
		public static var RtmpOnStatusEvent:MessageType = new MessageType("|RtmpOnStatusEvent", "RtmpOnStatusEvent", false, false, true);
		private var messageTypeId:String;
		private var messageTypeName:String;
		private var isRequest:Boolean;
		private var isResponse:Boolean;
		private var isEvent:Boolean;

		final private static function register(param1:MessageType) : void
		{
			var _loc_2:Number = param1.getMessageTypeId().charCodeAt(0);
			messageTypes[_loc_2] = param1;
			var _loc_3:String = param1.getMessageTypeId();
		}

		final public static function findTypeById(param1:String) : MessageType
		{
			var _loc_2:Number = param1.charCodeAt(0);
			var _loc_3:MessageType = messageTypes[_loc_2];
			if(_loc_3 == null)
			{
				MessageType.trace("Error: MessageType class. Message type not found with id: " + param1);
			}
			return _loc_3;
		}

		public function MessageType(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean)
		{
			super();
			setIsRequest(param3);
			setIsResponse(param4);
			setIsEvent(param4);
			setMessageTypeId(param1);
			setMessageTypeName(param2);
			register(this);
		}

		public function setIsRequest(param1:Boolean) : void
		{
			isRequest = param1;
		}

		public function getIsRequest() : Boolean
		{
			return isRequest;
		}

		public function setIsResponse(param1:Boolean) : void
		{
			isResponse = param1;
		}

		public function getIsResponse() : Boolean
		{
			return isResponse;
		}

		public function setIsEvent(param1:Boolean) : void
		{
			isEvent = param1;
		}

		public function getIsEvent() : Boolean
		{
			return isEvent;
		}

		public function setMessageTypeName(param1:String) : void
		{
			messageTypeName = param1;
		}

		public function getMessageTypeName() : String
		{
			return messageTypeName;
		}

		public function getMessageTypeId() : String
		{
			return messageTypeId;
		}

		public function setMessageTypeId(param1:String) : void
		{
			messageTypeId = param1;
		}
	}
}
