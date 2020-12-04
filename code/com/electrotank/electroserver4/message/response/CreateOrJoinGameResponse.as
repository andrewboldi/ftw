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
