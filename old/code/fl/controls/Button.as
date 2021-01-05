package fl.controls
{
	import fl.core.*;
	import fl.managers.*;
	import flash.display.*;

	public class Button extends LabelButton implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {emphasizedSkin:"Button_emphasizedSkin", emphasizedPadding:2};
		public static var createAccessibilityImplementation:Function;
		protected var emphasizedBorder:DisplayObject;
		protected var _emphasized:Boolean = false;

		final public static function getStyleDefinition() : Object
		{
			return UIComponent.mergeStyles(LabelButton.getStyleDefinition(), defaultStyles);
		}

		public function Button()
		{
			_emphasized = false;
			super();
		}

		override public function drawFocus(param1:Boolean) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:* = undefined;
			super.drawFocus(param1);
			if(param1)
			{
				_loc_2 = Number(getStyleValue("emphasizedPadding"));
				if(_loc_2 < 0 || !_emphasized)
				{
					_loc_2 = 0;
				}
				_loc_3 = getStyleValue("focusRectPadding");
				_loc_3 = _loc_3 == null ? 2 : _loc_3;
				_loc_3 = _loc_3 + _loc_2;
				uiFocusRect.x = -_loc_3;
				uiFocusRect.y = -_loc_3;
				uiFocusRect.width = width + (_loc_3 * 2);
				uiFocusRect.height = height + (_loc_3 * 2);
			}
		}

		public function set emphasized(param1:Boolean) : void
		{
			_emphasized = param1;
			invalidate(InvalidationType.STYLES);
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STYLES) || isInvalid(InvalidationType.SIZE))
			{
				drawEmphasized();
			}
			super.draw();
			if(emphasizedBorder != null)
			{
				setChildIndex(emphasizedBorder, numChildren - 1);
			}
		}

		public function get emphasized() : Boolean
		{
			return _emphasized;
		}

		override protected function initializeAccessibility() : void
		{
			if(Button.createAccessibilityImplementation != null)
			{
				Button.createAccessibilityImplementation(this);
			}
		}

		protected function drawEmphasized() : void
		{
			var _loc_1:Object = null;
			var _loc_2:int = NaN;
			if(emphasizedBorder != null)
			{
				removeChild(emphasizedBorder);
			}
			emphasizedBorder = null;
			if(!_emphasized)
			{
				return;
			}
			_loc_1 = getStyleValue("emphasizedSkin");
			if(_loc_1 != null)
			{
				emphasizedBorder = getDisplayObjectInstance(_loc_1);
			}
			if(emphasizedBorder != null)
			{
				addChildAt(emphasizedBorder, 0);
				_loc_2 = Number(getStyleValue("emphasizedPadding"));
				var _loc_3:int = -_loc_2;
				emphasizedBorder.y = _loc_3;
				emphasizedBorder.x = _loc_3;
				emphasizedBorder.width = width + (_loc_2 * 2);
				emphasizedBorder.height = height + (_loc_2 * 2);
			}
		}
	}
}
