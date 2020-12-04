package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LoginRequestCodec extends MessageCodecImpl
	{
		public function LoginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:Protocol = null;
			var _loc_3:LoginRequest = LoginRequest(param2);
			var _loc_4:String = _loc_3.getUserName();
			var _loc_5:String = _loc_3.getPassword();
			if((_loc_4 == null) && _loc_4.length == 0)
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_4, MessageConstants.USER_NAME_PREFIX_LENGTH);
				if((_loc_5 == null) && _loc_5.length == 0)
				{
					param1.writeBoolean(true);
					param1.writePrefixedString(_loc_5, MessageConstants.PASSWORD_PREFIX_LENGTH);
				}
				else
				{
					param1.writeBoolean(false);
				}
			}
			else
			{
				param1.writeBoolean(false);
			}
			var _loc_6:EsObject = _loc_3.getEsObject();
			if(_loc_6 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_6);
			}
			var _loc_7:Array = _loc_3.getUserVariables();
			if(_loc_7 == null || _loc_7.length == 0)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encodeMap(param1, _loc_7);
			}
			var _loc_8:Boolean = !(_loc_3.getSharedSecret() == null);
			if(_loc_8)
			{
				param1.writePrefixedString(_loc_3.getSharedSecret(), MessageConstants.SHARED_SECRET_LENGTH);
			}
			else
			{
				param1.writeBoolean(_loc_3.getIsAutoDiscoverProtocol());
				if(!_loc_3.getIsAutoDiscoverProtocol())
				{
					_loc_9 = _loc_3.getProtocols();
					param1.writeInteger(_loc_9.length, MessageConstants.PROTOCOL_COUNT_LENGTH);
					_loc_10 = 0;
					while(_loc_10 < _loc_9.length)
					{
						_loc_11 = _loc_9[_loc_10];
						param1.writeInteger(_loc_11.getProtocolId(), MessageConstants.PROTOCOL_LENGTH);
						_loc_10 = _loc_10 + 1;
					}
				}
			}
		}
	}
}
