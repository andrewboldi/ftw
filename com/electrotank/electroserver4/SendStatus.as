package com.electrotank.electroserver4
{
	import com.electrotank.electroserver4.message.*;

	public class SendStatus extends Object
	{
		public static var NOT_CONNECTED:String = "not_connected";
		public static var VALIDATION_FAILED:String = "validation_failed";
		private var isSent:Boolean;
		private var reason:String;
		private var validationResponse:ValidationResponse;

		public function SendStatus()
		{
			super();
		}

		public function setValidationResponse(param1:ValidationResponse) : void
		{
			this.validationResponse = param1;
		}

		public function getValidationResponse() : ValidationResponse
		{
			return this.validationResponse;
		}

		public function setIsSent(param1:Boolean) : void
		{
			this.isSent = param1;
		}

		public function getIsSent() : Boolean
		{
			return isSent;
		}

		public function setReason(param1:String) : void
		{
			this.reason = param1;
		}

		public function getReason() : String
		{
			return reason;
		}
	}
}
