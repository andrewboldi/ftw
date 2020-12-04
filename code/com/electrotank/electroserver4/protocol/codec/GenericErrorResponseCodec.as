package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GenericErrorResponseCodec extends MessageCodecImpl
	{
		public function GenericErrorResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_9:EsObject = null;
			var _loc_2:GenericErrorResponse = new GenericErrorResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:String = param1.nextCharacter();
			var _loc_5:Number = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
			var _loc_6:MessageType = MessageType.findTypeById(_loc_4);
			var _loc_7:EsError = Errors.getErrorById(_loc_5);
			_loc_2.setRequestMessageType(_loc_6);
			_loc_2.setErrorType(_loc_7);
			var _loc_8:Boolean = param1.nextBoolean();
			if(_loc_8)
			{
				_loc_9 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_9);
			}
			return _loc_2;
		}
	}
}
