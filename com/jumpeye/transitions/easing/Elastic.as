package com.jumpeye.transitions.easing
{
	public class Elastic extends Object
	{
		private static const _2PI:Number = Math.PI * 2;

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0) : Number
		{
			var _loc_7:int = NaN;
			if(param1 == 0)
			{
				return param2;
			}
			var _loc_8:Number = param1 / param4;
			param1 = _loc_8;
			if(_loc_8 == 1)
			{
				return param2 + param3;
			}
			if(!param6)
			{
				param6 = param4 * 0.30;
			}
			if(!param5 || param5 < Math.abs(param3))
			{
				param5 = param3;
				_loc_7 = param6 / 4;
			}
			else
			{
				_loc_7 = (param6 / _2PI) * (Math.asin(param3 / param5));
			}
			var _loc_8:Number = param1 - 1;
			param1 = _loc_8;
			return (-(param5 * (Math.pow(2, 10 * _loc_8))) * (Math.sin((param1 * param4) - _loc_7 * _2PI / param6))) + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0) : Number
		{
			var _loc_7:int = NaN;
			if(param1 == 0)
			{
				return param2;
			}
			var _loc_8:int = param1 / (param4 / 2);
			param1 = _loc_8;
			if(_loc_8 == 2)
			{
				return param2 + param3;
			}
			if(!param6)
			{
				param6 = param4 * (0.30 * 1.50);
			}
			if(!param5 || param5 < Math.abs(param3))
			{
				param5 = param3;
				_loc_7 = param6 / 4;
			}
			else
			{
				_loc_7 = (param6 / _2PI) * (Math.asin(param3 / param5));
			}
			if(param1 < 1)
			{
				var _loc_8:Number = param1 - 1;
				param1 = _loc_8;
				return (-0.50 * (param5 * (Math.pow(2, 10 * _loc_8))) * (Math.sin((param1 * param4) - _loc_7 * _2PI / param6))) + param2;
			}
			var _loc_8:Number = param1 - 1;
			param1 = _loc_8;
			return (param5 * (Math.pow(2, -10 * _loc_8))) * (Math.sin((param1 * param4) - _loc_7 * _2PI / param6)) * 0.50 + param3 + param2;
		}

		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0) : Number
		{
			var _loc_7:int = NaN;
			if(param1 == 0)
			{
				return param2;
			}
			var _loc_8:Number = param1 / param4;
			param1 = _loc_8;
			if(_loc_8 == 1)
			{
				return param2 + param3;
			}
			if(!param6)
			{
				param6 = param4 * 0.30;
			}
			if(!param5 || param5 < Math.abs(param3))
			{
				param5 = param3;
				_loc_7 = param6 / 4;
			}
			else
			{
				_loc_7 = (param6 / _2PI) * (Math.asin(param3 / param5));
			}
			return (param5 * (Math.pow(2, -10 * param1))) * (Math.sin((param1 * param4) - _loc_7 * _2PI / param6)) + param3 + param2;
		}

		public function Elastic()
		{
			super();
		}
	}
}
