package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D5 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = textOwnerClip.width / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			var _loc_8:Number = propOwner.teorecticSpace;
			return -(Math.sqrt((_loc_8 * _loc_8) - (_loc_6 * _loc_6)));
			propOwner.getZPosition = _func_3259;
		}

		public function JFETP3D5()
		{
			super();
		}
	}
}
