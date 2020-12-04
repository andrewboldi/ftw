package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RemoveBuddyRequestCodec extends MessageCodecImpl
	{
		public function RemoveBuddyRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:RemoveBuddyRequest = RemoveBuddyRequest(param2);
			param1.writePrefixedString(_loc_3.getBuddyName(), MessageConstants.USER_NAME_PREFIX_LENGTH);
		}
	}
}
