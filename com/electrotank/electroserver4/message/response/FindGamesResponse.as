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
