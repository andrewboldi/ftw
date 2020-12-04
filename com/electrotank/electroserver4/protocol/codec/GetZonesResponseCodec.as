package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.zone.*;

	public class GetZonesResponseCodec extends MessageCodecImpl
	{
		public function GetZonesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Zone = null;
			var _loc_2:GetZonesResponse = new GetZonesResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Number = param1.nextInteger(MessageConstants.ZONE_COUNT_LENGTH);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = new Zone();
				_loc_6.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_6.setZoneName(param1.nextPrefixedString(MessageConstants.ZONE_NAME_PREFIX_LENGTH));
				_loc_2.addZone(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
