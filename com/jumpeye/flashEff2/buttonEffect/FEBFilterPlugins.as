package com.jumpeye.flashEff2.buttonEffect
{
	import com.jumpeye.transitions.plugins.*;
	import flash.display.*;

	public class FEBFilterPlugins extends Sprite
	{
		public function FEBFilterPlugins()
		{
			super();
			TweenPlugin.activate([BlurFilterPlugin, BevelFilterPlugin, GlowFilterPlugin, DropShadowFilterPlugin]);
		}
	}
}
