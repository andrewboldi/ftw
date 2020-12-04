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
