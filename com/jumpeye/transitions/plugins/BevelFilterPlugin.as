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
