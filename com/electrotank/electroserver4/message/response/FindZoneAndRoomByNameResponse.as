package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class FindZoneAndRoomByNameResponse extends ResponseImpl
	{
		private var roomAndZoneList:Array;

		public function FindZoneAndRoomByNameResponse()
		{
			super();
			setMessageType(MessageType.FindZoneAndRoomByNameResponse);
		}

		public function setRoomAndZoneList(param1:Array) : void
		{
			roomAndZoneList = param1;
		}

		public function getRoomAndZoneList() : Array
		{
			return roomAndZoneList;
		}
	}
}
