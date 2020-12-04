package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class RtmpOnStatusEvent extends EventImpl
	{
		private var info:Object;

		public function RtmpOnStatusEvent()
		{
			super();
			setMessageType(MessageType.RtmpOnStatusEvent);
		}

		public function getInfo() : Object
		{
			return info;
		}

		public function setInfo(param1:Object) : void
		{
			this.info = param1;
		}
	}
}
