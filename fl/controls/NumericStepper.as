package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;

	public class NumericStepper extends UIComponent implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {downArrowDisabledSkin:"NumericStepperDownArrow_disabledSkin", downArrowDownSkin:"NumericStepperDownArrow_downSkin", downArrowOverSkin:"NumericStepperDownArrow_overSkin", downArrowUpSkin:"NumericStepperDownArrow_upSkin", upArrowDisabledSkin:"NumericStepperUpArrow_disabledSkin", upArrowDownSkin:"NumericStepperUpArrow_downSkin", upArrowOverSkin:"NumericStepperUpArrow_overSkin", upArrowUpSkin:"NumericStepperUpArrow_upSkin", upSkin:"TextInput_upSkin", disabledSkin:"TextInput_disabledSkin", focusRect:null, focusRectSkin:null, focusRectPadding:null, repeatDelay:500, repeatInterval:35, embedFonts:false};
		public static const DOWN_ARROW_STYLES:Object = {disabledSkin:"downArrowDisabledSkin", downSkin:"downArrowDownSkin", overSkin:"downArrowOverSkin", upSkin:"downArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		public static const TEXT_INPUT_STYLES:Object = {upSkin:"upSkin", disabledSkin:"disabledSkin", textPadding:"textPadding", textFormat:"textFormat", disabledTextFormat:"disabledTextFormat", embedFonts:"embedFonts"};
		public static const UP_ARROW_STYLES:Object = {disabledSkin:"upArrowDisabledSkin", downSkin:"upArrowDownSkin", overSkin:"upArrowOverSkin", upSkin:"upArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		protected var upArrow:BaseButton;
		protected var _stepSize:Number = 1;
		protected var downArrow:BaseButton;
		protected var _value:Number = 1;
		protected var _minimum:Number = 0;
		protected var _maximum:Number = 10;
		protected var _precision:Number;
		protected var inputField:TextInput;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function NumericStepper()
		{
			_maximum = 10;
			_minimum = 0;
			_value = 1;
			_stepSize = 1;
			super();
			setStyles();
			stepSize = _stepSize;
		}

		override public function drawFocus(param1:Boolean) : void
		{
			var _loc_2:int = NaN;
			super.drawFocus(param1);
			if(param1)
			{
				_loc_2 = Number(getStyleValue("focusRectPadding"));
				uiFocusRect.width = width + (_loc_2 * 2);
				uiFocusRect.height = height + (_loc_2 * 2);
			}
		}

		public function get minimum() : Number
		{
			return _minimum;
		}

		public function set imeMode(param1:String) : void
		{
			inputField.imeMode = param1;
		}

		public function set minimum(param1:Number) : void
		{
			_minimum = param1;
			if(_value < _minimum)
			{
				setValue(_minimum, false);
			}
		}

		public function get maximum() : Number
		{
			return _maximum;
		}

		override protected function isOurFocus(param1:DisplayObject) : Boolean
		{
			return super.isOurFocus(param1);
		}

		public function get nextValue() : Number
		{
			var _loc_1:int = NaN;
			_loc_1 = _value + _stepSize;
			return inRange(_loc_1) ? _loc_1 : _value;
		}

		public function set maximum(param1:Number) : void
		{
			_maximum = param1;
			if(_value > _maximum)
			{
				setValue(_maximum, false);
			}
		}

		protected function setValue(param1:Number, param2:Boolean = true) : void
		{
			var _loc_3:int = NaN;
			if(param1 == _value)
			{
				return;
			}
			_loc_3 = _value;
			_value = getValidValue(param1);
			inputField.text = _value.toString();
			if(param2)
			{
				dispatchEvent(new Event(Event.CHANGE, true));
			}
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			var _loc_2:int = NaN;
			if(!enabled)
			{
				return;
			}
			param1.stopImmediatePropagation();
			_loc_2 = Number(inputField.text);
			switch(param1.keyCode)
			{
			case Keyboard.END:
				setValue(maximum);
				break;
			case Keyboard.HOME:
				setValue(minimum);
				break;
			case Keyboard.UP:
				setValue(nextValue);
				break;
			case Keyboard.DOWN:
				setValue(previousValue);
				break;
			case Keyboard.ENTER:
				setValue(_loc_2);
				break;
			default:
				break;
			}
		}

		override public function set enabled(param1:Boolean) : void
		{
			if(param1 == enabled)
			{
				return;
			}
			var _loc_2:Boolean = param1;
			inputField.enabled = _loc_2;
			var _loc_2:Boolean = _loc_2;
			downArrow.enabled = _loc_2;
			upArrow.enabled = _loc_2;
		}

		protected function onTextChange(param1:Event) : void
		{
			param1.stopImmediatePropagation();
		}

		public function get previousValue() : Number
		{
			var _loc_1:int = NaN;
			_loc_1 = _value - _stepSize;
			return inRange(_loc_1) ? _loc_1 : _value;
		}

		protected function getValidValue(param1:Number) : Number
		{
			var _loc_2:int = NaN;
			if(isNaN(param1))
			{
				return _value;
			}
			_loc_2 = Number((_stepSize * (Math.round(param1 / _stepSize))).toFixed(_precision));
			if(_loc_2 > maximum)
			{
				return maximum;
			}
			if(_loc_2 < minimum)
			{
				return minimum;
			}
			return _loc_2;
		}

		public function set value(param1:Number) : void
		{
			setValue(param1, false);
		}

		public function get stepSize() : Number
		{
			return _stepSize;
		}

		protected function passEvent(param1:Event) : void
		{
			dispatchEvent(param1);
		}

		public function get imeMode() : String
		{
			return inputField.imeMode;
		}

		protected function stepperPressHandler(param1:ComponentEvent) : void
		{
			setValue(Number(inputField.text), false);
			switch(param1.currentTarget)
			{
			case upArrow:
				setValue(nextValue);
				break;
			case downArrow:
				setValue(previousValue);
				break;
			default:
				break;
			}
			inputField.setFocus();
			inputField.textField.setSelection(0, 0);
		}

		override protected function focusOutHandler(param1:FocusEvent) : void
		{
			if(param1.eventPhase == 3)
			{
				setValue(Number(inputField.text));
			}
			super.focusOutHandler(param1);
		}

		protected function inRange(param1:Number) : Boolean
		{
			return param1 >= _minimum && param1 <= _maximum;
		}

		override public function get enabled() : Boolean
		{
			return super.enabled;
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				setStyles();
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE))
			{
				drawLayout();
			}
			if(isFocused && focusManager.showFocusIndicator)
			{
				drawFocus(true);
			}
			validate();
		}

		override protected function configUI() : void
		{
			super.configUI();
			upArrow = new BaseButton();
			copyStylesToChild(upArrow, UP_ARROW_STYLES);
			upArrow.autoRepeat = true;
			upArrow.setSize(21, 12);
			upArrow.focusEnabled = false;
			addChild(upArrow);
			downArrow = new BaseButton();
			copyStylesToChild(downArrow, DOWN_ARROW_STYLES);
			downArrow.autoRepeat = true;
			downArrow.setSize(21, 12);
			downArrow.focusEnabled = false;
			addChild(downArrow);
			inputField = new TextInput();
			copyStylesToChild(inputField, TEXT_INPUT_STYLES);
			inputField.restrict = "0-9\\-\\.\\,";
			inputField.text = _value.toString();
			inputField.setSize(21, 24);
			inputField.focusTarget = this;
			inputField.focusEnabled = false;
			inputField.addEventListener(FocusEvent.FOCUS_IN, passEvent);
			inputField.addEventListener(FocusEvent.FOCUS_OUT, passEvent);
			addChild(inputField);
			inputField.addEventListener(Event.CHANGE, onTextChange, false, 0, true);
			upArrow.addEventListener(ComponentEvent.BUTTON_DOWN, stepperPressHandler, false, 0, true);
			downArrow.addEventListener(ComponentEvent.BUTTON_DOWN, stepperPressHandler, false, 0, true);
		}

		public function get value() : Number
		{
			return _value;
		}

		protected function inStep(param1:Number) : Boolean
		{
			return (param1 - _minimum) % _stepSize == 0;
		}

		protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			_loc_1 = width - upArrow.width;
			_loc_2 = height / 2;
			inputField.setSize(_loc_1, height);
			upArrow.height = _loc_2;
			downArrow.height = Math.floor(_loc_2);
			downArrow.move(_loc_1, _loc_2);
			upArrow.move(_loc_1, 0);
			downArrow.drawNow();
			upArrow.drawNow();
			inputField.drawNow();
		}

		override public function setFocus() : void
		{
			if(stage)
			{
				stage.focus = inputField.textField;
			}
		}

		protected function getPrecision() : Number
		{
			var _loc_1:String = null;
			_loc_1 = _stepSize.toString();
			if(_loc_1.indexOf(".") == -1)
			{
				return 0;
			}
			return _loc_1.split(".").pop().length;
		}

		public function get textField() : TextInput
		{
			return inputField;
		}

		public function set stepSize(param1:Number) : void
		{
			_stepSize = param1;
			_precision = getPrecision();
			setValue(_value);
		}

		protected function setStyles() : void
		{
			copyStylesToChild(downArrow, DOWN_ARROW_STYLES);
			copyStylesToChild(upArrow, UP_ARROW_STYLES);
			copyStylesToChild(inputField, TEXT_INPUT_STYLES);
		}
	}
}
