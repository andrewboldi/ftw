package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class DeleteUserVariableRequestCodec extends MessageCodecImpl
	{
		public function DeleteUserVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:DeleteUserVariableRequest = DeleteUserVariableRequest(param2);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
		}
	}
}
