package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;

	public class TextInput extends UIComponent implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {upSkin:"TextInput_upSkin", disabledSkin:"TextInput_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:0, embedFonts:false};
		public static var createAccessibilityImplementation:Function;
		protected var _html:Boolean = false;
		protected var _savedHTML:String;
		protected var background:DisplayObject;
		protected var _editable:Boolean = true;
		public var textField:TextField;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function TextInput()
		{
			_editable = true;
			_html = false;
			super();
		}

		override public function drawFocus(param1:Boolean) : void
		{
			if(focusTarget != null)
			{
				focusTarget.drawFocus(param1);
				return;
			}
			super.drawFocus(param1);
		}

		public function set imeMode(param1:String) : void
		{
			_imeMode = param1;
		}

		override protected function isOurFocus(param1:DisplayObject) : Boolean
		{
			return super.isOurFocus(param1);
		}

		protected function handleKeyDown(param1:KeyboardEvent) : void
		{
			if(param1.keyCode == Keyboard.ENTER)
			{
				dispatchEvent(new ComponentEvent(ComponentEvent.ENTER, true));
			}
		}

		public function set text(param1:String) : void
		{
			textField.text = param1;
			_html = false;
			invalidate(InvalidationType.DATA);
			invalidate(InvalidationType.STYLES);
		}

		protected function updateTextFieldType() : void
		{
			textField.type = enabled && editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			textField.selectable = enabled;
		}

		public function get selectionEndIndex() : int
		{
			return textField.selectionEndIndex;
		}

		public function get editable() : Boolean
		{
			return _editable;
		}

		override protected function focusInHandler(param1:FocusEvent) : void
		{
			var _loc_2:IFocusManager = null;
			if(param1.target == this)
			{
				stage.focus = textField;
			}
			_loc_2 = focusManager;
			if(editable && _loc_2)
			{
				_loc_2.showFocusIndicator = true;
				textField.selectable;
				if(textField.selectable && textField.selectionBeginIndex == textField.selectionBeginIndex)
				{
					setSelection(0, textField.length);
				}
			}
			super.focusInHandler(param1);
			if(editable)
			{
				setIMEMode(true);
			}
		}

		public function get selectionBeginIndex() : int
		{
			return textField.selectionBeginIndex;
		}

		public function set alwaysShowSelection(param1:Boolean) : void
		{
			textField.alwaysShowSelection = param1;
		}

		override public function set enabled(param1:Boolean) : void
		{
			updateTextFieldType();
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

		public function get horizontalScrollPosition() : int
		{
			return textField.scrollH;
		}

		public function set condenseWhite(param1:Boolean) : void
		{
			textField.condenseWhite = param1;
		}

		public function set displayAsPassword(param1:Boolean) : void
		{
			textField.displayAsPassword = param1;
		}

		public function set horizontalScrollPosition(param1:int) : void
		{
			textField.scrollH = param1;
		}

		public function get restrict() : String
		{
			return textField.restrict;
		}

		public function get textWidth() : Number
		{
			return textField.textWidth;
		}

		public function get textHeight() : Number
		{
			return textField.textHeight;
		}

		public function set editable(param1:Boolean) : void
		{
			_editable = param1;
			updateTextFieldType();
		}

		public function get maxChars() : int
		{
			return textField.maxChars;
		}

		public function get length() : int
		{
			return textField.length;
		}

		public function getLineMetrics(param1:int) : TextLineMetrics
		{
			return textField.getLineMetrics(param1);
		}

		public function get imeMode() : String
		{
			return _imeMode;
		}

		override protected function focusOutHandler(param1:FocusEvent) : void
		{
			super.focusOutHandler(param1);
			if(editable)
			{
				setIMEMode(false);
			}
		}

		public function set htmlText(param1:String) : void
		{
			if(param1 == "")
			{
				text = "";
				return;
			}
			_html = true;
			_savedHTML = param1;
			textField.htmlText = param1;
			invalidate(InvalidationType.DATA);
			invalidate(InvalidationType.STYLES);
		}

		public function get text() : String
		{
			return textField.text;
		}

		override public function get enabled() : Boolean
		{
			return super.enabled;
		}

		public function get condenseWhite() : Boolean
		{
			return textField.condenseWhite;
		}

		public function get alwaysShowSelection() : Boolean
		{
			return textField.alwaysShowSelection;
		}

		override protected function draw() : void
		{
			var _loc_1:Object = null;
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				drawTextFormat();
				drawBackground();
				_loc_1 = getStyleValue("embedFonts");
				if(_loc_1 != null)
				{
					textField.embedFonts = _loc_1;
				}
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE))
			{
				drawLayout();
			}
			super.draw();
		}

		protected function handleTextInput(param1:TextEvent) : void
		{
			param1.stopPropagation();
			dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT, true, false, param1.text));
		}

		override protected function configUI() : void
		{
			super.configUI();
			tabChildren = true;
			textField = new TextField();
			addChild(textField);
			updateTextFieldType();
			textField.addEventListener(TextEvent.TEXT_INPUT, handleTextInput, false, 0, true);
			textField.addEventListener(Event.CHANGE, handleChange, false, 0, true);
			textField.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
		}

		public function setSelection(param1:int, param2:int) : void
		{
			textField.setSelection(param1, param2);
		}

		public function get displayAsPassword() : Boolean
		{
			return textField.displayAsPassword;
		}

		public function appendText(param1:String) : void
		{
			textField.appendText(param1);
		}

		public function set restrict(param1:String) : void
		{
			if(componentInspectorSetting && param1 == "")
			{
				param1 = null;
			}
			textField.restrict = param1;
		}

		public function get htmlText() : String
		{
			return textField.htmlText;
		}

		protected function drawBackground() : void
		{
			var _loc_1:DisplayObject = null;
			var _loc_2:String = null;
			_loc_1 = background;
			_loc_2 = enabled ? "upSkin" : "disabledSkin";
			background = getDisplayObjectInstance(getStyleValue(_loc_2));
			if(background == null)
			{
				return;
			}
			addChildAt(background, 0);
			if((_loc_1 == null) && _loc_1 == background && contains(_loc_1))
			{
				removeChild(_loc_1);
			}
		}

		override public function setFocus() : void
		{
			stage.focus = textField;
		}

		protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			_loc_1 = Number(getStyleValue("textPadding"));
			if(background != null)
			{
				background.width = width;
				background.height = height;
			}
			textField.width = width - (2 * _loc_1);
			textField.height = height - (2 * _loc_1);
			var _loc_2:int = _loc_1;
			textField.y = _loc_2;
			textField.x = _loc_2;
		}

		public function set maxChars(param1:int) : void
		{
			textField.maxChars = param1;
		}

		public function get maxHorizontalScrollPosition() : int
		{
			return textField.maxScrollH;
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
			if(_html)
			{
				textField.htmlText = _savedHTML;
			}
		}

		protected function handleChange(param1:Event) : void
		{
			param1.stopPropagation();
			dispatchEvent(new Event(Event.CHANGE, true));
		}
	}
}
