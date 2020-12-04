package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;

	public class RoomVariableUpdateEventTransaction extends TransactionImpl
	{
		public function RoomVariableUpdateEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_5:RoomVariable = null;
			var _loc_6:String = null;
			var _loc_3:RoomVariableUpdateEvent = RoomVariableUpdateEvent(param1);
			var _loc_4:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			var _loc_7:Number = _loc_3.getUpdateAction();
			if(_loc_7 == RoomVariableUpdateEvent.VariableCreated)
			{
				_loc_6 = "created";
			}
			else
			{
				if(_loc_7 == RoomVariableUpdateEvent.VariableUpdated)
				{
					_loc_6 = "updated";
				}
				else
				{
					if(_loc_7 == RoomVariableUpdateEvent.VariableDeleted)
					{
						_loc_6 = "deleted";
					}
				}
			}
			if(_loc_7 == RoomVariableUpdateEvent.VariableCreated)
			{
				_loc_5 = new RoomVariable(_loc_3.getName(), _loc_3.getValue(), _loc_3.getPersistent(), _loc_3.getLocked());
				_loc_4.addRoomVariable(_loc_5);
			}
			_loc_5 = _loc_4.getRoomVariable(_loc_3.getName());
			if(_loc_3.getValueChanged())
			{
				_loc_5.setValue(_loc_3.getValue());
			}
			if(_loc_3.getLockChanged())
			{
				_loc_5.setLocked(_loc_3.getLocked());
			}
			if(_loc_7 == RoomVariableUpdateEvent.VariableDeleted)
			{
				_loc_4.removeRoomVariable(_loc_3.getName());
			}
			_loc_3.room = _loc_4;
			_loc_3.minorType = _loc_6;
			_loc_3.variable = _loc_5;
			param2.dispatchEvent(_loc_3);
		}
	}
}
