package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.message.*;

	public class LogoutRequest extends RequestImpl
	{
		private var dropAllConnections:Boolean;
		private var dropConnection:Boolean;

		public function LogoutRequest()
		{
			super();
			setMessageType(MessageType.LogoutRequest);
			setDropAllConnections(true);
			setDropConnection(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setDropAllConnections(param1:Boolean) : void
		{
			dropAllConnections = param1;
		}

		public function getDropAllConnections() : Boolean
		{
			return dropAllConnections;
		}

		public function setDropConnection(param1:Boolean) : void
		{
			dropConnection = param1;
		}

		public function getDropConnection() : Boolean
		{
			return dropConnection;
		}
	}
}
