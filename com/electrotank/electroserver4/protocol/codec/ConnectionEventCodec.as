package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ConnectionEventCodec extends MessageCodecImpl
	{
		public function ConnectionEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:int = NaN;
			var _loc_2:ConnectionEvent = new ConnectionEvent();
			var _loc_3:Boolean = param1.nextBoolean();
			_loc_2.setAccepted(_loc_3);
			if(_loc_2.getAccepted())
			{
				_loc_2.setHashId(param1.nextInteger(MessageConstants.HASH_ID_LENGTH));
				_loc_2.setPrime(param1.nextString());
				_loc_2.setBase(param1.nextString());
			}
			else
			{
				_loc_4 = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
				_loc_2.setEsError(Errors.getErrorById(_loc_4));
			}
			return _loc_2;
		}
	}
}
