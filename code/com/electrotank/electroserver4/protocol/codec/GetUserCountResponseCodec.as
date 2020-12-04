package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserCountResponseCodec extends MessageCodecImpl
	{
		public function GetUserCountResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:GetUserCountResponse = new GetUserCountResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			_loc_2.setCount(param1.nextInteger(MessageConstants.FULL_USER_COUNT_LENGTH));
			return _loc_2;
		}
	}
}
