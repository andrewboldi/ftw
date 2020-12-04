package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class JoinZoneEventTransaction extends TransactionImpl
	{
		public function JoinZoneEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_6:Room = null;
			var _loc_3:JoinZoneEvent = JoinZoneEvent(param1);
			var _loc_4:Zone = new Zone();
			_loc_4.setZoneId(_loc_3.getZoneId());
			_loc_4.setZoneName(_loc_3.getZoneName());
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3.getRooms().length)
			{
				_loc_6 = _loc_3.getRooms()[_loc_5];
				_loc_4.addRoom(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			param2.getZoneManager().addZone(_loc_4);
			_loc_3.zone = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
