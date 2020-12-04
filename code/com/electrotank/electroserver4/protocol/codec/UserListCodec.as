package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.user.*;

	public class UserListCodec extends Object
	{
		final public static function decode(param1:MessageReader) : Array
		{
			var _loc_5:User = null;
			var _loc_6:String = null;
			var _loc_7:int = NaN;
			var _loc_8:int = NaN;
			var _loc_9:String = null;
			var _loc_10:EsObject = null;
			var _loc_2:Array = new Array();
			var _loc_3:Number = param1.nextInteger(MessageConstants.USER_COUNT_LENGTH);
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = new User();
				_loc_6 = param1.nextLong(MessageConstants.USER_ID_LENGTH);
				_loc_5.setUserId(_loc_6);
				_loc_5.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
				_loc_7 = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
				_loc_8 = 0;
				while(_loc_8 < _loc_7)
				{
					_loc_9 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
					_loc_10 = EsObjectCodec.decode(param1);
					_loc_5.addUserVariable(new UserVariable(_loc_9, _loc_10));
					_loc_8 = _loc_8 + 1;
				}
				_loc_5.setIsSendingVideo(param1.nextBoolean());
				if(_loc_5.getIsSendingVideo())
				{
					_loc_5.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
				_loc_2.push(_loc_5);
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		public function UserListCodec()
		{
			super();
		}
	}
}
