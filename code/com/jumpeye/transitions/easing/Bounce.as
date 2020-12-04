package com.jumpeye.transitions.easing
{
	public class Bounce extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			if(_loc_5 < (1 / 2.75))
			{
				return (param3 * (7.56 * param1) * param1) + param2;
			}
			if(param1 < (2 / 2.75))
			{
				var _loc_5:Number = param1 - (1.50 / 2.75);
				param1 = _loc_5;
				return (param3 * (7.56 * _loc_5) * param1 + 0.75) + param2;
			}
			if(param1 < (2.50 / 2.75))
			{
				var _loc_5:Number = param1 - (2.25 / 2.75);
				param1 = _loc_5;
				return (param3 * (7.56 * _loc_5) * param1 + 0.94) + param2;
			}
			var _loc_5:Number = param1 - (2.63 / 2.75);
			param1 = _loc_5;
			return (param3 * (7.56 * _loc_5) * param1 + 0.98) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 - (Bounce.easeOut(param4 - param1, 0, param3, param4))) + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			if(param1 < (param4 / 2))
			{
				return (Bounce.easeIn(param1 * 2, 0, param3, param4)) * 0.50 + param2;
			}
			return (Bounce.easeOut((param1 * 2) - param4, 0, param3, param4)) * 0.50 + (param3 * 0.50) + param2;
		}

		public function Bounce()
		{
			super();
		}
	}
}
