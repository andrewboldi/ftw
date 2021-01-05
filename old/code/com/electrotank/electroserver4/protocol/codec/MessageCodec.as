package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.protocol.*;

	public interface MessageCodec
	{
		function encode(param1:MessageWriter, param2:Message) : void;

		function decode(param1:MessageReader) : Message;
	}
}
