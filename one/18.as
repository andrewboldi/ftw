package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class BuddyStatusUpdatedEvent extends EventImpl
	{
		public static var LoggedIn:Number = 0;
		public static var LoggedOut:Number = 1;
		private var actionId:Number;
		private var userId:String;
		private var userName:String;
		private var user:User;
		private var esObject:EsObject;
		private var hasEsObject:Boolean;

		public function BuddyStatusUpdatedEvent()
		{
			super();
			setMessageType(MessageType.BuddyStatusUpdatedEvent);
		}

		public function setHasEsObject(param1:Boolean) : void
		{
			hasEsObject = param1;
		}

		public function getHasEsObject() : Boolean
		{
			return hasEsObject;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setUser(param1:User) : void
		{
			user = param1;
		}

		public function getUser() : User
		{
			return user;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class ClientIdleEvent extends EventImpl
	{
		public function ClientIdleEvent()
		{
			super();
			setMessageType(MessageType.ClientIdleEvent);
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class CompositePluginMessageEvent extends EventImpl
	{
		private var parameters:Array;
		private var pluginName:String;
		private var originZoneId:Number;
		private var originRoomId:Number;

		public function CompositePluginMessageEvent()
		{
			super();
			setMessageType(MessageType.CompositePluginMessageEvent);
		}

		public function setOriginZoneId(param1:Number) : void
		{
			originZoneId = param1;
		}

		public function getOriginZoneId() : Number
		{
			return originZoneId;
		}

		public function setOriginRoomId(param1:Number) : void
		{
			originRoomId = param1;
		}

		public function getOriginRoomId() : Number
		{
			return originRoomId;
		}

		public function setPluginName(param1:String) : void
		{
			pluginName = param1;
		}

		public function getPluginName() : String
		{
			return pluginName;
		}

		public function setParameters(param1:Array) : void
		{
			parameters = param1;
		}

		public function getParameters() : Array
		{
			return parameters;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.connection.*;
	import com.electrotank.electroserver4.message.*;

	public class ConnectionClosedEvent extends EventImpl
	{
		private var connection:AbstractConnection;

		public function ConnectionClosedEvent()
		{
			super();
			setMessageType(MessageType.ConnectionClosedEvent);
		}

		public function setConnection(param1:AbstractConnection) : void
		{
			connection = param1;
		}

		public function getConnection() : AbstractConnection
		{
			return connection;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;

	public class ConnectionEvent extends EventImpl
	{
		private var accepted:Boolean;
		private var esError:EsError;
		private var hashId:int;
		private var prime:String;
		private var base:String;

		public function ConnectionEvent()
		{
			super();
			setMessageType(MessageType.ConnectionEvent);
		}

		public function setHashId(param1:int) : void
		{
			this.hashId = param1;
		}

		public function getHashId() : int
		{
			return hashId;
		}

		public function setEsError(param1:EsError) : void
		{
			this.esError = param1;
		}

		public function getEsError() : EsError
		{
			return this.esError;
		}

		public function setPrime(param1:String) : void
		{
			this.prime = param1;
		}

		public function getPrime() : String
		{
			return this.prime;
		}

		public function setBase(param1:String) : void
		{
			this.base = param1;
		}

		public function getBase() : String
		{
			return this.base;
		}

		public function get success() : Boolean
		{
			return getAccepted();
		}

		public function setAccepted(param1:Boolean) : void
		{
			accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}

		public function toString() : String
		{
			return "ConnectionEvent[id: " + getHashId() + ", accepted: " + accepted + "]";
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class EventImpl extends MessageImpl
	{
		public function EventImpl()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class JoinRoomEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var roomName:String;
		private var zoneName:String;
		private var roomDescription:String;
		private var users:Array;
		private var roomVariables:Array;
		private var capacity:Number;
		private var isHidden:Boolean;
		private var hasPassword:Boolean;
		private var _room:Room;

		public function JoinRoomEvent()
		{
			super();
			setMessageType(MessageType.JoinRoomEvent);
			roomVariables = new Array();
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function setCapacity(param1:Number) : void
		{
			capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setIsHidden(param1:Boolean) : void
		{
			isHidden = param1;
		}

		public function getIsHidden() : Boolean
		{
			return isHidden;
		}

		public function setHasPassword(param1:Boolean) : void
		{
			hasPassword = param1;
		}

		public function getHasPassword() : Boolean
		{
			return hasPassword;
		}

		public function setRoomVariables(param1:Array) : void
		{
			roomVariables = param1;
		}

		public function getRoomVariables() : Array
		{
			return roomVariables;
		}

		public function setUsers(param1:Array) : void
		{
			users = param1;
		}

		public function getUsers() : Array
		{
			return users;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setRoomName(param1:String) : void
		{
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		public function setRoomDescription(param1:String) : void
		{
			roomDescription = param1;
		}

		public function getRoomDescription() : String
		{
			return roomDescription;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class JoinZoneEvent extends EventImpl
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var rooms:Array;
		private var _zone:Zone;

		public function JoinZoneEvent()
		{
			super();
			setMessageType(MessageType.JoinZoneEvent);
		}

		public function set zone(param1:Zone) : void
		{
			_zone = param1;
		}

		public function get zone() : Zone
		{
			return _zone;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setRooms(param1:Array) : void
		{
			rooms = param1;
		}

		public function getRooms() : Array
		{
			return rooms;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class LeaveRoomEvent extends EventImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var _room:Room;

		public function LeaveRoomEvent()
		{
			super();
			setMessageType(MessageType.LeaveRoomEvent);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class LeaveZoneEvent extends EventImpl
	{
		private var zoneId:Number;
		private var _zone:Zone;

		public function LeaveZoneEvent()
		{
			super();
			setMessageType(MessageType.LeaveZoneEvent);
		}

		public function set zone(param1:Zone) : void
		{
			_zone = param1;
		}

		public function get zone() : Zone
		{
			return _zone;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PluginMessageEvent extends EventImpl
	{
		private var originZoneId:Number;
		private var originRoomId:Number;
		private var destinationZoneId:Number;
		private var destinationRoomId:Number;
		private var esObject:EsObject;
		private var pluginName:String;
		private var sentToRoom:Boolean;
		private var isRoomLevelPlugin:Boolean;

		public function PluginMessageEvent()
		{
			super();
			setMessageType(MessageType.PluginMessageEvent);
			setIsRoomLevelPlugin(false);
		}

		public function setIsRoomLevelPlugin(param1:Boolean) : void
		{
			isRoomLevelPlugin = param1;
		}

		public function getIsRoomLevelPlugin() : Boolean
		{
			return isRoomLevelPlugin;
		}

		public function setPluginName(param1:String) : void
		{
			pluginName = param1;
		}

		public function getPluginName() : String
		{
			return pluginName;
		}

		public function wasSentToRoom() : Boolean
		{
			return sentToRoom;
		}

		public function setSentToRoom(param1:Boolean) : void
		{
			sentToRoom = param1;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return this.esObject;
		}

		public function setOriginZoneId(param1:Number) : void
		{
			originZoneId = param1;
		}

		public function getOriginZoneId() : Number
		{
			return originZoneId;
		}

		public function setOriginRoomId(param1:Number) : void
		{
			originRoomId = param1;
		}

		public function getOriginRoomId() : Number
		{
			return originRoomId;
		}

		public function setDestinationZoneId(param1:Number) : void
		{
			destinationZoneId = param1;
		}

		public function getDestinationZoneId() : Number
		{
			return destinationZoneId;
		}

		public function setDestinationRoomId(param1:Number) : void
		{
			destinationRoomId = param1;
		}

		public function getDestinationRoomId() : Number
		{
			return destinationRoomId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class PrivateMessageEvent extends EventImpl
	{
		private var userId:String;
		private var userName:String;
		private var message:String;
		private var esObject:EsObject;
		private var _user:User;

		public function PrivateMessageEvent()
		{
			super();
			setMessageType(MessageType.PrivateMessageEvent);
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setMessage(param1:String) : void
		{
			message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class PublicMessageEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var userName:String;
		private var message:String;
		private var esObject:EsObject;
		private var userNameIncluded:Boolean;
		private var _user:User;
		private var _room:Room;

		public function PublicMessageEvent()
		{
			super();
			setMessageType(MessageType.PublicMessageEvent);
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserNameIncluded(param1:Boolean) : void
		{
			userNameIncluded = param1;
		}

		public function isUserNameIncluded() : Boolean
		{
			return userNameIncluded;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setMessage(param1:String) : void
		{
			message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class RoomVariableUpdateEvent extends EventImpl
	{
		public static var VariableCreated:Number = 1;
		public static var VariableUpdated:Number = 2;
		public static var VariableDeleted:Number = 3;
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var lockChanged:Boolean;
		private var valueChanged:Boolean;
		private var updateAction:Number;
		private var persistent:Boolean;
		private var _room:Room;
		private var _minorType:String;
		private var _variable:RoomVariable;

		public function RoomVariableUpdateEvent()
		{
			super();
			setMessageType(MessageType.RoomVariableUpdateEvent);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function set variable(param1:RoomVariable) : void
		{
			_variable = param1;
		}

		public function get variable() : RoomVariable
		{
			return _variable;
		}

		public function setPersistent(param1:Boolean) : void
		{
			persistent = param1;
		}

		public function getPersistent() : Boolean
		{
			return persistent;
		}

		public function setUpdateAction(param1:Number) : void
		{
			updateAction = param1;
		}

		public function getUpdateAction() : Number
		{
			return updateAction;
		}

		public function setLockChanged(param1:Boolean) : void
		{
			lockChanged = param1;
		}

		public function getLockChanged() : Boolean
		{
			return lockChanged;
		}

		public function setValueChanged(param1:Boolean) : void
		{
			valueChanged = param1;
		}

		public function getValueChanged() : Boolean
		{
			return valueChanged;
		}

		public function setName(param1:String) : void
		{
			name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function setValue(param1:EsObject) : void
		{
			value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setLocked(param1:Boolean) : void
		{
			locked = param1;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpConnectionClosedEvent extends EventImpl
	{
		private var accepted:Boolean;

		public function RtmpConnectionClosedEvent()
		{
			super();
			setMessageType(MessageType.RtmpConnectionClosedEvent);
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpConnectionEvent extends EventImpl
	{
		private var accepted:Boolean;

		public function RtmpConnectionEvent()
		{
			super();
			setMessageType(MessageType.RtmpConnectionEvent);
		}

		public function setAccepted(param1:Boolean) : void
		{
			this.accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpOnStatusEvent extends EventImpl
	{
		private var info:Object;

		public function RtmpOnStatusEvent()
		{
			super();
			setMessageType(MessageType.RtmpOnStatusEvent);
		}

		public function getInfo() : Object
		{
			return info;
		}

		public function setInfo(param1:Object) : void
		{
			this.info = param1;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class UpdateRoomDetailsEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var roomNameUpdate:Boolean;
		private var roomName:String;
		private var capacityUpdate:Boolean;
		private var capacity:Number;
		private var descriptionUpdate:Boolean;
		private var description:String;
		private var passwordUpdate:Boolean;
		private var password:String;
		private var hiddenUpdate:Boolean;
		private var hidden:Boolean;
		private var _room:Room;

		public function UpdateRoomDetailsEvent()
		{
			super();
			setMessageType(MessageType.UpdateRoomDetailsEvent);
			setHiddenUpdate(false);
			setPasswordUpdate(false);
			setDescriptionUpdate(false);
			setCapacityUpdate(false);
			setRoomNameUpdate(false);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function setHidden(param1:Boolean) : void
		{
			setHiddenUpdate(true);
			hidden = param1;
		}

		public function getHidden() : Boolean
		{
			return hidden;
		}

		public function setHiddenUpdate(param1:Boolean) : void
		{
			hiddenUpdate = param1;
		}

		public function isHiddenUpdate() : Boolean
		{
			return hiddenUpdate;
		}

		public function getPassword() : String
		{
			return password;
		}

		public function setPassword(param1:String) : void
		{
			setPasswordUpdate(true);
			password = param1;
		}

		public function isPasswordUpdate() : Boolean
		{
			return passwordUpdate;
		}

		public function setPasswordUpdate(param1:Boolean) : void
		{
			passwordUpdate = param1;
		}

		public function setDescription(param1:String) : void
		{
			setDescriptionUpdate(true);
			description = param1;
		}

		public function getDescription() : String
		{
			return description;
		}

		public function setDescriptionUpdate(param1:Boolean) : void
		{
			descriptionUpdate = param1;
		}

		public function isDescriptionUpdate() : Boolean
		{
			return descriptionUpdate;
		}

		public function setCapacity(param1:Number) : void
		{
			setCapacityUpdate(true);
			capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setCapacityUpdate(param1:Boolean) : void
		{
			capacityUpdate = param1;
		}

		public function isCapacityUpdate() : Boolean
		{
			return capacityUpdate;
		}

		public function setRoomName(param1:String) : void
		{
			setRoomNameUpdate(true);
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		public function setRoomNameUpdate(param1:Boolean) : void
		{
			roomNameUpdate = param1;
		}

		public function isRoomNameUpdate() : Boolean
		{
			return roomNameUpdate;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class UserEvictedFromRoomEvent extends EventImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var reason:String;
		private var ban:Boolean;
		private var duration:Number;
		private var _user:User;

		public function UserEvictedFromRoomEvent()
		{
			super();
			setMessageType(MessageType.UserEvictedFromRoomEvent);
			ban = false;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function isBan() : Boolean
		{
			return ban;
		}

		public function setBan(param1:Boolean) : void
		{
			ban = param1;
		}

		public function setDuration(param1:Number) : void
		{
			duration = param1;
		}

		public function getDuration() : Number
		{
			return duration;
		}

		public function setReason(param1:String) : void
		{
			reason = param1;
		}

		public function getReason() : String
		{
			return reason;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.user.*;

	public class UserListUpdateEvent extends EventImpl
	{
		public static var AddUser:Number = 0;
		public static var DeleteUser:Number = 1;
		public static var UpdateUser:Number = 2;
		public static var OperatorGranted:Number = 3;
		public static var OperatorRevoked:Number = 4;
		public static var SendingVideoStream:Number = 5;
		public static var StoppingVideoStream:Number = 6;
		private var roomId:Number;
		private var zoneId:Number;
		private var actionId:Number;
		private var userId:String;
		private var userName:String;
		private var userVariables:Array;
		private var _user:User;
		private var _room:Room;
		private var _minorType:String;
		private var isSendingVideo:Boolean;
		private var videoStreamName:String;

		public function UserListUpdateEvent()
		{
			super();
			setMessageType(MessageType.UserListUpdateEvent);
		}

		public function setIsSendingVideo(param1:Boolean) : void
		{
			this.isSendingVideo = param1;
		}

		public function setUser(param1:User) : void
		{
			user = param1;
		}

		public function getUser() : User
		{
			return user;
		}

		public function getIsSendingVideo() : Boolean
		{
			return this.isSendingVideo;
		}

		public function setVideoStreamName(param1:String) : void
		{
			this.videoStreamName = param1;
		}

		public function getVideoStreamName() : String
		{
			return this.videoStreamName;
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.user.*;

	public class UserVariableUpdateEvent extends EventImpl
	{
		public static var VariableCreated:Number = 1;
		public static var VariableUpdated:Number = 2;
		public static var VariableDeleted:Number = 3;
		private var userId:String;
		private var actionId:Number;
		private var variable:UserVariable;
		private var _minorType:String;
		private var _user:User;
		private var variableName:String;

		public function UserVariableUpdateEvent()
		{
			super();
			setMessageType(MessageType.UserVariableUpdateEvent);
		}

		public function setVariableName(param1:String) : void
		{
			this.variableName = param1;
		}

		public function getVariableName() : String
		{
			return this.variableName;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function set user(param1:User) : void
		{
			_user = param1;
		}

		public function get user() : User
		{
			return _user;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setVariable(param1:UserVariable) : void
		{
			variable = param1;
		}

		public function getVariable() : UserVariable
		{
			return variable;
		}
	}
}
package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class ZoneUpdateEvent extends EventImpl
	{
		public static var AddRoom:Number = 0;
		public static var DeleteRoom:Number = 1;
		public static var UpdateRoom:Number = 2;
		private var zoneId:Number;
		private var roomId:Number;
		private var actionId:Number;
		private var roomCount:Number;
		private var __room:Room;
		private var _room:Room;
		private var _minorType:String;
		private var _zone:Zone;

		public function ZoneUpdateEvent()
		{
			super();
			setMessageType(MessageType.ZoneUpdateEvent);
		}

		public function set zone(param1:Zone) : void
		{
			_zone = param1;
		}

		public function get zone() : Zone
		{
			return _zone;
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function setRoom(param1:Room) : void
		{
			__room = param1;
		}

		public function getRoom() : Room
		{
			return __room;
		}

		public function setRoomCount(param1:Number) : void
		{
			roomCount = param1;
		}

		public function getRoomCount() : Number
		{
			return roomCount;
		}

		public function setActionId(param1:Number) : void
		{
			actionId = param1;
		}

		public function getActionId() : Number
		{
			return actionId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
