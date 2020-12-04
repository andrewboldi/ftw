package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpConnectionEvent extends EventImpl
	{
		private var accepted:Boolean;

		public function RtmpConnectionEvent()
		{
			super();
			setMessageType(MessageType.RtmpConnectionEvent);
		}

		public function setAccepted(param1:Boolean) : void
		{
			this.accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}
	}
}
