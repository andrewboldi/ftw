package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D10 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -param1 - param2;
			propOwner.getZPosition = _func_3122;
		}

		public function JFETP3D10()
		{
			super();
		}
	}
}
