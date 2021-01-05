package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class BuddyStatusUpdatedEventCodec extends MessageCodecImpl
	{
		public function BuddyStatusUpdatedEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:EsObject = null;
			var _loc_2:BuddyStatusUpdatedEvent = new BuddyStatusUpdatedEvent();
			var _loc_3:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_3);
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			_loc_2.setHasEsObject(param1.nextBoolean());
			if(_loc_2.getHasEsObject())
			{
				_loc_4 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_4);
			}
			return _loc_2;
		}
	}
}
