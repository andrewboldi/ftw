package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class FindZoneAndRoomByNameRequest extends RequestImpl
	{
		private var zoneName:String;
		private var roomName:String;

		public function FindZoneAndRoomByNameRequest()
		{
			super();
			setMessageType(MessageType.FindZoneAndRoomByNameRequest);
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}

		public function setRoomName(param1:String) : void
		{
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}
	}
}
