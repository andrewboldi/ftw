package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class ResponseImpl extends MessageImpl
	{
		private var requestId:Number;

		public function ResponseImpl()
		{
			super();
		}

		public function setRequestId(param1:Number) : void
		{
			requestId = param1;
		}

		public function getRequestId() : Number
		{
			return requestId;
		}
	}
}
