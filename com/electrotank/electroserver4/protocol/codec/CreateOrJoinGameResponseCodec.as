package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateOrJoinGameResponseCodec extends MessageCodecImpl
	{
		public function CreateOrJoinGameResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_3:CreateOrJoinGameResponse = new CreateOrJoinGameResponse();
			_loc_3.setSuccessful(param1.nextBoolean());
			if(_loc_3.getSuccessful())
			{
				_loc_3.setGameId(param1.nextInteger());
				_loc_3.setZoneId(param1.nextInteger());
				_loc_3.setRoomId(param1.nextInteger());
				_loc_3.setGameDetails(EsObjectCodec.decode(param1));
			}
			else
			{
				_loc_3.setEsError(Errors.getErrorById(param1.nextInteger()));
			}
			return _loc_3;
		}
	}
}
