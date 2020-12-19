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
package com.jumpeye.transitions.easing
{
	public class Circular extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = (param1 / param4) - 1;
			param1 = _loc_5;
			return (param3 * (Math.sqrt(1 - (_loc_5 * param1)))) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (-param3 * (Math.sqrt(1 - (_loc_5 * param1))) - 1) + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (-param3 / 2) * (Math.sqrt(1 - (param1 * param1))) - 1 + param2;
			}
			var _loc_5:int = param1 - 2;
			param1 = _loc_5;
			return (param3 / 2) * (Math.sqrt(1 - (_loc_5 * param1))) + 1 + param2;
		}

		public function Circular()
		{
			super();
		}
	}
}
package com.jumpeye.transitions.easing
{
	public class Cubic extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = (param1 / param4) - 1;
			param1 = _loc_5;
			return (param3 * (_loc_5 * param1) * param1 + 1) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (param3 * _loc_5) * param1 * param1 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (param3 / 2) * param1 * param1 * param1 + param2;
			}
			var _loc_5:int = param1 - 2;
			param1 = _loc_5;
			return (param3 / 2) * (_loc_5 * param1) * param1 + 2 + param2;
		}

		public function Cubic()
		{
			super();
		}
	}
}
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
package com.jumpeye.transitions.easing
{
	import flash.display.*;

	public class ElasticEase extends Sprite
	{
		public function ElasticEase()
		{
			var _loc_1:* = undefined;
			super();
			_loc_1 = new Elastic();
		}
	}
}
package com.jumpeye.transitions.easing
{
	public class Exponential extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return param1 == param4 ? param2 + param3 : (param3 * (-(Math.pow(2, (-10 * param1) / param4))) + 1) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return param1 == 0 ? param2 : (param3 * (Math.pow(2, 10 * (param1 / param4) - 1))) + param2 - (param3 * 0.00);
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			if(param1 == 0)
			{
				return param2;
			}
			if(param1 == param4)
			{
				return param2 + param3;
			}
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (param3 / 2) * (Math.pow(2, 10 * (param1 - 1))) + param2;
			}
			param1 = param1 - 1;
			return (param3 / 2) * (-(Math.pow(2, -10 * (param1 - 1)))) + 2 + param2;
		}

		public function Exponential()
		{
			super();
		}
	}
}
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
package com.jumpeye.transitions.easing
{
	public class Quadratic extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (-param3 * _loc_5) * (param1 - 2) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (param3 * _loc_5) * param1 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (param3 / 2) * param1 * param1 + param2;
			}
			param1 = param1 - 1;
			return (-param3 / 2) * (param1 - 1) * (param1 - 2) - 1 + param2;
		}

		public function Quadratic()
		{
			super();
		}
	}
}
package com.jumpeye.transitions.easing
{
	public class Quartic extends Object
	{
		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = (param1 / param4) - 1;
			param1 = _loc_5;
			return (-param3 * (_loc_5 * param1) * param1 * param1 - 1) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:Number = param1 / param4;
			param1 = _loc_5;
			return (param3 * _loc_5) * param1 * param1 * param1 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:int = param1 / (param4 / 2);
			param1 = _loc_5;
			if(_loc_5 < 1)
			{
				return (param3 / 2) * param1 * param1 * param1 * param1 + param2;
			}
			var _loc_5:int = param1 - 2;
			param1 = _loc_5;
			return (-param3 / 2) * (_loc_5 * param1) * param1 * param1 - 2 + param2;
		}

		public function Quartic()
		{
			super();
		}
	}
}
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
package com.jumpeye.transitions.easing
{
	public class Sine extends Object
	{
		private static const _HALF_PI:Number = Math.PI / 2;

		final public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (param3 * (Math.sin((param1 / param4) * _HALF_PI))) + param2;
		}

		final public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (-param3 * (Math.cos((param1 / param4) * _HALF_PI))) + param3 + param2;
		}

		final public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			return (-param3 / 2) * (Math.cos((Math.PI * param1) / param4)) - 1 + param2;
		}

		public function Sine()
		{
			super();
		}
	}
}
package com.jumpeye.transitions.easing
{
	public class Strong extends Object
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

		public function Strong()
		{
			super();
		}
	}
}
