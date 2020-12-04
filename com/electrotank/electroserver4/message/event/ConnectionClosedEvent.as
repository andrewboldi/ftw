package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.connection.*;
	import com.electrotank.electroserver4.message.*;

	public class ConnectionClosedEvent extends EventImpl
	{
		private var connection:AbstractConnection;

		public function ConnectionClosedEvent()
		{
			super();
			setMessageType(MessageType.ConnectionClosedEvent);
		}

		public function setConnection(param1:AbstractConnection) : void
		{
			connection = param1;
		}

		public function getConnection() : AbstractConnection
		{
			return connection;
		}
	}
}
