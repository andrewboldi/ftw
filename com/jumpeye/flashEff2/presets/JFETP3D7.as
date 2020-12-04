package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D7 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width;
			return param1 - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3177;
		}

		public function JFETP3D7()
		{
			super();
		}
	}
}
