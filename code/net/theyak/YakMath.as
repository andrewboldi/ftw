package net.theyak
{
	public class YakMath extends Object
	{
		final public static function randomRange(param1:int, param2:int)
		{
			return (Math.round(Math.random() * (param2 - param1))) + param1;
		}

		final public static function round_string(param1:String, param2:uint = 0) : String
		{
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			if(param1 == null)
			{
				return "";
			}
			var _loc_3:RegExp = new RegExp("^[0-9.]+$");
			if(param1.match(_loc_3))
			{
				if(param2 == 0)
				{
					return YakMath.String(Math.round(YakMath.Number(param1)));
				}
				_loc_4 = YakMath.Number(param1);
				_loc_5 = Math.pow(10, param2);
				_loc_4 = _loc_4 * _loc_5;
				_loc_4 = Math.round(_loc_4);
				_loc_4 = _loc_4 / _loc_5;
				return YakMath.String(_loc_4);
			}
			return param1;
		}

		public function YakMath()
		{
			super();
		}
	}
}
