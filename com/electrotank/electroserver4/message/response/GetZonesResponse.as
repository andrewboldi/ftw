package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.zone.*;

	public class GetZonesResponse extends ResponseImpl
	{
		private var zones:Array;

		public function GetZonesResponse()
		{
			super();
			setMessageType(MessageType.GetZonesResponse);
			zones = new Array();
		}

		public function addZone(param1:Zone) : void
		{
			getZones().push(param1);
		}

		public function getZones() : Array
		{
			return zones;
		}
	}
}
