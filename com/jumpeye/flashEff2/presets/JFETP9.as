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
