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
