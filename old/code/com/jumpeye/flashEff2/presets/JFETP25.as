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
