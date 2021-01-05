package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D12 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width + textOwnerClip.height;
			return -(textOwnerClip.height - param2) + param1;
			propOwner.getZPosition = _func_3117;
		}

		public function JFETP3D12()
		{
			super();
		}
	}
}
