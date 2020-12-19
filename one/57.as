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
package net.theyak.events
{
	public class EventDispatcher extends Object
	{
		private var listeners:Array;
		private var events:Object;

		public function EventDispatcher()
		{
			super();
			listeners = new Array();
			events = new Object();
		}

		public function dispatchEvent(param1:String, param2:Object) : void
		{
			var _loc_4:int = 0;
			var _loc_5:Object = null;
			var _loc_6:String = null;
			var _loc_3:Array = events[param1];
			if(_loc_3 != null)
			{
				_loc_4 = 0;
				while(_loc_4 < _loc_3.length)
				{
					_loc_5 = _loc_3[_loc_4].scope;
					_loc_6 = _loc_3[_loc_4].funcName;
					var _loc_7:Object = _loc_5;
					_loc_7[_loc_6](param2);
					_loc_4++;
				}
			}
		}

		public function addEventListener(param1:String, param2:String, param3:Object) : void
		{
			if(events[param1] == null)
			{
				events[param1] = new Array();
			}
			var _loc_4:Boolean = false;
			var _loc_5:int = 0;
			while(_loc_5 < events[param1].length)
			{
				if(events[param1][_loc_5].scope == param3 && events[param1][_loc_5].funcName == param2)
				{
					_loc_4 = true;
					break;
				}
				_loc_5++;
			}
			if(!_loc_4)
			{
				events[param1].push({scope:param3, funcName:param2});
			}
		}

		public function removeEventListener(param1:String, param2:String, param3:Object) : void
		{
			if(!events[param1])
			{
				return;
			}
			var _loc_4:int = 0;
			while(_loc_4 < events[param1].length)
			{
				if(events[param1][_loc_4].scope == param3 && events[param1][_loc_4].funcName == param2)
				{
					events[param1].splice(_loc_4, 1);
					break;
				}
				_loc_4++;
			}
			if(events[param1].length == 0)
			{
			}
		}
	}
}
