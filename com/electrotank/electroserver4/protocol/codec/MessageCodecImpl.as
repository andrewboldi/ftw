package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.protocol.*;

	public class MessageCodecImpl extends Object implements MessageCodec
	{
		public function MessageCodecImpl()
		{
			super();
		}

		public function encode(param1:MessageWriter, param2:Message) : void
		{
			trace("Error: 'encode' method not over-written in a codec for " + param2.getMessageType().getMessageTypeName());
		}

		public function decode(param1:MessageReader) : Message
		{
			var _loc_2:Message = null;
			trace("Error: 'decode' method not over-written in a codec for this message");
			return _loc_2;
		}
	}
}
