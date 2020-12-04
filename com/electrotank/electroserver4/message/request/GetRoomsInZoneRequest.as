package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetRoomsInZoneRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var zoneName:String;

		public function GetRoomsInZoneRequest()
		{
			super();
			setMessageType(MessageType.GetRoomsInZoneRequest);
			setZoneId(-1);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setZoneName(param1:String) : void
		{
			this.zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
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
