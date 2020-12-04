package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;
	import com.electrotank.electroserver4.zone.*;

	public class ZoneUpdateEventTransaction extends TransactionImpl
	{
		public function ZoneUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_5:String = null;
			var _loc_6:Room = null;
			var _loc_3:ZoneUpdateEvent = ZoneUpdateEvent(param1);
			var _loc_4:Number = _loc_3.getActionId();
			if(_loc_4 == ZoneUpdateEvent.AddRoom)
			{
				_loc_6 = _loc_3.getRoom();
				_loc_6.setZone(param2.getZoneManager().getZoneById(_loc_3.getZoneId()));
				param2.getZoneManager().getZoneById(_loc_3.getZoneId()).addRoom(_loc_6);
				_loc_5 = "roomcreated";
			}
			else
			{
				if(_loc_4 == ZoneUpdateEvent.DeleteRoom)
				{
					_loc_6 = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
					param2.getZoneManager().getZoneById(_loc_3.getZoneId()).removeRoom(_loc_3.getRoomId());
					_loc_5 = "roomdeleted";
				}
				else
				{
					if(_loc_4 == ZoneUpdateEvent.UpdateRoom)
					{
						_loc_6 = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
						param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId()).setUserCount(_loc_3.getRoomCount());
						_loc_5 = "roomupdated";
					}
				}
			}
			var _loc_7:Zone = param2.getZoneManager().getZoneById(_loc_3.getZoneId());
			_loc_3.room = _loc_6;
			_loc_3.zone = _loc_7;
			_loc_3.minorType = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
