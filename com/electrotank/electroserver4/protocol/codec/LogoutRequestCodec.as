package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LogoutRequestCodec extends MessageCodecImpl
	{
		public function LogoutRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:LogoutRequest = LogoutRequest(param2);
			param1.writeBoolean(_loc_3.getDropAllConnections());
			if(!_loc_3.getDropAllConnections())
			{
				param1.writeBoolean(_loc_3.getDropConnection());
			}
		}
	}
}
