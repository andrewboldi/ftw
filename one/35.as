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
package com.jumpeye.flashEff2.core.interfaces
{
	import flash.display.*;

	public class IFlashEffCommand extends IFlashEffPattern
	{
		protected var _target:DisplayObject;
		private var _commandEventType:String;

		public function IFlashEffCommand()
		{
			super();
		}

		public function get target() : DisplayObject
		{
			return _target;
		}

		public function set target(param1:DisplayObject) : void
		{
			_target = param1;
		}

		public function get commandEventType() : String
		{
			return this._commandEventType;
		}

		public function set commandEventType(param1:String) : void
		{
			_commandEventType = param1;
		}

		public function run() : void
		{
		}
	}
}
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
package com.jumpeye.flashEff2.core.interfaces
{
	import flash.display.*;

	public class IFlashEffSymbol extends IFlashEffSymbolText
	{
		protected var _target:DisplayObject;

		public function IFlashEffSymbol()
		{
			super();
		}

		public function get target() : DisplayObject
		{
			return _target;
		}

		public function set target(param1:DisplayObject) : void
		{
			_target = param1;
		}
	}
}
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
package com.jumpeye.flashEff2.core.interfaces
{
	import flash.text.*;

	public class IFlashEffText extends IFlashEffSymbolText
	{
		protected var _partialBlurAmount:Number = 0;
		protected var _partialStart:Number = 50;
		protected var _partialGroup:String = "letters";
		protected var _partialPercent:Number = -28;
		protected var _selectedStrings:Array;
		protected var _target:TextField;

		public function IFlashEffText()
		{
			super();
		}

		public function get partialPercent() : Number
		{
			return this._partialPercent;
		}

		public function get partialBlurAmount() : Number
		{
			return this._partialBlurAmount;
		}

		public function set partialPercent(param1:Number) : void
		{
			if(param1 < 0)
			{
				param1 = 0;
			}
			else
			{
				if(param1 > 100)
				{
					param1 = 100;
				}
			}
			this._partialPercent = param1;
		}

		public function set partialStart(param1:Number) : void
		{
			if(param1 < 0)
			{
				param1 = 0;
			}
			else
			{
				if(param1 > 100)
				{
					param1 = 100;
				}
			}
			this._partialStart = param1;
		}

		public function set selectedStrings(param1:Array) : void
		{
			this._selectedStrings = param1;
		}

		public function get target() : TextField
		{
			return this._target;
		}

		public function set partialBlurAmount(param1:Number) : void
		{
			if(param1 < 0)
			{
				param1 = 0;
			}
			this._partialBlurAmount = param1;
		}

		public function get partialStart() : Number
		{
			return this._partialStart;
		}

		public function set target(param1:TextField) : void
		{
			this._target = param1;
		}

		public function get selectedStrings() : Array
		{
			return this._selectedStrings;
		}

		public function set partialGroup(param1:String) : void
		{
			this._partialGroup = param1;
		}

		public function get partialGroup() : String
		{
			return this._partialGroup;
		}
	}
}
