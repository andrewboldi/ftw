package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;

	public class LabelButton extends BaseButton implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {icon:null, upIcon:null, downIcon:null, overIcon:null, disabledIcon:null, selectedDisabledIcon:null, selectedUpIcon:null, selectedDownIcon:null, selectedOverIcon:null, textFormat:null, disabledTextFormat:null, textPadding:5, embedFonts:false};
		public static var createAccessibilityImplementation:Function;
		protected var _labelPlacement:String = "right";
		protected var _toggle:Boolean = false;
		protected var icon:DisplayObject;
		protected var oldMouseState:String;
		protected var mode:String = "center";
		public var textField:TextField;
		protected var _label:String = "Label";

		final public static function getStyleDefinition() : Object
		{
			return LabelButton.mergeStyles(defaultStyles, BaseButton.getStyleDefinition());
		}

		public function LabelButton()
		{
			_labelPlacement = ButtonLabelPlacement.RIGHT;
			_toggle = false;
			_label = "Label";
			mode = "center";
			super();
		}

		protected function toggleSelected(param1:MouseEvent) : void
		{
			selected = !selected;
			dispatchEvent(new Event(Event.CHANGE, true));
		}

		public function get labelPlacement() : String
		{
			return _labelPlacement;
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			if(!enabled)
			{
				return;
			}
			if(param1.keyCode == Keyboard.SPACE)
			{
				if(oldMouseState == null)
				{
					oldMouseState = mouseState;
				}
				setMouseState("down");
				startPress();
			}
		}

		protected function setEmbedFont()
		{
			var _loc_1:Object = null;
			_loc_1 = getStyleValue("embedFonts");
			if(_loc_1 != null)
			{
				textField.embedFonts = _loc_1;
			}
		}

		override protected function keyUpHandler(param1:KeyboardEvent) : void
		{
			if(!enabled)
			{
				return;
			}
			if(param1.keyCode == Keyboard.SPACE)
			{
				setMouseState(oldMouseState);
				oldMouseState = null;
				endPress();
				dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
		}

		override public function get selected() : Boolean
		{
			return _toggle ? _selected : false;
		}

		public function set labelPlacement(param1:String) : void
		{
			_labelPlacement = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function set toggle(param1:Boolean) : void
		{
			if(!param1 && super.selected)
			{
				selected = false;
			}
			_toggle = param1;
			if(_toggle)
			{
				addEventListener(MouseEvent.CLICK, toggleSelected, false, 0, true);
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, toggleSelected);
			}
			invalidate(InvalidationType.STATE);
		}

		public function get label() : String
		{
			return _label;
		}

		override public function set selected(param1:Boolean) : void
		{
			_selected = param1;
			if(_toggle)
			{
				invalidate(InvalidationType.STATE);
			}
		}

		override protected function draw() : void
		{
			if(textField.text != _label)
			{
				label = _label;
			}
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				drawBackground();
				drawIcon();
				drawTextFormat();
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE))
			{
				drawLayout();
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
			{
				if(isFocused && focusManager.showFocusIndicator)
				{
					drawFocus(true);
				}
			}
			validate();
		}

		public function get toggle() : Boolean
		{
			return _toggle;
		}

		override protected function configUI() : void
		{
			super.configUI();
			textField = new TextField();
			textField.type = TextFieldType.DYNAMIC;
			textField.selectable = false;
			addChild(textField);
		}

		override protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:String = null;
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			var _loc_6:int = NaN;
			var _loc_7:int = NaN;
			var _loc_8:int = NaN;
			_loc_1 = Number(getStyleValue("textPadding"));
			_loc_2 = icon == null && mode == "center" ? ButtonLabelPlacement.TOP : _labelPlacement;
			textField.height = textField.textHeight + 4;
			_loc_3 = textField.textWidth + 4;
			_loc_4 = textField.textHeight + 4;
			_loc_5 = icon == null ? 0 : icon.width + _loc_1;
			_loc_6 = icon == null ? 0 : icon.height + _loc_1;
			textField.visible = label.length > 0;
			if(icon != null)
			{
				icon.x = Math.round((width - icon.width) / 2);
				icon.y = Math.round((height - icon.height) / 2);
			}
			if(textField.visible == false)
			{
				textField.width = 0;
				textField.height = 0;
			}
			else
			{
				if(_loc_2 == ButtonLabelPlacement.BOTTOM || _loc_2 == ButtonLabelPlacement.TOP)
				{
					_loc_7 = Math.max(0, Math.min(_loc_3, width - (2 * _loc_1)));
					if((height - 2) > _loc_4)
					{
						_loc_8 = _loc_4;
					}
					else
					{
						_loc_8 = height - 2;
					}
					var _loc_9:int = _loc_7;
					_loc_3 = _loc_9;
					textField.width = _loc_9;
					var _loc_9:int = _loc_8;
					_loc_4 = _loc_9;
					textField.height = _loc_9;
					textField.x = Math.round((width - _loc_3) / 2);
					textField.y = Math.round((height - textField.height) - _loc_6 / 2 + (_loc_2 == ButtonLabelPlacement.BOTTOM ? _loc_6 : 0));
					if(icon != null)
					{
						icon.y = Math.round(_loc_2 == ButtonLabelPlacement.BOTTOM ? textField.y - _loc_6 : (textField.y + textField.height) + _loc_1);
					}
				}
				else
				{
					_loc_9 = Math.max(0, Math.min(_loc_3, (width - _loc_5) - (2 * _loc_1)));
					var _loc_9:int = _loc_9;
					_loc_3 = _loc_9;
					textField.width = _loc_9;
					textField.x = Math.round((width - _loc_3) - _loc_5 / 2 + (_loc_2 != ButtonLabelPlacement.LEFT ? _loc_5 : 0));
					textField.y = Math.round((height - textField.height) / 2);
					if(icon != null)
					{
						icon.x = Math.round(_loc_2 != ButtonLabelPlacement.LEFT ? textField.x - _loc_5 : (textField.x + _loc_3) + _loc_1);
					}
				}
			}
			super.drawLayout();
		}

		override protected function initializeAccessibility() : void
		{
			if(LabelButton.createAccessibilityImplementation != null)
			{
				LabelButton.createAccessibilityImplementation(this);
			}
		}

		protected function drawIcon() : void
		{
			var _loc_1:DisplayObject = null;
			var _loc_2:String = null;
			var _loc_3:Object = null;
			_loc_1 = icon;
			_loc_2 = enabled ? mouseState : "disabled";
			if(selected)
			{
				_loc_2 = "selected" + (_loc_2.substr(0, 1)).toUpperCase() + _loc_2.substr(1);
			}
			_loc_2 = _loc_2 + "Icon";
			_loc_3 = getStyleValue(_loc_2);
			if(_loc_3 == null)
			{
				_loc_3 = getStyleValue("icon");
			}
			if(_loc_3 != null)
			{
				icon = getDisplayObjectInstance(_loc_3);
			}
			if(icon != null)
			{
				addChildAt(icon, 1);
			}
			if((_loc_1 == null) && _loc_1 == icon)
			{
				removeChild(_loc_1);
			}
		}

		public function set label(param1:String) : void
		{
			_label = param1;
			if(textField.text != _label)
			{
				textField.text = _label;
				dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
			}
			invalidate(InvalidationType.SIZE);
			invalidate(InvalidationType.STYLES);
		}

		protected function drawTextFormat() : void
		{
			var _loc_1:Object = null;
			var _loc_2:TextFormat = null;
			var _loc_3:TextFormat = null;
			_loc_1 = UIComponent.getStyleDefinition();
			_loc_2 = enabled ? _loc_1.defaultTextFormat : _loc_1.defaultDisabledTextFormat;
			textField.setTextFormat(_loc_2);
			_loc_3 = getStyleValue(enabled ? "textFormat" : "disabledTextFormat");
			if(_loc_3 != null)
			{
				textField.setTextFormat(_loc_3);
			}
			else
			{
				_loc_3 = _loc_2;
			}
			textField.defaultTextFormat = _loc_3;
			setEmbedFont();
		}
	}
}
