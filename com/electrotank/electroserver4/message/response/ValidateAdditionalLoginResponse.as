package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.message.*;

	public class ValidateAdditionalLoginResponse extends ResponseImpl
	{
		private var approved:Boolean;
		private var secret:String;

		public function ValidateAdditionalLoginResponse()
		{
			super();
			setMessageType(MessageType.ValidateAdditionalLoginResponse);
		}

		public function getApproved() : Boolean
		{
			return approved;
		}

		public function setApproved(param1:Boolean) : void
		{
			approved = param1;
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
