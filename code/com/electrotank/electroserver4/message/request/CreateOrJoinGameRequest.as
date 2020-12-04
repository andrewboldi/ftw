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
