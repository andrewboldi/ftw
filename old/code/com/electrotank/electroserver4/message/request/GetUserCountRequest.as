package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserCountRequest extends RequestImpl
	{
		public function GetUserCountRequest()
		{
			super();
			setMessageType(MessageType.GetUserCountRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
