package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;

	public interface Transaction
	{
		function execute(param1:Message, param2:ElectroServer) : void;
	}
}
