package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP1 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param3;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP1()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP10 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (param3 + param2) - _loc_6 - _loc_7 - 2;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = (_loc_6 + _loc_7) - 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP10()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP11 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (param2 + _loc_7) - _loc_6 - 1;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = (_loc_6 + _loc_7) - 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP11()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP12 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (param3 - _loc_7) + _loc_6 - 1;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = (_loc_6 + _loc_7) - 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP12()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP13 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_9)
			{
				_loc_7 = _loc_6;
				while(_loc_7 < (param3 - _loc_7))
				{
					param4[_loc_7][_loc_7] = _loc_7;
					param4[(param2 - _loc_7) - 1][_loc_7] = _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				if(_loc_7 <= (JFESP13.uint(param3 / 2)))
				{
					_loc_7 = _loc_7 + 1;
					while(_loc_7 < (param2 - _loc_7) - 1)
					{
						param4[_loc_7][_loc_7] = _loc_7;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_7;
						_loc_7 = _loc_7 + 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			_loc_8 = _loc_9;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP13()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP14 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			var _loc_10:uint = Math.min(_loc_9, param3 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_9)
			{
				_loc_7 = _loc_6;
				while(_loc_7 < (param3 - _loc_7))
				{
					param4[_loc_7][_loc_7] = _loc_10 - _loc_7;
					param4[(param2 - _loc_7) - 1][_loc_7] = _loc_10 - _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				if(_loc_7 <= (JFESP14.uint(param3 / 2)))
				{
					_loc_7 = _loc_7 + 1;
					while(_loc_7 < (param2 - _loc_7) - 1)
					{
						param4[_loc_7][_loc_7] = _loc_10 - _loc_7;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_10 - _loc_7;
						_loc_7 = _loc_7 + 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			_loc_8 = _loc_9 + 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP14()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP15 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:int = 0;
			var _loc_10:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_10)
			{
				if(_loc_6 <= (param3 - _loc_6) - 1)
				{
					_loc_7 = _loc_6;
					while(_loc_7 <= (param2 - _loc_7) - 2)
					{
						_loc_9++;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				_loc_7 = _loc_7;
				while(_loc_7 <= (param3 - _loc_7) - 1)
				{
					_loc_9++;
					param4[(param2 - _loc_7) - 1][_loc_7] = _loc_9;
					_loc_7 = _loc_7 + 1;
				}
				if((param3 - _loc_7) - 1 > _loc_7)
				{
					_loc_7 = (param2 - _loc_7) - 2;
					while(_loc_7 > _loc_7)
					{
						_loc_9++;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				if(_loc_7 < (param2 - _loc_7) - 1)
				{
					_loc_7 = (param3 - _loc_7) - 1;
					while(_loc_7 > _loc_7)
					{
						_loc_9++;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			_loc_8 = _loc_9;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP15()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP16 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:* = param3 * param2;
			_loc_8 = _loc_9;
			var _loc_10:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_10)
			{
				if(_loc_6 <= (param3 - _loc_6) - 1)
				{
					_loc_7 = _loc_6;
					while(_loc_7 <= (param2 - _loc_7) - 2)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				_loc_7 = _loc_7;
				while(_loc_7 <= (param3 - _loc_7) - 1)
				{
					_loc_9 = _loc_9 - 1;
					param4[(param2 - _loc_7) - 1][_loc_7] = _loc_9;
					_loc_7 = _loc_7 + 1;
				}
				if((param3 - _loc_7) - 1 > _loc_7)
				{
					_loc_7 = (param2 - _loc_7) - 2;
					while(_loc_7 > _loc_7)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				if(_loc_7 < (param2 - _loc_7) - 1)
				{
					_loc_7 = (param3 - _loc_7) - 1;
					while(_loc_7 > _loc_7)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP16()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP17 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = 0;
			var _loc_10:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_10)
			{
				if((param2 - _loc_6) - 1 >= _loc_6)
				{
					_loc_7 = _loc_6;
					while(_loc_7 <= (param3 - _loc_7) - 1)
					{
						_loc_9 = _loc_9 + 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				if((param3 - _loc_7) - 1 >= _loc_7)
				{
					_loc_7 = _loc_7 + 1;
					while(_loc_7 < (param2 - _loc_7) - 1)
					{
						_loc_9 = _loc_9 + 1;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				if(_loc_7 < (param3 - _loc_7) - 1)
				{
					if((param2 - _loc_7) - 1 > _loc_7)
					{
						_loc_7 = param3 - _loc_7;
						while(_loc_7 > _loc_7)
						{
							_loc_9 = _loc_9 + 1;
							param4[(param2 - _loc_7) - 1][_loc_7 - 1] = _loc_9;
							_loc_7 = _loc_7 - 1;
						}
					}
				}
				if(_loc_7 < (param3 - _loc_7) - 1)
				{
					_loc_7 = (param2 - _loc_7) - 2;
					while(_loc_7 > _loc_7)
					{
						_loc_9 = _loc_9 + 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			_loc_8 = _loc_9;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP17()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP18 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = param3 * param2;
			_loc_8 = _loc_9;
			var _loc_10:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_10)
			{
				if((param2 - _loc_6) - 1 >= _loc_6)
				{
					_loc_7 = _loc_6;
					while(_loc_7 <= (param3 - _loc_7) - 1)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				if((param3 - _loc_7) - 1 >= _loc_7)
				{
					_loc_7 = _loc_7 + 1;
					while(_loc_7 < (param2 - _loc_7) - 1)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][(param3 - _loc_7) - 1] = _loc_9;
						_loc_7 = _loc_7 + 1;
					}
				}
				if(_loc_7 < (param3 - _loc_7) - 1)
				{
					if((param2 - _loc_7) - 1 > _loc_7)
					{
						_loc_7 = param3 - _loc_7;
						while(_loc_7 > _loc_7)
						{
							_loc_9 = _loc_9 - 1;
							param4[(param2 - _loc_7) - 1][_loc_7 - 1] = _loc_9;
							_loc_7 = _loc_7 - 1;
						}
					}
				}
				if(_loc_7 < (param3 - _loc_7) - 1)
				{
					_loc_7 = (param2 - _loc_7) - 2;
					while(_loc_7 > _loc_7)
					{
						_loc_9 = _loc_9 - 1;
						param4[_loc_7][_loc_7] = _loc_9;
						_loc_7 = _loc_7 - 1;
					}
				}
				_loc_7 = _loc_7 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP18()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP19 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = JFESP19.uint((Math.random() * param3) * param2);
					_loc_8 = Math.max(_loc_8, param4[_loc_6][_loc_7]);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP19()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP2 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = param3 - _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param3;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP2()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP20 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (_loc_6 + _loc_7) % 2;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = 2;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP20()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP3 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = _loc_6;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param2;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP3()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP4 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = param2 - _loc_6;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param2;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP4()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP5 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < _loc_9)
				{
					param4[_loc_6][_loc_7] = _loc_9 - _loc_7;
					param4[_loc_6][(param3 - _loc_7) - 1] = _loc_9 - _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = _loc_9 + 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP5()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP6 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < _loc_9)
				{
					param4[_loc_6][_loc_7] = _loc_7;
					param4[_loc_6][(param3 - _loc_7) - 1] = _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = _loc_9;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP6()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP7 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_9)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = _loc_6;
					param4[(param2 - _loc_6) - 1][_loc_7] = _loc_6;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = _loc_9;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP7()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP8 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			var _loc_9:Number = (Math.ceil(param2 / 2)) - 1;
			_loc_6 = 0;
			while(_loc_6 <= _loc_9)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = _loc_9 - _loc_6;
					param4[(param2 - _loc_6) - 1][_loc_7] = _loc_9 - _loc_6;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = _loc_9 + 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP8()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESP9 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = _loc_6 + _loc_7;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = (_loc_6 + _loc_7) - 1;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESP9()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM2 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (_loc_6 * (param3 - 1)) + (param3 - _loc_7);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param2 * param3;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM2()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM3 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (_loc_7 * (param2 - 1)) + _loc_6;
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param2 * param3;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM3()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM4 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_8:Number = 0;
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					param4[_loc_6][_loc_7] = (_loc_7 * (param2 - 1)) + (param2 - _loc_6);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			_loc_8 = param2 * param3;
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM4()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM5 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_10:int = NaN;
			var _loc_8:Number = 0;
			var _loc_9:uint = Math.ceil(param3 / 2);
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < _loc_9)
				{
					_loc_10 = (Math.ceil(_loc_6 * _loc_9)) + (_loc_9 - _loc_7) - 1;
					param4[_loc_6][_loc_7] = _loc_10;
					param4[_loc_6][(param3 - _loc_7) - 1] = _loc_10;
					_loc_8 = Math.max(_loc_8, _loc_10);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM5()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM6 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_10:int = NaN;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param3 / 2);
			_loc_6 = 0;
			while(_loc_6 < param2)
			{
				_loc_7 = 0;
				while(_loc_7 < _loc_9)
				{
					_loc_10 = (Math.ceil(_loc_6 * _loc_9)) + _loc_7;
					param4[_loc_6][_loc_7] = _loc_10;
					param4[_loc_6][(param3 - _loc_7) - 1] = _loc_10;
					_loc_8 = Math.max(_loc_10, _loc_8);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM6()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM7 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_10:int = NaN;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_9)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					_loc_10 = Math.ceil((_loc_7 * _loc_9) + _loc_6);
					param4[_loc_6][_loc_7] = _loc_10;
					param4[(param2 - _loc_6) - 1][_loc_7] = _loc_10;
					_loc_8 = Math.max(_loc_10, _loc_8);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM7()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFESPM8 extends Sprite
	{
		final public static function fep(param1:uint, param2:uint, param3:uint, param4:Array, param5:Object = null) : Array
		{
			var _loc_6:* = undefined;
			var _loc_7:uint = 0;
			var _loc_10:int = NaN;
			var _loc_8:Number = 0;
			var _loc_9:Number = Math.ceil(param2 / 2);
			_loc_6 = 0;
			while(_loc_6 < _loc_9)
			{
				_loc_7 = 0;
				while(_loc_7 < param3)
				{
					_loc_10 = (Math.ceil(_loc_7 * _loc_9)) + (_loc_9 - _loc_6) - 1;
					param4[_loc_6][_loc_7] = _loc_10;
					param4[(param2 - _loc_6) - 1][_loc_7] = _loc_10;
					_loc_8 = Math.max(_loc_10, _loc_8);
					_loc_7 = _loc_7 + 1;
				}
				_loc_6 = _loc_6 + 1;
			}
			if(param5 != null)
			{
				param5.MAX = _loc_8;
			}
			return param4;
		}

		public function JFESPM8()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP10 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_8)
				{
					_loc_4[_loc_2][_loc_3] = _loc_3;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = _loc_3;
					_loc_3++;
				}
				_loc_7 = Math.max(_loc_7, _loc_8);
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP10()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP11 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_8)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_8 - _loc_3) - 1;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = (_loc_8 - _loc_3) - 1;
					_loc_3++;
				}
				_loc_7 = Math.max(_loc_7, _loc_8);
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP11()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP12 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:int = NaN;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_3 = 0;
				while(_loc_3 < _loc_8)
				{
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = _loc_7;
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP12()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP13 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_3 = 0;
				while(_loc_3 < _loc_8)
				{
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = _loc_7;
					_loc_3++;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP13()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP14 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:int = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_3 = _loc_8 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = _loc_7;
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP14()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP15 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_8 = Math.ceil(_loc_6 / 2);
				_loc_3 = _loc_8 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][(_loc_6 - _loc_3) - 1] = _loc_7;
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP15()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP16 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = _loc_2 + (_loc_3 * _loc_8);
					_loc_7 = Math.max(_loc_7, _loc_2 + (_loc_3 * _loc_8));
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = _loc_2 + (_loc_3 * _loc_8);
					_loc_7 = Math.max(_loc_7, _loc_2 + (_loc_3 * _loc_8));
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP16()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP17 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = Math.ceil(_loc_5 / 2);
			var _loc_8:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_7)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = _loc_2 + (_loc_6 - _loc_3) - 1 * _loc_7;
					_loc_8 = Math.max(_loc_8, _loc_2 + (_loc_6 - _loc_3) - 1 * _loc_7);
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = _loc_2 + (_loc_6 - _loc_3) - 1 * _loc_7;
					_loc_8 = Math.max(_loc_8, _loc_2 + (_loc_6 - _loc_3) - 1 * _loc_7);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_8, timeMatrix:_loc_4};
		}

		public function JFETP17()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP18 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = Math.ceil(_loc_5 / 2);
			var _loc_8:uint = 0;
			_loc_2 = _loc_7 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_7 - _loc_2) - 1 + (_loc_3 * _loc_7);
					_loc_8 = Math.max(_loc_8, (_loc_7 - _loc_2) - 1 + (_loc_3 * _loc_7));
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = (_loc_7 - _loc_2) - 1 + (_loc_3 * _loc_7);
					_loc_8 = Math.max(_loc_8, (_loc_7 - _loc_2) - 1 + (_loc_3 * _loc_7));
					_loc_3++;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_8, timeMatrix:_loc_4};
		}

		public function JFETP18()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP19 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = _loc_8 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_8 - _loc_2) - 1 + (_loc_6 - _loc_3) - 1 * _loc_8;
					_loc_7 = Math.max(_loc_7, (_loc_8 - _loc_2) - 1 + (_loc_6 - _loc_3) - 1 * _loc_8);
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = (_loc_8 - _loc_2) - 1 + (_loc_6 - _loc_3) - 1 * _loc_8;
					_loc_7 = Math.max(_loc_7, (_loc_8 - _loc_2) - 1 + (_loc_6 - _loc_3) - 1 * _loc_8);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP19()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP2 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 > -1)
				{
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_7 = _loc_7 + 1;
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP2()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP20 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:* = -1;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_4[_loc_2] = [];
				if((_loc_8 + _loc_2) < _loc_5)
				{
					_loc_4[_loc_8 + _loc_2] = [];
				}
				_loc_2 = _loc_2 + 1;
			}
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_6 = param1[_loc_2].length;
				if((_loc_5 - _loc_2) - 1 >= _loc_2)
				{
					_loc_3 = _loc_2;
					while(_loc_3 <= (_loc_6 - _loc_3) - 1)
					{
						if(JFETP20.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_7 = _loc_7 + 1;
							_loc_4[_loc_3][_loc_3] = _loc_7;
						}
						_loc_3++;
					}
				}
				_loc_6 = param1[_loc_3].length;
				_loc_3 = _loc_3;
				while(_loc_3 < (_loc_5 - _loc_3) - 1)
				{
					_loc_6 = param1[_loc_3].length;
					if((_loc_6 - _loc_3) - 1 > _loc_3)
					{
						if(JFETP20.isNaN(_loc_4[_loc_3][(_loc_6 - _loc_3) - 1]))
						{
							_loc_7 = _loc_7 + 1;
							_loc_4[_loc_3][(_loc_6 - _loc_3) - 1] = _loc_7;
						}
					}
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
				if((_loc_5 - _loc_3) - 1 > _loc_3)
				{
					_loc_3 = _loc_6 - _loc_3;
					while(_loc_3 > _loc_3)
					{
						if(JFETP20.isNaN(_loc_4[(_loc_5 - _loc_3) - 1][_loc_3 - 1]))
						{
							_loc_7 = _loc_7 + 1;
							_loc_4[(_loc_5 - _loc_3) - 1][_loc_3 - 1] = _loc_7;
						}
						_loc_3 = _loc_3 - 1;
					}
				}
				_loc_3 = (_loc_5 - _loc_3) - 2;
				while(_loc_3 > _loc_3)
				{
					_loc_6 = param1[_loc_3].length;
					if(_loc_3 < _loc_6)
					{
						if(JFETP20.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_7 = _loc_7 + 1;
							_loc_4[_loc_3][_loc_3] = _loc_7;
						}
					}
					_loc_3 = _loc_3 - 1;
				}
				_loc_3 = _loc_3 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP20()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP21 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_4[_loc_2] = [];
				_loc_7 = _loc_7 + param1[_loc_2].length;
				_loc_2 = _loc_2 + 1;
			}
			var _loc_9:uint = _loc_7;
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_3 = _loc_2;
				while(_loc_3 <= (_loc_5 - _loc_3) - 2)
				{
					_loc_6 = param1[_loc_3].length;
					if(_loc_3 < _loc_6)
					{
						if(JFETP21.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][_loc_3] = _loc_9;
						}
					}
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
				_loc_3 = _loc_3;
				while(_loc_3 <= (_loc_6 - _loc_3) - 1)
				{
					_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
					if(JFETP21.isNaN(_loc_4[(_loc_5 - _loc_3) - 1][_loc_3]))
					{
						_loc_9 = _loc_9 - 1;
						_loc_4[(_loc_5 - _loc_3) - 1][_loc_3] = _loc_9;
					}
					_loc_3++;
				}
				_loc_3 = (_loc_5 - _loc_3) - 2;
				while(_loc_3 > _loc_3)
				{
					_loc_6 = param1[_loc_3].length;
					if((_loc_6 - _loc_3) - 1 > _loc_3)
					{
						if(JFETP21.isNaN(_loc_4[_loc_3][(_loc_6 - _loc_3) - 1]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][(_loc_6 - _loc_3) - 1] = _loc_9;
						}
					}
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = param1[_loc_3].length;
				if(_loc_3 < (_loc_5 - _loc_3) - 1)
				{
					_loc_3 = (_loc_6 - _loc_3) - 1;
					while(_loc_3 > _loc_3)
					{
						if(JFETP21.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][_loc_3] = _loc_9;
						}
						_loc_3 = _loc_3 - 1;
					}
				}
				_loc_3 = _loc_3 + 1;
			}
			return {maxItems:_loc_9, timeMatrix:_loc_4};
		}

		public function JFETP21()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP22 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:int = -1;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_4[_loc_2] = [];
				if((_loc_8 + _loc_2) < _loc_5)
				{
					_loc_4[_loc_8 + _loc_2] = [];
				}
				_loc_2 = _loc_2 + 1;
			}
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_3 = _loc_2;
				while(_loc_3 <= (_loc_5 - _loc_3) - 2)
				{
					_loc_6 = param1[_loc_3].length;
					if(_loc_3 <= (_loc_6 - _loc_3) - 1)
					{
						if(JFETP22.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_7++;
							_loc_4[_loc_3][_loc_3] = _loc_7;
						}
					}
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
				_loc_3 = _loc_3;
				while(_loc_3 <= (_loc_6 - _loc_3) - 1)
				{
					_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
					if(JFETP22.isNaN(_loc_4[(_loc_5 - _loc_3) - 1][_loc_3]))
					{
						_loc_7++;
						_loc_4[(_loc_5 - _loc_3) - 1][_loc_3] = _loc_7;
					}
					_loc_3++;
				}
				_loc_3 = (_loc_5 - _loc_3) - 2;
				while(_loc_3 > _loc_3)
				{
					_loc_6 = param1[_loc_3].length;
					if((_loc_6 - _loc_3) - 1 > _loc_3)
					{
						if(JFETP22.isNaN(_loc_4[_loc_3][(_loc_6 - _loc_3) - 1]))
						{
							_loc_7++;
							_loc_4[_loc_3][(_loc_6 - _loc_3) - 1] = _loc_7;
						}
					}
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = param1[_loc_3].length;
				if(_loc_3 < (_loc_5 - _loc_3) - 1)
				{
					_loc_3 = (_loc_6 - _loc_3) - 1;
					while(_loc_3 > _loc_3)
					{
						if(JFETP22.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_7++;
							_loc_4[_loc_3][_loc_3] = _loc_7;
						}
						_loc_3 = _loc_3 - 1;
					}
				}
				_loc_3 = _loc_3 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP22()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP23 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:int = -1;
			var _loc_8:uint = Math.ceil(_loc_5 / 2);
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_4[_loc_2] = [];
				_loc_7 = _loc_7 + param1[_loc_2].length;
				_loc_2 = _loc_2 + 1;
			}
			var _loc_9:int = _loc_7;
			_loc_2 = 0;
			while(_loc_2 < _loc_8)
			{
				_loc_6 = param1[_loc_2].length;
				if((_loc_5 - _loc_2) - 1 >= _loc_2)
				{
					_loc_3 = _loc_2;
					while(_loc_3 <= (_loc_6 - _loc_3) - 1)
					{
						if(JFETP23.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][_loc_3] = _loc_9;
						}
						_loc_3++;
					}
				}
				_loc_6 = param1[_loc_3].length;
				_loc_3 = _loc_3;
				while(_loc_3 < (_loc_5 - _loc_3) - 1)
				{
					_loc_6 = param1[_loc_3].length;
					if((_loc_6 - _loc_3) - 1 >= _loc_3)
					{
						if(JFETP23.isNaN(_loc_4[_loc_3][(_loc_6 - _loc_3) - 1]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][(_loc_6 - _loc_3) - 1] = _loc_9;
						}
					}
					_loc_3++;
				}
				_loc_6 = (param1[(_loc_5 - _loc_3) - 1]).length;
				if(_loc_3 <= (_loc_6 - _loc_3) - 1)
				{
					if((_loc_5 - _loc_3) - 1 > _loc_3)
					{
						_loc_3 = _loc_6 - _loc_3;
						while(_loc_3 > _loc_3)
						{
							if(JFETP23.isNaN(_loc_4[(_loc_5 - _loc_3) - 1][_loc_3 - 1]))
							{
								_loc_9 = _loc_9 - 1;
								_loc_4[(_loc_5 - _loc_3) - 1][_loc_3 - 1] = _loc_9;
							}
							_loc_3 = _loc_3 - 1;
						}
					}
				}
				_loc_3 = (_loc_5 - _loc_3) - 2;
				while(_loc_3 > _loc_3)
				{
					_loc_6 = param1[_loc_3].length;
					if(_loc_3 < _loc_6)
					{
						if(JFETP23.isNaN(_loc_4[_loc_3][_loc_3]))
						{
							_loc_9 = _loc_9 - 1;
							_loc_4[_loc_3][_loc_3] = _loc_9;
						}
					}
					_loc_3 = _loc_3 - 1;
				}
				_loc_3 = _loc_3 + 1;
			}
			return {maxItems:_loc_9, timeMatrix:_loc_4};
		}

		public function JFETP23()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP24 extends Sprite
	{
		final public static function jtpFill(param1:*, param2:*, param3:Array) : Array
		{
			var _loc_4:Number = param3[param1][param2];
			if(JFETP24.isNaN(param3[param1 - 1][param2]) || (param3[param1 - 1][param2]) > (_loc_4 + 1))
			{
				param3[param1 - 1][param2] = _loc_4 + 1;
				JFETP24.jtpFill(param1 - 1, param2, param3);
			}
			if(JFETP24.isNaN(param3[param1 + 1][param2]) || (param3[param1 + 1][param2]) > (_loc_4 + 1))
			{
				param3[param1 + 1][param2] = _loc_4 + 1;
				JFETP24.jtpFill(param1 + 1, param2, param3);
			}
			if(JFETP24.isNaN(param3[param1][param2 - 1]) || (param3[param1][param2 - 1]) > (_loc_4 + 1))
			{
				param3[param1][param2 - 1] = _loc_4 + 1;
				JFETP24.jtpFill(param1, param2 - 1, param3);
			}
			if(JFETP24.isNaN(param3[param1][param2 + 1]) || (param3[param1][param2 + 1]) > (_loc_4 + 1))
			{
				param3[param1][param2 + 1] = _loc_4 + 1;
				JFETP24.jtpFill(param1, param2 + 1, param3);
			}
			return param3;
		}

		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_14:int = NaN;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			var _loc_8:Number = Math.ceil(_loc_5 / 2);
			var _loc_9:Array = [];
			var _loc_10:Number = 0;
			var _loc_11:int = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_4[_loc_2] = [];
				_loc_9[_loc_2] = [];
				_loc_14 = param1[_loc_2].length;
				_loc_7 = _loc_7 + _loc_14;
				_loc_10 = Math.max(_loc_10, _loc_14);
				_loc_2 = _loc_2 + 1;
			}
			_loc_9[_loc_5] = [];
			_loc_9[_loc_5 + 1] = [];
			var _loc_12:Number = Math.ceil(_loc_10 / 2);
			_loc_2 = 0;
			while(_loc_2 <= (_loc_5 + 1))
			{
				_loc_9[_loc_2][0] = -1;
				_loc_9[_loc_2][_loc_10 + 1] = -1;
				_loc_2 = _loc_2 + 1;
			}
			_loc_2 = 0;
			while(_loc_2 <= (_loc_10 + 1))
			{
				_loc_9[0][_loc_2] = -1;
				_loc_9[_loc_5 + 1][_loc_2] = -1;
				_loc_2 = _loc_2 + 1;
			}
			_loc_9[_loc_8][_loc_12] = 0;
			JFETP24.jtpFill(_loc_8, _loc_12, _loc_9);
			_loc_11 = 0;
			var _loc_13:Number = Math.max(_loc_9[1][1], _loc_9[1][_loc_10]);
			_loc_13 = Math.max(_loc_13, _loc_9[_loc_5][1]);
			_loc_13 = Math.max(_loc_13, _loc_9[_loc_5][_loc_10]);
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = _loc_13 - (_loc_9[_loc_2 + 1][_loc_3 + 1]);
					_loc_11 = Math.max(_loc_11, _loc_4[_loc_2][_loc_3]);
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_11, timeMatrix:_loc_4};
		}

		public function JFETP24()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP25 extends Sprite
	{
		final public static function jtpFill(param1:*, param2:*, param3:Array) : Array
		{
			var _loc_4:Number = param3[param1][param2];
			if(JFETP25.isNaN(param3[param1 - 1][param2]) || (param3[param1 - 1][param2]) > (_loc_4 + 1))
			{
				param3[param1 - 1][param2] = _loc_4 + 1;
				JFETP25.jtpFill(param1 - 1, param2, param3);
			}
			if(JFETP25.isNaN(param3[param1 + 1][param2]) || (param3[param1 + 1][param2]) > (_loc_4 + 1))
			{
				param3[param1 + 1][param2] = _loc_4 + 1;
				JFETP25.jtpFill(param1 + 1, param2, param3);
			}
			if(JFETP25.isNaN(param3[param1][param2 - 1]) || (param3[param1][param2 - 1]) > (_loc_4 + 1))
			{
				param3[param1][param2 - 1] = _loc_4 + 1;
				JFETP25.jtpFill(param1, param2 - 1, param3);
			}
			if(JFETP25.isNaN(param3[param1][param2 + 1]) || (param3[param1][param2 + 1]) > (_loc_4 + 1))
			{
				param3[param1][param2 + 1] = _loc_4 + 1;
				JFETP25.jtpFill(param1, param2 + 1, param3);
			}
			return param3;
		}

		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_13:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:Number = Math.ceil(_loc_5 / 2);
			var _loc_8:Array = [];
			var _loc_9:Number = 0;
			var _loc_10:int = 0;
			var _loc_11:int = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_4[_loc_2] = [];
				_loc_8[_loc_2] = [];
				_loc_13 = param1[_loc_2].length;
				_loc_10 = _loc_10 + _loc_13;
				_loc_9 = Math.max(_loc_9, _loc_13);
				_loc_2 = _loc_2 + 1;
			}
			_loc_8[_loc_5] = [];
			_loc_8[_loc_5 + 1] = [];
			var _loc_12:uint = Math.ceil(_loc_9 / 2);
			_loc_2 = 0;
			while(_loc_2 <= (_loc_5 + 1))
			{
				_loc_8[_loc_2][0] = -1;
				_loc_8[_loc_2][_loc_9 + 1] = -1;
				_loc_2 = _loc_2 + 1;
			}
			_loc_2 = 0;
			while(_loc_2 <= (_loc_9 + 1))
			{
				_loc_8[0][_loc_2] = -1;
				_loc_8[_loc_5 + 1][_loc_2] = -1;
				_loc_2 = _loc_2 + 1;
			}
			_loc_8[_loc_7][_loc_12] = 0;
			JFETP25.jtpFill(_loc_7, _loc_12, _loc_8);
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = _loc_8[_loc_2 + 1][_loc_3 + 1];
					_loc_11 = Math.max(_loc_11, _loc_4[_loc_2][_loc_3]);
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_11, timeMatrix:_loc_4};
		}

		public function JFETP25()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP26 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = _loc_2;
					_loc_3++;
				}
				_loc_7 = _loc_7 + _loc_6;
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP26()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP27 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_5 - _loc_2) - 1;
					_loc_3++;
				}
				_loc_7 = _loc_7 + _loc_6;
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP27()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP28 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = Math.random() * _loc_5;
					_loc_3++;
				}
				_loc_7 = _loc_7 + _loc_6;
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP28()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP29 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:Number = Math.ceil(_loc_5 / 2);
			var _loc_8:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_7)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = _loc_2;
					_loc_8 = Math.max(_loc_8, _loc_2 + 1);
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = _loc_2;
					_loc_8 = Math.max(_loc_8, _loc_2 + 1);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_8, timeMatrix:_loc_4};
		}

		public function JFETP29()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_3++;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP3()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP30 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:Number = Math.ceil(_loc_5 / 2);
			var _loc_8:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_7)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_4[(_loc_5 - _loc_2) - 1] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_7 - _loc_2) - 1;
					_loc_8 = Math.max(_loc_8, _loc_7 - _loc_2);
					_loc_3 = _loc_3 - 1;
				}
				_loc_6 = (param1[(_loc_5 - _loc_2) - 1]).length;
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[(_loc_5 - _loc_2) - 1][_loc_3] = (_loc_7 - _loc_2) - 1;
					_loc_8 = Math.max(_loc_8, _loc_7 - _loc_2);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_8, timeMatrix:_loc_4};
		}

		public function JFETP30()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D10 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -param1 - param2;
			propOwner.getZPosition = _func_3122;
		}

		public function JFETP3D10()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D11 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(textOwnerClip.width - param1) + param2;
			propOwner.getZPosition = _func_3112;
		}

		public function JFETP3D11()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D12 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(textOwnerClip.height - param2) + param1;
			propOwner.getZPosition = _func_3117;
		}

		public function JFETP3D12()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D13 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(propOwner.teorecticSpace + param1) + param2;
			propOwner.getZPosition = _func_3155;
		}

		public function JFETP3D13()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D14 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width;
			return -Math.random() * propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3160;
		}

		public function JFETP3D14()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D15 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = (Math.sqrt((textOwnerClip.width * textOwnerClip.width) + (textOwnerClip.height * textOwnerClip.height))) / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			return -(Math.sqrt(Math.abs((propOwner.teorecticSpace * propOwner.teorecticSpace) - (_loc_6 * _loc_6) - (_loc_7 * _loc_7))));
			propOwner.getZPosition = _func_3145;
		}

		public function JFETP3D15()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D16 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = (Math.sqrt((textOwnerClip.width * textOwnerClip.width) + (textOwnerClip.height * textOwnerClip.height))) / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			return (Math.sqrt(Math.abs((propOwner.teorecticSpace * propOwner.teorecticSpace) - (_loc_6 * _loc_6) - (_loc_7 * _loc_7)))) - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3150;
		}

		public function JFETP3D16()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D17 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.height;
			return param2 - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3135;
		}

		public function JFETP3D17()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D18 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.height;
			return -param2;
			propOwner.getZPosition = _func_3140;
		}

		public function JFETP3D18()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D19 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width;
			return -Math.random() * propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3130;
		}

		public function JFETP3D19()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D2 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = (Math.sqrt((textOwnerClip.width * textOwnerClip.width) + (textOwnerClip.height * textOwnerClip.height))) / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			return -(Math.sqrt(Math.abs((propOwner.teorecticSpace * propOwner.teorecticSpace) - (_loc_6 * _loc_6) - (_loc_7 * _loc_7))));
			propOwner.getZPosition = _func_3254;
		}

		public function JFETP3D2()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D3 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = (Math.sqrt((textOwnerClip.width * textOwnerClip.width) + (textOwnerClip.height * textOwnerClip.height))) / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			return (Math.sqrt(Math.abs((propOwner.teorecticSpace * propOwner.teorecticSpace) - (_loc_6 * _loc_6) - (_loc_7 * _loc_7)))) - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3249;
		}

		public function JFETP3D3()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D4 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			var _loc_8:Number = propOwner.teorecticSpace;
			return (Math.sqrt((_loc_8 * _loc_8) - (_loc_6 * _loc_6))) - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3264;
		}

		public function JFETP3D4()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D5 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			var _loc_8:Number = propOwner.teorecticSpace;
			return -(Math.sqrt((_loc_8 * _loc_8) - (_loc_6 * _loc_6)));
			propOwner.getZPosition = _func_3259;
		}

		public function JFETP3D5()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D6 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width;
			return -param1;
			propOwner.getZPosition = _func_3186;
		}

		public function JFETP3D6()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D7 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width;
			return param1 - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3177;
		}

		public function JFETP3D7()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D8 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.height;
			return param2 - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3204;
		}

		public function JFETP3D8()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D9 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.height;
			return -param2;
			propOwner.getZPosition = _func_3195;
		}

		public function JFETP3D9()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP4 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 > -1)
				{
					_loc_7 = _loc_7 + 1;
					_loc_4[_loc_2][_loc_3] = _loc_7;
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP4()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP5 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = _loc_2 + _loc_3;
					_loc_7 = Math.max(_loc_7, _loc_2 + _loc_3);
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP5()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP6 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_2 + _loc_6) - _loc_3;
					_loc_7 = Math.max(_loc_7, (_loc_2 + _loc_6) - _loc_3);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 + 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP6()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP7 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_5 - _loc_2) + _loc_3;
					_loc_7 = Math.max(_loc_7, (_loc_5 - _loc_2) + _loc_3);
					_loc_3++;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP7()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP8 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:uint = 0;
			_loc_2 = _loc_5 - 1;
			while(_loc_2 >= 0)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = _loc_6 - 1;
				while(_loc_3 >= 0)
				{
					_loc_4[_loc_2][_loc_3] = (_loc_5 - _loc_2) + _loc_6 - _loc_3;
					_loc_7 = Math.max(_loc_7, (_loc_5 - _loc_2) + _loc_6 - _loc_3);
					_loc_3 = _loc_3 - 1;
				}
				_loc_2 = _loc_2 - 1;
			}
			return {maxItems:_loc_7, timeMatrix:_loc_4};
		}

		public function JFETP8()
		{
			super();
		}
	}
}
package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP9 extends Sprite
	{
		final public static function fep(param1:Array) : Object
		{
			var _loc_2:* = undefined;
			var _loc_3:int = 0;
			var _loc_6:uint = 0;
			var _loc_8:uint = 0;
			var _loc_9:int = NaN;
			var _loc_10:* = undefined;
			var _loc_4:Array = [];
			var _loc_5:uint = param1.length;
			var _loc_7:Array = [];
			_loc_2 = 0;
			while(_loc_2 < _loc_5)
			{
				_loc_6 = param1[_loc_2].length;
				_loc_4[_loc_2] = [];
				_loc_3 = 0;
				while(_loc_3 < _loc_6)
				{
					_loc_7.push({i:_loc_2, j:_loc_3, id:_loc_7.length});
					_loc_3++;
				}
				_loc_2 = _loc_2 + 1;
			}
			_loc_8 = _loc_7.length;
			while(_loc_7.length != 0)
			{
				_loc_9 = _loc_7.length;
				_loc_10 = Math.floor(Math.random() * _loc_9);
				_loc_4[_loc_7[_loc_10].i][_loc_7[_loc_10].j] = _loc_9 - 1;
				_loc_7.splice(_loc_10, 1);
			}
			return {maxItems:_loc_8, timeMatrix:_loc_4};
		}

		public function JFETP9()
		{
			super();
		}
	}
}
