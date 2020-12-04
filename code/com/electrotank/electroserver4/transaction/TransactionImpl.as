package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;

	public class TransactionImpl extends Object implements Transaction
	{
		public function TransactionImpl()
		{
			super();
		}

		public function execute(param1:Message, param2:ElectroServer) : void
		{
			trace("Error: 'execute' method not overwritten in transaction for " + param1.getMessageType().getMessageTypeName());
		}
	}
}
