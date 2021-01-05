package net.theyak.events
{
	import flash.events.*;

	public class DialogEvent extends Event
	{
		public var action:String = "";

		public function DialogEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
		{
			super("DialogEvent", param2, param3);
			this.action = param1;
		}
	}
}
