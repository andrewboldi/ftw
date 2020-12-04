package com.jumpeye.flashEff2.core.interfaces
{
	import flash.display.*;
	import flash.utils.*;

	public class IFlashEffButtonEffect extends IFlashEffPattern
	{
		protected var _tweenDuration:Number = 0.300000;
		protected var _tweenType:String = "Linear";
		protected var _target:DisplayObject;
		protected var _easeType:String = "easeOut";

		public function IFlashEffButtonEffect()
		{
			super();
		}

		public function get tweenDuration() : Number
		{
			return this._tweenDuration;
		}

		public function set target(param1:DisplayObject) : void
		{
			this._target = param1;
		}

		public function buttonRollOver() : void
		{
		}

		public function remove() : void
		{
		}

		public function get tweenType() : String
		{
			return this._tweenType;
		}

		public function get easeType() : String
		{
			return this._easeType;
		}

		public function set tweenType(param1:String) : void
		{
			this._tweenType = param1;
		}

		public function apply() : void
		{
		}

		public function buttonPress() : void
		{
		}

		protected function get easeFunc() : Function
		{
			var easeFunc:* = undefined;
			try
			{
				easeFunc = getDefinitionByName("com.jumpeye.transitions.easing." + this._tweenType);
				return easeFunc[this._easeType];
			}
			catch(e:ReferenceError)
			{
				throw "FlashEff2 WARNING: The selected ease function is not in the Library ! Please drag the " + this.tweenType + "Ease from the Components panel over the Library panel.";
				return null;
			}
			return null;
		}

		public function set easeType(param1:String) : void
		{
			this._easeType = param1;
		}

		public function get target() : DisplayObject
		{
			return this._target;
		}

		public function buttonRelease() : void
		{
		}

		public function set tweenDuration(param1:Number) : void
		{
			if(param1 < 0)
			{
				param1 = 0;
			}
			this._tweenDuration = param1;
		}

		public function buttonRollOut() : void
		{
		}
	}
}
