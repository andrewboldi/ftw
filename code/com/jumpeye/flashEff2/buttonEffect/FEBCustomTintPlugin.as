package com.jumpeye.flashEff2.buttonEffect
{
	import com.jumpeye.transitions.plugins.*;
	import flash.display.*;

	public class FEBCustomTintPlugin extends Sprite
	{
		public function FEBCustomTintPlugin()
		{
			super();
			TweenPlugin.activate([CustomTintPlugin]);
		}
	}
}
