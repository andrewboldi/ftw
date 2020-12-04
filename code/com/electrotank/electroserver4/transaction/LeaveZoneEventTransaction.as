package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.zone.*;

	public class LeaveZoneEventTransaction extends TransactionImpl
	{
		public function LeaveZoneEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:LeaveZoneEvent = LeaveZoneEvent(param1);
			var _loc_4:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			param2.getZoneManager().removeZone(_loc_4.getZoneId());
			_loc_3.zone = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
