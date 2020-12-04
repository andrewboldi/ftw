package com.jumpeye.transitions.easing
{
	public class Back extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 1.701580) : Number
		{
			var _loc_6:Number = (param1 / param4) - 1;
			param1 = _loc_6;
			return (param3 * (_loc_6 * param1) * (param5 + 1) * param1 + param5 + 1) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 1.701580) : Number
		{
			var _loc_6:Number = param1 / param4;
			param1 = _loc_6;
			return (param3 * _loc_6) * param1 * (param5 + 1) * param1 - param5 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 1.701580) : Number
		{
			var _loc_6:int = param1 / (param4 / 2);
			param1 = _loc_6;
			if(_loc_6 < 1)
			{
				var _loc_6:Number = param5 * 1.52;
				param5 = _loc_6;
				return (param3 / 2) * (param1 * param1) * (_loc_6 + 1) * param1 - param5 + param2;
			}
			var _loc_6:int = param1 - 2;
			param1 = _loc_6;
			var _loc_6:Number = param5 * 1.52;
			param5 = _loc_6;
			return (param3 / 2) * (_loc_6 * param1) * (_loc_6 + 1) * param1 + param5 + 2 + param2;
		}

		public function Back()
		{
			super();
		}
	}
}
