package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class AddBuddyRequestCodec extends MessageCodecImpl
	{
		public function AddBuddyRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:AddBuddyRequest = AddBuddyRequest(param2);
			param1.writePrefixedString(_loc_3.getBuddyName(), MessageConstants.USER_NAME_PREFIX_LENGTH);
			var _loc_4:EsObject = _loc_3.getEsObject();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
		}
	}
}
