package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUsersInRoomRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;

		public function GetUsersInRoomRequest()
		{
			super();
			setMessageType(MessageType.GetUsersInRoomRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
