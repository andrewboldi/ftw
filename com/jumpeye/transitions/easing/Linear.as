package com.jumpeye.transitions.easing
{
	public class Linear extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 * param1) / param4 + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 * param1) / param4 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 * param1) / param4 + param2;
		}

		final public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 * param1) / param4 + param2;
		}

		public function Linear()
		{
			super();
		}
	}
}
