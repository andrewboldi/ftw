package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class ClientIdleEventTransaction extends TransactionImpl
	{
		public function ClientIdleEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:ClientIdleEvent = ClientIdleEvent(param1);
			param2.dispatchEvent(_loc_3);
		}
	}
}
