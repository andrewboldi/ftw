package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class BevelFilterPlugin extends FilterPlugin
	{
		public static const VERSION:Number = 1;
		public static const API:Number = 1;

		public function BevelFilterPlugin()
		{
			super();
			this.propName = "bevelFilter";
			this.overwriteProps = ["bevelFilter"];
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			_target = param1;
			_type = BevelFilter;
			param2.quality;
			initFilter(param2, new BevelFilter(0, 0, 16777215, 0.50, 0, 0.50, 2, 2, 0, 2));
			return true;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class BlurFilterPlugin extends FilterPlugin
	{
		public static const VERSION:Number = 1;
		public static const API:Number = 1;

		public function BlurFilterPlugin()
		{
			super();
			this.propName = "blurFilter";
			this.overwriteProps = ["blurFilter"];
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			_target = param1;
			_type = BlurFilter;
			param2.quality;
			initFilter(param2, new BlurFilter(0, 0, 2));
			return true;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class ColorMatrixFilterPlugin extends FilterPlugin
	{
		public static const API:Number = 1;
		public static var _lumG:Number = 0.72;
		public static var _lumR:Number = 0.21;
		public static const VERSION:Number = 1.01;
		public static var _idMatrix:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
		public static var _lumB:Number = 0.07;
		protected var _matrix:Array;
		protected var _matrixTween:EndArrayPlugin;

		final public static function setSaturation(param1:Array, param2:Number) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			var _loc_3:Number = 1 - param2;
			var _loc_4:Number = _loc_3 * _lumR;
			var _loc_5:Number = _loc_3 * _lumG;
			var _loc_6:Number = _loc_3 * _lumB;
			var _loc_7:Array = [_loc_4 + param2, _loc_5, _loc_6, 0, 0, _loc_4, _loc_5 + param2, _loc_6, 0, 0, _loc_4, _loc_5, _loc_6 + param2, 0, 0, 0, 0, 0, 1, 0];
			return ColorMatrixFilterPlugin.applyMatrix(_loc_7, param1);
		}

		final public static function setHue(param1:Array, param2:Number) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			param2 = param2 * (Math.PI / 180);
			var _loc_3:Number = Math.cos(param2);
			var _loc_4:Number = Math.sin(param2);
			var _loc_5:Array = [(_lumR + (_loc_3 * (1 - _lumR))) + (_loc_4 * -_lumR), (_lumG + (_loc_3 * -_lumG)) + (_loc_4 * -_lumG), (_lumB + (_loc_3 * -_lumB)) + (_loc_4 * (1 - _lumB)), 0, 0, (_lumR + (_loc_3 * -_lumR)) + (_loc_4 * 0.14), (_lumG + (_loc_3 * (1 - _lumG))) + (_loc_4 * 0.14), (_lumB + (_loc_3 * -_lumB)) + (_loc_4 * -0.28), 0, 0, (_lumR + (_loc_3 * -_lumR)) + (_loc_4 * (-(1 - _lumR))), (_lumG + (_loc_3 * -_lumG)) + (_loc_4 * _lumG), (_lumB + (_loc_3 * (1 - _lumB))) + (_loc_4 * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
			return ColorMatrixFilterPlugin.applyMatrix(_loc_5, param1);
		}

		final public static function setThreshold(param1:Array, param2:Number) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			var _loc_3:Array = [_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, 0, 0, 0, 1, 0];
			return ColorMatrixFilterPlugin.applyMatrix(_loc_3, param1);
		}

		final public static function applyMatrix(param1:Array, param2:Array) : Array
		{
			var _loc_6:int = 0;
			var _loc_7:int = 0;
			if((param1 is Array) || param2 is Array)
			{
				return param2;
			}
			var _loc_3:Array = [];
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			_loc_6 = 0;
			while(_loc_6 < 4)
			{
				_loc_7 = 0;
				while(_loc_7 < 5)
				{
					if(_loc_7 == 4)
					{
						_loc_5 = param1[_loc_4 + 4];
					}
					else
					{
						_loc_5 = 0;
					}
					_loc_3[_loc_4 + _loc_7] = (param1[_loc_4] * param2[_loc_7]) + (param1[_loc_4 + 1]) * (param2[_loc_7 + 5]) + (param1[_loc_4 + 2]) * (param2[_loc_7 + 10]) + (param1[_loc_4 + 3]) * (param2[_loc_7 + 15]) + _loc_5;
					_loc_7++;
				}
				_loc_4 = _loc_4 + 5;
				_loc_6++;
			}
			return _loc_3;
		}

		final public static function colorize(param1:Array, param2:Number, param3:Number = 1) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			if(ColorMatrixFilterPlugin.isNaN(param3))
			{
				param3 = 1;
			}
			var _loc_4:Number = (param2 >> 16) & 255 / 255;
			var _loc_5:Number = (param2 >> 8) & 255 / 255;
			var _loc_6:Number = (param2 & 255) / 255;
			var _loc_7:Number = 1 - param3;
			var _loc_8:Array = [_loc_7 + (param3 * _loc_4) * _lumR, (param3 * _loc_4) * _lumG, (param3 * _loc_4) * _lumB, 0, 0, (param3 * _loc_5) * _lumR, _loc_7 + (param3 * _loc_5) * _lumG, (param3 * _loc_5) * _lumB, 0, 0, (param3 * _loc_6) * _lumR, (param3 * _loc_6) * _lumG, _loc_7 + (param3 * _loc_6) * _lumB, 0, 0, 0, 0, 0, 1, 0];
			return ColorMatrixFilterPlugin.applyMatrix(_loc_8, param1);
		}

		final public static function setBrightness(param1:Array, param2:Number) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			param2 = (param2 * 100) - 100;
			return ColorMatrixFilterPlugin.applyMatrix([1, 0, 0, 0, param2, 0, 1, 0, 0, param2, 0, 0, 1, 0, param2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], param1);
		}

		final public static function setContrast(param1:Array, param2:Number) : Array
		{
			if(ColorMatrixFilterPlugin.isNaN(param2))
			{
				return param1;
			}
			param2 = param2 + 0.01;
			var _loc_3:Array = [param2, 0, 0, 0, 128 * (1 - param2), 0, param2, 0, 0, 128 * (1 - param2), 0, 0, param2, 0, 128 * (1 - param2), 0, 0, 0, 1, 0];
			return ColorMatrixFilterPlugin.applyMatrix(_loc_3, param1);
		}

		public function ColorMatrixFilterPlugin()
		{
			super();
			this.propName = "colorMatrixFilter";
			this.overwriteProps = ["colorMatrixFilter"];
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			_target = param1;
			_type = ColorMatrixFilter;
			var _loc_4:Object = param2;
			initFilter({}, new ColorMatrixFilter(_idMatrix.slice()));
			_matrix = ColorMatrixFilter(_filter).matrix;
			var _loc_5:Array = [];
			if(!(_loc_4.matrix == null) && _loc_4.matrix is Array)
			{
				_loc_5 = _loc_4.matrix;
			}
			else
			{
				if(_loc_4.relative == true)
				{
					_loc_5 = _matrix.slice();
				}
				else
				{
					_loc_5 = _idMatrix.slice();
				}
				_loc_5 = setBrightness(_loc_5, _loc_4.brightness);
				_loc_5 = setContrast(_loc_5, _loc_4.contrast);
				_loc_5 = setHue(_loc_5, _loc_4.hue);
				_loc_5 = setSaturation(_loc_5, _loc_4.saturation);
				_loc_5 = setThreshold(_loc_5, _loc_4.threshold);
				if(!isNaN(_loc_4.colorize))
				{
					_loc_5 = colorize(_loc_5, _loc_4.colorize, _loc_4.amount);
				}
			}
			_matrixTween = new EndArrayPlugin();
			_matrixTween.init(_matrix, _loc_5);
			return true;
		}

		override public function set changeFactor(param1:Number) : void
		{
			_matrixTween.changeFactor = param1;
			ColorMatrixFilter(_filter).matrix = _matrix;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import com.jumpeye.transitions.utils.tween.*;
	import fl.motion.*;
	import flash.display.*;
	import flash.geom.*;

	public class CustomTintPlugin extends TweenPlugin
	{
		public static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];
		public static const VERSION:Number = 1;
		public static const API:Number = 1;
		protected var _color:Color;
		protected var _matrixTween:EndArrayPlugin;
		protected var _matrix:Array;
		protected var _target:DisplayObject;
		protected var _tintMultiplier:Number = 0;

		public function CustomTintPlugin()
		{
			super();
			this.propName = "customTint";
			this.overwriteProps = ["customTint"];
		}

		public function init(param1:DisplayObject, param2:Color) : void
		{
			var _loc_3:int = 0;
			var _loc_4:String = null;
			_target = param1;
			_loc_3 = _props.length - 1;
			while(_loc_3 > -1)
			{
				_loc_4 = _props[_loc_3];
				if(_color[_loc_4] != param2[_loc_4])
				{
					_tweens[_tweens.length] = new TweenInfo(_color, _loc_4, _color[_loc_4], param2[_loc_4] - _color[_loc_4], "customTint", true);
				}
				_loc_3 = _loc_3 - 1;
			}
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			if(!(param1 is DisplayObject))
			{
				return false;
			}
			var _loc_4:Object = param2;
			var _loc_5:Color = new Color();
			var _loc_6:ColorTransform = param1.transform.colorTransform;
			_color = new Color(_loc_6.redMultiplier, _loc_6.greenMultiplier, _loc_6.blueMultiplier, _loc_6.alphaMultiplier, _loc_6.redOffset, _loc_6.greenOffset, _loc_6.blueOffset, _loc_6.alphaOffset);
			var _loc_7:Number = _loc_4.amount;
			if(isNaN(_loc_7))
			{
				_loc_7 = 1;
			}
			_loc_4.tintColor;
			_loc_5.setTint(_color.tintColor, _loc_7);
			init(param1, _loc_5);
			return true;
		}

		override public function set changeFactor(param1:Number) : void
		{
			updateTweens(param1);
			_target.transform.colorTransform = _color;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class DropShadowFilterPlugin extends FilterPlugin
	{
		public static const VERSION:Number = 1;
		public static const API:Number = 1;

		public function DropShadowFilterPlugin()
		{
			super();
			this.propName = "dropShadowFilter";
			this.overwriteProps = ["dropShadowFilter"];
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			_target = param1;
			_type = DropShadowFilter;
			param2.quality;
			initFilter(param2, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, 2, param2.inner, param2.knockout, param2.hideObject));
			return true;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import com.jumpeye.transitions.utils.tween.*;

	public class EndArrayPlugin extends TweenPlugin
	{
		public static const VERSION:Number = 1.01;
		public static const API:Number = 1;
		protected var _a:Array;
		protected var _info:Array;

		public function EndArrayPlugin()
		{
			_info = [];
			super();
			this.propName = "endArray";
			this.overwriteProps = ["endArray"];
		}

		public function init(param1:Array, param2:Array) : void
		{
			_a = param1;
			var _loc_3:int = param2.length - 1;
			while(_loc_3 > -1)
			{
				if((param1[_loc_3] == param2[_loc_3]) && param1[_loc_3] == null)
				{
					_info[_info.length] = new ArrayTweenInfo(_loc_3, _a[_loc_3], param2[_loc_3] - _a[_loc_3]);
				}
				_loc_3 = _loc_3 - 1;
			}
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			if((param1 is Array) || param2 is Array)
			{
				return false;
			}
			init(param1, param2);
			return true;
		}

		override public function set changeFactor(param1:Number) : void
		{
			var _loc_2:int = 0;
			var _loc_3:ArrayTweenInfo = null;
			var _loc_4:int = NaN;
			var _loc_5:int = 0;
			if(this.round)
			{
				_loc_2 = _info.length - 1;
				while(_loc_2 > -1)
				{
					_loc_3 = _info[_loc_2];
					_loc_4 = _loc_3.start + (_loc_3.change * param1);
					_loc_5 = _loc_4 < 0 ? -1 : 1;
					_a[_loc_3.index] = (_loc_4 % 1) * _loc_5 > 0.50 ? int(_loc_4) + _loc_5 : int(_loc_4);
					_loc_2 = _loc_2 - 1;
				}
			}
			else
			{
				_loc_2 = _info.length - 1;
				while(_loc_2 > -1)
				{
					_loc_3 = _info[_loc_2];
					_a[_loc_3.index] = _loc_3.start + (_loc_3.change * param1);
					_loc_2 = _loc_2 - 1;
				}
			}
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.utils.tween.*;
	import flash.filters.*;

	public class FilterPlugin extends TweenPlugin
	{
		public static const VERSION:Number = 1.03;
		public static const API:Number = 1;
		protected var _remove:Boolean;
		protected var _target:Object;
		protected var _index:int;
		protected var _filter:BitmapFilter;
		protected var _type:Class;

		public function FilterPlugin()
		{
			super();
		}

		public function onCompleteTween() : void
		{
			var _loc_1:int = 0;
			var _loc_2:Array = null;
			if(_remove)
			{
				_loc_2 = _target.filters;
				if(!(_loc_2[_index] is _type))
				{
					_loc_1 = _loc_2.length - 1;
					while(_loc_1 > -1)
					{
						if(_loc_2[_loc_1] is _type)
						{
							_loc_2.splice(_loc_1, 1);
							break;
						}
						_loc_1 = _loc_1 - 1;
					}
				}
				else
				{
					_loc_2.splice(_index, 1);
				}
				_target.filters = _loc_2;
			}
		}

		protected function initFilter(param1:Object, param2:BitmapFilter) : void
		{
			var _loc_4:String = null;
			var _loc_5:int = 0;
			var _loc_6:HexColorsPlugin = null;
			var _loc_3:Array = _target.filters;
			_index = -1;
			if(param1.index != null)
			{
				_index = param1.index;
			}
			else
			{
				_loc_5 = _loc_3.length - 1;
				while(_loc_5 > -1)
				{
					if(_loc_3[_loc_5] is _type)
					{
						_index = _loc_5;
						break;
					}
					_loc_5 = _loc_5 - 1;
				}
			}
			if(_index == -1 || _loc_3[_index] == null || param1.addFilter == true)
			{
				_index = param1.index != null ? param1.index : _loc_3.length;
				_loc_3[_index] = param2;
				_target.filters = _loc_3;
			}
			_filter = _loc_3[_index];
			_remove = Boolean(param1.remove == true);
			if(_remove)
			{
				this.onComplete = onCompleteTween;
			}
			var _loc_7:Object = param1.isTV == true ? param1.exposedVars : param1;
			var _loc_8:int = 0;
			var _loc_9:* = _loc_7;
			for each(_loc_4 in _loc_9)
			{
				if(!(_loc_4 in _filter) || _filter[_loc_4] == _loc_9[_loc_4] || _loc_4 == "remove" || _loc_4 == "index" || _loc_4 == "addFilter")
				{
					continue;
				}
				if(_loc_4 == "color" || _loc_4 == "highlightColor" || _loc_4 == "shadowColor")
				{
					_loc_6 = new HexColorsPlugin();
					_loc_6.initColor(_filter, _loc_4, _filter[_loc_4], _loc_9[_loc_4]);
					_tweens[_tweens.length] = new TweenInfo(_loc_6, "changeFactor", 0, 1, _loc_4, false);
					continue;
				}
				if(_loc_4 == "quality" || _loc_4 == "inner" || _loc_4 == "knockout" || _loc_4 == "hideObject")
				{
					_filter[_loc_4] = _loc_9[_loc_4];
					continue;
				}
				addTween(_filter, _loc_4, _filter[_loc_4], _loc_9[_loc_4], _loc_4);
			}
		}

		override public function set changeFactor(param1:Number) : void
		{
			var _loc_2:int = 0;
			var _loc_3:TweenInfo = null;
			var _loc_4:Array = _target.filters;
			_loc_2 = _tweens.length - 1;
			while(_loc_2 > -1)
			{
				_loc_3 = _tweens[_loc_2];
				_loc_3.target[_loc_3.property] = _loc_3.start + (_loc_3.change * param1);
				_loc_2 = _loc_2 - 1;
			}
			if(!(_loc_4[_index] is _type))
			{
				_index = _loc_4.length - 1;
				_loc_2 = _loc_4.length - 1;
				while(_loc_2 > -1)
				{
					if(_loc_4[_loc_2] is _type)
					{
						_index = _loc_2;
						break;
					}
					_loc_2 = _loc_2 - 1;
				}
			}
			_loc_4[_index] = _filter;
			_target.filters = _loc_4;
		}
	}
}
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class GlowFilterPlugin extends FilterPlugin
	{
		public static const VERSION:Number = 1;
		public static const API:Number = 1;

		public function GlowFilterPlugin()
		{
			super();
			this.propName = "glowFilter";
			this.overwriteProps = ["glowFilter"];
		}

		override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			_target = param1;
			_type = GlowFilter;
			param2.quality;
			initFilter(param2, new GlowFilter(16777215, 0, 0, 0, 1, 2, param2.inner, param2.knockout));
			return true;
		}
	}
}
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
package com.jumpeye.transitions.plugins
{
	import com.jumpeye.transitions.*;
	import com.jumpeye.transitions.utils.tween.*;

	public class TweenPlugin extends Object
	{
		public static const VERSION:Number = 1.03;
		public static const API:Number = 1;
		public var overwriteProps:Array;
		protected var _tweens:Array;
		public var propName:String;
		public var onComplete:Function;
		public var round:Boolean;
		protected var _changeFactor:Number = 0;

		final public static function activate(param1:Array) : Boolean
		{
			var _loc_2:int = 0;
			var _loc_3:Object = null;
			_loc_2 = param1.length - 1;
			while(_loc_2 > -1)
			{
				_loc_3 = ();
				TweenLite.plugins[_loc_3.propName] = param1[_loc_2];
				_loc_2 = _loc_2 - 1;
			}
			return true;
		}

		public function TweenPlugin()
		{
			_tweens = [];
			super();
		}

		protected function updateTweens(param1:Number) : void
		{
			var _loc_2:int = 0;
			var _loc_3:TweenInfo = null;
			var _loc_4:int = NaN;
			var _loc_5:int = 0;
			if(this.round)
			{
				_loc_2 = _tweens.length - 1;
				while(_loc_2 > -1)
				{
					_loc_3 = _tweens[_loc_2];
					_loc_4 = _loc_3.start + (_loc_3.change * param1);
					_loc_5 = _loc_4 < 0 ? -1 : 1;
					_loc_3.target[_loc_3.property] = (_loc_4 % 1) * _loc_5 > 0.50 ? int(_loc_4) + _loc_5 : int(_loc_4);
					_loc_2 = _loc_2 - 1;
				}
			}
			else
			{
				_loc_2 = _tweens.length - 1;
				while(_loc_2 > -1)
				{
					_loc_3 = _tweens[_loc_2];
					_loc_3.target[_loc_3.property] = _loc_3.start + (_loc_3.change * param1);
					_loc_2 = _loc_2 - 1;
				}
			}
		}

		public function set changeFactor(param1:Number) : void
		{
			updateTweens(param1);
			_changeFactor = param1;
		}

		protected function addTween(param1:Object, param2:String, param3:Number, param4:*, param5:String = null) : void
		{
			var _loc_6:int = NaN;
			if(param4 != null)
			{
				_loc_6 = typeof(param4) == "number" ? param4 - param3 : Number(param4);
				if(_loc_6 != 0)
				{
					_tweens[_tweens.length] = param5 || new TweenInfo(param1, param2, param3, _loc_6, param2, false);
				}
			}
		}

		public function killProps(param1:Object) : void
		{
			var _loc_2:int = 0;
			_loc_2 = this.overwriteProps.length - 1;
			while(_loc_2 > -1)
			{
				if(this.overwriteProps[_loc_2] in param1)
				{
					this.overwriteProps.splice(_loc_2, 1);
				}
				_loc_2 = _loc_2 - 1;
			}
			_loc_2 = _tweens.length - 1;
			while(_loc_2 > -1)
			{
				if(_tweens[_loc_2].name in param1)
				{
					_tweens.splice(_loc_2, 1);
				}
				_loc_2 = _loc_2 - 1;
			}
		}

		public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
		{
			addTween(param1, this.propName, param1[this.propName], param2, this.propName);
			return true;
		}

		public function get changeFactor() : Number
		{
			return _changeFactor;
		}
	}
}
