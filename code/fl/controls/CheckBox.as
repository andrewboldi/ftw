package fl.controls
{
	import flash.display.*;

	public class CheckBox extends LabelButton
	{
		private static var defaultStyles:Object = {icon:null, upIcon:"CheckBox_upIcon", downIcon:"CheckBox_downIcon", overIcon:"CheckBox_overIcon", disabledIcon:"CheckBox_disabledIcon", selectedDisabledIcon:"CheckBox_selectedDisabledIcon", focusRectSkin:null, focusRectPadding:null, selectedUpIcon:"CheckBox_selectedUpIcon", selectedDownIcon:"CheckBox_selectedDownIcon", selectedOverIcon:"CheckBox_selectedOverIcon", textFormat:null, disabledTextFormat:null, embedFonts:null, textPadding:5};
		public static var createAccessibilityImplementation:Function;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function CheckBox()
		{
			super();
		}

		override public function drawFocus(param1:Boolean) : void
		{
			var _loc_2:int = NaN;
			super.drawFocus(param1);
			if(param1)
			{
				_loc_2 = Number(getStyleValue("focusRectPadding"));
				uiFocusRect.x = background.x - _loc_2;
				uiFocusRect.y = background.y - _loc_2;
				uiFocusRect.width = background.width + (_loc_2 << 1);
				uiFocusRect.height = background.height + (_loc_2 << 1);
			}
		}

		override public function get autoRepeat() : Boolean
		{
			return false;
		}

		override public function set autoRepeat(param1:Boolean) : void
		{
		}

		override public function set toggle(param1:Boolean) : void
		{
			throw new Error("Warning: You cannot change a CheckBox's toggle.");
		}

		override public function get toggle() : Boolean
		{
			return true;
		}

		override protected function configUI() : void
		{
			var _loc_1:Shape = null;
			var _loc_2:Graphics = null;
			super.configUI();
			_loc_1 = new Shape();
			_loc_2 = _loc_1.graphics;
			_loc_2.beginFill(0, 0);
			_loc_2.drawRect(0, 0, 100, 100);
			_loc_2.endFill();
			background = _loc_1;
			addChildAt(background, 0);
		}

		override protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			super.drawLayout();
			_loc_1 = Number(getStyleValue("textPadding"));
			switch(_labelPlacement)
			{
			case ButtonLabelPlacement.RIGHT:
				icon.x = _loc_1;
				textField.x = icon.x + (icon.width + _loc_1);
				background.width = (textField.x + textField.width) + _loc_1;
				background.height = (Math.max(textField.height, icon.height)) + (_loc_1 * 2);
				break;
			case ButtonLabelPlacement.LEFT:
				icon.x = (width - icon.width) - _loc_1;
				textField.x = (width - icon.width) - (_loc_1 * 2) - textField.width;
				background.width = (textField.width + icon.width) + (_loc_1 * 3);
				background.height = (Math.max(textField.height, icon.height)) + (_loc_1 * 2);
				break;
			case ButtonLabelPlacement.TOP:
				background.width = (Math.max(textField.width, icon.width)) + (_loc_1 * 2);
				background.height = (textField.height + icon.height) + (_loc_1 * 3);
				break;
			case ButtonLabelPlacement.BOTTOM:
				background.width = (Math.max(textField.width, icon.width)) + (_loc_1 * 2);
				background.height = (textField.height + icon.height) + (_loc_1 * 3);
				break;
			default:
				break;
			}
			background.x = Math.min(icon.x - _loc_1, textField.x - _loc_1);
			background.y = Math.min(icon.y - _loc_1, textField.y - _loc_1);
		}

		override protected function drawBackground() : void
		{
		}

		override protected function initializeAccessibility() : void
		{
			if(CheckBox.createAccessibilityImplementation != null)
			{
				CheckBox.createAccessibilityImplementation(this);
			}
		}
	}
}
