package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateOrJoinGameRequestCodec extends MessageCodecImpl
	{
		public function CreateOrJoinGameRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:CreateOrJoinGameRequest = CreateOrJoinGameRequest(param2);
			param1.writeString(_loc_3.getGameType());
			param1.writeString(_loc_3.getZoneName());
			if(_loc_3.getPassword() == null || _loc_3.getPassword().length == 0)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				param1.writeString(_loc_3.getPassword());
			}
			var _loc_4:EsObject = _loc_3.getGameDetails();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
			param1.writeBoolean(_loc_3.getIsLocked());
			param1.writeBoolean(_loc_3.getIsHidden());
			SearchCriteriaCodec.encode(param1, _loc_3.getSearchCriteria());
		}
	}
}
