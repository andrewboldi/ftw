package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;

	public class TextArea extends UIComponent implements IFocusManagerComponent
	{
		public static const SCROLL_BAR_STYLES:Object = {downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		private static var defaultStyles:Object = {upSkin:"TextArea_upSkin", disabledSkin:"TextArea_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:3, embedFonts:false};
		public static var createAccessibilityImplementation:Function;
		protected var _html:Boolean = false;
		protected var _verticalScrollBar:UIScrollBar;
		protected var _savedHTML:String;
		protected var background:DisplayObject;
		protected var _horizontalScrollBar:UIScrollBar;
		protected var _horizontalScrollPolicy:String = "auto";
		protected var _editable:Boolean = true;
		protected var textHasChanged:Boolean = false;
		public var textField:TextField;
		protected var _wordWrap:Boolean = true;
		protected var _verticalScrollPolicy:String = "auto";

		final public static function getStyleDefinition() : Object
		{
			return UIComponent.mergeStyles(defaultStyles, ScrollBar.getStyleDefinition());
		}

		public function TextArea()
		{
			_editable = true;
			_wordWrap = true;
			_horizontalScrollPolicy = ScrollPolicy.AUTO;
			_verticalScrollPolicy = ScrollPolicy.AUTO;
			_html = false;
			textHasChanged = false;
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

		protected function handleWheel(param1:MouseEvent) : void
		{
			if(!enabled || !_verticalScrollBar.visible)
			{
				return;
			}
			_verticalScrollBar.scrollPosition = _verticalScrollBar.scrollPosition - (param1.delta * _verticalScrollBar.lineScrollSize);
			dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, param1.delta * _verticalScrollBar.lineScrollSize, _verticalScrollBar.scrollPosition));
		}

		public function get verticalScrollPosition() : Number
		{
			return textField.scrollV;
		}

		override protected function isOurFocus(param1:DisplayObject) : Boolean
		{
			return super.isOurFocus(param1);
		}

		public function set verticalScrollPosition(param1:Number) : void
		{
			drawNow();
			textField.scrollV = param1;
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
			if(componentInspectorSetting && param1 == "")
			{
				return;
			}
			textField.text = param1;
			_html = false;
			invalidate(InvalidationType.DATA);
			invalidate(InvalidationType.STYLES);
			textHasChanged = true;
		}

		protected function updateTextFieldType() : void
		{
			textField.type = enabled && _editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			textField.selectable = enabled;
			textField.wordWrap = _wordWrap;
			textField.multiline = true;
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
			setIMEMode(true);
			if(param1.target == this)
			{
				stage.focus = textField;
			}
			_loc_2 = focusManager;
			if(_loc_2)
			{
				if(editable)
				{
					_loc_2.showFocusIndicator = true;
				}
				_loc_2.defaultButtonEnabled = false;
			}
			super.focusInHandler(param1);
			if(editable)
			{
				setIMEMode(true);
			}
		}

		public function get wordWrap() : Boolean
		{
			return _wordWrap;
		}

		public function get selectionBeginIndex() : int
		{
			return textField.selectionBeginIndex;
		}

		public function get horizontalScrollBar() : UIScrollBar
		{
			return _horizontalScrollBar;
		}

		public function set alwaysShowSelection(param1:Boolean) : void
		{
			textField.alwaysShowSelection = param1;
		}

		override public function set enabled(param1:Boolean) : void
		{
			mouseChildren = enabled;
			invalidate(InvalidationType.STATE);
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

		public function get horizontalScrollPosition() : Number
		{
			return textField.scrollH;
		}

		public function set condenseWhite(param1:Boolean) : void
		{
			textField.condenseWhite = param1;
			invalidate(InvalidationType.DATA);
		}

		public function get horizontalScrollPolicy() : String
		{
			return _horizontalScrollPolicy;
		}

		public function set displayAsPassword(param1:Boolean) : void
		{
			textField.displayAsPassword = param1;
		}

		public function get maxVerticalScrollPosition() : int
		{
			return textField.maxScrollV;
		}

		public function set horizontalScrollPosition(param1:Number) : void
		{
			drawNow();
			textField.scrollH = param1;
		}

		public function get textHeight() : Number
		{
			drawNow();
			return textField.textHeight;
		}

		public function get textWidth() : Number
		{
			drawNow();
			return textField.textWidth;
		}

		public function get restrict() : String
		{
			return textField.restrict;
		}

		public function set editable(param1:Boolean) : void
		{
			_editable = param1;
			invalidate(InvalidationType.STATE);
		}

		protected function updateScrollBars()
		{
			_horizontalScrollBar.update();
			_verticalScrollBar.update();
			_verticalScrollBar.enabled = enabled;
			_horizontalScrollBar.enabled = enabled;
			_horizontalScrollBar.drawNow();
			_verticalScrollBar.drawNow();
		}

		public function get maxChars() : int
		{
			return textField.maxChars;
		}

		public function get length() : Number
		{
			return textField.text.length;
		}

		public function set wordWrap(param1:Boolean) : void
		{
			_wordWrap = param1;
			invalidate(InvalidationType.STATE);
		}

		public function get verticalScrollPolicy() : String
		{
			return _verticalScrollPolicy;
		}

		public function getLineMetrics(param1:int) : TextLineMetrics
		{
			return textField.getLineMetrics(param1);
		}

		public function get imeMode() : String
		{
			return IME.conversionMode;
		}

		protected function handleScroll(param1:ScrollEvent) : void
		{
			dispatchEvent(param1);
		}

		override protected function focusOutHandler(param1:FocusEvent) : void
		{
			var _loc_2:IFocusManager = null;
			_loc_2 = focusManager;
			if(_loc_2)
			{
				_loc_2.defaultButtonEnabled = true;
			}
			setSelection(0, 0);
			super.focusOutHandler(param1);
			if(editable)
			{
				setIMEMode(false);
			}
		}

		protected function delayedLayoutUpdate(param1:Event) : void
		{
			if(textHasChanged)
			{
				textHasChanged = false;
				drawLayout();
				return;
			}
			removeEventListener(Event.ENTER_FRAME, delayedLayoutUpdate);
		}

		public function set htmlText(param1:String) : void
		{
			if(componentInspectorSetting && param1 == "")
			{
				return;
			}
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
			textHasChanged = true;
		}

		public function get text() : String
		{
			return textField.text;
		}

		public function get verticalScrollBar() : UIScrollBar
		{
			return _verticalScrollBar;
		}

		override public function get enabled() : Boolean
		{
			return super.enabled;
		}

		public function get condenseWhite() : Boolean
		{
			return textField.condenseWhite;
		}

		public function set horizontalScrollPolicy(param1:String) : void
		{
			_horizontalScrollPolicy = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function get displayAsPassword() : Boolean
		{
			return textField.displayAsPassword;
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STATE))
			{
				updateTextFieldType();
			}
			if(isInvalid(InvalidationType.STYLES))
			{
				setStyles();
				setEmbedFont();
			}
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				drawTextFormat();
				drawBackground();
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.DATA))
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
			_verticalScrollBar = new UIScrollBar();
			_verticalScrollBar.name = "V";
			_verticalScrollBar.visible = false;
			_verticalScrollBar.focusEnabled = false;
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			_verticalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
			addChild(_verticalScrollBar);
			_horizontalScrollBar = new UIScrollBar();
			_horizontalScrollBar.name = "H";
			_horizontalScrollBar.visible = false;
			_horizontalScrollBar.focusEnabled = false;
			_horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
			_horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
			addChild(_horizontalScrollBar);
			textField.addEventListener(TextEvent.TEXT_INPUT, handleTextInput, false, 0, true);
			textField.addEventListener(Event.CHANGE, handleChange, false, 0, true);
			textField.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
			_horizontalScrollBar.scrollTarget = textField;
			_verticalScrollBar.scrollTarget = textField;
			addEventListener(MouseEvent.MOUSE_WHEEL, handleWheel, false, 0, true);
		}

		protected function setTextSize(param1:Number, param2:Number, param3:Number) : void
		{
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			_loc_4 = param1 - (param3 * 2);
			_loc_5 = param2 - (param3 * 2);
			if(_loc_4 != textField.width)
			{
				textField.width = _loc_4;
			}
			if(_loc_5 != textField.height)
			{
				textField.height = _loc_5;
			}
		}

		public function appendText(param1:String) : void
		{
			textField.appendText(param1);
			invalidate(InvalidationType.DATA);
		}

		protected function needVScroll() : Boolean
		{
			if(_verticalScrollPolicy == ScrollPolicy.OFF)
			{
				return false;
			}
			if(_verticalScrollPolicy == ScrollPolicy.ON)
			{
				return true;
			}
			return textField.maxScrollV > 1;
		}

		public function setSelection(param1:int, param2:int) : void
		{
			textField.setSelection(param1, param2);
		}

		public function get alwaysShowSelection() : Boolean
		{
			return textField.alwaysShowSelection;
		}

		public function get htmlText() : String
		{
			return textField.htmlText;
		}

		public function set restrict(param1:String) : void
		{
			if(componentInspectorSetting && param1 == "")
			{
				param1 = null;
			}
			textField.restrict = param1;
		}

		protected function drawBackground() : void
		{
			var _loc_1:DisplayObject = null;
			var _loc_2:String = null;
			_loc_1 = background;
			_loc_2 = enabled ? "upSkin" : "disabledSkin";
			background = getDisplayObjectInstance(getStyleValue(_loc_2));
			if(background != null)
			{
				addChildAt(background, 0);
			}
			if((_loc_1 == null) && _loc_1 == background && contains(_loc_1))
			{
				removeChild(_loc_1);
			}
		}

		public function set maxChars(param1:int) : void
		{
			textField.maxChars = param1;
		}

		public function get maxHorizontalScrollPosition() : int
		{
			return textField.maxScrollH;
		}

		protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:Boolean = false;
			var _loc_4:int = NaN;
			var _loc_5:Boolean = false;
			_loc_1 = Number(getStyleValue("textPadding"));
			var _loc_6:int = _loc_1;
			textField.y = _loc_6;
			textField.x = _loc_6;
			background.width = width;
			background.height = height;
			_loc_2 = height;
			_loc_3 = needVScroll();
			_loc_4 = width - 0;
			_loc_5 = needHScroll();
			if(_loc_5)
			{
				_loc_2 = _loc_2 - _horizontalScrollBar.height;
			}
			setTextSize(_loc_4, _loc_2, _loc_6);
			_verticalScrollBar.visible = false;
			_horizontalScrollBar.visible = false;
			updateScrollBars();
			addEventListener(Event.ENTER_FRAME, delayedLayoutUpdate, false, 0, true);
		}

		protected function setStyles() : void
		{
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
		}

		protected function needHScroll() : Boolean
		{
			if(_horizontalScrollPolicy == ScrollPolicy.OFF)
			{
				return false;
			}
			if(_horizontalScrollPolicy == ScrollPolicy.ON)
			{
				return true;
			}
			return textField.maxScrollH > 0;
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

		public function set verticalScrollPolicy(param1:String) : void
		{
			_verticalScrollPolicy = param1;
			invalidate(InvalidationType.SIZE);
		}

		protected function handleChange(param1:Event) : void
		{
			param1.stopPropagation();
			dispatchEvent(new Event(Event.CHANGE, true));
			invalidate(InvalidationType.DATA);
		}
	}
}
