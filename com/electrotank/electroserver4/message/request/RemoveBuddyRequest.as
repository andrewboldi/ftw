package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class RemoveBuddyRequest extends RequestImpl
	{
		private var buddyName:String;

		public function RemoveBuddyRequest()
		{
			super();
			setMessageType(MessageType.RemoveBuddyRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setBuddyName(param1:String) : void
		{
			buddyName = param1;
		}

		public function getBuddyName() : String
		{
			return buddyName;
		}
	}
}
