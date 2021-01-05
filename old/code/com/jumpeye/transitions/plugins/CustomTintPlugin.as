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
