package com.jumpeye.flashEff2.symbol.badTransmission
{
	public class CustomMotion extends Object
	{
		protected var _points:Array;
		protected var pLen:uint;

		public function CustomMotion()
		{
			var _loc_1:* = undefined;
			super();
			_points = [];
			_loc_1 = 0;
			while(_loc_1 < 30)
			{
				_points[_loc_1] = 1;
				_loc_1 = _loc_1 + 1;
			}
		}

		public function get points() : Array
		{
			return this._points;
		}

		public function set points(param1:Array) : void
		{
			if(param1 is Array)
			{
				this._points = param1;
				pLen = param1.length - 1;
			}
		}

		public function getValue(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:* = undefined;
			var _loc_6:uint = 0;
			if(param4 <= 0)
			{
				return NaN;
			}
			_loc_5 = param1 / param4;
			_loc_6 = Math.floor(this.pLen * _loc_5);
			return param2 + (this._points[_loc_6] * param3);
		}
	}
}
