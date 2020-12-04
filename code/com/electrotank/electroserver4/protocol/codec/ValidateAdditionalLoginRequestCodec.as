package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ValidateAdditionalLoginRequestCodec extends MessageCodecImpl
	{
		public function ValidateAdditionalLoginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:ValidateAdditionalLoginRequest = ValidateAdditionalLoginRequest(param2);
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:ValidateAdditionalLoginRequest = new ValidateAdditionalLoginRequest();
			_loc_2.setSecret(param1.nextPrefixedString(MessageConstants.SHARED_SECRET_LENGTH));
			return _loc_2;
		}
	}
}
