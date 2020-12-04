package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GateWayKickUserRequestCodec extends MessageCodecImpl
	{
		public function GateWayKickUserRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GateWayKickUserRequest = GateWayKickUserRequest(param2);
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:GateWayKickUserRequest = new GateWayKickUserRequest();
			return _loc_2;
		}
	}
}
