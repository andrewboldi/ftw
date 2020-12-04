package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ValidateAdditionalLoginResponseCodec extends MessageCodecImpl
	{
		public function ValidateAdditionalLoginResponseCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:ValidateAdditionalLoginResponse = ValidateAdditionalLoginResponse(param2);
			param1.writeBoolean(_loc_3.getApproved());
			param1.writePrefixedString(_loc_3.getSecret(), MessageConstants.SHARED_SECRET_LENGTH);
		}
	}
}
