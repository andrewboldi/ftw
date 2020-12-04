package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class SearchCriteria extends Object
	{
		private var gameType:String;
		private var locked:Boolean;
		private var gameDetails:EsObject;
		private var gameId:Number;
		private var lockedSet:Boolean;

		public function SearchCriteria()
		{
			super();
			setGameId(-1);
			lockedSet = false;
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

		public function getLockedSet() : Boolean
		{
			return lockedSet;
		}

		public function setLocked(param1:Boolean) : void
		{
			lockedSet = true;
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return this.locked;
		}

		public function setGameType(param1:String) : void
		{
			this.gameType = param1;
		}

		public function getGameType() : String
		{
			return gameType;
		}
	}
}
