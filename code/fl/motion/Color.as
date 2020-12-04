package fl.motion
{
	import flash.geom.*;

	public class Color extends ColorTransform
	{
		private var _tintColor:Number = 0;
		private var _tintMultiplier:Number = 0;

		final public static function interpolateColor(param1:uint, param2:uint, param3:Number) : uint
		{
			var _loc_4:Number = 1 - param3;
			var _loc_5:uint = (param1 >> 24) & 255;
			var _loc_6:uint = (param1 >> 16) & 255;
			var _loc_7:uint = (param1 >> 8) & 255;
			var _loc_8:uint = param1 & 255;
			var _loc_9:uint = (param2 >> 24) & 255;
			var _loc_10:uint = (param2 >> 16) & 255;
			var _loc_11:uint = (param2 >> 8) & 255;
			var _loc_12:uint = param2 & 255;
			var _loc_13:uint = (_loc_5 * _loc_4) + (_loc_9 * param3);
			var _loc_14:uint = (_loc_6 * _loc_4) + (_loc_10 * param3);
			var _loc_15:uint = (_loc_7 * _loc_4) + (_loc_11 * param3);
			var _loc_16:uint = (_loc_8 * _loc_4) + (_loc_12 * param3);
			var _loc_17:uint = (_loc_13 << 24) | (_loc_14 << 16) | (_loc_15 << 8) | _loc_16;
			return _loc_17;
		}

		final public static function interpolateTransform(param1:ColorTransform, param2:ColorTransform, param3:Number) : ColorTransform
		{
			var _loc_4:Number = 1 - param3;
			var _loc_5:ColorTransform = new ColorTransform((param1.redMultiplier * _loc_4) + (param2.redMultiplier * param3), (param1.greenMultiplier * _loc_4) + (param2.greenMultiplier * param3), (param1.blueMultiplier * _loc_4) + (param2.blueMultiplier * param3), (param1.alphaMultiplier * _loc_4) + (param2.alphaMultiplier * param3), (param1.redOffset * _loc_4) + (param2.redOffset * param3), (param1.greenOffset * _loc_4) + (param2.greenOffset * param3), (param1.blueOffset * _loc_4) + (param2.blueOffset * param3), (param1.alphaOffset * _loc_4) + (param2.alphaOffset * param3));
			return _loc_5;
		}

		final public static function fromXML(param1:XML) : Color
		{
			return Color((new Color()).parseXML(param1));
		}

		public function Color(param1:Number = 1.000000, param2:Number = 1.000000, param3:Number = 1.000000, param4:Number = 1.000000, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0)
		{
			super(param1, param2, param3, param4, param5, param6, param7, param8);
		}

		private function deriveTintColor() : uint
		{
			var _loc_1:Number = 1 / this.tintMultiplier;
			var _loc_2:uint = Math.round(this.redOffset * _loc_1);
			var _loc_3:uint = Math.round(this.greenOffset * _loc_1);
			var _loc_4:uint = Math.round(this.blueOffset * _loc_1);
			var _loc_5:uint = (_loc_2 << 16) | (_loc_3 << 8) | _loc_4;
			return _loc_5;
		}

		public function set brightness(param1:Number) : void
		{
			if(param1 > 1)
			{
				param1 = 1;
			}
			else
			{
				if(param1 < -1)
				{
					param1 = -1;
				}
			}
			var _loc_2:Number = 1 - Math.abs(param1);
			var _loc_3:Number = 0;
			if(param1 > 0)
			{
				_loc_3 = param1 * 255;
			}
			var _loc_4:Number = _loc_2;
			this.blueMultiplier = _loc_4;
			var _loc_4:Number = _loc_4;
			this.greenMultiplier = _loc_4;
			this.redMultiplier = _loc_4;
			var _loc_4:Number = _loc_3;
			this.blueOffset = _loc_4;
			var _loc_4:Number = _loc_4;
			this.greenOffset = _loc_4;
			this.redOffset = _loc_4;
		}

		private function parseXML(param1:XML = null) : Color
		{
			var _loc_3:XML = null;
			var _loc_4:String = null;
			var _loc_5:uint = 0;
			if(!param1)
			{
				return this;
			}
			var _loc_2:XML = param1.elements()[0];
			if(!_loc_2)
			{
				return this;
			}
			var _loc_6:int = 0;
			var _loc_7:* = _loc_2.attributes();
			for each(_loc_3 in _loc_7)
			{
				_loc_4 = _loc_3.localName();
				if(_loc_4 == "tintColor")
				{
					_loc_5 = Number(_loc_3.toString());
					this.tintColor = _loc_5;
					continue;
				}
				this[_loc_4] = Number(_loc_3.toString());
			}
			return this;
		}

		public function get tintColor() : uint
		{
			return this._tintColor;
		}

		public function set tintColor(param1:uint) : void
		{
			setTint(param1, this.tintMultiplier);
		}

		public function get brightness() : Number
		{
			return this.redOffset ? 1 - this.redMultiplier : this.redMultiplier - 1;
		}

		public function set tintMultiplier(param1:Number) : void
		{
			setTint(this.tintColor, param1);
		}

		public function get tintMultiplier() : Number
		{
			return this._tintMultiplier;
		}

		public function setTint(param1:uint, param2:Number) : void
		{
			this._tintColor = param1;
			this._tintMultiplier = param2;
			var _loc_6:Number = 1 - param2;
			this.blueMultiplier = _loc_6;
			var _loc_6:Number = _loc_6;
			this.greenMultiplier = _loc_6;
			this.redMultiplier = _loc_6;
			var _loc_3:uint = (param1 >> 16) & 255;
			var _loc_4:uint = (param1 >> 8) & 255;
			var _loc_5:uint = param1 & 255;
			this.redOffset = Math.round(_loc_3 * param2);
			this.greenOffset = Math.round(_loc_4 * param2);
			this.blueOffset = Math.round(_loc_5 * param2);
		}
	}
}
