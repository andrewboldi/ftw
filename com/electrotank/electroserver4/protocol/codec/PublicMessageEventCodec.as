package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PublicMessageEventCodec extends MessageCodecImpl
	{
		public function PublicMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:EsObject = null;
			var _loc_2:PublicMessageEvent = new PublicMessageEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setUserNameIncluded(param1.nextBoolean());
			if(_loc_2.isUserNameIncluded())
			{
				_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			}
			_loc_2.setMessage(param1.nextPrefixedString(MessageConstants.PUBLIC_MESSAGE_PREFIX_LENGTH));
			var _loc_3:Boolean = param1.nextBoolean();
			if(_loc_3)
			{
				_loc_4 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_4);
			}
			return _loc_2;
		}
	}
}
