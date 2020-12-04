package com.jumpeye.flashEff2.core.interfaces
{
	import flash.utils.*;

	public class IFlashEffSymbolText extends IFlashEffPattern
	{
		protected var _tweenDuration:Number = 1.700000;
		protected var _easeType:String = "easeInOut";
		protected var _tweenType:String = "Strong";

		public function IFlashEffSymbolText()
		{
			_tweenDuration = 1.70;
			_tweenType = "Strong";
			_easeType = "easeInOut";
			super();
		}

		public function show() : void
		{
		}

		public function get tweenDuration() : Number
		{
			return this._tweenDuration;
		}

		public function set tweenDuration(param1:Number) : void
		{
			if(param1 < 0.00)
			{
				param1 = 0.00;
			}
			this._tweenDuration = param1;
		}

		public function get tweenType() : String
		{
			return this._tweenType;
		}

		public function get easeType() : String
		{
			return this._easeType;
		}

		public function hide() : void
		{
		}

		public function remove() : void
		{
		}

		public function set tweenType(param1:String) : void
		{
			this._tweenType = param1;
		}

		public function set easeType(param1:String) : void
		{
			this._easeType = param1;
		}

		public function get easeFunc() : Function
		{
			var easeFunc:* = undefined;
			try
			{
				easeFunc = getDefinitionByName("com.jumpeye.transitions.easing." + this.tweenType);
				return easeFunc[this.easeType];
			}
			catch(e:ReferenceError)
			{
				throw "FlashEff2 WARNING:  The selected ease function is not in the Library ! Please drag the " + this.tweenType + "Ease from the Components panel over the Library panel.";
				return null;
			}
			return null;
		}
	}
}
