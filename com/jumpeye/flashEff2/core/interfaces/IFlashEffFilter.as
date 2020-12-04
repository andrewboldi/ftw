package com.jumpeye.flashEff2.core.interfaces
{
	import flash.display.*;

	public class IFlashEffFilter extends IFlashEffPattern
	{
		protected var _target:Sprite;

		public function IFlashEffFilter()
		{
			super();
		}

		public function get target() : Sprite
		{
			return _target;
		}

		public function set target(param1:Sprite) : void
		{
			_target = param1;
		}

		public function remove() : void
		{
		}

		public function apply() : void
		{
		}
	}
}
