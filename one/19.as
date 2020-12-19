package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class AddBuddyRequest extends RequestImpl
	{
		private var buddyName:String;
		private var esObject:EsObject;

		public function AddBuddyRequest()
		{
			super();
			setMessageType(MessageType.AddBuddyRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setBuddyName(param1:String) : void
		{
			buddyName = param1;
		}

		public function getBuddyName() : String
		{
			return buddyName;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class AddRoomOperatorRequest extends RequestImpl
	{
		private var userId:String;
		private var zoneId:Number;
		private var roomId:Number;

		public function AddRoomOperatorRequest()
		{
			super();
			setMessageType(MessageType.AddRoomOperatorRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserId(param1:String) : void
		{
			this.userId = param1;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class CreateOrJoinGameRequest extends RequestImpl
	{
		private var zoneName:String;
		private var password:String;
		private var gameDetails:EsObject;
		private var searchCriteria:SearchCriteria;
		private var gameType:String;
		private var createOnly:Boolean;
		private var isHidden:Boolean;
		private var isLocked:Boolean;

		public function CreateOrJoinGameRequest()
		{
			super();
			setMessageType(MessageType.CreateOrJoinGameRequest);
			setSearchCriteria(new SearchCriteria());
			setIsHidden(false);
			setIsLocked(false);
		}

		public function setCreateOnly(param1:Boolean) : void
		{
			this.createOnly = param1;
			if(param1)
			{
				searchCriteria = null;
			}
		}

		public function setIsLocked(param1:Boolean) : void
		{
			this.isLocked = param1;
		}

		public function getIsLocked() : Boolean
		{
			return isLocked;
		}

		public function setIsHidden(param1:Boolean) : void
		{
			this.isHidden = param1;
		}

		public function getIsHidden() : Boolean
		{
			return isHidden;
		}

		public function setGameType(param1:String) : void
		{
			this.gameType = param1;
		}

		public function getGameType() : String
		{
			return gameType;
		}

		public function setZoneName(param1:String) : void
		{
			this.zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setPassword(param1:String) : void
		{
			this.password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}

		public function setGameDetails(param1:EsObject) : void
		{
			this.gameDetails = param1;
		}

		public function getGameDetails() : EsObject
		{
			return this.gameDetails;
		}

		public function setSearchCriteria(param1:SearchCriteria) : void
		{
			this.searchCriteria = param1;
		}

		public function getSearchCriteria() : SearchCriteria
		{
			return searchCriteria;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class CreateRoomRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var roomName:String;
		private var roomDescription:String;
		private var capacity:Number;
		private var password:String;
		private var isReceivingRoomListUpdates:Boolean;
		private var isReceivingUserListUpdates:Boolean;
		private var isReceivingRoomVariableUpdates:Boolean;
		private var isReceivingUserVariableUpdates:Boolean;
		private var isReceivingVideoEvents:Boolean;
		private var isReceivingRoomDetailUpdates:Boolean;
		private var isNonOperatorUpdateAllowed:Boolean;
		private var isNonOperatorVariableUpdateAllowed:Boolean;
		private var isPersistent:Boolean;
		private var isHidden:Boolean;
		private var isCreateOrJoinRoom:Boolean;
		private var plugins:Array;
		private var variables:Array;
		private var isUsingLanguageFilter:Boolean;
		private var languageFilterName:String;
		private var isDeliverMessageOnFailure:Boolean;
		private var failuresBeforeKick:Number;
		private var kicksBeforeBan:Number;
		private var banDuration:Number;
		private var isResetAfterKick:Boolean;
		private var isUsingFloodingFilter:Boolean;
		private var isFloodingFilterSpecified:Boolean;
		private var floodingFilterName:String;
		private var floodingFilterFailuresBeforeKick:Number;
		private var floodingFilterKicksBeforeBan:Number;
		private var floodingFilterBanDuration:Number;
		private var isFloodingFilterResetAfterKick:Boolean;
		private var isLanguageFilterSpecified:Boolean;

		public function CreateRoomRequest()
		{
			super();
			setMessageType(MessageType.CreateRoomRequest);
			setZoneId(-1);
			setCapacity(-1);
			setIsCreateOrJoinRoom(true);
			setRoomDescription("");
			setIsNonOperatorUpdateAllowed(true);
			setIsNonOperatorVariableUpdateAllowed(true);
			setIsPersistent(false);
			setIsHidden(false);
			setPlugins(new Array());
			setRoomVariables(new Array());
			setIsReceivingRoomListUpdates(true);
			setIsReceivingRoomDetailUpdates(true);
			setIsReceivingUserListUpdates(true);
			setIsReceivingRoomVariableUpdates(true);
			setIsReceivingUserVariableUpdates(true);
			setIsReceivingVideoEvents(true);
			setIsUsingFloodingFilter(false);
			setIsFloodingFilterSpecified(false);
			setIsFloodingFilterResetAfterKick(false);
			setFloodingFilterBanDuration(-1);
			setFloodingFilterKicksBeforeBan(3);
			setFloodingFilterFailuresBeforeKick(1);
			setIsUsingLanguageFilter(false);
			setIsLanguageFilterSpecified(false);
			setIsDeliverMessageOnFailure(false);
			setFailuresBeforeKick(3);
			setKicksBeforeBan(3);
			setBanDuration(-1);
			setIsResetAfterKick(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setIsReceivingRoomDetailUpdates(param1:Boolean) : void
		{
			this.isReceivingRoomDetailUpdates = param1;
		}

		public function getIsReceivingRoomDetailUpdates() : Boolean
		{
			return isReceivingRoomDetailUpdates;
		}

		public function getIsReceivingVideoEvents() : Boolean
		{
			return this.isReceivingVideoEvents;
		}

		public function setIsReceivingVideoEvents(param1:Boolean) : void
		{
			this.isReceivingVideoEvents = param1;
		}

		private function setIsLanguageFilterSpecified(param1:Boolean) : void
		{
			isLanguageFilterSpecified = param1;
		}

		public function getIsLanguageFilterSpecified() : Boolean
		{
			return isLanguageFilterSpecified;
		}

		public function setIsFloodingFilterResetAfterKick(param1:Boolean) : void
		{
			isFloodingFilterResetAfterKick = param1;
		}

		public function getIsFloodingFilterResetAfterKick() : Boolean
		{
			return isFloodingFilterResetAfterKick;
		}

		public function setFloodingFilterBanDuration(param1:Number) : void
		{
			floodingFilterBanDuration = param1;
		}

		public function getFloodingFilterBanDuration() : Number
		{
			return floodingFilterBanDuration;
		}

		public function setFloodingFilterKicksBeforeBan(param1:Number) : void
		{
			floodingFilterKicksBeforeBan = param1;
		}

		public function getFloodingFilterKicksBeforeBan() : Number
		{
			return floodingFilterKicksBeforeBan;
		}

		public function setFloodingFilterFailuresBeforeKick(param1:Number) : void
		{
			floodingFilterFailuresBeforeKick = param1;
		}

		public function getFloodingFilterFailuresBeforeKick() : Number
		{
			return floodingFilterFailuresBeforeKick;
		}

		public function setFloodingFilterName(param1:String) : void
		{
			setIsFloodingFilterSpecified(true);
			floodingFilterName = param1;
		}

		public function getFloodingFilterName() : String
		{
			return floodingFilterName;
		}

		public function getIsFloodingFilterSpecified() : Boolean
		{
			return isFloodingFilterSpecified;
		}

		private function setIsFloodingFilterSpecified(param1:Boolean) : void
		{
			isFloodingFilterSpecified = param1;
		}

		public function setIsUsingFloodingFilter(param1:Boolean) : void
		{
			isUsingFloodingFilter = param1;
		}

		public function getIsUsingFloodingFilter() : Boolean
		{
			return isUsingFloodingFilter;
		}

		public function setIsResetAfterKick(param1:Boolean) : void
		{
			isResetAfterKick = param1;
		}

		public function getIsResetAfterKick() : Boolean
		{
			return isResetAfterKick;
		}

		public function setLanguageFilterName(param1:String) : void
		{
			setIsLanguageFilterSpecified(true);
			languageFilterName = param1;
		}

		public function getLanguageFilterName() : String
		{
			return languageFilterName;
		}

		public function setIsDeliverMessageOnFailure(param1:Boolean) : void
		{
			isDeliverMessageOnFailure = param1;
		}

		public function getIsDeliverMessageOnFailure() : Boolean
		{
			return isDeliverMessageOnFailure;
		}

		public function setFailuresBeforeKick(param1:Number) : void
		{
			param1 = param1;
		}

		public function getFailuresBeforeKick() : Number
		{
			return failuresBeforeKick;
		}

		public function setKicksBeforeBan(param1:Number) : void
		{
			param1 = param1;
		}

		public function getKicksBeforeBan() : Number
		{
			return kicksBeforeBan;
		}

		public function setBanDuration(param1:Number) : void
		{
			banDuration = param1;
		}

		public function getBanDuration() : Number
		{
			return banDuration;
		}

		public function setIsUsingLanguageFilter(param1:Boolean) : void
		{
			isUsingLanguageFilter = param1;
		}

		public function getIsUsingLanguageFilter() : Boolean
		{
			return isUsingLanguageFilter;
		}

		public function setIsCreateOrJoinRoom(param1:Boolean) : void
		{
			isCreateOrJoinRoom = param1;
		}

		public function getIsCreateOrJoinRoom() : Boolean
		{
			return isCreateOrJoinRoom;
		}

		public function setRoomVariables(param1:Array) : void
		{
			variables = param1;
		}

		public function getRoomVariables() : Array
		{
			return variables;
		}

		public function setIsNonOperatorUpdateAllowed(param1:Boolean) : void
		{
			isNonOperatorUpdateAllowed = param1;
		}

		public function getIsNonOperatorUpdateAllowed() : Boolean
		{
			return isNonOperatorUpdateAllowed;
		}

		public function setIsNonOperatorVariableUpdateAllowed(param1:Boolean) : void
		{
			isNonOperatorVariableUpdateAllowed = param1;
		}

		public function getIsNonOperatorVariableUpdateAllowed() : Boolean
		{
			return isNonOperatorVariableUpdateAllowed;
		}

		public function setPlugins(param1:Array) : void
		{
			this.plugins = param1;
		}

		public function getPlugins() : Array
		{
			return plugins;
		}

		public function setIsPersistent(param1:Boolean) : void
		{
			isPersistent = param1;
		}

		public function getIsPersistent() : Boolean
		{
			return isPersistent;
		}

		public function setIsHidden(param1:Boolean) : void
		{
			isHidden = param1;
		}

		public function getIsHidden() : Boolean
		{
			return isHidden;
		}

		public function setIsReceivingRoomListUpdates(param1:Boolean) : void
		{
			isReceivingRoomListUpdates = param1;
		}

		public function getIsReceivingRoomListUpdates() : Boolean
		{
			return isReceivingRoomListUpdates;
		}

		public function setIsReceivingUserListUpdates(param1:Boolean) : void
		{
			isReceivingUserListUpdates = param1;
		}

		public function getIsReceivingUserListUpdates() : Boolean
		{
			return isReceivingUserListUpdates;
		}

		public function setIsReceivingRoomVariableUpdates(param1:Boolean) : void
		{
			isReceivingRoomVariableUpdates = param1;
		}

		public function getIsReceivingRoomVariableUpdates() : Boolean
		{
			return isReceivingRoomVariableUpdates;
		}

		public function setIsReceivingUserVariableUpdates(param1:Boolean) : void
		{
			isReceivingUserVariableUpdates = param1;
		}

		public function getIsReceivingUserVariableUpdates() : Boolean
		{
			return isReceivingUserVariableUpdates;
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

		public function setCapacity(param1:Number) : void
		{
			this.capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setPassword(param1:String) : void
		{
			this.password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class CreateRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var persistent:Boolean;

		public function CreateRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.CreateRoomVariableRequest);
			setLocked(false);
			setPersistent(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
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

		public function setLocked(param1:Boolean) : void
		{
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setPersistent(param1:Boolean) : void
		{
			persistent = param1;
		}

		public function getPersistent() : Boolean
		{
			return persistent;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class DeleteRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;

		public function DeleteRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.DeleteRoomVariableRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class DeleteUserVariableRequest extends RequestImpl
	{
		private var name:String;

		public function DeleteUserVariableRequest()
		{
			super();
			setMessageType(MessageType.DeleteUserVariableRequest);
		}

		public function setName(param1:String) : void
		{
			name = param1;
		}

		public function getName() : String
		{
			return name;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class EvictUserFromRoomRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var reason:String;
		private var ban:Boolean;
		private var duration:Number;

		public function EvictUserFromRoomRequest()
		{
			super();
			setMessageType(MessageType.EvictUserFromRoomRequest);
			ban = false;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;

	public class FindGamesRequest extends RequestImpl
	{
		private var searchCriteria:SearchCriteria;

		public function FindGamesRequest()
		{
			super();
			setMessageType(MessageType.FindGamesRequest);
		}

		public function setSearchCriteria(param1:SearchCriteria) : void
		{
			this.searchCriteria = param1;
		}

		public function getSearchCriteria() : SearchCriteria
		{
			return searchCriteria;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class FindZoneAndRoomByNameRequest extends RequestImpl
	{
		private var zoneName:String;
		private var roomName:String;

		public function FindZoneAndRoomByNameRequest()
		{
			super();
			setMessageType(MessageType.FindZoneAndRoomByNameRequest);
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
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GateWayKickUserRequest extends RequestImpl
	{
		private var eserror:EsError;
		private var esObject:EsObject;

		public function GateWayKickUserRequest()
		{
			super();
			setMessageType(MessageType.GateWayKickUserRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setEsError(param1:EsError) : void
		{
			this.eserror = param1;
		}

		public function getEsError() : EsError
		{
			return eserror;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetRoomsInZoneRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var zoneName:String;

		public function GetRoomsInZoneRequest()
		{
			super();
			setMessageType(MessageType.GetRoomsInZoneRequest);
			setZoneId(-1);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setZoneName(param1:String) : void
		{
			this.zoneName = param1;
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
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserCountRequest extends RequestImpl
	{
		public function GetUserCountRequest()
		{
			super();
			setMessageType(MessageType.GetUserCountRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUsersInRoomRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;

		public function GetUsersInRoomRequest()
		{
			super();
			setMessageType(MessageType.GetUsersInRoomRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserVariablesRequest extends RequestImpl
	{
		private var userName:String;
		private var userVariableNames:Array;

		public function GetUserVariablesRequest()
		{
			super();
			setMessageType(MessageType.GetUserVariablesRequest);
			userVariableNames = new Array();
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getUserName() == null)
			{
				_loc_2.push("A username must be specified.");
			}
			if(_loc_2.length != 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return this.userName;
		}

		public function addUserVariableName(param1:String) : void
		{
			getUserVariableNames().push(param1);
		}

		public function getUserVariableNames() : Array
		{
			return userVariableNames;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetZonesRequest extends RequestImpl
	{
		public function GetZonesRequest()
		{
			super();
			setMessageType(MessageType.GetZonesRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class JoinRoomRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var password:String;
		private var isReceivingRoomListUpdates:Boolean;
		private var isReceivingUserListUpdates:Boolean;
		private var isReceivingRoomVariableUpdates:Boolean;
		private var isReceivingUserVariableUpdates:Boolean;
		private var isReceivingVideoEvents:Boolean;
		private var isReceivingRoomDetailUpdates:Boolean;
		private var room:Room;

		public function JoinRoomRequest()
		{
			super();
			setMessageType(MessageType.JoinRoomRequest);
			setRoomId(-1);
			setZoneId(-1);
			setIsReceivingRoomListUpdates(true);
			setIsReceivingRoomDetailUpdates(true);
			setIsReceivingUserListUpdates(true);
			setIsReceivingRoomVariableUpdates(true);
			setIsReceivingUserVariableUpdates(true);
			setIsReceivingVideoEvents(true);
		}

		public function setIsReceivingRoomDetailUpdates(param1:Boolean) : void
		{
			this.isReceivingRoomDetailUpdates = param1;
		}

		public function getIsReceivingRoomDetailUpdates() : Boolean
		{
			return isReceivingRoomDetailUpdates;
		}

		public function getRoom() : Room
		{
			return room;
		}

		public function getIsReceivingVideoEvents() : Boolean
		{
			return this.isReceivingVideoEvents;
		}

		public function setIsReceivingVideoEvents(param1:Boolean) : void
		{
			this.isReceivingVideoEvents = param1;
		}

		public function setIsReceivingRoomListUpdates(param1:Boolean) : void
		{
			isReceivingRoomListUpdates = param1;
		}

		public function getIsReceivingRoomListUpdates() : Boolean
		{
			return isReceivingRoomListUpdates;
		}

		public function setIsReceivingUserListUpdates(param1:Boolean) : void
		{
			isReceivingUserListUpdates = param1;
		}

		public function getIsReceivingUserListUpdates() : Boolean
		{
			return isReceivingUserListUpdates;
		}

		public function setIsReceivingRoomVariableUpdates(param1:Boolean) : void
		{
			isReceivingRoomVariableUpdates = param1;
		}

		public function getIsReceivingRoomVariableUpdates() : Boolean
		{
			return isReceivingRoomVariableUpdates;
		}

		public function setIsReceivingUserVariableUpdates(param1:Boolean) : void
		{
			isReceivingUserVariableUpdates = param1;
		}

		public function getIsReceivingUserVariableUpdates() : Boolean
		{
			return isReceivingUserVariableUpdates;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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

		public function setPassword(param1:String) : void
		{
			password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class LeaveRoomRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;

		public function LeaveRoomRequest()
		{
			super();
			setMessageType(MessageType.LeaveRoomRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class LoginRequest extends RequestImpl
	{
		private var userName:String;
		private var password:String;
		private var pairs:Array;
		private var userVariables:Array;
		private var sharedSecret:String;
		private var isAutoDiscoverProtocol:Boolean;
		private var protocols:Array;
		private var esObject:EsObject;
		private var isAdditionalLoginRequest:Boolean;

		public function LoginRequest()
		{
			super();
			setMessageType(MessageType.LoginRequest);
			isAdditionalLoginRequest = false;
			pairs = new Array();
			protocols = new Array();
			userVariables = new Array();
			setIsAutoDiscoverProtocol(true);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if((isAdditionalLoginRequest && userName == null) && userName == "")
			{
				_loc_2.push("Additional login request requires a null UserName");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setSharedSecret(param1:String) : void
		{
			this.sharedSecret = param1;
			setMessageType(MessageType.AdditionalLoginRequest);
			isAdditionalLoginRequest = true;
		}

		public function getSharedSecret() : String
		{
			return sharedSecret;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setProtocols(param1:Array) : void
		{
			this.protocols = param1;
		}

		public function getProtocols() : Array
		{
			return this.protocols;
		}

		public function setIsAutoDiscoverProtocol(param1:Boolean) : void
		{
			this.isAutoDiscoverProtocol = param1;
		}

		public function getIsAutoDiscoverProtocol() : Boolean
		{
			return isAutoDiscoverProtocol;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function addUserVariable(param1:String, param2:EsObject) : void
		{
			var _loc_3:EsObjectMap = new EsObjectMap(param1, param2);
			getUserVariables().push(_loc_3);
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setPassword(param1:String) : void
		{
			this.password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class LogoutRequest extends RequestImpl
	{
		private var dropAllConnections:Boolean;
		private var dropConnection:Boolean;

		public function LogoutRequest()
		{
			super();
			setMessageType(MessageType.LogoutRequest);
			setDropAllConnections(true);
			setDropConnection(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setDropAllConnections(param1:Boolean) : void
		{
			dropAllConnections = param1;
		}

		public function getDropAllConnections() : Boolean
		{
			return dropAllConnections;
		}

		public function setDropConnection(param1:Boolean) : void
		{
			dropConnection = param1;
		}

		public function getDropConnection() : Boolean
		{
			return dropConnection;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PluginRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var esObject:EsObject;
		private var pluginName:String;
		private var sentToRoom:Boolean;

		public function PluginRequest()
		{
			super();
			setMessageType(MessageType.PluginRequest);
			esObject = new EsObject();
			setSentToRoom(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function getEsObject() : EsObject
		{
			return this.esObject;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
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

		private function setSentToRoom(param1:Boolean) : void
		{
			sentToRoom = param1;
		}

		public function setZoneId(param1:Number) : void
		{
			setSentToRoom(true);
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PrivateMessageRequest extends RequestImpl
	{
		private var message:String;
		private var pairs:Array;
		private var users:Array;
		private var userNames:Array;
		private var esObject:EsObject;

		public function PrivateMessageRequest()
		{
			super();
			setMessageType(MessageType.PrivateMessageRequest);
			setUsers(new Array());
			setUserNames(new Array());
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getUsers().length == 0 && getUserNames().length == 0)
			{
				_loc_2.push("getUsers() is empty.");
			}
			if(getUsers() == null)
			{
				_loc_2.push("getUsers() returned null.");
			}
			if(getMessage() == null)
			{
				_loc_2.push("getMessage() returned null.");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserNames(param1:Array) : void
		{
			userNames = param1;
		}

		public function getUserNames() : Array
		{
			return userNames;
		}

		public function setUsers(param1:Array) : void
		{
			this.users = param1;
		}

		public function getUsers() : Array
		{
			return users;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setMessage(param1:String) : void
		{
			this.message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PublicMessageRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var message:String;
		private var esObject:EsObject;

		public function PublicMessageRequest()
		{
			super();
			setMessageType(MessageType.PublicMessageRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(isNaN(getZoneId()))
			{
				_loc_2.push("zoneId cannot be null");
			}
			if(isNaN(getRoomId()))
			{
				_loc_2.push("roomId cannot be null");
			}
			if(getMessage() == null)
			{
				_loc_2.push("message cannot be null");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setMessage(param1:String) : void
		{
			this.message = param1;
		}

		public function getMessage() : String
		{
			return message;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class RemoveBuddyRequest extends RequestImpl
	{
		private var buddyName:String;

		public function RemoveBuddyRequest()
		{
			super();
			setMessageType(MessageType.RemoveBuddyRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setBuddyName(param1:String) : void
		{
			buddyName = param1;
		}

		public function getBuddyName() : String
		{
			return buddyName;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class RemoveRoomOperatorRequest extends RequestImpl
	{
		private var userId:String;
		private var zoneId:Number;
		private var roomId:Number;

		public function RemoveRoomOperatorRequest()
		{
			super();
			setMessageType(MessageType.RemoveRoomOperatorRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class RequestImpl extends MessageImpl
	{
		public function RequestImpl()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class UpdateRoomDetailsRequest extends RequestImpl
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

		public function UpdateRoomDetailsRequest()
		{
			super();
			setMessageType(MessageType.UpdateRoomDetailsRequest);
			setHiddenUpdate(false);
			setPasswordUpdate(false);
			setDescriptionUpdate(false);
			setCapacityUpdate(false);
			setRoomNameUpdate(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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

		private function setHiddenUpdate(param1:Boolean) : void
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
			this.password = param1;
		}

		public function isPasswordUpdate() : Boolean
		{
			return passwordUpdate;
		}

		private function setPasswordUpdate(param1:Boolean) : void
		{
			passwordUpdate = param1;
		}

		public function setDescription(param1:String) : void
		{
			setDescriptionUpdate(true);
			this.description = param1;
		}

		public function getDescription() : String
		{
			return description;
		}

		private function setDescriptionUpdate(param1:Boolean) : void
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
			this.capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		private function setCapacityUpdate(param1:Boolean) : void
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
			this.roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		private function setRoomNameUpdate(param1:Boolean) : void
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class UpdateRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var lockChanged:Boolean;
		private var valueChanged:Boolean;

		public function UpdateRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.UpdateRoomVariableRequest);
			lockChanged = false;
			valueChanged = false;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function hasValueChanged() : Boolean
		{
			return valueChanged;
		}

		public function setValue(param1:EsObject) : void
		{
			valueChanged = true;
			this.value = param1;
		}

		public function hasLockStatusChanged() : Boolean
		{
			return lockChanged;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
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
			lockChanged = true;
			this.locked = param1;
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
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class UpdateUserVariableRequest extends RequestImpl
	{
		private var name:String;
		private var value:EsObject;

		public function UpdateUserVariableRequest()
		{
			super();
			setMessageType(MessageType.UpdateUserVariableRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getValue() == null)
			{
				_loc_2.push("getValue() must not return null.");
			}
			if(getName() == null)
			{
				_loc_2.push("getName() must not return null.");
			}
			_loc_1 = _loc_2.length == 0;
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function setValue(param1:EsObject) : void
		{
			this.value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}
	}
}
package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class ValidateAdditionalLoginRequest extends RequestImpl
	{
		private var secret:String;

		public function ValidateAdditionalLoginRequest()
		{
			super();
			setMessageType(MessageType.ValidateAdditionalLoginRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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
