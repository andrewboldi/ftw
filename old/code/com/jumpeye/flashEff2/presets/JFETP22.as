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
