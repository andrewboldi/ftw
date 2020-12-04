package com.jumpeye.flashEff2.presets
{
	import flash.display.*;

	public class JFETP3D3 extends Sprite
	{
		final public static function fep(param1:Object, param2:Sprite) : void
		{
			var propOwner:Object = param1;
			var textOwnerClip:Sprite = param2;
			propOwner.teorecticSpace = (Math.sqrt((textOwnerClip.width * textOwnerClip.width) + (textOwnerClip.height * textOwnerClip.height))) / 2;
			var _loc_6:Number = param1 - param3;
			var _loc_7:Number = param2 - param4;
			return (Math.sqrt(Math.abs((propOwner.teorecticSpace * propOwner.teorecticSpace) - (_loc_6 * _loc_6) - (_loc_7 * _loc_7)))) - propOwner.teorecticSpace;
			propOwner.getZPosition = _func_3249;
		}

		public function JFETP3D3()
		{
			super();
		}
	}
}
