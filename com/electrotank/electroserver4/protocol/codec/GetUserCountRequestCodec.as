package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserCountRequestCodec extends MessageCodecImpl
	{
		public function GetUserCountRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetUserCountRequest = GetUserCountRequest(param2);
		}
	}
}
