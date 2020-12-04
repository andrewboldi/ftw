package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PrivateMessageRequestCodec extends MessageCodecImpl
	{
		public function PrivateMessageRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_5:int = NaN;
			var _loc_8:String = null;
			var _loc_3:PrivateMessageRequest = PrivateMessageRequest(param2);
			var _loc_4:Array = _loc_3.getUsers();
			param1.writeInteger(_loc_4.length, MessageConstants.USER_COUNT_LENGTH);
			_loc_5 = 0;
			while(_loc_5 < _loc_4.length)
			{
				param1.writeLong(_loc_4[_loc_5].getUserId(), MessageConstants.USER_ID_LENGTH);
				_loc_5 = _loc_5 + 1;
			}
			var _loc_6:Array = _loc_3.getUserNames();
			param1.writeInteger(_loc_6.length, MessageConstants.USER_COUNT_LENGTH);
			_loc_5 = 0;
			while(_loc_5 < _loc_6.length)
			{
				_loc_8 = _loc_6[_loc_5];
				param1.writePrefixedString(_loc_8, MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_5 = _loc_5 + 1;
			}
			param1.writePrefixedString(_loc_3.getMessage(), MessageConstants.PRIVATE_MESSAGE_PREFIX_LENGTH);
			var _loc_7:EsObject = _loc_3.getEsObject();
			if(_loc_7 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_7);
			}
		}
	}
}
