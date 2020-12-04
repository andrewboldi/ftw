package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class ValidateAdditionalLoginRequest extends RequestImpl
	{
		private var secret:String;

		public function ValidateAdditionalLoginRequest()
		{
			super();
			setMessageType(MessageType.ValidateAdditionalLoginRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setSecret(param1:String) : void
		{
			secret = param1;
		}

		public function getSecret() : String
		{
			return secret;
		}
	}
}
