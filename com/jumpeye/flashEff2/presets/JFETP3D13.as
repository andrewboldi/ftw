package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D13 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(propOwner.teorecticSpace + param1) + param2;
			propOwner.getZPosition = _func_3155;
		}

		public function JFETP3D13()
		{
			super();
		}
	}
}
