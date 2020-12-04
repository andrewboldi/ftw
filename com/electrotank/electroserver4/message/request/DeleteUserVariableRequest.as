package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class DeleteUserVariableRequest extends RequestImpl
	{
		private var name:String;

		public function DeleteUserVariableRequest()
		{
			super();
			setMessageType(MessageType.DeleteUserVariableRequest);
		}

		public function setName(param1:String) : void
		{
			name = param1;
		}

		public function getName() : String
		{
			return name;
		}
	}
}
