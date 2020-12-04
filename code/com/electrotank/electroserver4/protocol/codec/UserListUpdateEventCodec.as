package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserListUpdateEventCodec extends MessageCodecImpl
	{
		public function UserListUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:String = null;
			var _loc_8:int = NaN;
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:String = null;
			var _loc_12:EsObject = null;
			var _loc_2:UserListUpdateEvent = new UserListUpdateEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_4);
			var _loc_5:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_5);
			var _loc_6:String = param1.nextLong(MessageConstants.USER_ID_LENGTH);
			_loc_2.setUserId(_loc_6);
			if(_loc_5 == UserListUpdateEvent.AddUser)
			{
				_loc_7 = param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_2.setUserName(_loc_7);
				_loc_8 = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
				_loc_9 = new Array();
				_loc_10 = 0;
				while(_loc_10 < _loc_8)
				{
					_loc_11 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
					_loc_12 = EsObjectCodec.decode(param1);
					_loc_9.push(new UserVariable(_loc_11, _loc_12));
					_loc_10 = _loc_10 + 1;
				}
				_loc_2.setUserVariables(_loc_9);
				_loc_2.setIsSendingVideo(param1.nextBoolean());
				if(_loc_2.getIsSendingVideo())
				{
					_loc_2.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
			}
			else
			{
				if(_loc_5 == UserListUpdateEvent.SendingVideoStream)
				{
					_loc_2.setIsSendingVideo(true);
					_loc_2.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
				else
				{
					if(_loc_5 == UserListUpdateEvent.StoppingVideoStream)
					{
						_loc_2.setIsSendingVideo(false);
						_loc_2.setVideoStreamName("");
					}
				}
			}
			return _loc_2;
		}
	}
}
