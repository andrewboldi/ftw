package com.electrotank.electroserver4
{
	public class MessageConstants extends Object
	{
		public static var MESSAGE_HEADER_SIZE:Number = 1;
		public static var MESSAGE_ID_SIZE:Number = 4;
		public static var GATEWAY_ID_LENGTH:Number = 13;
		public static var GATEWAY_STATE_LENGTH:Number = 2;
		public static var USER_ID_LENGTH:Number = 13;
		public static var USER_NAME_PREFIX_LENGTH:Number = 2;
		public static var USER_COUNT_LENGTH:Number = 4;
		public static var FULL_USER_COUNT_LENGTH:Number = 6;
		public static var USER_VARIABLE_COUNT_LENGTH:Number = 2;
		public static var USER_VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var USER_VARIABLE_VALUE_PREFIX_LENGTH:Number = 4;
		public static var PASSWORD_PREFIX_LENGTH:Number = 2;
		public static var VIDEO_STREAM_NAME_PREFIX_LENGTH:Number = 2;
		public static var VARIABLE_COUNT_LENGTH:Number = 2;
		public static var VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var VARIABLE_VALUE_PREFIX_LENGTH:Number = 5;
		public static var ZONE_COUNT_LENGTH:Number = 5;
		public static var ZONE_ID_LENGTH:Number = 5;
		public static var ZONE_NAME_PREFIX_LENGTH:Number = 3;
		public static var UPDATE_ACTION_LENGTH:Number = 1;
		public static var ROOM_ID_LENGTH:Number = 5;
		public static var ROOM_NAME_PREFIX_LENGTH:Number = 3;
		public static var ROOM_COUNT_LENGTH:Number = 5;
		public static var ROOM_CAPACITY_LENGTH:Number = 3;
		public static var ROOM_PASSWORD_PREFIX_LENGTH:Number = 2;
		public static var ROOM_DESCRIPTION_PREFIX_LENGTH:Number = 3;
		public static var ROOM_EVICTION_REASON_PREFIX_LENGTH:Number = 3;
		public static var ROOM_BAN_DURATION_LENGTH:Number = 6;
		public static var ROOM_VARIABLE_COUNT_LENGTH:Number = 2;
		public static var ROOM_VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var FILTER_NAME_PREFIX_LENGTH:Number = 2;
		public static var FILTER_FAILURES_BEFORE_KICK_LENGTH:Number = 2;
		public static var FILTER_KICKS_BEFORE_BAN_LENGTH:Number = 2;
		public static var FLOODING_FILTER_MAX_DUP_MESSAGES_LENGTH:Number = 2;
		public static var FLOODING_FILTER_WINDOW_DURATION_LENGTH:Number = 3;
		public static var FLOODING_FILTER_MAX_MESSAGE_IN_WINDOW_LENGTH:Number = 2;
		public static var PUBLIC_MESSAGE_PREFIX_LENGTH:Number = 4;
		public static var PRIVATE_MESSAGE_PREFIX_LENGTH:Number = 4;
		public static var MESSAGE_NUMBER_LENGTH:Number = 4;
		public static var REQUEST_ID_LENGTH:Number = 4;
		public static var ERROR_ID_LENGTH:Number = 3;
		public static var DEFAULT_LONG_LENGTH:Number = 64;
		public static var DEFAULT_DOUBLE_LENGTH:Number = 64;
		public static var PASSPHRASE_PREFIX_LENGTH:Number = 4;
		public static var ZONE_AND_ROOM_ID_LIST_LENGTH:Number = 2;
		public static var SHARED_SECRET_LENGTH:Number = 2;
		public static var PLUGIN_COUNT_LENGTH:Number = 2;
		public static var EXTENSION_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_HANDLE_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_PARM_COUNT_LENGTH:Number = 2;
		public static var PLUGIN_PARM_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_PARM_VALUE_PREFIX_LENGTH:Number = 4;
		public static var PROTOCOL_COUNT_LENGTH:Number = 3;
		public static var PROTOCOL_HOST_PREFIX_LENGTH:Number = 2;
		public static var PROTOCOL_PORT_LENGTH:Number = 5;
		public static var PROTOCOL_LENGTH:Number = 2;
		public static var CUSTOM_POLICY_FILE_CONTENTS_PREFIX_LENGTH:Number = 4;
		public static var COMPOSITE_ESOBJECT_ARRAY_PREFIX_LENGTH:Number = 2;
		public static var HASH_ID_LENGTH:Number = 11;

		public function MessageConstants()
		{
			super();
		}
	}
}
