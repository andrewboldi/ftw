package net.theyak.events
{
	import flash.events.*;

	public class AlertEvent extends Event
	{
		public var button:String = "";

		public function AlertEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
		{
			super("AlertEvent", param2, param3);
			this.button = param1;
		}
	}
}
