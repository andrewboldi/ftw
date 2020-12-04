package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetZonesRequestCodec extends MessageCodecImpl
	{
		public function GetZonesRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetZonesRequest = GetZonesRequest(param2);
		}
	}
}
