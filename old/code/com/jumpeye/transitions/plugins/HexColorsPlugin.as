package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;

	public class HexColorsPlugin extends TweenPlugin
	{
		public static const VERSION:Number = 1.01;
		public static const API:Number = 1;
		protected var _colors:Array;

		public function HexColorsPlugin()
		{
			super();
			this.propName = "hexColors";
			this.overwriteProps = [];
			_colors = [];
		}

		override public function killProps(param1:Object) : void
		{
			var _loc_2:int = _colors.length - 1;
			while(_loc_2 > -1)
			{
				if(param1[_colors[_loc_2][1]] != undefined)
				{
					_colors.splice(_loc_2, 1);
				}
				_loc_2 = _loc_2 - 1;
			}
			super.killProps(param1);
		}

		public function initColor(param1:Object, param2:String, param3:uint, param4:uint) : void
		{
			var _loc_5:int = NaN;
			var _loc_6:int = NaN;
			var _loc_7:int = NaN;
			if(param3 != param4)
			{
				_loc_5 = param3 >> 16;
				_loc_6 = (param3 >> 8) & 255;
				_loc_7 = param3 & 255;
				_colors[_colors.length] = [param1, param2, _loc_5, (param4 >> 16) - _loc_5, _loc_6, (param4 >> 8) & 255 - _loc_6, _loc_7, (param4 & 255) - _loc_7];
				this.overwriteProps[this.overwriteProps.length] = param2;
			}
		}

		override public function set changeFactor(param1:Number) : void
		{
			var _loc_2:int = 0;
			var _loc_3:Array = null;
			_loc_2 = _colors.length - 1;
			while(_loc_2 > -1)
			{
				_loc_3 = _colors[_loc_2];
				_loc_3[0][_loc_3[1]] = (_loc_3[2] + (param1 * _loc_3[3])) << 16 | (_loc_3[4] + (param1 * _loc_3[5])) << 8 | (_loc_3[6] + (param1 * _loc_3[7]));
				_loc_2 = _loc_2 - 1;
			}
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			var _loc_4:String = null;
			var _loc_5:int = 0;
			var _loc_6:* = param2;
			for each(_loc_4 in _loc_6)
			{
				initColor(param1, _loc_4, uint(param1[_loc_4]), uint(_loc_6[_loc_4]));
			}
			return true;
		}
	}
}
