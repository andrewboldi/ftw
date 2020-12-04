package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class EvictUserFromRoomRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var userId:String;
		private var reason:String;
		private var ban:Boolean;
		private var duration:Number;

		public function EvictUserFromRoomRequest()
		{
			super();
			setMessageType(MessageType.EvictUserFromRoomRequest);
			ban = false;
		}

		public function isBan() : Boolean
		{
			return ban;
		}

		public function setBan(param1:Boolean) : void
		{
			ban = param1;
		}

		public function setDuration(param1:Number) : void
		{
			duration = param1;
		}

		public function getDuration() : Number
		{
			return duration;
		}

		public function setReason(param1:String) : void
		{
			reason = param1;
		}

		public function getReason() : String
		{
			return reason;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
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
