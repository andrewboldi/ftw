package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserVariablesResponseCodec extends MessageCodecImpl
	{
		public function GetUserVariablesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:String = null;
			var _loc_7:EsObject = null;
			var _loc_2:GetUserVariablesResponse = new GetUserVariablesResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			_loc_2.setUserName(param1.nextString());
			var _loc_4:Number = param1.nextInteger();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = param1.nextString();
				_loc_7 = EsObjectCodec.decode(param1);
				_loc_2.addVariable(_loc_6, _loc_7);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
