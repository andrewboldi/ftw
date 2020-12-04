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
