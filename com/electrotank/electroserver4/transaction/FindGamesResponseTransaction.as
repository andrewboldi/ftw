package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;

	public class FindGamesResponseTransaction extends TransactionImpl
	{
		public function FindGamesResponseTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:FindGamesResponse = FindGamesResponse(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
