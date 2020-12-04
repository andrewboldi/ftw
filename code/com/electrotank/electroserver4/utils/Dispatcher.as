package com.electrotank.electroserver4.utils
{
	public class Dispatcher extends Object
	{
		private var listeners:Array;
		private var events:Object;

		public function Dispatcher()
		{
			super();
			listeners = new Array();
			events = new Object();
		}

		public function dispatchEvent(param1:Object) : void
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

		public function addEventListener(param1:String, param2:String, param3:Object) : void
		{
			if(events[param1] == null)
			{
				events[param1] = new Array();
			}
			var _loc_4:Boolean = false;
			var _loc_5:Number = 0;
			while(_loc_5 < events[param1].length)
			{
				if(events[param1][_loc_5].scope == param3 && events[param1][_loc_5].funcName == param2)
				{
					_loc_4 = true;
					break;
				}
				_loc_5 = _loc_5 + 1;
			}
			if(!_loc_4)
			{
				events[param1].push({scope:param3, funcName:param2});
			}
		}

		public function removeEventListener(param1:String, param2:String, param3:Object) : void
		{
			var _loc_4:Number = 0;
			while(_loc_4 < events[param1].length)
			{
				if(events[param1][_loc_4].scope == param3 && events[param1][_loc_4].funcName == param2)
				{
					events[param1].splice(_loc_4, 1);
					break;
				}
				_loc_4 = _loc_4 + 1;
			}
			if(events[param1].length == 0)
			{
			}
		}

		private function getListeners() : Array
		{
			return listeners;
		}
	}
}
