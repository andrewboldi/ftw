package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LoginResponseCodec extends MessageCodecImpl
	{
		public function LoginResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_10:int = NaN;
			var _loc_11:String = null;
			var _loc_12:EsObject = null;
			var _loc_15:int = NaN;
			var _loc_16:EsObject = null;
			var _loc_17:UserVariable = null;
			var _loc_2:LoginResponse = new LoginResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Boolean = param1.nextBoolean();
			_loc_2.setAccepted(_loc_4);
			if(!_loc_2.getAccepted())
			{
				_loc_15 = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
				_loc_2.setEsError(Errors.getErrorById(_loc_15));
			}
			var _loc_5:Boolean = param1.nextBoolean();
			if(_loc_5)
			{
				_loc_16 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_16);
			}
			var _loc_6:Boolean = param1.nextBoolean();
			if(_loc_6)
			{
				_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			}
			var _loc_7:Boolean = param1.nextBoolean();
			if(_loc_7)
			{
				_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			}
			var _loc_8:Number = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
			var _loc_9:Array = new Array();
			_loc_10 = 0;
			while(_loc_10 < _loc_8)
			{
				_loc_11 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
				_loc_12 = EsObjectCodec.decode(param1);
				_loc_17 = new UserVariable(_loc_11, _loc_12);
				_loc_9.push(_loc_17);
				_loc_10 = _loc_10 + 1;
			}
			_loc_2.setUserVariables(_loc_9);
			var _loc_13:Number = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
			var _loc_14:Object = new Object();
			_loc_10 = 0;
			while(_loc_10 < _loc_13)
			{
				_loc_11 = param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_12 = EsObjectCodec.decode(param1);
				_loc_14[_loc_11] = _loc_12;
				_loc_10 = _loc_10 + 1;
			}
			_loc_2.setBuddies(_loc_14);
			return _loc_2;
		}
	}
}
