package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateUserVariableRequestCodec extends MessageCodecImpl
	{
		public function UpdateUserVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:UpdateUserVariableRequest = UpdateUserVariableRequest(param2);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.USER_VARIABLE_NAME_PREFIX_LENGTH);
			EsObjectCodec.encode(param1, _loc_3.getValue());
		}
	}
}
