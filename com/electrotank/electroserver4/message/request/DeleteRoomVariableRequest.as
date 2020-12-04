package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class DeleteRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;

		public function DeleteRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.DeleteRoomVariableRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
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
