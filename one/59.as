package net.theyak.server
{
	import Misc.*;
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.plugin.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;
	import com.electrotank.electroserver4.zone.*;
	import flash.utils.*;
	import net.theyak.events.*;

	public class ElectroServer4 extends EventDispatcher
	{
		protected var server:ElectroServer;
		private var _ip:String;
		private var _port:uint;
		protected var lastRequest:int;
		private var reconnect:Boolean = true;
		public var isConnected:Boolean = false;
		private var hasConnected:Boolean = false;
		private var debug:Boolean = true;

		public function ElectroServer4()
		{
			super();
			server = new ElectroServer();
			server.setDebug(true);
			lastRequest = getTimer();
			initializeListeners();
		}

		public function connect(param1:String = null, param2:uint = 0) : void
		{
			lastRequest = getTimer();
			if(param1 == null)
			{
				param1 = _ip;
				param2 = _port;
			}
			else
			{
				_port = param2;
				_ip = param1;
			}
			server.createConnection(param1, param2);
		}

		public function onConnectionEvent(param1:ConnectionEvent) : void
		{
			isConnected = param1.getAccepted();
			if(hasConnected)
			{
				g.scene.debug("Sending reconnection event" + isConnected);
				dispatchEvent("reconnection", {connected:isConnected});
			}
			else
			{
				dispatchEvent("connection", {connected:isConnected});
				hasConnected = isConnected;
			}
		}

		public function onConnectionClosedEvent(param1:ConnectionClosedEvent) : void
		{
			dispatchEvent("connectionClosed", {});
			isConnected = false;
		}

		public function reset() : void
		{
			destroyListeners();
			server = new ElectroServer();
			initializeListeners();
		}

		public function onGenericError(param1:GenericErrorResponse) : void
		{
			if(param1.getRequestMessageType().getMessageTypeName() == "LogoutRequest")
			{
				server.removeEventListener(MessageType.GenericErrorResponse, "onGenericError", this);
				server = new ElectroServer();
				initializeListeners();
				hasConnected = true;
				dispatchEvent("connectionCloseReset", {});
			}
			else
			{
					break;
					break;
				switch(param1.getErrorType().getId())
				{
				default:
					trace("(ERR) Unhandled Error: " + param1.getRequestMessageType().getMessageTypeName() + " : " + param1.getErrorType().getDescription());
					break;
				}
			}
		}

		public function disconnectAndReset() : void
		{
			g.scene.debug("Disconnect and reset");
			destroyListeners();
			g.scene.debug("Dropping connections");
			server.addEventListener(MessageType.GenericErrorResponse, "onGenericError", this);
			var _loc_1:LogoutRequest = new LogoutRequest();
			server.send(_loc_1);
		}

		public function onConnectionCloseResetEvent(param1:ConnectionClosedEvent) : void
		{
			g.scene.debug("onConnectionCloseResetEvent");
			server.removeEventListener(MessageType.ConnectionClosedEvent, "onConnectionCloseResetEvent", this);
			initializeListeners();
			hasConnected = false;
			dispatchEvent("connectionCloseReset", {});
		}

		public function login(param1:String, param2:String) : void
		{
			lastRequest = getTimer();
			var _loc_3:LoginRequest = new LoginRequest();
			_loc_3.setUserName(param1);
			server.send(_loc_3);
		}

		public function onLoginResponse(param1:LoginResponse) : void
		{
			if(param1.getEsError())
			{
				g.scene.debug("Error: " + param1.getEsError().getDescription());
			}
			if(param1.getAccepted())
			{
				dispatchEvent("login", {success:true});
			}
			else
			{
				dispatchEvent("login", {success:false});
			}
		}

		public function logout() : void
		{
			lastRequest = getTimer();
			reconnect = false;
			var _loc_1:LogoutRequest = new LogoutRequest();
			_loc_1.setDropAllConnections(true);
			server.send(_loc_1);
		}

		public function joinRoom(param1:String, param2:String, param3:Object = null, param4:Object = null) : void
		{
			lastRequest = getTimer();
			var _loc_5:CreateRoomRequest = new CreateRoomRequest();
			_loc_5.setRoomName(param2);
			_loc_5.setZoneName(param1);
			var _loc_6:Plugin = new Plugin();
			_loc_6.setPluginHandle("PublicMessageEventHandler");
			_loc_6.setPluginName("ScrewYouPlugin");
			_loc_6.setExtensionName("ForTheWin");
			_loc_5.setPlugins([_loc_6]);
			server.send(_loc_5);
		}

		public function leaveRoom(param1:String, param2:String) : void
		{
			var _loc_3:LeaveRoomRequest = null;
			lastRequest = getTimer();
			if(inRoom(param1, param2))
			{
				_loc_3 = new LeaveRoomRequest();
				_loc_3.setRoomId(toRoomId(param1, param2));
				_loc_3.setZoneId(toZoneId(param1));
				server.send(_loc_3);
			}
		}

		public function leaveAllRooms() : void
		{
			var _loc_3:LeaveRoomRequest = null;
			var _loc_1:Array = getRoomList();
			var _loc_2:uint = 0;
			while(_loc_2 < _loc_1.length)
			{
				_loc_3 = new LeaveRoomRequest();
				_loc_3.setRoomId(toRoomId(_loc_1[_loc_2].zonename, _loc_1[_loc_2].roomname));
				_loc_3.setZoneId(toZoneId(_loc_1[_loc_2].zonename));
				server.send(_loc_3);
				_loc_2 = _loc_2 + 1;
			}
		}

		public function getUsersInRoom(param1:String, param2:String) : Array
		{
			var _loc_3:Zone = server.getZoneManager().getZoneByName(param1);
			var _loc_4:Room = _loc_3.getRoomByName(param2);
			g.scene.debug(String(_loc_4.getUserCount()));
			return toUsers(_loc_4.getUsers());
		}

		public function getRoomList() : Array
		{
			var _loc_5:Zone = null;
			var _loc_6:Array = null;
			var _loc_7:uint = 0;
			var _loc_8:Object = null;
			var _loc_1:Array = new Array();
			var _loc_2:ZoneManager = server.getZoneManager();
			var _loc_3:Array = _loc_2.getZones();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_5 = _loc_3[_loc_4];
				_loc_6 = _loc_5.getRooms();
				_loc_7 = 0;
				while(_loc_7 < _loc_6.length)
				{
					if(_loc_6[_loc_7].getIsJoined())
					{
						_loc_8 = new Object();
						_loc_8.zonename = _loc_3[_loc_4].getZoneName();
						_loc_8.roomname = _loc_6[_loc_7].getRoomName();
						_loc_1.push(_loc_8);
					}
					_loc_7 = _loc_7 + 1;
				}
				_loc_4 = _loc_4 + 1;
			}
			return _loc_1;
		}

		public function inRoom(param1:String, param2:String) : Boolean
		{
			var _loc_3:Array = getRoomList();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				if(_loc_3[_loc_4].zonename == param1 && _loc_3[_loc_4].roomname == param2)
				{
					return true;
				}
				_loc_4 = _loc_4 + 1;
			}
			return false;
		}

		public function onJoinRoomEvent(param1:JoinRoomEvent) : void
		{
			dispatchEvent("joinRoom", {users:toUsers(param1.getUsers()), description:param1.getRoomDescription(), zonename:param1.getZoneName(), roomname:param1.getRoomName(), variables:param1.getRoomVariables(), capacity:param1.getCapacity()});
		}

		public function onLeaveRoomEvent(param1:LeaveRoomEvent) : void
		{
			g.scene.debug("Leaving room " + toZoneName(param1.getZoneId()) + ":" + (toRoomName(param1.getZoneId(), param1.getRoomId())));
			dispatchEvent("leaveRoom", {zonename:toZoneName(param1.getZoneId()), roomname:toRoomName(param1.getZoneId(), param1.getRoomId())});
		}

		public function getServerZoneList()
		{
			server.addEventListener(MessageType.GetZonesResponse, "onZonesResponse", this);
			var _loc_1:GetZonesRequest = new GetZonesRequest();
			server.send(_loc_1);
		}

		public function onZonesResponse(param1:GetZonesResponse) : void
		{
			var _loc_2:String = "";
			server.removeEventListener(MessageType.GetZonesResponse, "onZonesResponse", this);
			var _loc_3:Array = param1.getZones();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_2 = _loc_2 + (_loc_3[_loc_4].getZoneName() + "\n");
				_loc_4 = _loc_4 + 1;
			}
			dispatchEvent("zoneList", {zones:_loc_2});
		}

		public function getRoomsInZone(param1:String)
		{
			server.addEventListener(MessageType.GetRoomsInZoneResponse, "onRoomsInZoneResponse", this);
			var _loc_2:GetRoomsInZoneRequest = new GetRoomsInZoneRequest();
			_loc_2.setZoneName(param1);
			server.send(_loc_2);
		}

		public function onRoomsInZoneResponse(param1:GetRoomsInZoneResponse) : void
		{
			var _loc_2:String = "";
			server.removeEventListener(MessageType.GetRoomsInZoneResponse, "onRoomsInZoneResponse", this);
			var _loc_3:Array = param1.getRooms();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_2 = _loc_2 + (_loc_3[_loc_4].getRoomName() + "\n");
				_loc_4 = _loc_4 + 1;
			}
			dispatchEvent("roomsInZone", {zonename:param1.getZoneName(), rooms:_loc_2});
		}

		public function setUserVariable(param1:String, param2:String) : void
		{
			var _loc_3:UpdateUserVariableRequest = new UpdateUserVariableRequest();
			var _loc_4:EsObject = new EsObject();
			_loc_4.setString(param1, param2);
			_loc_3.setValue(_loc_4);
			_loc_3.setName(param1);
			server.send(_loc_3);
		}

		public function getUserVariable(param1:String, param2:String) : String
		{
			var _loc_4:UserVariable = null;
			var _loc_3:User = server.getUserManager().getUserByName(param1);
			if(_loc_3 != null)
			{
				_loc_4 = _loc_3.getUserVariable(param2);
				if(_loc_4 != null)
				{
					return _loc_4.getValue().getString(param2);
				}
			}
			return null;
		}

		public function sendPublicMessage(param1:String, param2:String, param3:String) : void
		{
			lastRequest = getTimer();
			var _loc_4:PublicMessageRequest = new PublicMessageRequest();
			_loc_4.setMessage(param1);
			_loc_4.setRoomId(toRoomId(param2, param3));
			_loc_4.setZoneId(toZoneId(param2));
			server.send(_loc_4);
		}

		public function sendPrivateMessage(param1:String, param2:String) : void
		{
			lastRequest = getTimer();
			var _loc_3:PrivateMessageRequest = new PrivateMessageRequest();
			_loc_3.setMessage(param2);
			_loc_3.setUserNames([param1]);
			server.send(_loc_3);
		}

		public function serverPlugin(param1:String, param2:String, param3:Object = null, param4:Boolean = true) : void
		{
			esServerPlugin(param1, param2, toEsObject(param3), param4);
		}

		public function esServerPlugin(param1:String, param2:String, param3:EsObject = null, param4:Boolean = true) : void
		{
			if(param4)
			{
				lastRequest = getTimer();
			}
			var _loc_5:PluginRequest = new PluginRequest();
			_loc_5.setPluginName(param1);
			param3.setString("Action", param2);
			_loc_5.setEsObject(param3);
			server.send(_loc_5);
		}

		public function roomPlugin(param1:String, param2:String, param3:String, param4:String, param5:Object, param6:Boolean) : void
		{
			esRoomPlugin(param1, param2, param3, param4, toEsObject(param5), param6);
		}

		public function esRoomPlugin(param1:String, param2:String, param3:String, param4:String, param5:EsObject = null, param6:Boolean = true) : void
		{
			var _loc_8:PluginRequest = null;
			if(param6)
			{
				lastRequest = getTimer();
			}
			var _loc_7:Number = toRoomId(param2, param3);
			if(_loc_7 >= 0)
			{
				_loc_8 = new PluginRequest();
				_loc_8.setPluginName(param1);
				_loc_8.setRoomId(_loc_7);
				_loc_8.setZoneId(toZoneId(param2));
				if(!param5)
				{
					param5 = new EsObject();
				}
				param5.setString("Action", param4);
				_loc_8.setEsObject(param5);
				server.send(_loc_8);
			}
		}

		public function onUserListUpdateEvent(param1:UserListUpdateEvent) : void
		{
			var _loc_2:String = null;
			switch(param1.getActionId())
			{
			case UserListUpdateEvent.AddUser:
				_loc_2 = "add";
				break;
			case UserListUpdateEvent.DeleteUser:
				_loc_2 = "remove";
				break;
			case UserListUpdateEvent.UpdateUser:
				_loc_2 = "update";
				break;
			case UserListUpdateEvent.OperatorGranted:
				_loc_2 = "ops";
				break;
			case UserListUpdateEvent.OperatorRevoked:
				_loc_2 = "noops";
				break;
			case UserListUpdateEvent.SendingVideoStream:
				_loc_2 = "startvideo";
				break;
			case UserListUpdateEvent.StoppingVideoStream:
				_loc_2 = "stopvideo";
				break;
			default:
				break;
			}
			dispatchEvent("userListUpdate", {action:_loc_2, user:toUser(param1.getUser()), zonename:toZoneName(param1.getZoneId()), roomname:toRoomName(param1.getZoneId(), param1.getRoomId())});
		}

		public function onPublicMessageEvent(param1:PublicMessageEvent) : void
		{
			dispatchEvent("publicMessage", {name:param1.getUserName(), message:param1.getMessage(), roomname:toRoomName(param1.getZoneId(), param1.getRoomId()), zonename:toZoneName(param1.getZoneId())});
		}

		public function onPrivateMessageEvent(param1:PrivateMessageEvent) : void
		{
			dispatchEvent("privateMessage", {from:param1.getUserName(), message:param1.getMessage()});
		}

		public function onPluginMessageEvent(param1:PluginMessageEvent) : void
		{
			dispatchEvent("pluginMessage", {response:toObject(param1.getEsObject())});
		}

		public function onUserVariableUpdateEvent(param1:UserVariableUpdateEvent) : void
		{
			var _loc_2:String = "UserVariableUpdated";
			if(param1.getActionId() == UserVariableUpdateEvent.VariableCreated)
			{
				_loc_2 = "UserVariableCreated";
			}
			else
			{
				if(param1.getActionId() == UserVariableUpdateEvent.VariableDeleted)
				{
					_loc_2 = "UserVariableDeleted";
				}
			}
			var _loc_3:String = param1.getVariable().getValue().getString(param1.getVariableName());
			var _loc_4:Object = new Object();
			_loc_4.username = param1.user.getUserName();
			_loc_4.variable = param1.getVariableName();
			_loc_4.value = _loc_3;
			dispatchEvent(_loc_2, _loc_4);
		}

		private function toEsObject(param1:Object) : EsObject
		{
			var _loc_3:uint = 0;
			var _loc_4:String = null;
			var _loc_2:EsObject = new EsObject();
			if(_loc_2 == null)
			{
				return _loc_2;
			}
			if(param1 is Array)
			{
				_loc_3 = 0;
				while(_loc_3 < param1.length)
				{
					if(param1[_loc_3].type == "s")
					{
						_loc_2.setString(param1[_loc_3].key, String(param1[_loc_3].value));
					}
					else
					{
						if(param1[_loc_3].type == "i")
						{
							_loc_2.setInteger(param1[_loc_3].key, parseInt(param1[_loc_3].value));
						}
						else
						{
							if(param1[_loc_3].type == "b")
							{
								_loc_2.setBoolean(param1[_loc_3].key, Boolean(param1[_loc_3].value));
							}
							else
							{
								if(param1[_loc_3].type == "r")
								{
									_loc_2.setFloat(param1[_loc_3].key, Number(param1[_loc_3].value));
								}
							}
						}
					}
					_loc_3 = _loc_3 + 1;
				}
			}
			else
			{
				if(param1 is Object)
				{
					var _loc_5:int = 0;
					var _loc_6:* = param1;
					for each(_loc_4 in _loc_6)
					{
						_loc_2.setString(_loc_4, String(_loc_6[_loc_4]));
					}
				}
			}
			return _loc_2;
		}

		private function toObject(param1:EsObject) : Object
		{
			var _loc_2:Object = new Object();
			var _loc_3:Array = param1.getEntries();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_2[_loc_3[_loc_4].getName()] = _loc_3[_loc_4].getRawValue();
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		private function toUser(param1:User) : User
		{
			var _loc_2:User = new User(param1.getUserName());
			_loc_2.isMe = param1.getIsMe();
			_loc_2.isSendingVideo = param1.getIsSendingVideo();
			_loc_2.videoStreamName = param1.getVideoStreamName();
			var _loc_3:Array = param1.getUserVariables();
			var _loc_4:uint = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_2.setVariable(_loc_3[_loc_4].getName(), _loc_3[_loc_4].getValue().getString(_loc_3[_loc_4].getName()));
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		private function toUsers(param1:Array) : Array
		{
			var _loc_2:Array = new Array();
			var _loc_3:uint = 0;
			while(_loc_3 < param1.length)
			{
				if(param1[_loc_3] is User)
				{
					_loc_2.push(toUser(param1[_loc_3]));
				}
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function toZoneId(param1:String) : Number
		{
			return server.getZoneManager().getZoneByName(param1).getZoneId();
		}

		public function toRoomId(param1:String, param2:String) : Number
		{
			var zonename:String = param1;
			var roomname:String = param2;
			var zone:Zone = server.getZoneManager().getZoneByName(zonename);
			try
			{
				if(zone != null)
				{
					return zone.getRoomByName(roomname).getRoomId();
				}
				else
				{
					trace("zone is null");
					return -1;
				}
			}
			catch(error:Error)
			{
				trace("Invalid zone");
				return -1;
			}
			return -1;
		}

		private function toZoneName(param1:Number) : String
		{
			return server.getZoneManager().getZoneById(param1).getZoneName();
		}

		private function toRoomName(param1:Number, param2:Number) : String
		{
			var _loc_3:Zone = server.getZoneManager().getZoneById(param1);
			return _loc_3.getRoomById(param2).getRoomName();
		}

		public function debugEvent(param1:EventImpl) : void
		{
			g.scene.debug(String(param1));
		}

		public function debugResponse(param1:ResponseImpl) : void
		{
			g.scene.debug(String(param1));
		}

		private function initializeListeners() : void
		{
			var _loc_3:uint = 0;
			server.addEventListener(MessageType.JoinRoomEvent, "onJoinRoomEvent", this);
			server.addEventListener(MessageType.LeaveRoomEvent, "onLeaveRoomEvent", this);
			server.addEventListener(MessageType.UserListUpdateEvent, "onUserListUpdateEvent", this);
			server.addEventListener(MessageType.UserVariableUpdateEvent, "onUserVariableUpdateEvent", this);
			server.addEventListener(MessageType.PublicMessageEvent, "onPublicMessageEvent", this);
			server.addEventListener(MessageType.PrivateMessageEvent, "onPrivateMessageEvent", this);
			server.addEventListener(MessageType.PluginMessageEvent, "onPluginMessageEvent", this);
			server.addEventListener(MessageType.ConnectionEvent, "onConnectionEvent", this);
			server.addEventListener(MessageType.ConnectionClosedEvent, "onConnectionClosedEvent", this);
			server.addEventListener(MessageType.LoginResponse, "onLoginResponse", this);
			server.addEventListener(MessageType.GenericErrorResponse, "onGenericError", this);
			var _loc_1:Array = [MessageType.LoginResponse, MessageType.GetUsersInRoomResponse, MessageType.GetUserCountResponse, MessageType.GetZonesResponse, MessageType.GetRoomsInZoneResponse, MessageType.GenericErrorResponse, MessageType.FindZoneAndRoomByNameResponse, MessageType.ValidateAdditionalLoginResponse, MessageType.CreateOrJoinGameResponse, MessageType.FindGamesResponse, MessageType.GetUserVariablesResponse];
			var _loc_2:Array = [MessageType.ConnectionEvent, MessageType.ClientIdleEvent, MessageType.JoinRoomEvent, MessageType.JoinZoneEvent, MessageType.PublicMessageEvent, MessageType.PrivateMessageEvent, MessageType.ZoneUpdateEvent, MessageType.LeaveRoomEvent, MessageType.LeaveZoneEvent, MessageType.UserListUpdateEvent, MessageType.RoomVariableUpdateEvent, MessageType.UserVariableUpdateEvent, MessageType.BuddyStatusUpdatedEvent, MessageType.UserEvictedFromRoomEvent, MessageType.UpdateRoomDetailsEvent, MessageType.PluginMessageEvent, MessageType.CompositePluginMessageEvent, MessageType.ConnectionClosedEvent, MessageType.RtmpConnectionEvent, MessageType.RtmpConnectionClosedEvent, MessageType.RtmpOnStatusEvent];
			if(debug && 1 == 0)
			{
				_loc_3 = 0;
				while(_loc_3 < _loc_2.length)
				{
					server.addEventListener(_loc_2[_loc_3], "debugEvent", this);
					_loc_3 = _loc_3 + 1;
				}
				_loc_3 = 0;
				while(_loc_3 < _loc_1.length)
				{
					server.addEventListener(_loc_1[_loc_3], "debugResponse", this);
					_loc_3 = _loc_3 + 1;
				}
			}
		}

		private function destroyListeners() : void
		{
			server.removeEventListener(MessageType.JoinRoomEvent, "onJoinRoomEvent", this);
			server.removeEventListener(MessageType.LeaveRoomEvent, "onLeaveRoomEvent", this);
			server.removeEventListener(MessageType.UserListUpdateEvent, "onUserListUpdateEvent", this);
			server.removeEventListener(MessageType.UserVariableUpdateEvent, "onUserVariableUpdateEvent", this);
			server.removeEventListener(MessageType.PublicMessageEvent, "onPublicMessageEvent", this);
			server.removeEventListener(MessageType.PrivateMessageEvent, "onPrivateMessageEvent", this);
			server.removeEventListener(MessageType.PluginMessageEvent, "onPluginMessageEvent", this);
			server.removeEventListener(MessageType.ConnectionEvent, "onConnectionEvent", this);
			server.removeEventListener(MessageType.ConnectionClosedEvent, "onConnectionClosedEvent", this);
			server.removeEventListener(MessageType.LoginResponse, "onLoginResponse", this);
			server.removeEventListener(MessageType.GenericErrorResponse, "onGenericError", this);
		}

		private function eventDisplay(param1:String) : void
		{
			if(debug)
			{
				g.scene.debug(param1);
			}
		}
	}
}
package net.theyak.server
{
	public class User extends Object
	{
		public var name:String;
		public var isMe:Boolean;
		public var isSendingVideo:Boolean;
		public var isSendingAudio:Boolean;
		public var videoStreamName:String;
		public var audioStreamName:String;
		private var variables:Array;

		public function User(param1:String)
		{
			super();
			variables = new Array();
			this.name = param1;
			this.isSendingVideo = false;
			this.isSendingAudio = false;
		}

		public function setVariable(param1:String, param2:String) : void
		{
			var _loc_3:uint = 0;
			while(_loc_3 < variables.length)
			{
				if(variables[_loc_3].name == param1)
				{
					variables[_loc_3].value = param2;
					return;
				}
				_loc_3 = _loc_3 + 1;
			}
			var _loc_4:Object = new Object();
			_loc_4.name = param1;
			_loc_4.value = param2;
			variables.push(_loc_4);
		}

		public function getVariable(param1:String) : String
		{
			var _loc_2:uint = 0;
			while(_loc_2 < variables.length)
			{
				if(variables[_loc_2].name == param1)
				{
					return variables[_loc_2].value;
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		public function variableExists(param1:String) : Boolean
		{
			return !(getVariable(param1) == null);
		}

		public function toString() : String
		{
			var _loc_1:String = "";
			_loc_1 = _loc_1 + "Name: " + name + "\n";
			_loc_1 = _loc_1 + "isMe: " + isMe + "\n";
			_loc_1 = _loc_1 + "isSendingVideo: " + isSendingVideo + "\n";
			_loc_1 = _loc_1 + "isSendingAudio: " + isSendingAudio + "\n";
			_loc_1 = _loc_1 + "videoStreamName: " + videoStreamName + "\n";
			_loc_1 = _loc_1 + "audioStreamName: " + audioStreamName + "\n";
			_loc_1 = _loc_1 + "Variables:\n";
			var _loc_2:uint = 0;
			while(_loc_2 < variables.length)
			{
				_loc_1 = _loc_1 + "        " + variables[_loc_2].name + ": " + variables[_loc_2].value;
				_loc_2 = _loc_2 + 1;
			}
			return _loc_1;
		}
	}
}
