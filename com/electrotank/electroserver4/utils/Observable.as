package com.electrotank.electroserver4.utils
{
	import com.electrotank.electroserver4.message.*;

	public class Observable extends Object
	{
		private var listeners:Array;
		private var events:Object;

		public function Observable()
		{
			super();
			listeners = new Array();
			events = new Object();
		}

		public function notifyListeners(param1:String, param2:Object) : void
		{
			var _loc_5:Object = null;
			var _loc_3:Array = listeners.slice(0);
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_3.length)
			{
				_loc_5 = _loc_3[_loc_4];
				var _loc_6:Object = _loc_5;
				_loc_6[param1](param2);
				_loc_4 = _loc_4 + 1;
			}
		}

		public function removeListener(param1:Object) : void
		{
			var _loc_3:Object = null;
			var _loc_2:Number = 0;
			while(_loc_2 < listeners.length)
			{
				_loc_3 = listeners[_loc_2];
				if(_loc_3 == param1)
				{
					listeners.splice(_loc_2, 1);
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function dispatchEvent(param1:MessageImpl) : void
		{
			var _loc_4:int = NaN;
			var _loc_5:Object = null;
			var _loc_6:String = null;
			param1.target = this;
			var _loc_2:String = param1.type;
			var _loc_3:Array = events[_loc_2];
			if(_loc_3 != null)
			{
				_loc_4 = 0;
				while(_loc_4 < _loc_3.length)
				{
					_loc_5 = _loc_3[_loc_4].scope;
					_loc_6 = _loc_3[_loc_4].funcName;
					var _loc_7:Object = _loc_5;
					_loc_7[_loc_6](param1);
					_loc_4 = _loc_4 + 1;
				}
			}
		}

		public function addEventListener(param1:MessageType, param2:String, param3:Object, param4:Boolean = false) : void
		{
			var _loc_5:String = param1.getMessageTypeName();
			if(events[_loc_5] == null)
			{
				events[_loc_5] = new Array();
			}
			var _loc_6:Boolean = false;
			var _loc_7:Number = 0;
			while(_loc_7 < events[_loc_5].length)
			{
				if(events[_loc_5][_loc_7].scope == param3 && events[_loc_5][_loc_7].funcName == param2)
				{
					_loc_6 = true;
					break;
				}
				_loc_7 = _loc_7 + 1;
			}
			if(!_loc_6)
			{
				if(param4)
				{
					events[_loc_5].unshift({scope:param3, funcName:param2});
				}
				else
				{
					events[_loc_5].push({scope:param3, funcName:param2});
				}
			}
		}

		public function removeEventListener(param1:MessageType, param2:String, param3:Object) : void
		{
			var _loc_5:int = NaN;
			var _loc_4:String = param1.getMessageTypeName();
			if(events[_loc_4] != null)
			{
				_loc_5 = 0;
				while(_loc_5 < events[_loc_4].length)
				{
					if(events[_loc_4][_loc_5].scope == param3 && events[_loc_4][_loc_5].funcName == param2)
					{
						events[_loc_4].splice(_loc_5, 1);
						break;
					}
					_loc_5 = _loc_5 + 1;
				}
				if(events[_loc_4].length == 0)
				{
					events[_loc_4] = null;
				}
			}
		}

		public function addListener(param1:Object) : void
		{
			getListeners().push(param1);
		}

		private function getListeners() : Array
		{
			return listeners;
		}
	}
}
