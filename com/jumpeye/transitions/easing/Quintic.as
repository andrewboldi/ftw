package com.jumpeye.transitions.easing
{
	public class Quintic extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = (param1 / param4) - 1;
			param1 = _loc_5;
			return (param3 * (_loc_5 * param1) * param1 * param1 * param1 + 1) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (param3 * _loc_5) * param1 * param1 * param1 * param1 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (param3 / 2) * param1 * param1 * param1 * param1 * param1 + param2;
			}
			var _loc_5:int = param1 - 2;
			param1 = _loc_5;
			return (param3 / 2) * (_loc_5 * param1) * param1 * param1 * param1 + 2 + param2;
		}

		public function Quintic()
		{
			super();
		}
	}
}
