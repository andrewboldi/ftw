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
