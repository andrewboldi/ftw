package com.jumpeye.flashEff2.buttonEffect
{
	import com.jumpeye.transitions.plugins.*;
	import flash.display.*;

	public class FEBColorMatrixFilterPlugin extends Sprite
	{
		public function FEBColorMatrixFilterPlugin()
		{
			super();
			TweenPlugin.activate([ColorMatrixFilterPlugin]);
		}
	}
}
