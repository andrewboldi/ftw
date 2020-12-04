package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserVariableUpdateEventCodec extends MessageCodecImpl
	{
		public function UserVariableUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_5:EsObject = null;
			var _loc_2:UserVariableUpdateEvent = new UserVariableUpdateEvent();
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			var _loc_3:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_3);
			var _loc_4:String = param1.nextPrefixedString(MessageConstants.USER_VARIABLE_NAME_PREFIX_LENGTH);
			_loc_2.setVariableName(_loc_4);
			if(_loc_2.getActionId() != UserVariableUpdateEvent.VariableDeleted)
			{
				_loc_5 = EsObjectCodec.decode(param1);
				_loc_2.setVariable(new UserVariable(_loc_4, _loc_5));
			}
			return _loc_2;
		}
	}
}
