package com.jumpeye.flashEff2.core.interfaces
{
	import com.jumpeye.core.*;
	import flash.display.*;

	public class IFlashEffPattern extends Sprite
	{
		protected var _component:JUIComponent;

		public function IFlashEffPattern()
		{
			super();
			if(this.numChildren > 0)
			{
				removeChildAt(0);
			}
			var _loc_1:int = 0;
			scaleY = _loc_1;
			scaleX = _loc_1;
			visible = false;
		}

		public function set component(param1:JUIComponent) : void
		{
			this._component = param1;
		}

		public function get component() : JUIComponent
		{
			return this._component;
		}
	}
}
