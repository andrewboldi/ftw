package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class ClientIdleEvent extends EventImpl
	{
		public function ClientIdleEvent()
		{
			super();
			setMessageType(MessageType.ClientIdleEvent);
		}
	}
}
