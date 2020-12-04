package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindGamesRequestCodec extends MessageCodecImpl
	{
		public function FindGamesRequestCodec()
		{
			super();
		}

		public function getDefaultMessageSize() : Number
		{
			return 1024;
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:FindGamesRequest = FindGamesRequest(param2);
			var _loc_4:SearchCriteria = _loc_3.getSearchCriteria();
			SearchCriteriaCodec.encode(param1, _loc_4);
		}
	}
}
