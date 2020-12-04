package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class ServerGame extends Object
	{
		private var passwordProtected:Boolean;
		private var gameDetails:EsObject;
		private var locked:Boolean;
		private var gameId:Number;

		public function ServerGame()
		{
			super();
		}

		public function setPasswordProtected(param1:Boolean) : void
		{
			this.passwordProtected = param1;
		}

		public function getPasswordProtected() : Boolean
		{
			return passwordProtected;
		}

		public function setGameDetails(param1:EsObject) : void
		{
			this.gameDetails = param1;
		}

		public function getGameDetails() : EsObject
		{
			return gameDetails;
		}

		public function setLocked(param1:Boolean) : void
		{
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setGameId(param1:Number) : void
		{
			this.gameId = param1;
		}

		public function getGameId() : Number
		{
			return gameId;
		}
	}
}
