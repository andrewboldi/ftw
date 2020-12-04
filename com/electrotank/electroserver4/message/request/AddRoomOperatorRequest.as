package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class AddRoomOperatorRequest extends RequestImpl
	{
		private var userId:String;
		private var zoneId:Number;
		private var roomId:Number;

		public function AddRoomOperatorRequest()
		{
			super();
			setMessageType(MessageType.AddRoomOperatorRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setUserId(param1:String) : void
		{
			this.userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
