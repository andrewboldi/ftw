package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class GetUserCountResponse extends ResponseImpl
	{
		private var count:Number;

		public function GetUserCountResponse()
		{
			super();
			setMessageType(MessageType.GetUserCountResponse);
		}

		public function setCount(param1:Number) : void
		{
			count = param1;
		}

		public function getCount() : Number
		{
			return count;
		}
	}
}
