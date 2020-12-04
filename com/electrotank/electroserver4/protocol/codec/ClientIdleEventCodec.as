package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ClientIdleEventCodec extends MessageCodecImpl
	{
		public function ClientIdleEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:ClientIdleEvent = new ClientIdleEvent();
			return _loc_2;
		}
	}
}
