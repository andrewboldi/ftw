package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class CreateOrJoinGameResponse extends ResponseImpl
	{
		private var successful:Boolean;
		private var zoneId:Number;
		private var roomId:Number;
		private var esError:EsError;
		private var gameDetails:EsObject;
		private var gameId:Number;

		public function CreateOrJoinGameResponse()
		{
			super();
			setMessageType(MessageType.CreateOrJoinGameResponse);
		}

		public function setGameId(param1:Number) : void
		{
			this.gameId = param1;
		}

		public function getGameId() : Number
		{
			return gameId;
		}

		public function setGameDetails(param1:EsObject) : void
		{
			this.gameDetails = param1;
		}

		public function getGameDetails() : EsObject
		{
			return gameDetails;
		}

		public function setSuccessful(param1:Boolean) : void
		{
			this.successful = param1;
		}

		public function getSuccessful() : Boolean
		{
			return successful;
		}

		public function setZoneId(param1:Number) : void
		{
			this.zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			this.roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setEsError(param1:EsError) : void
		{
			this.esError = param1;
		}

		public function getEsError() : EsError
		{
			return esError;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class FindGamesResponse extends ResponseImpl
	{
		private var games:Array;

		public function FindGamesResponse()
		{
			super();
			setMessageType(MessageType.FindGamesResponse);
		}

		public function setGames(param1:Array) : void
		{
			this.games = param1;
		}

		public function getGames() : Array
		{
			return this.games;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class FindZoneAndRoomByNameResponse extends ResponseImpl
	{
		private var roomAndZoneList:Array;

		public function FindZoneAndRoomByNameResponse()
		{
			super();
			setMessageType(MessageType.FindZoneAndRoomByNameResponse);
		}

		public function setRoomAndZoneList(param1:Array) : void
		{
			roomAndZoneList = param1;
		}

		public function getRoomAndZoneList() : Array
		{
			return roomAndZoneList;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GenericErrorResponse extends ResponseImpl
	{
		private var requestMessageType:MessageType;
		private var errorType:EsError;
		private var esObject:EsObject;
		private var hasEsObject:Boolean;

		public function GenericErrorResponse()
		{
			super();
			setMessageType(MessageType.GenericErrorResponse);
			hasEsObject = false;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
			hasEsObject = true;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setRequestMessageType(param1:MessageType) : void
		{
			requestMessageType = param1;
		}

		public function getRequestMessageType() : MessageType
		{
			return requestMessageType;
		}

		public function setErrorType(param1:EsError) : void
		{
			errorType = param1;
		}

		public function getErrorType() : EsError
		{
			return errorType;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class GetRoomsInZoneResponse extends ResponseImpl
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var rooms:Array;

		public function GetRoomsInZoneResponse()
		{
			super();
			setMessageType(MessageType.GetRoomsInZoneResponse);
			rooms = new Array();
			setZoneId(-1);
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function addRoom(param1:Room) : void
		{
			getRooms().push(param1);
		}

		public function getRooms() : Array
		{
			return rooms;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserCountResponse extends ResponseImpl
	{
		private var count:Number;

		public function GetUserCountResponse()
		{
			super();
			setMessageType(MessageType.GetUserCountResponse);
		}

		public function setCount(param1:Number) : void
		{
			count = param1;
		}

		public function getCount() : Number
		{
			return count;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class GetUsersInRoomResponse extends ResponseImpl
	{
		private var users:Array;
		private var roomId:Number;
		private var zoneId:Number;

		public function GetUsersInRoomResponse()
		{
			super();
			setMessageType(MessageType.GetUsersInRoomResponse);
		}

		public function setUsers(param1:Array) : void
		{
			users = param1;
		}

		public function getUsers() : Array
		{
			return users;
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
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GetUserVariablesResponse extends ResponseImpl
	{
		private var userVariables:Array;
		private var userVariablesByName:Object;
		private var userName:String;

		public function GetUserVariablesResponse()
		{
			super();
			setMessageType(MessageType.GetUserVariablesResponse);
			userVariables = new Array();
			userVariablesByName = new Object();
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function addVariable(param1:String, param2:EsObject) : void
		{
			var _loc_3:UserVariable = new UserVariable(param1, param2);
			userVariablesByName[param1] = _loc_3;
			userVariables.push(_loc_3);
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function getUserVariableByName(param1:String) : UserVariable
		{
			return userVariablesByName[param1];
		}

		public function doesUserVariableExist(param1:String) : Boolean
		{
			return !(userVariablesByName[param1] == null);
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class GetZonesResponse extends ResponseImpl
	{
		private var zones:Array;

		public function GetZonesResponse()
		{
			super();
			setMessageType(MessageType.GetZonesResponse);
			zones = new Array();
		}

		public function addZone(param1:Zone) : void
		{
			getZones().push(param1);
		}

		public function getZones() : Array
		{
			return zones;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class LoginResponse extends ResponseImpl
	{
		private var accepted:Boolean;
		private var esError:EsError;
		private var esObject:EsObject;
		private var userName:String;
		private var userId:String;
		private var userVariables:Array;
		private var buddies:Object;

		public function LoginResponse()
		{
			super();
			setMessageType(MessageType.LoginResponse);
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function setBuddies(param1:Object) : void
		{
			buddies = param1;
		}

		public function getBuddies() : Object
		{
			return buddies;
		}

		public function setUserId(param1:String) : void
		{
			this.userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function get success() : Boolean
		{
			return getAccepted();
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setAccepted(param1:Boolean) : void
		{
			accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}

		public function setEsError(param1:EsError) : void
		{
			esError = param1;
		}

		public function getEsError() : EsError
		{
			return esError;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class ResponseImpl extends MessageImpl
	{
		private var requestId:Number;

		public function ResponseImpl()
		{
			super();
		}

		public function setRequestId(param1:Number) : void
		{
			requestId = param1;
		}

		public function getRequestId() : Number
		{
			return requestId;
		}
	}
}
package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class ValidateAdditionalLoginResponse extends ResponseImpl
	{
		private var approved:Boolean;
		private var secret:String;

		public function ValidateAdditionalLoginResponse()
		{
			super();
			setMessageType(MessageType.ValidateAdditionalLoginResponse);
		}

		public function getApproved() : Boolean
		{
			return approved;
		}

		public function setApproved(param1:Boolean) : void
		{
			approved = param1;
		}

		public function setSecret(param1:String) : void
		{
			secret = param1;
		}

		public function getSecret() : String
		{
			return secret;
		}
	}
}
