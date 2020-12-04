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
