package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D8 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.height;
			return param2 - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3204;
		}

		public function JFETP3D8()
		{
			super();
		}
	}
}
