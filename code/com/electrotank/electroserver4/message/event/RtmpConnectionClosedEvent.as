package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpConnectionClosedEvent extends EventImpl
	{
		private var accepted:Boolean;

		public function RtmpConnectionClosedEvent()
		{
			super();
			setMessageType(MessageType.RtmpConnectionClosedEvent);
		}
	}
}
