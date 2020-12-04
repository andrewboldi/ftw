package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D11 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(textOwnerClip.width - param1) + param2;
			propOwner.getZPosition = _func_3112;
		}

		public function JFETP3D11()
		{
			super();
		}
	}
}
