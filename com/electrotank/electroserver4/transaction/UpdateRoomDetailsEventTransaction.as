package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.room.*;

	public class UpdateRoomDetailsEventTransaction extends TransactionImpl
	{
		public function UpdateRoomDetailsEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_3:UpdateRoomDetailsEvent = UpdateRoomDetailsEvent(param1);
			var _loc_4:Room = param2.getZoneManager().getZoneById(_loc_3.getZoneId()).getRoomById(_loc_3.getRoomId());
			if(_loc_3.isHiddenUpdate())
			{
				_loc_4.setIsHidden(_loc_3.getHidden());
			}
			if(_loc_3.isDescriptionUpdate())
			{
				_loc_4.setDescription(_loc_3.getDescription());
			}
			if(_loc_3.isCapacityUpdate())
			{
				_loc_4.setCapacity(_loc_3.getCapacity());
			}
			if(_loc_3.isRoomNameUpdate())
			{
				_loc_4.setRoomName(_loc_3.getRoomName());
			}
			if(_loc_3.isPasswordUpdate())
			{
			}
			_loc_3.room = _loc_4;
			param2.dispatchEvent(_loc_3);
		}
	}
}
