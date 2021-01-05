package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class DeleteRoomVariableRequestCodec extends MessageCodecImpl
	{
		public function DeleteRoomVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:DeleteRoomVariableRequest = DeleteRoomVariableRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
		}
	}
}
