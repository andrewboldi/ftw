package Misc
{
	import flash.events.*;

	public class EventManager extends Object
	{
		private static var listeners:Array = new Array();

		final public static function exists(param1:EventDispatcher, param2:String, param3:Function) : Boolean
		{
			var _loc_4:int = listeners.length - 1;
			while(_loc_4 >= 0)
			{
				if(param1 == listeners[_loc_4].object && param2 == listeners[_loc_4].type && param3 == listeners[_loc_4].listener)
				{
					return true;
				}
				_loc_4 = _loc_4 - 1;
			}
			return false;
		}

		final public static function add(param1:EventDispatcher, param2:String, param3:Function, param4:String = null) : void
		{
			var _loc_5:Object = null;
			if(!(EventManager.exists(param1, param2, param3)))
			{
				param1.addEventListener(param2, param3);
				_loc_5 = new Object();
				_loc_5.object = param1;
				_loc_5.type = param2;
				_loc_5.listener = param3;
				_loc_5.description = param4;
				_loc_5.time = (new Date()).toString();
				EventManager.listeners.push(_loc_5);
			}
		}

		final public static function remove(param1:EventDispatcher = null, param2:String = null, param3:Function = null) : void
		{
			var _loc_4:int = listeners.length - 1;
			while(_loc_4 >= 0)
			{
				if(param1 == listeners[_loc_4].object)
				{
					if(param2 == null || param2 == EventManager.String(listeners[_loc_4].type))
					{
						if(param3 == null || listeners[_loc_4].listener == param3)
						{
							EventManager.EventDispatcher(listeners[_loc_4].object).removeEventListener(EventManager.String(listeners[_loc_4].type), listeners[_loc_4].listener);
							listeners.splice(_loc_4, 1);
						}
					}
				}
				_loc_4 = _loc_4 - 1;
			}
		}

		final public static function toString(param1:String = null) : String
		{
			var _loc_2:String = "";
			var _loc_3:int = listeners.length - 1;
			while(_loc_3 >= 0)
			{
				if(param1 == null || (EventManager.String(listeners[_loc_3].category).substr(0, param1.length)) == param1)
				{
					_loc_2 = _loc_2 + (_loc_3 + ": ");
					_loc_2 = _loc_2 + (listeners[_loc_3].time + "\t");
					_loc_2 = _loc_2 + (listeners[_loc_3].object + "\t\t");
					_loc_2 = _loc_2 + listeners[_loc_3].type;
					if(listeners[_loc_3].description != null)
					{
						_loc_2 = _loc_2 + "\t\t" + listeners[_loc_3].description;
					}
					_loc_2 = _loc_2 + "\n";
				}
				_loc_3 = _loc_3 - 1;
			}
			return _loc_2;
		}

		public function EventManager()
		{
			super();
		}
	}
}
