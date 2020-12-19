package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class BaseButton extends UIComponent
	{
		private static var defaultStyles:Object = {upSkin:"Button_upSkin", downSkin:"Button_downSkin", overSkin:"Button_overSkin", disabledSkin:"Button_disabledSkin", selectedDisabledSkin:"Button_selectedDisabledSkin", selectedUpSkin:"Button_selectedUpSkin", selectedDownSkin:"Button_selectedDownSkin", selectedOverSkin:"Button_selectedOverSkin", focusRectSkin:null, focusRectPadding:null, repeatDelay:500, repeatInterval:35};
		protected var _selected:Boolean = false;
		private var unlockedMouseState:String;
		protected var pressTimer:Timer;
		protected var mouseState:String;
		protected var background:DisplayObject;
		private var _mouseStateLocked:Boolean = false;
		protected var _autoRepeat:Boolean = false;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function BaseButton()
		{
			_selected = false;
			_autoRepeat = false;
			_mouseStateLocked = false;
			super();
			buttonMode = true;
			mouseChildren = false;
			useHandCursor = false;
			setupMouseEvents();
			setMouseState("up");
			pressTimer = new Timer(1, 0);
			pressTimer.addEventListener(TimerEvent.TIMER, buttonDown, false, 0, true);
		}

		protected function endPress() : void
		{
			pressTimer.reset();
		}

		public function set mouseStateLocked(param1:Boolean) : void
		{
			_mouseStateLocked = param1;
			if(param1 == false)
			{
				setMouseState(unlockedMouseState);
			}
			else
			{
				unlockedMouseState = mouseState;
			}
		}

		public function get autoRepeat() : Boolean
		{
			return _autoRepeat;
		}

		public function set autoRepeat(param1:Boolean) : void
		{
			_autoRepeat = param1;
		}

		override public function set enabled(param1:Boolean) : void
		{
			mouseEnabled = param1;
		}

		public function get selected() : Boolean
		{
			return _selected;
		}

		protected function mouseEventHandler(param1:MouseEvent) : void
		{
			if(param1.type == MouseEvent.MOUSE_DOWN)
			{
				setMouseState("down");
				startPress();
			}
			else
			{
				if(param1.type == MouseEvent.ROLL_OVER || param1.type == MouseEvent.MOUSE_UP)
				{
					setMouseState("over");
					endPress();
				}
				else
				{
					if(param1.type == MouseEvent.ROLL_OUT)
					{
						setMouseState("up");
						endPress();
					}
				}
			}
		}

		public function setMouseState(param1:String) : void
		{
			if(_mouseStateLocked)
			{
				unlockedMouseState = param1;
				return;
			}
			if(mouseState == param1)
			{
				return;
			}
			mouseState = param1;
			invalidate(InvalidationType.STATE);
		}

		protected function startPress() : void
		{
			if(_autoRepeat)
			{
				pressTimer.delay = Number(getStyleValue("repeatDelay"));
				pressTimer.start();
			}
			dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
		}

		protected function buttonDown(param1:TimerEvent) : void
		{
			if(!_autoRepeat)
			{
				endPress();
				return;
			}
			if(pressTimer.currentCount == 1)
			{
				pressTimer.delay = Number(getStyleValue("repeatInterval"));
			}
			dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
		}

		public function set selected(param1:Boolean) : void
		{
			if(_selected == param1)
			{
				return;
			}
			_selected = param1;
			invalidate(InvalidationType.STATE);
		}

		override public function get enabled() : Boolean
		{
			return super.enabled;
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				drawBackground();
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE))
			{
				drawLayout();
			}
			super.draw();
		}

		protected function setupMouseEvents() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler, false, 0, true);
		}

		protected function drawLayout() : void
		{
			background.width = width;
			background.height = height;
		}

		protected function drawBackground() : void
		{
			var _loc_1:String = null;
			var _loc_2:DisplayObject = null;
			_loc_1 = enabled ? mouseState : "disabled";
			if(selected)
			{
				_loc_1 = "selected" + (_loc_1.substr(0, 1)).toUpperCase() + _loc_1.substr(1);
			}
			_loc_1 = _loc_1 + "Skin";
			_loc_2 = background;
			background = getDisplayObjectInstance(getStyleValue(_loc_1));
			addChildAt(background, 0);
			if((_loc_2 == null) && _loc_2 == background)
			{
				removeChild(_loc_2);
			}
		}
	}
}
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
package fl.controls
{
	public class ButtonLabelPlacement extends Object
	{
		public static const TOP:String = "top";
		public static const LEFT:String = "left";
		public static const BOTTOM:String = "bottom";
		public static const RIGHT:String = "right";

		public function ButtonLabelPlacement()
		{
			super();
		}
	}
}
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
package fl.controls
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import fl.data.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.ui.*;

	public class ComboBox extends UIComponent implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {upSkin:"ComboBox_upSkin", downSkin:"ComboBox_downSkin", overSkin:"ComboBox_overSkin", disabledSkin:"ComboBox_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:3, buttonWidth:24, disabledAlpha:null, listSkin:null};
		public static var createAccessibilityImplementation:Function;
		public static const BACKGROUND_STYLES:Object = {overSkin:"overSkin", downSkin:"downSkin", upSkin:"upSkin", disabledSkin:"disabledSkin", repeatInterval:"repeatInterval"};
		public static const LIST_STYLES:Object = {upSkin:"comboListUpSkin", overSkin:"comboListOverSkin", downSkin:"comobListDownSkin", disabledSkin:"comboListDisabledSkin", downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval", textFormat:"textFormat", disabledAlpha:"disabledAlpha", skin:"listSkin"};
		protected var _dropdownWidth:Number;
		protected var highlightedCell:int = -1;
		protected var _prompt:String;
		protected var isOpen:Boolean = false;
		protected var list:List;
		protected var _rowCount:uint = 5;
		protected var currentIndex:int;
		protected var isKeyDown:Boolean = false;
		protected var _labels:Array;
		protected var background:BaseButton;
		protected var inputField:TextInput;
		protected var listOverIndex:uint;
		protected var editableValue:String;
		protected var _editable:Boolean = false;
		private var collectionItemImport:SimpleCollectionItem;

		final public static function getStyleDefinition() : Object
		{
			return ComboBox.mergeStyles(defaultStyles, List.getStyleDefinition());
		}

		public function ComboBox()
		{
			_rowCount = 5;
			_editable = false;
			isOpen = false;
			highlightedCell = -1;
			isKeyDown = false;
			super();
		}

		protected function drawList() : void
		{
			list.rowCount = Math.max(0, Math.min(_rowCount, list.dataProvider.length));
		}

		public function set imeMode(param1:String) : void
		{
			inputField.imeMode = param1;
		}

		public function get dropdown() : List
		{
			return list;
		}

		public function get dropdownWidth() : Number
		{
			return list.width;
		}

		public function sortItemsOn(param1:String, param2:Object = null)
		{
			return list.sortItemsOn(param1, param2);
		}

		protected function onEnter(param1:ComponentEvent) : void
		{
			param1.stopPropagation();
		}

		public function removeItemAt(param1:uint) : void
		{
			list.removeItemAt(param1);
			invalidate(InvalidationType.DATA);
		}

		public function open() : void
		{
			currentIndex = selectedIndex;
			if(isOpen || length == 0)
			{
				return;
			}
			dispatchEvent(new Event(Event.OPEN));
			isOpen = true;
			addEventListener(Event.ENTER_FRAME, addCloseListener, false, 0, true);
			positionList();
			list.scrollToSelected();
			stage.addChild(list);
		}

		public function get selectedItem() : Object
		{
			return list.selectedItem;
		}

		public function set text(param1:String) : void
		{
			if(!editable)
			{
				return;
			}
			inputField.text = param1;
		}

		public function get labelField() : String
		{
			return list.labelField;
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:uint = 0;
			var _loc_4:int = NaN;
			var _loc_5:int = 0;
			isKeyDown = true;
			if(param1.ctrlKey)
			{
				switch(param1.keyCode)
				{
				case Keyboard.UP:
					if(highlightedCell > -1)
					{
						selectedIndex = highlightedCell;
						dispatchEvent(new Event(Event.CHANGE));
					}
					close();
					break;
				case Keyboard.DOWN:
					open();
					break;
				default:
					break;
				}
				return;
			}
			param1.stopPropagation();
			_loc_2 = Math.max((calculateAvailableHeight() / list.rowHeight) << 0, 1);
			_loc_3 = selectedIndex;
			_loc_4 = highlightedCell == -1 ? selectedIndex : highlightedCell;
			_loc_5 = -1;
			switch(param1.keyCode)
			{
			case Keyboard.SPACE:
				if(isOpen)
				{
					close();
				}
				else
				{
					open();
				}
				return;
			case Keyboard.ESCAPE:
				if(isOpen)
				{
					if(highlightedCell > -1)
					{
						selectedIndex = selectedIndex;
					}
					close();
				}
				return;
			case Keyboard.UP:
				_loc_5 = Math.max(0, _loc_4 - 1);
				break;
			case Keyboard.DOWN:
				_loc_5 = Math.min(length - 1, _loc_4 + 1);
				break;
			case Keyboard.PAGE_UP:
				_loc_5 = Math.max(_loc_4 - _loc_2, 0);
				break;
			case Keyboard.PAGE_DOWN:
				_loc_5 = Math.min(_loc_4 + _loc_2, length - 1);
				break;
			case Keyboard.HOME:
				_loc_5 = 0;
				break;
			case Keyboard.END:
				_loc_5 = length - 1;
				break;
			case Keyboard.ENTER:
				if(_editable && highlightedCell == -1)
				{
					editableValue = inputField.text;
					selectedIndex = -1;
				}
				else
				{
					if(isOpen && highlightedCell > -1)
					{
						editableValue = null;
						selectedIndex = highlightedCell;
						dispatchEvent(new Event(Event.CHANGE));
					}
				}
				dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
				close();
				return;
			default:
				if(editable)
				{
				}
				else
				{
					_loc_5 = list.getNextIndexAtLetter(String.fromCharCode(param1.keyCode), _loc_4);
					var _loc_6:* = param1.keyCode;
					_loc_5 = 0;
						if(_loc_5 > -1)
						{
							if(isOpen)
							{
								highlightCell(_loc_5);
								inputField.text = list.itemToLabel(getItemAt(_loc_5));
								break;
							}
							highlightCell();
							selectedIndex = _loc_5;
							dispatchEvent(new Event(Event.CHANGE));
						}
					}
				}
			}
		}

		public function set dropdownWidth(param1:Number) : void
		{
			_dropdownWidth = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function get editable() : Boolean
		{
			return _editable;
		}

		override protected function focusInHandler(param1:FocusEvent) : void
		{
			super.focusInHandler(param1);
			if(editable)
			{
				stage.focus = inputField.textField;
			}
		}

		protected function onStageClick(param1:MouseEvent) : void
		{
			if(!isOpen)
			{
				return;
			}
			if(!contains(param1.target) && !list.contains(param1.target))
			{
				if(highlightedCell != -1)
				{
					selectedIndex = highlightedCell;
					dispatchEvent(new Event(Event.CHANGE));
				}
				close();
			}
		}

		protected function handleDataChange(param1:DataChangeEvent) : void
		{
			invalidate(InvalidationType.DATA);
		}

		override protected function keyUpHandler(param1:KeyboardEvent) : void
		{
			isKeyDown = false;
		}

		protected function onListItemUp(param1:MouseEvent) : void
		{
			var _loc_2:* = undefined;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onListItemUp);
			if(!(param1.target is ICellRenderer) || !list.contains(param1.target))
			{
				return;
			}
			editableValue = null;
			_loc_2 = selectedIndex;
			selectedIndex = param1.target.listData.index;
			if(_loc_2 != selectedIndex)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
			close();
		}

		public function removeAll() : void
		{
			list.removeAll();
			inputField.text = "";
			invalidate(InvalidationType.DATA);
		}

		public function set selectedItem(param1:Object) : void
		{
			list.selectedItem = param1;
			invalidate(InvalidationType.SELECTED);
		}

		protected function highlightCell(param1:int = -1) : void
		{
			var _loc_2:ICellRenderer = null;
			if(highlightedCell > -1)
			{
				_loc_2 = list.itemToCellRenderer(getItemAt(highlightedCell));
				if(_loc_2 != null)
				{
					_loc_2.setMouseState("up");
				}
			}
			if(param1 == -1)
			{
				return;
			}
			list.scrollToIndex(param1);
			list.drawNow();
			_loc_2 = list.itemToCellRenderer(getItemAt(param1));
			if(_loc_2 != null)
			{
				_loc_2.setMouseState("over");
				highlightedCell = param1;
			}
		}

		public function itemToLabel(param1:Object) : String
		{
			if(param1 == null)
			{
				return "";
			}
			return list.itemToLabel(param1);
		}

		public function addItemAt(param1:Object, param2:uint) : void
		{
			list.addItemAt(param1, param2);
			invalidate(InvalidationType.DATA);
		}

		public function replaceItemAt(param1:Object, param2:uint) : Object
		{
			return list.replaceItemAt(param1, param2);
		}

		protected function showPrompt() : void
		{
			inputField.text = _prompt;
		}

		public function set rowCount(param1:uint) : void
		{
			_rowCount = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function get restrict() : String
		{
			return inputField.restrict;
		}

		protected function setEmbedFonts() : void
		{
			var _loc_1:Object = null;
			_loc_1 = getStyleValue("embedFonts");
			if(_loc_1 != null)
			{
				inputField.textField.embedFonts = _loc_1;
			}
		}

		public function sortItems(...restArguments)
		{
			return list.sortItems.apply(list, restArguments);
		}

		public function set labelField(param1:String) : void
		{
			list.labelField = param1;
			invalidate(InvalidationType.DATA);
		}

		public function set editable(param1:Boolean) : void
		{
			_editable = param1;
			drawTextField();
		}

		public function set prompt(param1:String) : void
		{
			if(param1 == "")
			{
				_prompt = null;
			}
			else
			{
				_prompt = param1;
			}
			invalidate(InvalidationType.STATE);
		}

		public function get length() : int
		{
			return list.length;
		}

		protected function drawTextField() : void
		{
			inputField.setStyle("upSkin", "");
			inputField.setStyle("disabledSkin", "");
			inputField.enabled = enabled;
			inputField.editable = _editable;
			inputField.textField.selectable = enabled && _editable;
			var _loc_1:Boolean = enabled && _editable;
			inputField.mouseChildren = _loc_1;
			inputField.mouseEnabled = _loc_1;
			inputField.focusEnabled = false;
			if(_editable)
			{
				inputField.addEventListener(FocusEvent.FOCUS_IN, onInputFieldFocus, false, 0, true);
				inputField.addEventListener(FocusEvent.FOCUS_OUT, onInputFieldFocusOut, false, 0, true);
			}
			else
			{
				inputField.removeEventListener(FocusEvent.FOCUS_IN, onInputFieldFocus);
				inputField.removeEventListener(FocusEvent.FOCUS_OUT, onInputFieldFocusOut);
			}
		}

		protected function onInputFieldFocusOut(param1:FocusEvent) : void
		{
			inputField.removeEventListener(ComponentEvent.ENTER, onEnter);
			selectedIndex = selectedIndex;
		}

		protected function passEvent(param1:Event) : void
		{
			dispatchEvent(param1);
		}

		public function get imeMode() : String
		{
			return inputField.imeMode;
		}

		public function get labelFunction() : Function
		{
			return list.labelFunction;
		}

		protected function calculateAvailableHeight() : Number
		{
			var _loc_1:int = NaN;
			_loc_1 = Number(getStyleValue("contentPadding"));
			return list.height - (_loc_1 * 2);
		}

		public function get selectedIndex() : int
		{
			return list.selectedIndex;
		}

		override protected function focusOutHandler(param1:FocusEvent) : void
		{
			isKeyDown = false;
			if(isOpen)
			{
				if(!param1.relatedObject || !list.contains(param1.relatedObject))
				{
					if((highlightedCell == -1) && highlightedCell == selectedIndex)
					{
						selectedIndex = highlightedCell;
						dispatchEvent(new Event(Event.CHANGE));
					}
					close();
				}
			}
			super.focusOutHandler(param1);
		}

		public function get selectedLabel() : String
		{
			if(editableValue != null)
			{
				return editableValue;
			}
			if(selectedIndex == -1)
			{
				return null;
			}
			return itemToLabel(selectedItem);
		}

		public function get text() : String
		{
			return inputField.text;
		}

		protected function onListChange(param1:Event) : void
		{
			editableValue = null;
			dispatchEvent(param1);
			invalidate(InvalidationType.SELECTED);
			if(isKeyDown)
			{
				return;
			}
			close();
		}

		protected function onToggleListVisibility(param1:MouseEvent) : void
		{
			param1.stopPropagation();
			dispatchEvent(param1);
			if(isOpen)
			{
				close();
			}
			else
			{
				open();
				stage.addEventListener(MouseEvent.MOUSE_UP, onListItemUp, false, 0, true);
			}
		}

		override protected function draw() : void
		{
			var _loc_1:* = undefined;
			_loc_1 = selectedIndex;
			if(!(_loc_1 == -1 && prompt == null) || editable || length == 0)
			{
				_loc_1 = Math.max(-1, Math.min(_loc_1, length - 1));
			}
			else
			{
				editableValue = null;
				_loc_1 = Math.max(0, Math.min(_loc_1, length - 1));
			}
			if(list.selectedIndex != _loc_1)
			{
				list.selectedIndex = _loc_1;
				invalidate(InvalidationType.SELECTED, false);
			}
			if(isInvalid(InvalidationType.STYLES))
			{
				setStyles();
				setEmbedFonts();
				invalidate(InvalidationType.SIZE, false);
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.STATE))
			{
				drawTextFormat();
				drawLayout();
				invalidate(InvalidationType.DATA);
			}
			if(isInvalid(InvalidationType.DATA))
			{
				drawList();
				invalidate(InvalidationType.SELECTED, true);
			}
			if(isInvalid(InvalidationType.SELECTED))
			{
				if(!(_loc_1 == -1 && editableValue == null))
				{
					inputField.text = editableValue;
				}
				else
				{
					if(_loc_1 > -1)
					{
						if(length > 0)
						{
							inputField.horizontalScrollPosition = 0;
							inputField.text = itemToLabel(list.selectedItem);
						}
					}
					else
					{
						if(!(_loc_1 == -1 && _prompt == null))
						{
							showPrompt();
						}
						else
						{
							inputField.text = "";
						}
					}
				}
				if(editable && selectedIndex > -1 && stage.focus == inputField.textField)
				{
					inputField.setSelection(0, inputField.length);
				}
			}
			drawTextField();
			super.draw();
		}

		public function addItem(param1:Object) : void
		{
			list.addItem(param1);
			invalidate(InvalidationType.DATA);
		}

		public function get rowCount() : uint
		{
			return _rowCount;
		}

		override protected function configUI() : void
		{
			super.configUI();
			background = new BaseButton();
			background.focusEnabled = false;
			copyStylesToChild(background, BACKGROUND_STYLES);
			background.addEventListener(MouseEvent.MOUSE_DOWN, onToggleListVisibility, false, 0, true);
			addChild(background);
			inputField = new TextInput();
			inputField.focusTarget = this;
			inputField.focusEnabled = false;
			inputField.addEventListener(Event.CHANGE, onTextInput, false, 0, true);
			addChild(inputField);
			list = new List();
			list.focusEnabled = false;
			copyStylesToChild(list, LIST_STYLES);
			list.addEventListener(Event.CHANGE, onListChange, false, 0, true);
			list.addEventListener(ListEvent.ITEM_CLICK, onListChange, false, 0, true);
			list.addEventListener(ListEvent.ITEM_ROLL_OUT, passEvent, false, 0, true);
			list.addEventListener(ListEvent.ITEM_ROLL_OVER, passEvent, false, 0, true);
			list.verticalScrollBar.addEventListener(Event.SCROLL, passEvent, false, 0, true);
		}

		protected function positionList() : void
		{
			var _loc_1:Point = null;
			_loc_1 = localToGlobal(new Point(0, 0));
			list.x = _loc_1.x;
			if((_loc_1.y + height) + list.height > stage.stageHeight)
			{
				list.y = _loc_1.y - list.height;
			}
			else
			{
				list.y = _loc_1.y + height;
			}
		}

		public function get value() : String
		{
			var _loc_1:Object = null;
			if(editableValue != null)
			{
				return editableValue;
			}
			_loc_1 = selectedItem;
			if(_editable && _loc_1.data == null)
			{
				return _loc_1.data;
			}
			return itemToLabel(_loc_1);
		}

		public function get prompt() : String
		{
			return _prompt;
		}

		public function set dataProvider(param1:DataProvider) : void
		{
			param1.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			list.dataProvider = param1;
			invalidate(InvalidationType.DATA);
		}

		public function set restrict(param1:String) : void
		{
			if(componentInspectorSetting && param1 == "")
			{
				param1 = null;
			}
			if(!_editable)
			{
				return;
			}
			inputField.restrict = param1;
		}

		protected function onTextInput(param1:Event) : void
		{
			param1.stopPropagation();
			if(!_editable)
			{
				return;
			}
			editableValue = inputField.text;
			selectedIndex = -1;
			dispatchEvent(new Event(Event.CHANGE));
		}

		protected function onInputFieldFocus(param1:FocusEvent) : void
		{
			inputField.addEventListener(ComponentEvent.ENTER, onEnter, false, 0, true);
			close();
		}

		public function getItemAt(param1:uint) : Object
		{
			return list.getItemAt(param1);
		}

		override protected function initializeAccessibility() : void
		{
			if(ComboBox.createAccessibilityImplementation != null)
			{
				ComboBox.createAccessibilityImplementation(this);
			}
		}

		protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			_loc_1 = getStyleValue("buttonWidth");
			_loc_2 = getStyleValue("textPadding");
			background.setSize(width, height);
			var _loc_3:int = _loc_2;
			inputField.y = _loc_3;
			inputField.x = _loc_3;
			inputField.setSize((width - _loc_1) - _loc_3, height - _loc_3);
			list.width = isNaN(_dropdownWidth) ? width : _dropdownWidth;
			background.enabled = enabled;
			background.drawNow();
		}

		public function removeItem(param1:Object) : Object
		{
			return list.removeItem(param1);
		}

		private function addCloseListener(param1:Event)
		{
			removeEventListener(Event.ENTER_FRAME, addCloseListener);
			if(!isOpen)
			{
				return;
			}
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageClick, false, 0, true);
		}

		public function get dataProvider() : DataProvider
		{
			return list.dataProvider;
		}

		public function get textField() : TextInput
		{
			return inputField;
		}

		protected function setStyles() : void
		{
			copyStylesToChild(background, BACKGROUND_STYLES);
			copyStylesToChild(list, LIST_STYLES);
		}

		public function set labelFunction(param1:Function) : void
		{
			list.labelFunction = param1;
			invalidate(InvalidationType.DATA);
		}

		protected function drawTextFormat() : void
		{
			var _loc_1:TextFormat = null;
			_loc_1 = getStyleValue(_enabled ? "textFormat" : "disabledTextFormat");
			if(_loc_1 == null)
			{
				_loc_1 = new TextFormat();
			}
			inputField.textField.defaultTextFormat = _loc_1;
			inputField.textField.setTextFormat(_loc_1);
			setEmbedFonts();
		}

		public function set selectedIndex(param1:int) : void
		{
			list.selectedIndex = param1;
			highlightCell();
			invalidate(InvalidationType.SELECTED);
		}

		public function close() : void
		{
			highlightCell();
			highlightedCell = -1;
			if(!isOpen)
			{
				return;
			}
			dispatchEvent(new Event(Event.CLOSE));
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageClick);
			isOpen = false;
			stage.removeChild(list);
		}
	}
}
package fl.controls
{
	import fl.controls.dataGridClasses.*;
	import fl.controls.listClasses.*;
	import fl.core.*;
	import fl.data.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.*;

	public class DataGrid extends SelectableList implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {headerUpSkin:"HeaderRenderer_upSkin", headerDownSkin:"HeaderRenderer_downSkin", headerOverSkin:"HeaderRenderer_overSkin", headerDisabledSkin:"HeaderRenderer_disabledSkin", headerSortArrowDescSkin:"HeaderSortArrow_descIcon", headerSortArrowAscSkin:"HeaderSortArrow_ascIcon", columnStretchCursorSkin:"ColumnStretch_cursor", columnDividerSkin:null, headerTextFormat:null, headerDisabledTextFormat:null, headerTextPadding:5, headerRenderer:HeaderRenderer, focusRectSkin:null, focusRectPadding:null, skin:"DataGrid_skin"};
		public static const HEADER_STYLES:Object = {disabledSkin:"headerDisabledSkin", downSkin:"headerDownSkin", overSkin:"headerOverSkin", upSkin:"headerUpSkin", textFormat:"headerTextFormat", disabledTextFormat:"headerDisabledTextFormat", textPadding:"headerTextPadding"};
		public static var createAccessibilityImplementation:Function;
		protected var _showHeaders:Boolean = true;
		protected var _sortIndex:int = -1;
		protected var _minColumnWidth:Number;
		protected var _headerRenderer:Object;
		public var sortableColumns:Boolean = true;
		protected var activeCellRenderersMap:Dictionary;
		protected var _labelFunction:Function;
		protected var headerSortArrow:Sprite;
		protected var _sortDescending:Boolean = false;
		protected var losingFocus:Boolean = false;
		protected var maxHeaderHeight:Number = 25;
		protected var minColumnWidthInvalid:Boolean = false;
		protected var _rowHeight:Number = 20;
		protected var _cellRenderer:Object;
		protected var proposedEditedItemPosition:*;
		public var editable:Boolean = false;
		protected var dragHandlesMap:Dictionary;
		protected var header:Sprite;
		protected var availableCellRenderersMap:Dictionary;
		protected var _columns:Array;
		public var resizableColumns:Boolean = true;
		protected var columnStretchStartWidth:Number;
		protected var actualRowIndex:int;
		protected var _editedItemPosition:Object;
		protected var editedItemPositionChanged:Boolean = false;
		protected var actualColIndex:int;
		protected var columnStretchCursor:Sprite;
		protected var visibleColumns:Array;
		protected var headerMask:Sprite;
		public var itemEditorInstance:Object;
		protected var displayableColumns:Array;
		protected var columnStretchIndex:Number = -1;
		protected var columnsInvalid:Boolean = true;
		protected var currentHoveredRow:int = -1;
		protected var isPressed:Boolean = false;
		protected var lastSortIndex:int = -1;
		protected var columnStretchStartX:Number;
		protected var _headerHeight:Number = 25;

		final public static function getStyleDefinition() : Object
		{
			return DataGrid.mergeStyles(defaultStyles, SelectableList.getStyleDefinition(), ScrollBar.getStyleDefinition());
		}

		public function DataGrid()
		{
			_rowHeight = 20;
			_headerHeight = 25;
			_showHeaders = true;
			columnsInvalid = true;
			minColumnWidthInvalid = false;
			columnStretchIndex = -1;
			_sortIndex = -1;
			lastSortIndex = -1;
			_sortDescending = false;
			editedItemPositionChanged = false;
			isPressed = false;
			losingFocus = false;
			maxHeaderHeight = 25;
			currentHoveredRow = -1;
			editable = false;
			resizableColumns = true;
			sortableColumns = true;
			super();
			if(_columns == null)
			{
				_columns = [];
			}
			_horizontalScrollPolicy = ScrollPolicy.OFF;
			activeCellRenderersMap = new Dictionary(true);
			availableCellRenderersMap = new Dictionary(true);
			addEventListener(DataGridEvent.ITEM_EDIT_BEGINNING, itemEditorItemEditBeginningHandler, false, -50);
			addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, itemEditorItemEditBeginHandler, false, -50);
			addEventListener(DataGridEvent.ITEM_EDIT_END, itemEditorItemEditEndHandler, false, -50);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		override protected function drawList() : void
		{
			var _loc_1:uint = 0;
			var _loc_2:uint = 0;
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:uint = 0;
			var _loc_6:Object = null;
			var _loc_7:ICellRenderer = null;
			var _loc_8:Array = null;
			var _loc_9:DataGridColumn = null;
			var _loc_10:Boolean = false;
			var _loc_11:Dictionary = null;
			var _loc_12:DataGridColumn = null;
			var _loc_13:Sprite = null;
			var _loc_14:UIComponent = null;
			var _loc_15:Array = null;
			var _loc_16:uint = 0;
			var _loc_17:uint = 0;
			var _loc_18:int = NaN;
			var _loc_19:DataGridColumn = null;
			var _loc_20:Object = null;
			var _loc_21:Array = null;
			var _loc_22:Dictionary = null;
			var _loc_23:Object = null;
			var _loc_24:HeaderRenderer = null;
			var _loc_25:Sprite = null;
			var _loc_26:Graphics = null;
			var _loc_27:Boolean = false;
			var _loc_28:String = null;
			if(showHeaders)
			{
				header.visible = true;
				header.x = contentPadding - _horizontalScrollPosition;
				header.y = contentPadding;
				listHolder.y = contentPadding + headerHeight;
				_loc_18 = Math.floor(availableHeight - headerHeight);
				_verticalScrollBar.setScrollProperties(_loc_18, 0, contentHeight - _loc_18, _verticalScrollBar.pageScrollSize);
			}
			else
			{
				header.visible = false;
				listHolder.y = contentPadding;
			}
			listHolder.x = contentPadding;
			contentScrollRect = listHolder.scrollRect;
			contentScrollRect.x = _horizontalScrollPosition;
			contentScrollRect.y = vOffset + (Math.floor(_verticalScrollPosition) % rowHeight);
			listHolder.scrollRect = contentScrollRect;
			listHolder.cacheAsBitmap = useBitmapScrolling;
			_loc_1 = Math.min(Math.max(length - 1, 0), Math.floor(_verticalScrollPosition / rowHeight));
			_loc_2 = Math.min(Math.max(length - 1, 0), (_loc_1 + rowCount) + 1);
			_loc_10 = list.hitTestPoint(stage.mouseX, stage.mouseY);
			calculateColumnSizes();
			var _loc_29:Dictionary = new Dictionary(true);
			renderedItems = _loc_29;
			_loc_11 = _loc_29;
			if(length > 0)
			{
				_loc_5 = _loc_1;
				while(_loc_5 <= _loc_2)
				{
					_loc_11[_dataProvider.getItemAt(_loc_5)] = true;
					_loc_5 = _loc_5 + 1;
				}
			}
			_loc_3 = 0;
			_loc_12 = visibleColumns[0];
			_loc_5 = 0;
			while(_loc_5 < displayableColumns.length)
			{
				_loc_19 = displayableColumns[_loc_5];
				if(_loc_19 != _loc_12)
				{
					_loc_3 = _loc_3 + _loc_19.width;
				}
				else
				{
					break;
				}
				_loc_5 = _loc_5 + 1;
			}
			while(header.numChildren > 0)
			{
				header.removeChildAt(0);
			}
			dragHandlesMap = new Dictionary(true);
			_loc_15 = [];
			_loc_16 = visibleColumns.length;
			_loc_17 = 0;
			while(_loc_17 < _loc_16)
			{
				_loc_9 = visibleColumns[_loc_17];
				_loc_15.push(_loc_9.colNum);
				if(showHeaders)
				{
					_loc_23 = _loc_9.headerRenderer != null ? _loc_9.headerRenderer : _headerRenderer;
					_loc_24 = getDisplayObjectInstance(_loc_23);
					if(_loc_24 != null)
					{
						_loc_24.addEventListener(MouseEvent.CLICK, handleHeaderRendererClick, false, 0, true);
						_loc_24.x = _loc_3;
						_loc_24.y = 0;
						_loc_24.setSize(_loc_9.width, headerHeight);
						_loc_24.column = _loc_9.colNum;
						_loc_24.label = _loc_9.headerText;
						header.addChildAt(_loc_24, _loc_17);
						copyStylesToChild(_loc_24, HEADER_STYLES);
						if(!(sortIndex == -1 && lastSortIndex == -1 || _loc_9.colNum == sortIndex))
						{
							_loc_24.setStyle("icon", null);
						}
						else
						{
							_loc_24.setStyle("icon", sortDescending ? getStyleValue("headerSortArrowAscSkin") : getStyleValue("headerSortArrowDescSkin"));
						}
						if(_loc_17 < (_loc_16 - 1) && resizableColumns && _loc_9.resizable)
						{
							_loc_25 = new Sprite();
							_loc_26 = _loc_25.graphics;
							_loc_26.beginFill(0, 0);
							_loc_26.drawRect(0, 0, 3, headerHeight);
							_loc_26.endFill();
							_loc_25.x = (_loc_3 + _loc_9.width) - 2;
							_loc_25.y = 0;
							_loc_25.alpha = 0;
							_loc_25.addEventListener(MouseEvent.MOUSE_OVER, handleHeaderResizeOver, false, 0, true);
							_loc_25.addEventListener(MouseEvent.MOUSE_OUT, handleHeaderResizeOut, false, 0, true);
							_loc_25.addEventListener(MouseEvent.MOUSE_DOWN, handleHeaderResizeDown, false, 0, true);
							header.addChild(_loc_25);
							dragHandlesMap[_loc_25] = _loc_9.colNum;
						}
						if(_loc_17 == (_loc_16 - 1) && _horizontalScrollPosition == 0 && availableWidth > (_loc_3 + _loc_9.width))
						{
							_loc_4 = Math.floor(availableWidth - _loc_3);
							_loc_24.setSize(_loc_4, headerHeight);
						}
						else
						{
							_loc_4 = _loc_9.width;
						}
						_loc_24.drawNow();
					}
				}
				_loc_20 = _loc_9.cellRenderer != null ? _loc_9.cellRenderer : _cellRenderer;
				_loc_21 = availableCellRenderersMap[_loc_9];
				_loc_8 = activeCellRenderersMap[_loc_9];
				if(_loc_8 == null)
				{
					var _loc_29:Array = [];
					_loc_8 = _loc_29;
					activeCellRenderersMap[_loc_9] = _loc_8;
				}
				if(_loc_21 == null)
				{
					var _loc_29:Array = [];
					_loc_21 = _loc_29;
					availableCellRenderersMap[_loc_9] = _loc_21;
				}
				_loc_22 = new Dictionary(true);
				while(_loc_8.length > 0)
				{
					_loc_7 = _loc_8.pop();
					_loc_6 = _loc_7.data;
					if(_loc_11[_loc_6] == null || invalidItems[_loc_6] == true)
					{
						_loc_21.push(_loc_7);
					}
					else
					{
						_loc_22[_loc_6] = _loc_7;
						invalidItems[_loc_6] = true;
					}
					list.removeChild(_loc_7);
				}
				if(length > 0)
				{
					_loc_5 = _loc_5;
					while(_loc_5 <= _loc_2)
					{
						_loc_27 = false;
						_loc_6 = _dataProvider.getItemAt(_loc_5);
						if(_loc_22[_loc_6] != null)
						{
							_loc_27 = true;
							_loc_7 = _loc_22[_loc_6];
						}
						else
						{
							if(_loc_21.length > 0)
							{
								_loc_7 = _loc_21.pop();
							}
							else
							{
								_loc_7 = getDisplayObjectInstance(_loc_20);
								_loc_13 = _loc_7;
								if(_loc_13 != null)
								{
									_loc_13.addEventListener(MouseEvent.CLICK, handleCellRendererClick, false, 0, true);
									_loc_13.addEventListener(MouseEvent.ROLL_OVER, handleCellRendererMouseEvent, false, 0, true);
									_loc_13.addEventListener(MouseEvent.ROLL_OUT, handleCellRendererMouseEvent, false, 0, true);
									_loc_13.addEventListener(Event.CHANGE, handleCellRendererChange, false, 0, true);
									_loc_13.doubleClickEnabled = true;
									_loc_13.addEventListener(MouseEvent.DOUBLE_CLICK, handleCellRendererDoubleClick, false, 0, true);
									if(_loc_13["setStyle"] != null)
									{
										var _loc_29:int = 0;
										var _loc_30:* = rendererStyles;
										for each(_loc_28 in _loc_30)
										{
											var _loc_31:Sprite = _loc_13;
											_loc_31["setStyle"](_loc_28, rendererStyles[_loc_28]);
										}
									}
								}
							}
						}
						list.addChild(_loc_7);
						_loc_8.push(_loc_7);
						_loc_7.x = _loc_3;
						_loc_7.y = rowHeight * (_loc_5 - _loc_5);
						_loc_7.setSize(_loc_17 == (_loc_16 - 1) ? _loc_4 : _loc_9.width, rowHeight);
						if(!_loc_27)
						{
							_loc_7.data = _loc_6;
						}
						_loc_7.listData = new ListData(columnItemToLabel(_loc_9.colNum, _loc_6), null, this, _loc_5, _loc_5, _loc_17);
						_loc_7.setMouseState("up");
						_loc_7.selected = !(_selectedIndices.indexOf(_loc_5) == -1);
						if(_loc_7 is UIComponent)
						{
							_loc_14 = _loc_7;
							_loc_14.drawNow();
						}
						_loc_5 = _loc_5 + 1;
					}
				}
				_loc_3 = _loc_3 + _loc_9.width;
				_loc_17 = _loc_17 + 1;
			}
			_loc_5 = 0;
			while(_loc_5 < _columns.length)
			{
				if(_loc_15.indexOf(_loc_5) == -1)
				{
					removeCellRenderersByColumn(_columns[_loc_5]);
				}
				_loc_5 = _loc_5 + 1;
			}
			if(editedItemPositionChanged)
			{
				editedItemPositionChanged = false;
				commitEditedItemPosition(proposedEditedItemPosition);
				proposedEditedItemPosition = undefined;
			}
			invalidItems = new Dictionary(true);
		}

		protected function itemEditorItemEditBeginningHandler(param1:DataGridEvent) : void
		{
			if(!param1.isDefaultPrevented())
			{
				setEditedItemPosition({columnIndex:param1.columnIndex, rowIndex:uint(param1.rowIndex)});
			}
			else
			{
				if(!itemEditorInstance)
				{
					_editedItemPosition = null;
					editable = false;
					setFocus();
					editable = true;
				}
			}
		}

		protected function itemEditorItemEditEndHandler(param1:DataGridEvent) : void
		{
			var _loc_2:Boolean = false;
			var _loc_3:Object = null;
			var _loc_4:String = null;
			var _loc_5:Object = null;
			var _loc_6:String = null;
			var _loc_7:XML = null;
			var _loc_8:IFocusManager = null;
			if(!param1.isDefaultPrevented())
			{
				_loc_2 = false;
				if(!(itemEditorInstance && param1.reason == DataGridEventReason.CANCELLED))
				{
					_loc_3 = itemEditorInstance[_columns[param1.columnIndex].editorDataField];
					_loc_4 = _columns[param1.columnIndex].dataField;
					_loc_5 = param1.itemRenderer.data;
					_loc_6 = "";
					var _loc_9:int = 0;
					var _loc_10:* = describeType(_loc_5).variable;
					for each(_loc_7 in _loc_10)
					{
						if(_loc_4 == _loc_7.@name.toString())
						{
							_loc_6 = _loc_7.@type.toString();
							break;
						}
					}
					switch(_loc_6)
					{
					case "String":
						if(!(_loc_3 is String))
						{
							_loc_3 = _loc_3.toString();
						}
						break;
					case "uint":
						if(!(_loc_3 is uint))
						{
							_loc_3 = uint(_loc_3);
						}
						break;
					case "int":
						if(!(_loc_3 is int))
						{
							_loc_3 = int(_loc_3);
						}
						break;
					case "Number":
						if(!(_loc_3 is Number))
						{
							_loc_3 = Number(_loc_3);
						}
						break;
					default:
						break;
					}
					if(_loc_5[_loc_4] != _loc_3)
					{
						_loc_2 = true;
						_loc_5[_loc_4] = _loc_3;
					}
					param1.itemRenderer.data = _loc_5;
				}
			}
			else
			{
				if(param1.reason != DataGridEventReason.OTHER)
				{
					if(itemEditorInstance && _editedItemPosition)
					{
						if(selectedIndex != _editedItemPosition.rowIndex)
						{
							selectedIndex = _editedItemPosition.rowIndex;
						}
						_loc_8 = focusManager;
						if(itemEditorInstance is IFocusManagerComponent)
						{
							_loc_8.setFocus(InteractiveObject(itemEditorInstance));
						}
					}
				}
			}
			if(param1.reason == DataGridEventReason.OTHER || !param1.isDefaultPrevented())
			{
				destroyItemEditor();
			}
		}

		public function get editedItemPosition() : Object
		{
			if(_editedItemPosition)
			{
				return {rowIndex:_editedItemPosition.rowIndex, columnIndex:_editedItemPosition.columnIndex};
			}
			return _editedItemPosition;
		}

		protected function setEditedItemPosition(param1:Object) : void
		{
			editedItemPositionChanged = true;
			proposedEditedItemPosition = param1;
			if(!(param1 && param1.rowIndex == selectedIndex))
			{
				selectedIndex = param1.rowIndex;
			}
			invalidate(InvalidationType.DATA);
		}

		public function set headerHeight(param1:Number) : void
		{
			maxHeaderHeight = param1;
			_headerHeight = Math.max(0, param1);
			invalidate(InvalidationType.SIZE);
		}

		protected function handleHeaderResizeDown(param1:MouseEvent) : void
		{
			var _loc_2:Sprite = null;
			var _loc_3:int = NaN;
			var _loc_4:DataGridColumn = null;
			_loc_2 = param1.currentTarget;
			_loc_3 = dragHandlesMap[_loc_2];
			_loc_4 = getColumnAt(_loc_3);
			columnStretchIndex = _loc_3;
			columnStretchStartX = param1.stageX;
			columnStretchStartWidth = _loc_4.width;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleHeaderResizeMove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleHeaderResizeUp, false, 0, true);
		}

		protected function deactivateHandler(param1:Event) : void
		{
			if(itemEditorInstance)
			{
				endEdit(DataGridEventReason.OTHER);
				losingFocus = true;
				setFocus();
			}
		}

		protected function keyFocusChangeHandler(param1:FocusEvent) : void
		{
			if(param1.keyCode == Keyboard.TAB && !param1.isDefaultPrevented() && findNextItemRenderer(param1.shiftKey))
			{
				param1.preventDefault();
			}
		}

		override protected function handleDataChange(param1:DataChangeEvent) : void
		{
			super.handleDataChange(param1);
			if(_columns == null)
			{
				_columns = [];
			}
			if(_columns.length == 0)
			{
				createColumnsFromDataProvider();
			}
		}

		public function set editedItemPosition(param1:Object) : void
		{
			var _loc_2:Object = null;
			_loc_2 = {rowIndex:param1.rowIndex, columnIndex:param1.columnIndex};
			setEditedItemPosition(_loc_2);
		}

		override public function itemToCellRenderer(param1:Object) : ICellRenderer
		{
			return null;
		}

		public function getCellRendererAt(param1:uint, param2:uint) : ICellRenderer
		{
			var _loc_3:DataGridColumn = null;
			var _loc_4:Array = null;
			var _loc_5:uint = 0;
			var _loc_6:ICellRenderer = null;
			_loc_3 = _columns[param2];
			if(_loc_3 != null)
			{
				_loc_4 = activeCellRenderersMap[_loc_3];
				if(_loc_4 != null)
				{
					_loc_5 = 0;
					while(_loc_5 < _loc_4.length)
					{
						_loc_6 = _loc_4[_loc_5];
						if(_loc_6.listData.row == param1)
						{
							return _loc_6;
						}
						_loc_5 = _loc_5 + 1;
					}
				}
			}
			return null;
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			if(!selectable || itemEditorInstance)
			{
				return;
			}
			switch(param1.keyCode)
			{
			case Keyboard.UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.END:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.HOME:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.PAGE_UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.PAGE_DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.LEFT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.RIGHT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.SPACE:
				if(caretIndex == -1)
				{
					caretIndex = param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && 0;
				}
				scrollToIndex(caretIndex);
				doKeySelection(caretIndex, param1.shiftKey, param1.ctrlKey);
				break;
			default:
				break;
			}
			param1.stopPropagation();
		}

		protected function handleHeaderResizeUp(param1:MouseEvent) : void
		{
			var _loc_2:Sprite = null;
			var _loc_3:DataGridColumn = null;
			var _loc_4:HeaderRenderer = null;
			var _loc_5:uint = 0;
			var _loc_6:DataGridEvent = null;
			_loc_2 = param1.currentTarget;
			_loc_3 = _columns[columnStretchIndex];
			_loc_5 = 0;
			while(_loc_5 < header.numChildren)
			{
				_loc_4 = header.getChildAt(_loc_5);
				if(_loc_4 && _loc_4.column == columnStretchIndex)
				{
					break;
				}
				_loc_5 = _loc_5 + 1;
			}
			_loc_6 = new DataGridEvent(DataGridEvent.COLUMN_STRETCH, false, true, columnStretchIndex, -1, _loc_4, _loc_3 ? _loc_3.dataField : null);
			dispatchEvent(_loc_6);
			columnStretchIndex = -1;
			showColumnStretchCursor(false);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleHeaderResizeMove, false);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleHeaderResizeUp, false);
		}

		protected function handleHeaderResizeOver(param1:MouseEvent) : void
		{
			if(columnStretchIndex == -1)
			{
				showColumnStretchCursor();
			}
		}

		override protected function focusInHandler(param1:FocusEvent) : void
		{
			var _loc_2:Boolean = false;
			var _loc_3:DataGridColumn = null;
			if(param1.target != this)
			{
				return;
			}
			if(losingFocus)
			{
				losingFocus = false;
				return;
			}
			setIMEMode(true);
			super.focusInHandler(param1);
			if(editable && !isPressed)
			{
				_loc_2 = !(editedItemPosition == null);
				if(!_editedItemPosition)
				{
					_editedItemPosition = {rowIndex:0, columnIndex:0};
					while(_editedItemPosition.columnIndex < _columns.length)
					{
						_loc_3 = _columns[_editedItemPosition.columnIndex];
						_loc_3.editable;
						if(_loc_3.editable && _loc_3.visible)
						{
							_loc_2 = true;
							break;
						}
						var _loc_4:_editedItemPosition = _editedItemPosition;
						var _loc_5:* = _loc_4.columnIndex + 1;
						_loc_4.columnIndex = _loc_5;
					}
				}
			}
			if(editable)
			{
				addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
			}
		}

		public function createItemEditor(param1:uint, param2:uint) : void
		{
			var _loc_3:DataGridColumn = null;
			var _loc_4:ICellRenderer = null;
			var _loc_5:Sprite = null;
			var _loc_6:int = 0;
			if(displayableColumns.length != _columns.length)
			{
				_loc_6 = 0;
				while(_loc_6 < displayableColumns.length)
				{
					if(displayableColumns[_loc_6].colNum >= param1)
					{
						param1 = displayableColumns[_loc_6].colNum;
						break;
					}
					_loc_6++;
				}
				if(_loc_6 == displayableColumns.length)
				{
					param1 = 0;
				}
			}
			_loc_3 = _columns[param1];
			_loc_4 = getCellRendererAt(param2, param1);
			if(!itemEditorInstance)
			{
				itemEditorInstance = getDisplayObjectInstance(_loc_3.itemEditor);
				itemEditorInstance.tabEnabled = false;
				list.addChild(DisplayObject(itemEditorInstance));
			}
			list.setChildIndex(DisplayObject(itemEditorInstance), list.numChildren - 1);
			_loc_5 = _loc_4;
			itemEditorInstance.visible = true;
			itemEditorInstance.move(_loc_5.x, _loc_5.y);
			itemEditorInstance.setSize(_loc_3.width, rowHeight);
			itemEditorInstance.drawNow();
			DisplayObject(itemEditorInstance).addEventListener(FocusEvent.FOCUS_OUT, itemEditorFocusOutHandler);
			_loc_5.visible = false;
			DisplayObject(itemEditorInstance).addEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true, 0, true);
		}

		private function itemEditorFocusOutHandler(param1:FocusEvent) : void
		{
			param1.relatedObject;
			if(param1.relatedObject && contains(param1.relatedObject))
			{
				return;
			}
			if(!param1.relatedObject)
			{
				return;
			}
			if(itemEditorInstance)
			{
				endEdit(DataGridEventReason.OTHER);
			}
		}

		override public function get horizontalScrollPolicy() : String
		{
			return _horizontalScrollPolicy;
		}

		override protected function updateRendererStyles() : void
		{
			var _loc_1:Array = null;
			var _loc_2:Object = null;
			var _loc_3:uint = 0;
			var _loc_4:uint = 0;
			var _loc_5:String = null;
			_loc_1 = [];
			var _loc_6:int = 0;
			var _loc_7:* = availableCellRenderersMap;
			for each(_loc_2 in _loc_7)
			{
				_loc_1 = _loc_1.concat(availableCellRenderersMap[_loc_2]);
			}
			var _loc_6:int = 0;
			var _loc_7:* = activeCellRenderersMap;
			for each(_loc_2 in _loc_7)
			{
				_loc_1 = _loc_1.concat(activeCellRenderersMap[_loc_2]);
			}
			_loc_3 = _loc_1.length;
			_loc_4 = 0;
			while(_loc_4 < _loc_3)
			{
				if(_loc_1[_loc_4]["setStyle"] == null)
				{
				}
				else
				{
					var _loc_6:int = 0;
					var _loc_7:* = updatedRendererStyles;
					for each(_loc_5 in _loc_7)
					{
						_loc_1[_loc_4].setStyle(_loc_5, updatedRendererStyles[_loc_5]);
					}
					_loc_1[_loc_4].drawNow();
				}
				_loc_4 = _loc_4 + 1;
			}
			updatedRendererStyles = {};
		}

		public function set minColumnWidth(param1:Number) : void
		{
			_minColumnWidth = param1;
			columnsInvalid = true;
			minColumnWidthInvalid = true;
			invalidate(InvalidationType.SIZE);
		}

		protected function showColumnStretchCursor(param1:Boolean = true) : void
		{
			if(columnStretchCursor == null)
			{
				columnStretchCursor = getDisplayObjectInstance(getStyleValue("columnStretchCursorSkin"));
				columnStretchCursor.mouseEnabled = false;
			}
			if(param1)
			{
				Mouse.hide();
				stage.addChild(columnStretchCursor);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, positionColumnStretchCursor, false, 0, true);
				columnStretchCursor.x = stage.mouseX;
				columnStretchCursor.y = stage.mouseY;
			}
			else
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, positionColumnStretchCursor, false);
				if(stage.contains(columnStretchCursor))
				{
					stage.removeChild(columnStretchCursor);
				}
				Mouse.show();
			}
		}

		protected function findNextEnterItemRenderer(param1:KeyboardEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:int = 0;
			var _loc_5:DataGridEvent = null;
			if(proposedEditedItemPosition !== undefined)
			{
				return;
			}
			_loc_2 = _editedItemPosition.rowIndex;
			_loc_3 = _editedItemPosition.columnIndex;
			_loc_4 = _editedItemPosition.rowIndex + (param1.shiftKey ? -1 : 1);
			if(_loc_4 >= 0 && _loc_4 < length)
			{
				_loc_2 = _loc_4;
			}
			_loc_5 = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, false, true, _loc_3, _loc_2);
			_loc_5.dataField = _columns[_loc_3].dataField;
			dispatchEvent(_loc_5);
		}

		protected function mouseFocusChangeHandler(param1:MouseEvent) : void
		{
			if(itemEditorInstance && !param1.isDefaultPrevented() && itemRendererContains(itemEditorInstance, DisplayObject(param1.target)))
			{
				param1.preventDefault();
			}
		}

		public function get imeMode() : String
		{
			return _imeMode;
		}

		public function editField(param1:uint, param2:String, param3:Object) : void
		{
			var _loc_4:Object = null;
			_loc_4 = getItemAt(param1);
			_loc_4[param2] = param3;
			replaceItemAt(_loc_4, param1);
		}

		protected function calculateAvailableHeight() : Number
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			_loc_1 = Number(getStyleValue("contentPadding"));
			_loc_2 = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0;
			return (height - (_loc_1 * 2)) - _loc_2 - (showHeaders ? headerHeight : 0);
		}

		protected function mouseUpHandler(param1:MouseEvent) : void
		{
			if(!enabled || !selectable)
			{
				return;
			}
			isPressed = false;
		}

		override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void
		{
		}

		public function resizeColumn(param1:int, param2:Number) : void
		{
			var _loc_3:DataGridColumn = null;
			var _loc_4:int = 0;
			var _loc_5:int = NaN;
			var _loc_6:int = 0;
			var _loc_7:DataGridColumn = null;
			var _loc_8:DataGridColumn = null;
			var _loc_9:int = 0;
			var _loc_10:int = NaN;
			var _loc_11:int = NaN;
			var _loc_12:int = NaN;
			if(_columns.length == 0)
			{
				return;
			}
			_loc_3 = _columns[param1];
			if(!_loc_3)
			{
				return;
			}
			if(!visibleColumns || visibleColumns.length == 0)
			{
				_loc_3.setWidth(param2);
				return;
			}
			if(param2 < _loc_3.minWidth)
			{
				param2 = _loc_3.minWidth;
			}
			if(_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO)
			{
				_loc_3.setWidth(param2);
				_loc_3.explicitWidth = param2;
			}
			else
			{
				_loc_4 = getVisibleColumnIndex(_loc_3);
				if(_loc_4 != -1)
				{
					_loc_5 = 0;
					_loc_6 = visibleColumns.length;
					_loc_9 = _loc_4 + 1;
					while(_loc_9 < _loc_6)
					{
						_loc_7 = visibleColumns[_loc_9];
						_loc_7;
						if(_loc_7 && _loc_7.resizable)
						{
							_loc_5 = _loc_5 + _loc_7.width;
						}
						_loc_9++;
					}
					_loc_11 = (_loc_3.width - param2) + _loc_5;
					if(_loc_5)
					{
						_loc_3.setWidth(param2);
						_loc_3.explicitWidth = param2;
					}
					_loc_12 = 0;
					_loc_9 = _loc_4 + 1;
					while(_loc_9 < _loc_6)
					{
						_loc_7 = visibleColumns[_loc_9];
						if(_loc_7.resizable)
						{
							_loc_10 = (_loc_7.width * _loc_11) / _loc_5;
							if(_loc_10 < _loc_7.minWidth)
							{
								_loc_10 = _loc_7.minWidth;
							}
							_loc_7.setWidth(_loc_10);
							_loc_12 = _loc_12 + _loc_7.width;
							_loc_8 = _loc_7;
						}
						_loc_9++;
					}
					if(_loc_12 > _loc_11)
					{
						_loc_10 = (_loc_3.width - _loc_12) + _loc_11;
						if(_loc_10 < _loc_3.minWidth)
						{
							_loc_10 = _loc_3.minWidth;
						}
						_loc_3.setWidth(_loc_10);
					}
					else
					{
						if(_loc_8)
						{
							_loc_8.setWidth((_loc_8.width - _loc_12) + _loc_11);
						}
					}
				}
				else
				{
					_loc_3.setWidth(param2);
					_loc_3.explicitWidth = param2;
				}
			}
			columnsInvalid = true;
			invalidate(InvalidationType.SIZE);
		}

		protected function itemEditorItemEditBeginHandler(param1:DataGridEvent) : void
		{
			var _loc_2:IFocusManager = null;
			if(stage)
			{
				stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
			}
			if(!param1.isDefaultPrevented())
			{
				createItemEditor(param1.columnIndex, uint(param1.rowIndex));
				ICellRenderer(itemEditorInstance).listData = ICellRenderer(editedItemRenderer).listData;
				ICellRenderer(itemEditorInstance).data = editedItemRenderer.data;
				itemEditorInstance.imeMode = columns[param1.columnIndex].imeMode == null ? _imeMode : columns[param1.columnIndex].imeMode;
				_loc_2 = focusManager;
				if(itemEditorInstance is IFocusManagerComponent)
				{
					_loc_2.setFocus(InteractiveObject(itemEditorInstance));
				}
				_loc_2.defaultButtonEnabled = false;
				param1 = new DataGridEvent(DataGridEvent.ITEM_FOCUS_IN, false, false, _editedItemPosition.columnIndex, _editedItemPosition.rowIndex, itemEditorInstance);
				dispatchEvent(param1);
			}
		}

		override protected function draw() : void
		{
			var _loc_1:Boolean = false;
			_loc_1 = !(contentHeight == (rowHeight * length));
			contentHeight = rowHeight * length;
			if(isInvalid(InvalidationType.STYLES))
			{
				setStyles();
				drawBackground();
				if(contentPadding != getStyleValue("contentPadding"))
				{
					invalidate(InvalidationType.SIZE, false);
				}
				if((_cellRenderer == getStyleValue("cellRenderer")) || _headerRenderer == getStyleValue("headerRenderer"))
				{
					_invalidateList();
					_cellRenderer = getStyleValue("cellRenderer");
					_headerRenderer = getStyleValue("headerRenderer");
				}
			}
			if(isInvalid(InvalidationType.SIZE))
			{
				columnsInvalid = true;
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.STATE) || isInvalid(InvalidationType.RENDERER_STYLES))
			{
				updateRendererStyles();
			}
			if(isInvalid(InvalidationType.STYLES, InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.SCROLL, InvalidationType.SELECTED))
			{
				drawList();
			}
			updateChildren();
			validate();
		}

		override public function set horizontalScrollPolicy(param1:String) : void
		{
			columnsInvalid = true;
		}

		protected function getVisibleColumnIndex(param1:DataGridColumn) : int
		{
			var _loc_2:uint = 0;
			_loc_2 = 0;
			while(_loc_2 < visibleColumns.length)
			{
				if(param1 == visibleColumns[_loc_2])
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		protected function itemRendererContains(param1:Object, param2:DisplayObject) : Boolean
		{
			if(param2 || !param1 || param1 is DisplayObjectContainer)
			{
				return false;
			}
			return DisplayObjectContainer(param1).contains(param2);
		}

		override protected function configUI() : void
		{
			var _loc_1:Graphics = null;
			useFixedHorizontalScrolling = false;
			super.configUI();
			headerMask = new Sprite();
			_loc_1 = headerMask.graphics;
			_loc_1.beginFill(0, 0.30);
			_loc_1.drawRect(0, 0, 100, 100);
			_loc_1.endFill();
			headerMask.visible = false;
			addChild(headerMask);
			header = new Sprite();
			addChild(header);
			header.mask = headerMask;
			_horizontalScrollPolicy = ScrollPolicy.OFF;
			_verticalScrollPolicy = ScrollPolicy.AUTO;
		}

		public function columnItemToLabel(param1:uint, param2:Object) : String
		{
			var _loc_3:DataGridColumn = null;
			_loc_3 = _columns[param1];
			if(_loc_3 != null)
			{
				return _loc_3.itemToLabel(param2);
			}
			return " ";
		}

		protected function endEdit(param1:String) : Boolean
		{
			var _loc_2:DataGridEvent = null;
			if(!editedItemRenderer)
			{
				return true;
			}
			_loc_2 = new DataGridEvent(DataGridEvent.ITEM_EDIT_END, false, true, editedItemPosition.columnIndex, editedItemPosition.rowIndex, editedItemRenderer, _columns[editedItemPosition.columnIndex].dataField, param1);
			dispatchEvent(_loc_2);
			return !_loc_2.isDefaultPrevented();
		}

		override protected function drawLayout() : void
		{
			vOffset = showHeaders ? headerHeight : 0;
			super.drawLayout();
			contentScrollRect = listHolder.scrollRect;
			if(showHeaders)
			{
				headerHeight = maxHeaderHeight;
				if((Math.floor(availableHeight - headerHeight)) <= 0)
				{
					_headerHeight = availableHeight;
				}
				list.y = headerHeight;
				contentScrollRect = listHolder.scrollRect;
				contentScrollRect.y = contentPadding + headerHeight;
				contentScrollRect.height = availableHeight - headerHeight;
				listHolder.y = contentPadding + headerHeight;
				headerMask.x = contentPadding;
				headerMask.y = contentPadding;
				headerMask.width = availableWidth;
				headerMask.height = headerHeight;
			}
			else
			{
				contentScrollRect.y = contentPadding;
				listHolder.y = 0;
			}
			listHolder.scrollRect = contentScrollRect;
		}

		protected function commitEditedItemPosition(param1:Object) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:DataGridEvent = null;
			var _loc_4:String = null;
			var _loc_5:int = 0;
			if(!enabled || !editable)
			{
				return;
			}
			if(itemEditorInstance && param1 && itemEditorInstance is IFocusManagerComponent && _editedItemPosition.rowIndex == param1.rowIndex && _editedItemPosition.columnIndex == param1.columnIndex)
			{
				IFocusManagerComponent(itemEditorInstance).setFocus();
				return;
			}
			if(itemEditorInstance)
			{
				if(!param1)
				{
					_loc_4 = DataGridEventReason.OTHER;
				}
				else
				{
					if(!editedItemPosition || param1.rowIndex == editedItemPosition.rowIndex)
					{
						_loc_4 = DataGridEventReason.NEW_COLUMN;
					}
					else
					{
						_loc_4 = DataGridEventReason.NEW_ROW;
					}
				}
				if(endEdit(_loc_4) && _loc_4 == DataGridEventReason.OTHER)
				{
					return;
				}
			}
			_editedItemPosition = param1;
			if(!param1)
			{
				return;
			}
			actualRowIndex = param1.rowIndex;
			actualColIndex = param1.columnIndex;
			if(displayableColumns.length != _columns.length)
			{
				_loc_5 = 0;
				while(_loc_5 < displayableColumns.length)
				{
					if(displayableColumns[_loc_5].colNum >= actualColIndex)
					{
						actualColIndex = displayableColumns[_loc_5].colNum;
						break;
					}
					_loc_5++;
				}
				if(_loc_5 == displayableColumns.length)
				{
					actualColIndex = 0;
				}
			}
			scrollToPosition(actualRowIndex, actualColIndex);
			_loc_2 = getCellRendererAt(actualRowIndex, actualColIndex);
			_loc_3 = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGIN, false, true, actualColIndex, actualRowIndex, _loc_2);
			dispatchEvent(_loc_3);
			if(editedItemPositionChanged)
			{
				editedItemPositionChanged = false;
				commitEditedItemPosition(proposedEditedItemPosition);
				proposedEditedItemPosition = undefined;
			}
			if(!itemEditorInstance)
			{
				commitEditedItemPosition(null);
			}
		}

		protected function handleHeaderRendererClick(param1:MouseEvent) : void
		{
			var _loc_2:HeaderRenderer = null;
			var _loc_3:uint = 0;
			var _loc_4:DataGridColumn = null;
			var _loc_5:uint = 0;
			var _loc_6:DataGridEvent = null;
			if(!_enabled)
			{
				return;
			}
			_loc_2 = param1.currentTarget;
			_loc_3 = _loc_2.column;
			_loc_4 = _columns[_loc_3];
			if(sortableColumns && _loc_4.sortable)
			{
				_loc_5 = _sortIndex;
				_sortIndex = _loc_3;
				_loc_6 = new DataGridEvent(DataGridEvent.HEADER_RELEASE, false, true, _loc_3, -1, _loc_2, _loc_4 ? _loc_4.dataField : null);
				if(!dispatchEvent(_loc_6) || !_selectable)
				{
					_sortIndex = lastSortIndex;
					return;
				}
				lastSortIndex = _loc_5;
				sortByColumn(_loc_3);
				invalidate(InvalidationType.DATA);
			}
		}

		public function get showHeaders() : Boolean
		{
			return _showHeaders;
		}

		public function get sortIndex() : int
		{
			return _sortIndex;
		}

		public function set labelFunction(param1:Function) : void
		{
			if(_labelFunction == param1)
			{
				return;
			}
			_labelFunction = param1;
			invalidate(InvalidationType.DATA);
		}

		public function getColumnIndex(param1:String) : int
		{
			var _loc_2:uint = 0;
			var _loc_3:DataGridColumn = null;
			_loc_2 = 0;
			while(_loc_2 < _columns.length)
			{
				_loc_3 = _columns[_loc_2];
				if(_loc_3.dataField == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		protected function createColumnsFromDataProvider() : void
		{
			var _loc_1:Object = null;
			var _loc_2:String = null;
			_columns = [];
			if(length > 0)
			{
				_loc_1 = _dataProvider.getItemAt(0);
				var _loc_3:int = 0;
				var _loc_4:* = _loc_1;
				for each(_loc_2 in _loc_4)
				{
					addColumn(_loc_2);
				}
			}
		}

		protected function editorMouseDownHandler(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:uint = 0;
			if(!(itemRendererContains(itemEditorInstance, DisplayObject(param1.target))))
			{
				if(param1.target is ICellRenderer && contains(DisplayObject(param1.target)))
				{
					_loc_2 = param1.target;
					_loc_3 = _loc_2.listData.row;
					if(_editedItemPosition.rowIndex == _loc_3)
					{
						endEdit(DataGridEventReason.NEW_COLUMN);
					}
					else
					{
						endEdit(DataGridEventReason.NEW_ROW);
					}
				}
				else
				{
					endEdit(DataGridEventReason.OTHER);
				}
			}
		}

		public function addColumnAt(param1:*, param2:uint) : DataGridColumn
		{
			var _loc_3:DataGridColumn = null;
			var _loc_4:* = undefined;
			var _loc_5:uint = 0;
			if(param2 < _columns.length)
			{
				_columns.splice(param2, 0, "");
				_loc_5 = param2 + 1;
				while(_loc_5 < _columns.length)
				{
					_loc_3 = _columns[_loc_5];
					_loc_3.colNum = _loc_5;
					_loc_5 = _loc_5 + 1;
				}
			}
			_loc_4 = param1;
			if(!(_loc_4 is DataGridColumn))
			{
				if(_loc_4 is String)
				{
					_loc_4 = new DataGridColumn(_loc_4);
				}
				else
				{
					_loc_4 = new DataGridColumn();
				}
			}
			_loc_3 = _loc_4;
			_loc_3.owner = this;
			_loc_3.colNum = param2;
			_columns[param2] = _loc_3;
			invalidate(InvalidationType.SIZE);
			columnsInvalid = true;
			return _loc_3;
		}

		public function destroyItemEditor() : void
		{
			var _loc_1:DataGridEvent = null;
			if(itemEditorInstance)
			{
				DisplayObject(itemEditorInstance).removeEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true);
				_loc_1 = new DataGridEvent(DataGridEvent.ITEM_FOCUS_OUT, false, false, _editedItemPosition.columnIndex, _editedItemPosition.rowIndex, itemEditorInstance);
				dispatchEvent(_loc_1);
				if(itemEditorInstance && itemEditorInstance is UIComponent)
				{
					UIComponent(itemEditorInstance).drawFocus(false);
				}
				list.removeChild(DisplayObject(itemEditorInstance));
				DisplayObject(editedItemRenderer).visible = true;
				itemEditorInstance = null;
			}
		}

		public function set imeMode(param1:String) : void
		{
			_imeMode = param1;
		}

		protected function doKeySelection(param1:int, param2:Boolean, param3:Boolean) : void
		{
			var _loc_4:Boolean = false;
			var _loc_5:int = 0;
			var _loc_6:Array = null;
			var _loc_7:int = 0;
			var _loc_8:int = 0;
			_loc_4 = false;
			if(param2)
			{
				_loc_6 = [];
				_loc_7 = lastCaretIndex;
				_loc_8 = param1;
				if(_loc_7 == -1)
				{
					_loc_7 = caretIndex != -1 ? caretIndex : _loc_8;
				}
				if(_loc_7 > _loc_8)
				{
					_loc_8 = _loc_7;
					_loc_8 = _loc_8;
				}
				_loc_5 = _loc_8;
				while(_loc_5 <= _loc_8)
				{
					_loc_6.push(_loc_5);
					_loc_5++;
				}
				selectedIndices = _loc_6;
				caretIndex = _loc_8;
				_loc_4 = true;
			}
			else
			{
				if(param3)
				{
					caretIndex = _loc_8;
				}
				else
				{
					selectedIndex = _loc_8;
					var _loc_9:int = _loc_8;
					lastCaretIndex = _loc_9;
					caretIndex = _loc_9;
					_loc_4 = true;
				}
			}
			invalidate(InvalidationType.DATA);
		}

		public function get headerHeight() : Number
		{
			return _headerHeight;
		}

		public function getColumnCount() : uint
		{
			return _columns.length;
		}

		protected function sortByColumn(param1:int) : void
		{
			var _loc_2:DataGridColumn = null;
			var _loc_3:Boolean = false;
			var _loc_4:uint = 0;
			_loc_2 = columns[param1];
			if(!enabled || !_loc_2 || !_loc_2.sortable)
			{
				return;
			}
			_loc_3 = _loc_2.sortDescending;
			_loc_4 = _loc_2.sortOptions;
			_loc_4 = _loc_4 & ~Array.DESCENDING;
			if(_loc_2.sortCompareFunction != null)
			{
				sortItems(_loc_2.sortCompareFunction, _loc_4);
			}
			else
			{
				sortItemsOn(_loc_2.dataField, _loc_4);
			}
			var _loc_5:Boolean = !_loc_3;
			_loc_2.sortDescending = _loc_5;
			_sortDescending = _loc_5;
			if(!(lastSortIndex >= 0 && lastSortIndex == sortIndex))
			{
				_loc_2 = columns[lastSortIndex];
				if(_loc_2 != null)
				{
					_loc_2.sortDescending = false;
				}
			}
		}

		public function get minColumnWidth() : Number
		{
			return _minColumnWidth;
		}

		protected function isHovered(param1:ICellRenderer) : Boolean
		{
			var _loc_2:uint = 0;
			var _loc_3:int = NaN;
			var _loc_4:Point = null;
			_loc_2 = Math.min(Math.max(length - 1, 0), Math.floor(_verticalScrollPosition / rowHeight));
			_loc_3 = (param1.listData.row - _loc_2) * rowHeight;
			_loc_4 = list.globalToLocal(new Point(0, stage.mouseY));
			return _loc_4.y > _loc_3 && _loc_4.y < (_loc_3 + rowHeight);
		}

		protected function mouseDownHandler(param1:MouseEvent) : void
		{
			if(!enabled || !selectable)
			{
				return;
			}
			isPressed = true;
		}

		override public function set enabled(param1:Boolean) : void
		{
			header.mouseChildren = _enabled;
		}

		override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
		{
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			_loc_4 = Math.max(Math.floor(calculateAvailableHeight() / rowHeight), 1);
			_loc_5 = -1;
			_loc_6 = 0;
			switch(param1)
			{
			case Keyboard.UP:
				if(caretIndex > 0)
				{
					_loc_5 = caretIndex - 1;
				}
				break;
			case Keyboard.DOWN:
				if(caretIndex < (length - 1))
				{
					_loc_5 = caretIndex + 1;
				}
				break;
			case Keyboard.PAGE_UP:
				if(caretIndex > 0)
				{
					_loc_5 = Math.max(caretIndex - _loc_4, 0);
				}
				break;
			case Keyboard.PAGE_DOWN:
				if(caretIndex < (length - 1))
				{
					_loc_5 = Math.min(caretIndex + _loc_4, length - 1);
				}
				break;
			case Keyboard.HOME:
				if(caretIndex > 0)
				{
					_loc_5 = 0;
				}
				break;
			case Keyboard.END:
				if(caretIndex < (length - 1))
				{
					_loc_5 = length - 1;
				}
				break;
			default:
				break;
			}
			if(_loc_5 >= 0)
			{
				doKeySelection(_loc_5, param2, param3);
				scrollToSelected();
			}
		}

		protected function handleHeaderResizeOut(param1:MouseEvent) : void
		{
			if(columnStretchIndex == -1)
			{
				showColumnStretchCursor(false);
			}
		}

		public function removeAllColumns() : void
		{
			if(_columns.length > 0)
			{
				removeCellRenderers();
				_columns = [];
				invalidate(InvalidationType.SIZE);
				columnsInvalid = true;
			}
		}

		public function set rowCount(param1:uint) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_2 = Number(getStyleValue("contentPadding"));
			_loc_3 = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && hScrollBar ? 15 : 0;
			height = (rowHeight * param1) + (2 * _loc_2) + _loc_3 + (showHeaders ? headerHeight : 0);
		}

		protected function removeCellRenderers() : void
		{
			var _loc_1:uint = 0;
			_loc_1 = 0;
			while(_loc_1 < _columns.length)
			{
				removeCellRenderersByColumn(_columns[_loc_1]);
				_loc_1 = _loc_1 + 1;
			}
		}

		public function removeColumnAt(param1:uint) : DataGridColumn
		{
			var _loc_2:DataGridColumn = null;
			var _loc_3:uint = 0;
			_loc_2 = _columns[param1];
			if(_loc_2 != null)
			{
				removeCellRenderersByColumn(_loc_2);
				_columns.splice(param1, 1);
				_loc_3 = param1;
				while(_loc_3 < _columns.length)
				{
					_loc_2 = _columns[_loc_3];
					if(_loc_2)
					{
						_loc_2.colNum = _loc_3;
					}
					_loc_3 = _loc_3 + 1;
				}
				invalidate(InvalidationType.SIZE);
				columnsInvalid = true;
			}
			return _loc_2;
		}

		override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			if(param1 == _horizontalScrollPosition)
			{
				return;
			}
			contentScrollRect = listHolder.scrollRect;
			contentScrollRect.x = param1;
			listHolder.scrollRect = contentScrollRect;
			list.x = 0;
			header.x = -param1;
			super.setHorizontalScrollPosition(param1, true);
			invalidate(InvalidationType.SCROLL);
			columnsInvalid = true;
		}

		public function get labelFunction() : Function
		{
			return _labelFunction;
		}

		override protected function handleCellRendererClick(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:DataGridColumn = null;
			var _loc_4:DataGridEvent = null;
			super.handleCellRendererClick(param1);
			_loc_2 = param1.currentTarget;
			_loc_2.data;
			if(!(_loc_2 && _loc_2.data && _loc_2 == itemEditorInstance))
			{
				_loc_3 = _columns[_loc_2.listData.column];
				if(editable && _loc_3 && _loc_3.editable)
				{
					_loc_4 = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, false, true, _loc_2.listData.column, _loc_2.listData.row, _loc_2, _loc_3.dataField);
					dispatchEvent(_loc_4);
				}
			}
		}

		override protected function focusOutHandler(param1:FocusEvent) : void
		{
			setIMEMode(false);
			if(param1.target == this)
			{
				super.focusOutHandler(param1);
			}
			if(param1.relatedObject == this && itemRendererContains(itemEditorInstance, DisplayObject(param1.target)))
			{
				return;
			}
			if(param1.relatedObject == null && itemRendererContains(editedItemRenderer, DisplayObject(param1.target)))
			{
				return;
			}
			if(param1.relatedObject == null && itemRendererContains(itemEditorInstance, DisplayObject(param1.target)))
			{
				return;
			}
			if(itemEditorInstance && !param1.relatedObject || !(itemRendererContains(itemEditorInstance, param1.relatedObject)))
			{
				endEdit(DataGridEventReason.OTHER);
				removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
			}
		}

		protected function positionColumnStretchCursor(param1:MouseEvent) : void
		{
			columnStretchCursor.x = param1.stageX;
			columnStretchCursor.y = param1.stageY;
		}

		override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			if(itemEditorInstance)
			{
				endEdit(DataGridEventReason.OTHER);
			}
			invalidate(InvalidationType.SCROLL);
			super.setVerticalScrollPosition(param1, true);
		}

		public function get sortDescending() : Boolean
		{
			return _sortDescending;
		}

		protected function editorKeyDownHandler(param1:KeyboardEvent) : void
		{
			if(param1.keyCode == Keyboard.ESCAPE)
			{
				endEdit(DataGridEventReason.CANCELLED);
			}
			else
			{
				param1.ctrlKey;
				if(param1.ctrlKey && param1.charCode == 46)
				{
					endEdit(DataGridEventReason.CANCELLED);
				}
				else
				{
					if(!(param1.charCode == Keyboard.ENTER && param1.keyCode == 229))
					{
						if(endEdit(DataGridEventReason.NEW_ROW))
						{
							findNextEnterItemRenderer(param1);
						}
					}
				}
			}
		}

		override protected function calculateContentWidth() : void
		{
			var _loc_1:int = 0;
			var _loc_2:int = 0;
			var _loc_3:DataGridColumn = null;
			if(_columns.length == 0)
			{
				contentWidth = 0;
				return;
			}
			if(minColumnWidthInvalid)
			{
				_loc_1 = _columns.length;
				_loc_2 = 0;
				while(_loc_2 < _loc_1)
				{
					_loc_3 = _columns[_loc_2];
					_loc_3.minWidth = minColumnWidth;
					_loc_2++;
				}
				minColumnWidthInvalid = false;
			}
			if(horizontalScrollPolicy == ScrollPolicy.OFF)
			{
				contentWidth = availableWidth;
			}
			else
			{
				contentWidth = 0;
				_loc_1 = _columns.length;
				_loc_2 = 0;
				while(_loc_2 < _loc_1)
				{
					_loc_3 = _columns[_loc_2];
					if(_loc_3.visible)
					{
						contentWidth = contentWidth + _loc_3.width;
					}
					_loc_2++;
				}
				if(!isNaN(_horizontalScrollPosition) && (_horizontalScrollPosition + availableWidth) > contentWidth)
				{
					setHorizontalScrollPosition(contentWidth - availableWidth);
				}
			}
		}

		override public function get rowCount() : uint
		{
			return Math.ceil(calculateAvailableHeight() / rowHeight);
		}

		public function addColumn(param1:*) : DataGridColumn
		{
			return addColumnAt(param1, _columns.length);
		}

		protected function removeCellRenderersByColumn(param1:DataGridColumn) : void
		{
			var _loc_2:Array = null;
			if(param1 == null)
			{
				return;
			}
			_loc_2 = activeCellRenderersMap[param1];
			if(_loc_2 != null)
			{
				while(_loc_2.length > 0)
				{
					list.removeChild(_loc_2.pop());
				}
			}
		}

		override protected function handleCellRendererMouseEvent(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:int = 0;
			var _loc_4:String = null;
			var _loc_5:uint = 0;
			var _loc_6:DataGridColumn = null;
			var _loc_7:ICellRenderer = null;
			_loc_2 = param1.target;
			if(_loc_2)
			{
				_loc_3 = _loc_2.listData.row;
				if(param1.type == MouseEvent.ROLL_OVER)
				{
					_loc_4 = "over";
				}
				else
				{
					if(param1.type == MouseEvent.ROLL_OUT)
					{
						_loc_4 = "up";
					}
				}
				if(_loc_4)
				{
					_loc_5 = 0;
					while(_loc_5 < visibleColumns.length)
					{
						_loc_6 = visibleColumns[_loc_5];
						_loc_7 = getCellRendererAt(_loc_3, _loc_6.colNum);
						if(_loc_7)
						{
							_loc_7.setMouseState(_loc_4);
						}
						if(_loc_3 != currentHoveredRow)
						{
							_loc_7 = getCellRendererAt(currentHoveredRow, _loc_6.colNum);
							if(_loc_7)
							{
								_loc_7.setMouseState("up");
							}
						}
						_loc_5 = _loc_5 + 1;
					}
				}
			}
			super.handleCellRendererMouseEvent(param1);
		}

		protected function handleHeaderResizeMove(param1:MouseEvent) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_2 = param1.stageX - columnStretchStartX;
			_loc_3 = columnStretchStartWidth + _loc_2;
			resizeColumn(columnStretchIndex, _loc_3);
		}

		public function set rowHeight(param1:Number) : void
		{
			_rowHeight = Math.max(0, param1);
			invalidate(InvalidationType.SIZE);
		}

		protected function scrollToPosition(param1:int, param2:int) : void
		{
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:uint = 0;
			var _loc_6:int = NaN;
			var _loc_7:DataGridColumn = null;
			var _loc_8:DataGridColumn = null;
			_loc_3 = verticalScrollPosition;
			_loc_4 = horizontalScrollPosition;
			scrollToIndex(param1);
			_loc_6 = 0;
			_loc_7 = _columns[param2];
			_loc_5 = 0;
			while(_loc_5 < displayableColumns.length)
			{
				_loc_8 = displayableColumns[_loc_5];
				if(_loc_8 != _loc_7)
				{
					_loc_6 = _loc_6 + _loc_8.width;
				}
				else
				{
					break;
				}
				_loc_5 = _loc_5 + 1;
			}
			if(horizontalScrollPosition > _loc_6)
			{
				horizontalScrollPosition = _loc_6;
			}
			else
			{
				if((horizontalScrollPosition + availableWidth) < (_loc_6 + _loc_7.width))
				{
					horizontalScrollPosition = -(availableWidth - (_loc_6 + _loc_7.width));
				}
			}
			if((_loc_3 == verticalScrollPosition) || _loc_4 == horizontalScrollPosition)
			{
				drawNow();
			}
		}

		protected function findNextItemRenderer(param1:Boolean) : Boolean
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:Boolean = false;
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			var _loc_7:String = null;
			var _loc_8:DataGridEvent = null;
			if(!_editedItemPosition)
			{
				return false;
			}
			if(proposedEditedItemPosition !== undefined)
			{
				return false;
			}
			_loc_2 = _editedItemPosition.rowIndex;
			_loc_3 = _editedItemPosition.columnIndex;
			_loc_4 = false;
			_loc_5 = param1 ? -1 : 1;
			_loc_6 = length - 1;
			while(!_loc_4)
			{
				_loc_3 = _loc_3 + _loc_5;
				if(_loc_3 < 0 || _loc_3 >= _columns.length)
				{
					_loc_3 = _loc_3 < 0 ? _columns.length - 1 : 0;
					_loc_2 = _loc_2 + _loc_5;
					if(_loc_2 < 0 || _loc_2 > _loc_6)
					{
						setEditedItemPosition(null);
						losingFocus = true;
						setFocus();
						return false;
					}
				}
				_columns[_loc_3].editable;
				if(_columns[_loc_3].editable && _columns[_loc_3].visible)
				{
					_loc_4 = true;
					if(_loc_2 == _editedItemPosition.rowIndex)
					{
						_loc_7 = DataGridEventReason.NEW_COLUMN;
					}
					else
					{
						_loc_7 = DataGridEventReason.NEW_ROW;
					}
					if(!itemEditorInstance || endEdit(_loc_7))
					{
						_loc_8 = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, false, true, _loc_3, _loc_2);
						_loc_8.dataField = _columns[_loc_3].dataField;
						dispatchEvent(_loc_8);
					}
				}
			}
			return _loc_4;
		}

		override public function set dataProvider(param1:DataProvider) : void
		{
			if(_columns == null)
			{
				_columns = [];
			}
			if(_columns.length == 0)
			{
				createColumnsFromDataProvider();
			}
			removeCellRenderers();
		}

		override public function setSize(param1:Number, param2:Number) : void
		{
			super.setSize(param1, param2);
			columnsInvalid = true;
		}

		override public function scrollToIndex(param1:int) : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:int = NaN;
			drawNow();
			_loc_2 = (Math.floor((_verticalScrollPosition + availableHeight) / rowHeight)) - 1;
			_loc_3 = Math.ceil(_verticalScrollPosition / rowHeight);
			if(param1 < _loc_3)
			{
				verticalScrollPosition = param1 * rowHeight;
			}
			else
			{
				if(param1 >= _loc_2)
				{
					_loc_4 = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && hScrollBar ? 15 : 0;
					verticalScrollPosition = (param1 + 1) * rowHeight - availableHeight + _loc_4 + (showHeaders ? headerHeight : 0);
				}
			}
		}

		protected function calculateColumnSizes() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:int = NaN;
			var _loc_5:DataGridColumn = null;
			var _loc_6:DataGridColumn = null;
			var _loc_7:int = NaN;
			var _loc_8:int = 0;
			var _loc_9:int = NaN;
			var _loc_10:int = 0;
			var _loc_11:int = NaN;
			var _loc_12:int = NaN;
			var _loc_13:int = NaN;
			var _loc_14:int = NaN;
			_loc_4 = 0;
			if(_columns.length == 0)
			{
				visibleColumns = [];
				displayableColumns = [];
				return;
			}
			if(columnsInvalid)
			{
				columnsInvalid = false;
				visibleColumns = [];
				if(minColumnWidthInvalid)
				{
					_loc_2 = _columns.length;
					_loc_3 = 0;
					while(_loc_3 < _loc_2)
					{
						_columns[_loc_3].minWidth = minColumnWidth;
						_loc_3++;
					}
					minColumnWidthInvalid = false;
				}
				displayableColumns = null;
				_loc_2 = _columns.length;
				_loc_3 = 0;
				while(_loc_3 < _loc_2)
				{
					if(displayableColumns && _columns[_loc_3].visible)
					{
						displayableColumns.push(_columns[_loc_3]);
					}
					else
					{
						if(!displayableColumns && !_columns[_loc_3].visible)
						{
							displayableColumns = new Array(_loc_3);
							_loc_8 = 0;
							while(_loc_8 < _loc_3)
							{
								displayableColumns[_loc_8] = _columns[_loc_8];
								_loc_8++;
							}
						}
					}
					_loc_3++;
				}
				if(!displayableColumns)
				{
					displayableColumns = _columns;
				}
				if(horizontalScrollPolicy == ScrollPolicy.OFF)
				{
					_loc_2 = displayableColumns.length;
					_loc_3 = 0;
					while(_loc_3 < _loc_2)
					{
						visibleColumns.push(displayableColumns[_loc_3]);
						_loc_3++;
					}
				}
				else
				{
					_loc_2 = displayableColumns.length;
					_loc_9 = 0;
					_loc_3 = 0;
					while(_loc_3 < _loc_2)
					{
						_loc_5 = displayableColumns[_loc_3];
						if((_loc_9 + _loc_5.width) > _horizontalScrollPosition && _loc_9 < (_horizontalScrollPosition + availableWidth))
						{
							visibleColumns.push(_loc_5);
						}
						_loc_9 = _loc_9 + _loc_5.width;
						_loc_3++;
					}
				}
			}
			if(horizontalScrollPolicy == ScrollPolicy.OFF)
			{
				_loc_10 = 0;
				_loc_11 = 0;
				_loc_2 = visibleColumns.length;
				_loc_3 = 0;
				while(_loc_3 < _loc_2)
				{
					_loc_5 = visibleColumns[_loc_3];
					if(_loc_5.resizable)
					{
						if(!isNaN(_loc_5.explicitWidth))
						{
							_loc_11 = _loc_11 + _loc_5.width;
						}
						else
						{
							_loc_10++;
							_loc_11 = _loc_11 + _loc_5.minWidth;
						}
					}
					else
					{
						_loc_11 = _loc_11 + _loc_5.width;
					}
					_loc_4 = _loc_4 + _loc_5.width;
					_loc_3++;
				}
				_loc_13 = availableWidth;
				_loc_2 = availableWidth > _loc_11 && visibleColumns.length;
				_loc_3 = 0;
				while(_loc_3 < _loc_2)
				{
					_loc_6 = visibleColumns[_loc_3];
					_loc_12 = _loc_6.width / _loc_4;
					_loc_7 = availableWidth * _loc_12;
					_loc_6.setWidth(_loc_7);
					_loc_6.explicitWidth = NaN;
					_loc_13 = _loc_13 - _loc_7;
					_loc_3++;
				}
				if(_loc_13 && _loc_6)
				{
					_loc_6.setWidth(_loc_6.width + _loc_13);
				}
			}
		}

		public function set showHeaders(param1:Boolean) : void
		{
			_showHeaders = param1;
			invalidate(InvalidationType.SIZE);
		}

		override protected function initializeAccessibility() : void
		{
			if(DataGrid.createAccessibilityImplementation != null)
			{
				DataGrid.createAccessibilityImplementation(this);
			}
		}

		public function getColumnAt(param1:uint) : DataGridColumn
		{
			return _columns[param1];
		}

		public function get rowHeight() : Number
		{
			return _rowHeight;
		}

		public function set columns(param1:Array) : void
		{
			var _loc_2:uint = 0;
			removeCellRenderers();
			_columns = [];
			_loc_2 = 0;
			while(_loc_2 < param1.length)
			{
				addColumn(param1[_loc_2]);
				_loc_2 = _loc_2 + 1;
			}
		}

		public function get editedItemRenderer() : ICellRenderer
		{
			if(!itemEditorInstance)
			{
				return null;
			}
			return getCellRendererAt(actualRowIndex, actualColIndex);
		}

		public function get columns() : Array
		{
			return _columns.slice(0);
		}

		public function spaceColumnsEqually() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = 0;
			var _loc_3:DataGridColumn = null;
			drawNow();
			if(displayableColumns.length > 0)
			{
				_loc_1 = availableWidth / displayableColumns.length;
				_loc_2 = 0;
				while(_loc_2 < displayableColumns.length)
				{
					_loc_3 = displayableColumns[_loc_2];
					_loc_3.width = _loc_1;
					_loc_2++;
				}
				invalidate(InvalidationType.SIZE);
				columnsInvalid = true;
			}
		}
	}
}
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
package fl.controls
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.*;

	public class List extends SelectableList implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {focusRectSkin:null, focusRectPadding:null};
		public static var createAccessibilityImplementation:Function;
		protected var _labelField:String = "label";
		protected var _rowHeight:Number = 20;
		protected var _cellRenderer:Object;
		protected var _iconField:String = "icon";
		protected var _labelFunction:Function;
		protected var _iconFunction:Function;

		final public static function getStyleDefinition() : Object
		{
			return List.mergeStyles(defaultStyles, SelectableList.getStyleDefinition());
		}

		public function List()
		{
			_rowHeight = 20;
			_labelField = "label";
			_iconField = "icon";
			super();
		}

		public function get iconField() : String
		{
			return _iconField;
		}

		protected function doKeySelection(param1:int, param2:Boolean, param3:Boolean) : void
		{
			var _loc_4:Boolean = false;
			var _loc_5:int = 0;
			var _loc_6:Array = null;
			var _loc_7:int = 0;
			var _loc_8:int = 0;
			_loc_4 = false;
			if(param2)
			{
				_loc_6 = [];
				_loc_7 = lastCaretIndex;
				_loc_8 = param1;
				if(_loc_7 == -1)
				{
					_loc_7 = caretIndex != -1 ? caretIndex : _loc_8;
				}
				if(_loc_7 > _loc_8)
				{
					_loc_8 = _loc_7;
					_loc_8 = _loc_8;
				}
				_loc_5 = _loc_8;
				while(_loc_5 <= _loc_8)
				{
					_loc_6.push(_loc_5);
					_loc_5++;
				}
				selectedIndices = _loc_6;
				caretIndex = _loc_8;
				_loc_4 = true;
			}
			else
			{
				selectedIndex = _loc_8;
				var _loc_9:int = _loc_8;
				lastCaretIndex = _loc_9;
				caretIndex = _loc_9;
				_loc_4 = true;
			}
			invalidate(InvalidationType.DATA);
		}

		override protected function drawList() : void
		{
			var _loc_1:Rectangle = null;
			var _loc_2:uint = 0;
			var _loc_3:uint = 0;
			var _loc_4:uint = 0;
			var _loc_5:Object = null;
			var _loc_6:ICellRenderer = null;
			var _loc_7:Dictionary = null;
			var _loc_8:Dictionary = null;
			var _loc_9:Boolean = false;
			var _loc_10:String = null;
			var _loc_11:Object = null;
			var _loc_12:Sprite = null;
			var _loc_13:String = null;
			var _loc_14:contentPadding = contentPadding;
			listHolder.y = _loc_14;
			listHolder.x = _loc_14;
			_loc_1 = listHolder.scrollRect;
			_loc_1.x = _horizontalScrollPosition;
			_loc_1.y = Math.floor(_verticalScrollPosition) % rowHeight;
			listHolder.scrollRect = _loc_1;
			listHolder.cacheAsBitmap = useBitmapScrolling;
			_loc_2 = Math.floor(_verticalScrollPosition / rowHeight);
			_loc_3 = Math.min(length, (_loc_2 + rowCount) + 1);
			var _loc_14:Dictionary = new Dictionary(true);
			renderedItems = _loc_14;
			_loc_7 = _loc_14;
			_loc_4 = _loc_2;
			while(_loc_4 < _loc_3)
			{
				_loc_7[_dataProvider.getItemAt(_loc_4)] = true;
				_loc_4 = _loc_4 + 1;
			}
			_loc_8 = new Dictionary(true);
			while(activeCellRenderers.length > 0)
			{
				_loc_6 = activeCellRenderers.pop();
				_loc_5 = _loc_6.data;
				if(_loc_7[_loc_5] == null || invalidItems[_loc_5] == true)
				{
					availableCellRenderers.push(_loc_6);
				}
				else
				{
					_loc_8[_loc_5] = _loc_6;
					invalidItems[_loc_5] = true;
				}
				list.removeChild(_loc_6);
			}
			invalidItems = new Dictionary(true);
			_loc_4 = _loc_4;
			while(_loc_4 < _loc_3)
			{
				_loc_9 = false;
				_loc_5 = _dataProvider.getItemAt(_loc_4);
				if(_loc_8[_loc_5] != null)
				{
					_loc_9 = true;
					_loc_6 = _loc_8[_loc_5];
				}
				else
				{
					if(availableCellRenderers.length > 0)
					{
						_loc_6 = availableCellRenderers.pop();
					}
					else
					{
						_loc_6 = getDisplayObjectInstance(getStyleValue("cellRenderer"));
						_loc_12 = _loc_6;
						if(_loc_12 != null)
						{
							_loc_12.addEventListener(MouseEvent.CLICK, handleCellRendererClick, false, 0, true);
							_loc_12.addEventListener(MouseEvent.ROLL_OVER, handleCellRendererMouseEvent, false, 0, true);
							_loc_12.addEventListener(MouseEvent.ROLL_OUT, handleCellRendererMouseEvent, false, 0, true);
							_loc_12.addEventListener(Event.CHANGE, handleCellRendererChange, false, 0, true);
							_loc_12.doubleClickEnabled = true;
							_loc_12.addEventListener(MouseEvent.DOUBLE_CLICK, handleCellRendererDoubleClick, false, 0, true);
							if(_loc_12["setStyle"] != null)
							{
								var _loc_14:int = 0;
								var _loc_15:* = rendererStyles;
								for each(_loc_13 in _loc_15)
								{
									var _loc_16:Sprite = _loc_12;
									_loc_16["setStyle"](_loc_13, rendererStyles[_loc_13]);
								}
							}
						}
					}
				}
				list.addChild(_loc_6);
				activeCellRenderers.push(_loc_6);
				_loc_6.y = rowHeight * (_loc_4 - _loc_4);
				_loc_6.setSize(availableWidth + _maxHorizontalScrollPosition, rowHeight);
				_loc_10 = itemToLabel(_loc_5);
				_loc_11 = null;
				if(_iconFunction != null)
				{
					_loc_11 = _iconFunction(_loc_5);
				}
				else
				{
					if(_iconField != null)
					{
						_loc_11 = _loc_5[_iconField];
					}
				}
				if(!_loc_9)
				{
					_loc_6.data = _loc_5;
				}
				_loc_6.listData = new ListData(_loc_10, _loc_11, this, _loc_4, _loc_4, 0);
				_loc_6.selected = !(_selectedIndices.indexOf(_loc_4) == -1);
				if(_loc_6 is UIComponent)
				{
					_loc_6.drawNow();
				}
				_loc_4 = _loc_4 + 1;
			}
		}

		public function get iconFunction() : Function
		{
			return _iconFunction;
		}

		public function set iconField(param1:String) : void
		{
			if(param1 == _iconField)
			{
				return;
			}
			_iconField = param1;
			invalidate(InvalidationType.DATA);
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			var _loc_2:int = 0;
			if(!selectable)
			{
				return;
			}
			switch(param1.keyCode)
			{
			case Keyboard.UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.END:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.HOME:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.PAGE_UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.PAGE_DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.LEFT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.RIGHT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				break;
			case Keyboard.SPACE:
				if(caretIndex == -1)
				{
					caretIndex = param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && param1.shiftKey && param1.ctrlKey && 0;
				}
				doKeySelection(caretIndex, param1.shiftKey, param1.ctrlKey);
				scrollToSelected();
				break;
			default:
				_loc_2 = getNextIndexAtLetter(String.fromCharCode(param1.keyCode), selectedIndex);
				if(_loc_2 > -1)
				{
					selectedIndex = _loc_2;
					scrollToSelected();
				}
				break;
			}
			param1.stopPropagation();
		}

		override public function itemToLabel(param1:Object) : String
		{
			if(_labelFunction != null)
			{
				return String(_labelFunction(param1));
			}
			return param1[_labelField] != null ? String(param1[_labelField]) : "";
		}

		public function get labelField() : String
		{
			return _labelField;
		}

		override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
		{
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			_loc_4 = Math.max(Math.floor(calculateAvailableHeight() / rowHeight), 1);
			_loc_5 = -1;
			_loc_6 = 0;
			switch(param1)
			{
			case Keyboard.UP:
				if(caretIndex > 0)
				{
					_loc_5 = caretIndex - 1;
				}
				break;
			case Keyboard.DOWN:
				if(caretIndex < (length - 1))
				{
					_loc_5 = caretIndex + 1;
				}
				break;
			case Keyboard.PAGE_UP:
				if(caretIndex > 0)
				{
					_loc_5 = Math.max(caretIndex - _loc_4, 0);
				}
				break;
			case Keyboard.PAGE_DOWN:
				if(caretIndex < (length - 1))
				{
					_loc_5 = Math.min(caretIndex + _loc_4, length - 1);
				}
				break;
			case Keyboard.HOME:
				if(caretIndex > 0)
				{
					_loc_5 = 0;
				}
				break;
			case Keyboard.END:
				if(caretIndex < (length - 1))
				{
					_loc_5 = length - 1;
				}
				break;
			default:
				break;
			}
			if(_loc_5 >= 0)
			{
				doKeySelection(_loc_5, param2, param3);
				scrollToSelected();
			}
		}

		public function set labelField(param1:String) : void
		{
			if(param1 == _labelField)
			{
				return;
			}
			_labelField = param1;
			invalidate(InvalidationType.DATA);
		}

		public function set rowCount(param1:uint) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_2 = Number(getStyleValue("contentPadding"));
			_loc_3 = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0;
			height = (rowHeight * param1) + (2 * _loc_2) + _loc_3;
		}

		override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			list.x = -param1;
			super.setHorizontalScrollPosition(param1, true);
		}

		public function set iconFunction(param1:Function) : void
		{
			if(_iconFunction == param1)
			{
				return;
			}
			_iconFunction = param1;
			invalidate(InvalidationType.DATA);
		}

		public function get labelFunction() : Function
		{
			return _labelFunction;
		}

		override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void
		{
		}

		override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			invalidate(InvalidationType.SCROLL);
			super.setVerticalScrollPosition(param1, true);
		}

		protected function calculateAvailableHeight() : Number
		{
			var _loc_1:int = NaN;
			_loc_1 = Number(getStyleValue("contentPadding"));
			return (height - (_loc_1 * 2)) - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0);
		}

		override protected function draw() : void
		{
			var _loc_1:Boolean = false;
			_loc_1 = !(contentHeight == (rowHeight * length));
			contentHeight = rowHeight * length;
			if(isInvalid(InvalidationType.STYLES))
			{
				setStyles();
				drawBackground();
				if(contentPadding != getStyleValue("contentPadding"))
				{
					invalidate(InvalidationType.SIZE, false);
				}
				if(_cellRenderer != getStyleValue("cellRenderer"))
				{
					_invalidateList();
					_cellRenderer = getStyleValue("cellRenderer");
				}
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.STATE) || isInvalid(InvalidationType.RENDERER_STYLES))
			{
				updateRendererStyles();
			}
			if(isInvalid(InvalidationType.STYLES, InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.SCROLL, InvalidationType.SELECTED))
			{
				drawList();
			}
			updateChildren();
			validate();
		}

		override protected function configUI() : void
		{
			useFixedHorizontalScrolling = true;
			_horizontalScrollPolicy = ScrollPolicy.AUTO;
			_verticalScrollPolicy = ScrollPolicy.AUTO;
			super.configUI();
		}

		override public function get rowCount() : uint
		{
			return Math.ceil(calculateAvailableHeight() / rowHeight);
		}

		override protected function initializeAccessibility() : void
		{
			if(List.createAccessibilityImplementation != null)
			{
				List.createAccessibilityImplementation(this);
			}
		}

		override public function scrollToIndex(param1:int) : void
		{
			var _loc_2:uint = 0;
			var _loc_3:uint = 0;
			drawNow();
			_loc_2 = (Math.floor((_verticalScrollPosition + availableHeight) / rowHeight)) - 1;
			_loc_3 = Math.ceil(_verticalScrollPosition / rowHeight);
			if(param1 < _loc_3)
			{
				verticalScrollPosition = param1 * rowHeight;
			}
			else
			{
				if(param1 > _loc_2)
				{
					verticalScrollPosition = (param1 + 1) * rowHeight - availableHeight;
				}
			}
		}

		public function get rowHeight() : Number
		{
			return _rowHeight;
		}

		public function set labelFunction(param1:Function) : void
		{
			if(_labelFunction == param1)
			{
				return;
			}
			_labelFunction = param1;
			invalidate(InvalidationType.DATA);
		}

		public function set rowHeight(param1:Number) : void
		{
			_rowHeight = param1;
			invalidate(InvalidationType.SIZE);
		}
	}
}
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
package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import flash.events.*;

	public class ScrollBar extends UIComponent
	{
		private static var defaultStyles:Object = {downArrowDisabledSkin:"ScrollArrowDown_disabledSkin", downArrowDownSkin:"ScrollArrowDown_downSkin", downArrowOverSkin:"ScrollArrowDown_overSkin", downArrowUpSkin:"ScrollArrowDown_upSkin", thumbDisabledSkin:"ScrollThumb_upSkin", thumbDownSkin:"ScrollThumb_downSkin", thumbOverSkin:"ScrollThumb_overSkin", thumbUpSkin:"ScrollThumb_upSkin", trackDisabledSkin:"ScrollTrack_skin", trackDownSkin:"ScrollTrack_skin", trackOverSkin:"ScrollTrack_skin", trackUpSkin:"ScrollTrack_skin", upArrowDisabledSkin:"ScrollArrowUp_disabledSkin", upArrowDownSkin:"ScrollArrowUp_downSkin", upArrowOverSkin:"ScrollArrowUp_overSkin", upArrowUpSkin:"ScrollArrowUp_upSkin", thumbIcon:"ScrollBar_thumbIcon", repeatDelay:500, repeatInterval:35};
		public static const THUMB_STYLES:Object = {disabledSkin:"thumbDisabledSkin", downSkin:"thumbDownSkin", overSkin:"thumbOverSkin", upSkin:"thumbUpSkin", icon:"thumbIcon", textPadding:0};
		public static const WIDTH:Number = 15;
		public static const DOWN_ARROW_STYLES:Object = {disabledSkin:"downArrowDisabledSkin", downSkin:"downArrowDownSkin", overSkin:"downArrowOverSkin", upSkin:"downArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		public static const UP_ARROW_STYLES:Object = {disabledSkin:"upArrowDisabledSkin", downSkin:"upArrowDownSkin", overSkin:"upArrowOverSkin", upSkin:"upArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		public static const TRACK_STYLES:Object = {disabledSkin:"trackDisabledSkin", downSkin:"trackDownSkin", overSkin:"trackOverSkin", upSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		private var _direction:String = "vertical";
		protected var inDrag:Boolean = false;
		protected var upArrow:BaseButton;
		private var _pageScrollSize:Number = 0;
		protected var downArrow:BaseButton;
		private var _pageSize:Number = 10;
		private var thumbScrollOffset:Number;
		private var _maxScrollPosition:Number = 0;
		private var _scrollPosition:Number = 0;
		protected var track:BaseButton;
		private var _minScrollPosition:Number = 0;
		private var _lineScrollSize:Number = 1;
		protected var thumb:LabelButton;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function ScrollBar()
		{
			_pageSize = 10;
			_pageScrollSize = 0;
			_lineScrollSize = 1;
			_minScrollPosition = 0;
			_maxScrollPosition = 0;
			_scrollPosition = 0;
			_direction = ScrollBarDirection.VERTICAL;
			inDrag = false;
			super();
			setStyles();
			focusEnabled = false;
		}

		public function get minScrollPosition() : Number
		{
			return _minScrollPosition;
		}

		public function set minScrollPosition(param1:Number) : void
		{
			setScrollProperties(_pageSize, param1, _maxScrollPosition);
		}

		public function setScrollPosition(param1:Number, param2:Boolean = true) : void
		{
			var _loc_3:int = NaN;
			_loc_3 = scrollPosition;
			_scrollPosition = Math.max(_minScrollPosition, Math.min(_maxScrollPosition, param1));
			if(_loc_3 == _scrollPosition)
			{
				return;
			}
			if(param2)
			{
				dispatchEvent(new ScrollEvent(_direction, scrollPosition - _loc_3, scrollPosition));
			}
			updateThumb();
		}

		public function set scrollPosition(param1:Number) : void
		{
			setScrollPosition(param1, true);
		}

		public function get pageScrollSize() : Number
		{
			return _pageScrollSize == 0 ? _pageSize : _pageScrollSize;
		}

		public function set pageSize(param1:Number) : void
		{
			if(param1 > 0)
			{
				_pageSize = param1;
			}
		}

		public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
		{
			this.pageSize = param1;
			_minScrollPosition = param2;
			_maxScrollPosition = param3;
			if(param4 >= 0)
			{
				_pageScrollSize = param4;
			}
			enabled = _maxScrollPosition > _minScrollPosition;
			setScrollPosition(_scrollPosition, false);
			updateThumb();
		}

		override public function set enabled(param1:Boolean) : void
		{
			var _loc_2:Boolean = enabled && _maxScrollPosition > _minScrollPosition;
			upArrow.enabled = _loc_2;
			var _loc_2:Boolean = _loc_2;
			thumb.enabled = _loc_2;
			var _loc_2:Boolean = _loc_2;
			track.enabled = _loc_2;
			downArrow.enabled = _loc_2;
			updateThumb();
		}

		protected function updateThumb() : void
		{
			var _loc_1:int = NaN;
			_loc_1 = (_maxScrollPosition - _minScrollPosition) + _pageSize;
			if(track.height <= 12 || _maxScrollPosition <= _minScrollPosition || _loc_1 == 0 || isNaN(_loc_1))
			{
				thumb.height = 12;
				thumb.visible = false;
			}
			else
			{
				thumb.height = Math.max(13, (_pageSize / _loc_1) * track.height);
				thumb.y = track.y + (track.height - thumb.height) * (_scrollPosition - _minScrollPosition) / (_maxScrollPosition - _minScrollPosition);
				thumb.visible = enabled;
			}
		}

		protected function thumbPressHandler(param1:MouseEvent) : void
		{
			inDrag = true;
			thumbScrollOffset = mouseY - thumb.y;
			thumb.mouseStateLocked = true;
			mouseChildren = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleThumbDrag, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
		}

		protected function thumbReleaseHandler(param1:MouseEvent) : void
		{
			inDrag = false;
			mouseChildren = true;
			thumb.mouseStateLocked = false;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleThumbDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler);
		}

		public function set pageScrollSize(param1:Number) : void
		{
			if(param1 >= 0)
			{
				_pageScrollSize = param1;
			}
		}

		protected function handleThumbDrag(param1:MouseEvent) : void
		{
			var _loc_2:int = NaN;
			_loc_2 = Math.max(0, Math.min(track.height - thumb.height, (mouseY - track.y) - thumbScrollOffset));
			setScrollPosition((_loc_2 / (track.height - thumb.height)) * (_maxScrollPosition - _minScrollPosition) + _minScrollPosition);
		}

		public function set direction(param1:String) : void
		{
			var _loc_2:Boolean = false;
			if(_direction == param1)
			{
				return;
			}
			_direction = param1;
			if(isLivePreview)
			{
				return;
			}
			setScaleY(1);
			_loc_2 = _direction == ScrollBarDirection.HORIZONTAL;
			if(!componentInspectorSetting)
			{
				if(!_loc_2 && rotation == -90)
				{
					rotation = 0;
					setScaleX(1);
				}
			}
			invalidate(InvalidationType.SIZE);
		}

		public function set lineScrollSize(param1:Number) : void
		{
			if(param1 > 0)
			{
				_lineScrollSize = param1;
			}
		}

		override public function get height() : Number
		{
			return _direction == ScrollBarDirection.HORIZONTAL ? super.width : super.height;
		}

		protected function scrollPressHandler(param1:ComponentEvent) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			param1.stopImmediatePropagation();
			if(param1.currentTarget == upArrow)
			{
				setScrollPosition(_scrollPosition - _lineScrollSize);
			}
			else
			{
				if(param1.currentTarget == downArrow)
				{
					setScrollPosition(_scrollPosition + _lineScrollSize);
				}
				else
				{
					_loc_2 = (track.mouseY / track.height) * (_maxScrollPosition - _minScrollPosition) + _minScrollPosition;
					_loc_3 = pageScrollSize == 0 ? pageSize : pageScrollSize;
					if(_scrollPosition < _loc_2)
					{
						setScrollPosition(Math.min(_loc_2, _scrollPosition + _loc_3));
					}
					else
					{
						if(_scrollPosition > _loc_2)
						{
							setScrollPosition(Math.max(_loc_2, _scrollPosition - _loc_3));
						}
					}
				}
			}
		}

		public function get pageSize() : Number
		{
			return _pageSize;
		}

		public function set maxScrollPosition(param1:Number) : void
		{
			setScrollProperties(_pageSize, _minScrollPosition, param1);
		}

		public function get scrollPosition() : Number
		{
			return _scrollPosition;
		}

		override public function get enabled() : Boolean
		{
			return super.enabled;
		}

		override protected function draw() : void
		{
			var _loc_1:int = NaN;
			if(isInvalid(InvalidationType.SIZE))
			{
				_loc_1 = super.height;
				downArrow.move(0, Math.max(upArrow.height, _loc_1 - downArrow.height));
				track.setSize(WIDTH, Math.max(0, _loc_1 - (downArrow.height + upArrow.height)));
				updateThumb();
			}
			if(isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
			{
				setStyles();
			}
			downArrow.drawNow();
			upArrow.drawNow();
			track.drawNow();
			thumb.drawNow();
			validate();
		}

		override protected function configUI() : void
		{
			super.configUI();
			track = new BaseButton();
			track.move(0, 14);
			track.useHandCursor = false;
			track.autoRepeat = true;
			track.focusEnabled = false;
			addChild(track);
			thumb = new LabelButton();
			thumb.label = "";
			thumb.setSize(WIDTH, 15);
			thumb.move(0, 15);
			thumb.focusEnabled = false;
			addChild(thumb);
			downArrow = new BaseButton();
			downArrow.setSize(WIDTH, 14);
			downArrow.autoRepeat = true;
			downArrow.focusEnabled = false;
			addChild(downArrow);
			upArrow = new BaseButton();
			upArrow.setSize(WIDTH, 14);
			upArrow.move(0, 0);
			upArrow.autoRepeat = true;
			upArrow.focusEnabled = false;
			addChild(upArrow);
			upArrow.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			downArrow.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			track.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true);
			enabled = false;
		}

		public function get direction() : String
		{
			return _direction;
		}

		public function get lineScrollSize() : Number
		{
			return _lineScrollSize;
		}

		override public function setSize(param1:Number, param2:Number) : void
		{
			if(_direction == ScrollBarDirection.HORIZONTAL)
			{
				super.setSize(param2, param1);
			}
			else
			{
				super.setSize(param1, param2);
			}
		}

		public function get maxScrollPosition() : Number
		{
			return _maxScrollPosition;
		}

		override public function get width() : Number
		{
			return _direction == ScrollBarDirection.HORIZONTAL ? super.height : super.width;
		}

		protected function setStyles() : void
		{
			copyStylesToChild(downArrow, DOWN_ARROW_STYLES);
			copyStylesToChild(thumb, THUMB_STYLES);
			copyStylesToChild(track, TRACK_STYLES);
			copyStylesToChild(upArrow, UP_ARROW_STYLES);
		}
	}
}
package fl.controls
{
	public class ScrollBarDirection extends Object
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";

		public function ScrollBarDirection()
		{
			super();
		}
	}
}
package fl.controls
{
	public class ScrollPolicy extends Object
	{
		public static const OFF:String = "off";
		public static const ON:String = "on";
		public static const AUTO:String = "auto";

		public function ScrollPolicy()
		{
			super();
		}
	}
}
package fl.controls
{
	import fl.containers.*;
	import fl.controls.listClasses.*;
	import fl.core.*;
	import fl.data.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.*;

	public class SelectableList extends BaseScrollPane implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {skin:"List_skin", cellRenderer:CellRenderer, contentPadding:null, disabledAlpha:null};
		public static var createAccessibilityImplementation:Function;
		protected var invalidItems:Dictionary;
		protected var renderedItems:Dictionary;
		protected var listHolder:Sprite;
		protected var _allowMultipleSelection:Boolean = false;
		protected var lastCaretIndex:int = -1;
		protected var _selectedIndices:Array;
		protected var availableCellRenderers:Array;
		protected var list:Sprite;
		protected var caretIndex:int = -1;
		protected var updatedRendererStyles:Object;
		protected var preChangeItems:Array;
		protected var activeCellRenderers:Array;
		protected var rendererStyles:Object;
		protected var _verticalScrollPosition:Number;
		protected var _dataProvider:DataProvider;
		protected var _horizontalScrollPosition:Number;
		private var collectionItemImport:SimpleCollectionItem;
		protected var _selectable:Boolean = true;

		final public static function getStyleDefinition() : Object
		{
			return SelectableList.mergeStyles(defaultStyles, BaseScrollPane.getStyleDefinition());
		}

		public function SelectableList()
		{
			_allowMultipleSelection = false;
			_selectable = true;
			caretIndex = -1;
			lastCaretIndex = -1;
			super();
			activeCellRenderers = [];
			availableCellRenderers = [];
			invalidItems = new Dictionary(true);
			renderedItems = new Dictionary(true);
			_selectedIndices = [];
			if(dataProvider == null)
			{
				dataProvider = new DataProvider();
			}
			verticalScrollPolicy = ScrollPolicy.AUTO;
			rendererStyles = {};
			updatedRendererStyles = {};
		}

		protected function drawList() : void
		{
		}

		public function set allowMultipleSelection(param1:Boolean) : void
		{
			if(param1 == _allowMultipleSelection)
			{
				return;
			}
			_allowMultipleSelection = param1;
			if(!param1 && _selectedIndices.length > 1)
			{
				_selectedIndices = [_selectedIndices.pop()];
				invalidate(InvalidationType.DATA);
			}
		}

		public function sortItemsOn(param1:String, param2:Object = null)
		{
			return _dataProvider.sortOn(param1, param2);
		}

		public function removeItemAt(param1:uint) : Object
		{
			return _dataProvider.removeItemAt(param1);
		}

		public function get selectedItem() : Object
		{
			return _selectedIndices.length == 0 ? null : _dataProvider.getItemAt(selectedIndex);
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			if(!selectable)
			{
				return;
			}
			switch(param1.keyCode)
			{
			case Keyboard.UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.END:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.HOME:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.PAGE_UP:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.PAGE_DOWN:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionVertically(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.LEFT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			case Keyboard.RIGHT:
				param1.shiftKey;
				param1.ctrlKey;
				moveSelectionHorizontally(param1.keyCode, _allowMultipleSelection, _allowMultipleSelection);
				param1.stopPropagation();
				break;
			default:
				break;
			}
		}

		public function get selectable() : Boolean
		{
			return _selectable;
		}

		public function itemToCellRenderer(param1:Object) : ICellRenderer
		{
			var _loc_2:* = undefined;
			var _loc_3:ICellRenderer = null;
			if(param1 != null)
			{
				var _loc_4:int = 0;
				var _loc_5:* = activeCellRenderers;
				for each(_loc_2 in _loc_5)
				{
					_loc_3 = activeCellRenderers[_loc_2];
					if(_loc_3.data == param1)
					{
						return _loc_3;
					}
				}
			}
			return null;
		}

		public function getNextIndexAtLetter(param1:String, param2:int = -1) : int
		{
			var _loc_3:int = 0;
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			var _loc_6:Object = null;
			var _loc_7:String = null;
			if(length == 0)
			{
				return -1;
			}
			param1 = param1.toUpperCase();
			_loc_3 = length - 1;
			_loc_4 = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = (param2 + 1) + _loc_4;
				if(_loc_5 > (length - 1))
				{
					_loc_5 = _loc_5 - length;
				}
				_loc_6 = getItemAt(_loc_5);
				if(_loc_6 == null)
				{
					break;
				}
				_loc_7 = itemToLabel(_loc_6);
				if(_loc_7 == null)
				{
				}
				else
				{
					if(_loc_7.charAt(0).toUpperCase() == param1)
					{
						return _loc_5;
					}
				}
				_loc_4 = _loc_4 + 1;
			}
			return -1;
		}

		public function invalidateList() : void
		{
			_invalidateList();
			invalidate(InvalidationType.DATA);
		}

		override public function set enabled(param1:Boolean) : void
		{
			list.mouseChildren = _enabled;
		}

		public function get selectedIndices() : Array
		{
			return _selectedIndices.concat();
		}

		public function set selectable(param1:Boolean) : void
		{
			if(param1 == _selectable)
			{
				return;
			}
			if(!param1)
			{
				selectedIndices = [];
			}
			_selectable = param1;
		}

		public function itemToLabel(param1:Object) : String
		{
			return param1["label"];
		}

		public function addItemAt(param1:Object, param2:uint) : void
		{
			_dataProvider.addItemAt(param1, param2);
			invalidateList();
		}

		public function replaceItemAt(param1:Object, param2:uint) : Object
		{
			return _dataProvider.replaceItemAt(param1, param2);
		}

		protected function handleDataChange(param1:DataChangeEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:String = null;
			var _loc_5:uint = 0;
			_loc_2 = param1.startIndex;
			_loc_3 = param1.endIndex;
			_loc_4 = param1.changeType;
			if(_loc_4 == DataChangeType.INVALIDATE_ALL)
			{
				clearSelection();
				invalidateList();
			}
			else
			{
				if(_loc_4 == DataChangeType.INVALIDATE)
				{
					_loc_5 = 0;
					while(_loc_5 < param1.items.length)
					{
						invalidateItem(param1.items[_loc_5]);
						_loc_5 = _loc_5 + 1;
					}
				}
				else
				{
					if(_loc_4 == DataChangeType.ADD)
					{
						_loc_5 = 0;
						while(_loc_5 < _selectedIndices.length)
						{
							if(_selectedIndices[_loc_5] >= _loc_2)
							{
								_selectedIndices[_loc_5] = _selectedIndices[_loc_5] + (_loc_2 - _loc_3);
							}
							_loc_5 = _loc_5 + 1;
						}
					}
					else
					{
						if(_loc_4 == DataChangeType.REMOVE)
						{
							_loc_5 = 0;
							while(_loc_5 < _selectedIndices.length)
							{
								if(_selectedIndices[_loc_5] >= _loc_2)
								{
									if(_selectedIndices[_loc_5] <= _loc_3)
									{
									}
									else
									{
										_selectedIndices[_loc_5] = _selectedIndices[_loc_5] - (_loc_2 - _loc_3) + 1;
									}
								}
								_loc_5 = _loc_5 + 1;
							}
						}
						else
						{
							if(_loc_4 == DataChangeType.REMOVE_ALL)
							{
								clearSelection();
							}
							else
							{
								if(_loc_4 == DataChangeType.REPLACE)
								{
								}
								else
								{
									selectedItems = preChangeItems;
									preChangeItems = null;
								}
							}
						}
					}
				}
			}
			invalidate(InvalidationType.DATA);
		}

		protected function _invalidateList() : void
		{
			availableCellRenderers = [];
			while(activeCellRenderers.length > 0)
			{
				list.removeChild(activeCellRenderers.pop());
			}
		}

		protected function updateRendererStyles() : void
		{
			var _loc_1:Array = null;
			var _loc_2:uint = 0;
			var _loc_3:uint = 0;
			var _loc_4:String = null;
			_loc_1 = availableCellRenderers.concat(activeCellRenderers);
			_loc_2 = _loc_1.length;
			_loc_3 = 0;
			while(_loc_3 < _loc_2)
			{
				if(_loc_1[_loc_3].setStyle == null)
				{
				}
				else
				{
					var _loc_5:int = 0;
					var _loc_6:* = updatedRendererStyles;
					for each(_loc_4 in _loc_6)
					{
						_loc_1[_loc_3].setStyle(_loc_4, updatedRendererStyles[_loc_4]);
					}
					_loc_1[_loc_3].drawNow();
				}
				_loc_3 = _loc_3 + 1;
			}
			updatedRendererStyles = {};
		}

		public function set selectedItem(param1:Object) : void
		{
			var _loc_2:int = 0;
			_loc_2 = _dataProvider.getItemIndex(param1);
			selectedIndex = _loc_2;
		}

		public function sortItems(...restArguments)
		{
			return _dataProvider.sort.apply(_dataProvider, restArguments);
		}

		public function removeAll() : void
		{
			_dataProvider.removeAll();
		}

		protected function handleCellRendererChange(param1:Event) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:uint = 0;
			_loc_2 = param1.currentTarget;
			_loc_3 = _loc_2.listData.index;
			_dataProvider.invalidateItemAt(_loc_3);
		}

		protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
		{
		}

		override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			var _loc_3:int = NaN;
			if(param1 == _horizontalScrollPosition)
			{
				return;
			}
			_loc_3 = param1 - _horizontalScrollPosition;
			_horizontalScrollPosition = param1;
			if(param2)
			{
				dispatchEvent(new ScrollEvent(ScrollBarDirection.HORIZONTAL, _loc_3, param1));
			}
		}

		public function scrollToSelected() : void
		{
			scrollToIndex(selectedIndex);
		}

		public function invalidateItem(param1:Object) : void
		{
			if(renderedItems[param1] == null)
			{
				return;
			}
			invalidItems[param1] = true;
			invalidate(InvalidationType.DATA);
		}

		protected function handleCellRendererClick(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:uint = 0;
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:uint = 0;
			if(!_enabled)
			{
				return;
			}
			_loc_2 = param1.currentTarget;
			_loc_3 = _loc_2.listData.index;
			if(!(dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, false, true, _loc_2.listData.column, _loc_2.listData.row, _loc_3, _loc_2.data))) || !_selectable)
			{
				return;
			}
			_loc_4 = selectedIndices.indexOf(_loc_3);
			if(!_allowMultipleSelection)
			{
				if(_loc_4 != -1)
				{
					return;
				}
				_loc_2.selected = true;
				_selectedIndices = [_loc_3];
				var _loc_7:uint = _loc_3;
				caretIndex = _loc_7;
				lastCaretIndex = _loc_7;
			}
			else
			{
				if(param1.shiftKey)
				{
					_loc_6 = _selectedIndices.length > 0 ? _selectedIndices[0] : _loc_7;
					_selectedIndices = [];
					if(_loc_6 > _loc_7)
					{
						_loc_5 = _loc_6;
						while(_loc_5 >= _loc_7)
						{
							_selectedIndices.push(_loc_5);
							_loc_5 = _loc_5 - 1;
						}
					}
					else
					{
						_loc_5 = _loc_5;
						while(_loc_5 <= _loc_7)
						{
							_selectedIndices.push(_loc_5);
							_loc_5++;
						}
					}
					caretIndex = _loc_7;
				}
				else
				{
					if(param1.ctrlKey)
					{
						if(_loc_4 != -1)
						{
							_loc_2.selected = false;
							_selectedIndices.splice(_loc_4, 1);
						}
						else
						{
							_loc_2.selected = true;
							_selectedIndices.push(_loc_7);
						}
						caretIndex = _loc_7;
					}
					else
					{
						_selectedIndices = [_loc_7];
						var _loc_7:uint = _loc_7;
						caretIndex = _loc_7;
						lastCaretIndex = _loc_7;
					}
				}
			}
			dispatchEvent(new Event(Event.CHANGE));
			invalidate(InvalidationType.DATA);
		}

		public function get length() : uint
		{
			return _dataProvider.length;
		}

		public function get allowMultipleSelection() : Boolean
		{
			return _allowMultipleSelection;
		}

		protected function onPreChange(param1:DataChangeEvent) : void
		{
			switch(param1.changeType)
			{
			case DataChangeType.REMOVE:
				break;
			case DataChangeType.ADD:
				break;
			case DataChangeType.INVALIDATE:
				break;
			case DataChangeType.REMOVE_ALL:
				break;
			case DataChangeType.REPLACE:
				break;
			case DataChangeType.INVALIDATE_ALL:
				break;
			default:
				preChangeItems = selectedItems;
				break;
			}
		}

		public function getRendererStyle(param1:String, param2:int = -1) : Object
		{
			return rendererStyles[param1];
		}

		override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			var _loc_3:int = NaN;
			if(param1 == _verticalScrollPosition)
			{
				return;
			}
			_loc_3 = param1 - _verticalScrollPosition;
			_verticalScrollPosition = param1;
			if(param2)
			{
				dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, _loc_3, param1));
			}
		}

		protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void
		{
		}

		public function set selectedIndices(param1:Array) : void
		{
			if(!_selectable)
			{
				return;
			}
			_selectedIndices = param1 == null ? [] : param1.concat();
			invalidate(InvalidationType.SELECTED);
		}

		public function get selectedIndex() : int
		{
			return _selectedIndices.length == 0 ? -1 : _selectedIndices[_selectedIndices.length - 1];
		}

		override protected function draw() : void
		{
			super.draw();
		}

		override protected function configUI() : void
		{
			super.configUI();
			listHolder = new Sprite();
			addChild(listHolder);
			listHolder.scrollRect = contentScrollRect;
			list = new Sprite();
			listHolder.addChild(list);
		}

		public function addItem(param1:Object) : void
		{
			_dataProvider.addItem(param1);
			invalidateList();
		}

		protected function handleCellRendererMouseEvent(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:String = null;
			_loc_2 = param1.target;
			_loc_3 = param1.type == MouseEvent.ROLL_OVER ? ListEvent.ITEM_ROLL_OVER : ListEvent.ITEM_ROLL_OUT;
			dispatchEvent(new ListEvent(_loc_3, false, false, _loc_2.listData.column, _loc_2.listData.row, _loc_2.listData.index, _loc_2.data));
		}

		public function clearRendererStyle(param1:String, param2:int = -1) : void
		{
			updatedRendererStyles[param1] = null;
			invalidate(InvalidationType.RENDERER_STYLES);
		}

		protected function handleCellRendererDoubleClick(param1:MouseEvent) : void
		{
			var _loc_2:ICellRenderer = null;
			var _loc_3:uint = 0;
			if(!_enabled)
			{
				return;
			}
			_loc_2 = param1.currentTarget;
			_loc_3 = _loc_2.listData.index;
			dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK, false, true, _loc_2.listData.column, _loc_2.listData.row, _loc_3, _loc_2.data));
		}

		public function get rowCount() : uint
		{
			return 0;
		}

		public function isItemSelected(param1:Object) : Boolean
		{
			return selectedItems.indexOf(param1) > -1;
		}

		public function set dataProvider(param1:DataProvider) : void
		{
			if(_dataProvider != null)
			{
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange);
				_dataProvider.removeEventListener(DataChangeEvent.PRE_DATA_CHANGE, onPreChange);
			}
			_dataProvider = param1;
			_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			_dataProvider.addEventListener(DataChangeEvent.PRE_DATA_CHANGE, onPreChange, false, 0, true);
			clearSelection();
			invalidateList();
		}

		override protected function drawLayout() : void
		{
			super.drawLayout();
			contentScrollRect = listHolder.scrollRect;
			contentScrollRect.width = availableWidth;
			contentScrollRect.height = availableHeight;
			listHolder.scrollRect = contentScrollRect;
		}

		public function getItemAt(param1:uint) : Object
		{
			return _dataProvider.getItemAt(param1);
		}

		override protected function initializeAccessibility() : void
		{
			if(SelectableList.createAccessibilityImplementation != null)
			{
				SelectableList.createAccessibilityImplementation(this);
			}
		}

		public function scrollToIndex(param1:int) : void
		{
		}

		public function removeItem(param1:Object) : Object
		{
			return _dataProvider.removeItem(param1);
		}

		public function get dataProvider() : DataProvider
		{
			return _dataProvider;
		}

		public function set maxHorizontalScrollPosition(param1:Number) : void
		{
			_maxHorizontalScrollPosition = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function setRendererStyle(param1:String, param2:Object, param3:uint = 0) : void
		{
			if(rendererStyles[param1] == param2)
			{
				return;
			}
			updatedRendererStyles[param1] = param2;
			rendererStyles[param1] = param2;
			invalidate(InvalidationType.RENDERER_STYLES);
		}

		public function invalidateItemAt(param1:uint) : void
		{
			var _loc_2:Object = null;
			_loc_2 = _dataProvider.getItemAt(param1);
			if(_loc_2 != null)
			{
				invalidateItem(_loc_2);
			}
		}

		public function set selectedItems(param1:Array) : void
		{
			var _loc_2:Array = null;
			var _loc_3:uint = 0;
			var _loc_4:int = 0;
			if(param1 == null)
			{
				selectedIndices = null;
				return;
			}
			_loc_2 = [];
			_loc_3 = 0;
			while(_loc_3 < param1.length)
			{
				_loc_4 = _dataProvider.getItemIndex(param1[_loc_3]);
				if(_loc_4 != -1)
				{
					_loc_2.push(_loc_4);
				}
				_loc_3 = _loc_3 + 1;
			}
			selectedIndices = _loc_2;
		}

		public function clearSelection() : void
		{
			selectedIndex = -1;
		}

		override public function get maxHorizontalScrollPosition() : Number
		{
			return _maxHorizontalScrollPosition;
		}

		public function get selectedItems() : Array
		{
			var _loc_1:Array = null;
			var _loc_2:uint = 0;
			_loc_1 = [];
			_loc_2 = 0;
			while(_loc_2 < _selectedIndices.length)
			{
				_loc_1.push(_dataProvider.getItemAt(_selectedIndices[_loc_2]));
				_loc_2 = _loc_2 + 1;
			}
			return _loc_1;
		}

		public function set selectedIndex(param1:int) : void
		{
			selectedIndices = param1 == -1 ? null : [param1];
		}
	}
}
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
package fl.controls
{
	import fl.core.*;
	import fl.events.*;
	import flash.events.*;
	import flash.text.*;

	public class UIScrollBar extends ScrollBar
	{
		private static var defaultStyles:Object = {};
		protected var inScroll:Boolean = false;
		protected var _scrollTarget:TextField;
		protected var inEdit:Boolean = false;

		final public static function getStyleDefinition() : Object
		{
			return UIComponent.mergeStyles(defaultStyles, ScrollBar.getStyleDefinition());
		}

		public function UIScrollBar()
		{
			inEdit = false;
			inScroll = false;
			super();
		}

		protected function handleTargetScroll(param1:Event) : void
		{
			if(inDrag)
			{
				return;
			}
			if(!enabled)
			{
				return;
			}
			inEdit = true;
			updateScrollTargetProperties();
			scrollPosition = direction == ScrollBarDirection.HORIZONTAL ? _scrollTarget.scrollH : _scrollTarget.scrollV;
			inEdit = false;
		}

		override public function set minScrollPosition(param1:Number) : void
		{
		}

		override public function setScrollPosition(param1:Number, param2:Boolean = true) : void
		{
			super.setScrollPosition(param1, param2);
			if(!_scrollTarget)
			{
				inScroll = false;
				return;
			}
			updateTargetScroll();
		}

		override public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
		{
			var _loc_5:int = NaN;
			var _loc_6:int = NaN;
			_loc_5 = param3;
			_loc_6 = param2 < 0 ? 0 : param2;
			if(_scrollTarget != null)
			{
				if(direction == ScrollBarDirection.HORIZONTAL)
				{
					_loc_5 = param3 > _scrollTarget.maxScrollH ? _scrollTarget.maxScrollH : _loc_5;
				}
				else
				{
					_loc_5 = param3 > _scrollTarget.maxScrollV ? _scrollTarget.maxScrollV : _loc_5;
				}
			}
			super.setScrollProperties(param1, _loc_6, _loc_5, param4);
		}

		public function get scrollTargetName() : String
		{
			return _scrollTarget.name;
		}

		public function get scrollTarget() : TextField
		{
			return _scrollTarget;
		}

		protected function updateScrollTargetProperties() : void
		{
			var _loc_1:Boolean = false;
			var _loc_2:int = NaN;
			if(_scrollTarget == null)
			{
				setScrollProperties(pageSize, minScrollPosition, maxScrollPosition, pageScrollSize);
				scrollPosition = 0;
			}
			else
			{
				_loc_1 = direction == ScrollBarDirection.HORIZONTAL;
				_loc_2 = 10;
				setScrollProperties(_loc_2, 1, _scrollTarget.maxScrollV, pageScrollSize);
				scrollPosition = _scrollTarget.scrollV;
			}
		}

		public function update() : void
		{
			inEdit = true;
			updateScrollTargetProperties();
			inEdit = false;
		}

		public function set scrollTargetName(param1:String) : void
		{
			var target:String = param1;
			try
			{
				scrollTarget = parent.getChildByName(target);
			}
			catch(error:Error)
			{
				throw new Error("ScrollTarget not found, or is not a TextField");
			}
		}

		override public function set direction(param1:String) : void
		{
			if(isLivePreview)
			{
				return;
			}
			updateScrollTargetProperties();
		}

		protected function handleTargetChange(param1:Event) : void
		{
			inEdit = true;
			setScrollPosition(direction == ScrollBarDirection.HORIZONTAL ? _scrollTarget.scrollH : _scrollTarget.scrollV, true);
			updateScrollTargetProperties();
			inEdit = false;
		}

		override public function set maxScrollPosition(param1:Number) : void
		{
			var _loc_2:int = NaN;
			_loc_2 = param1;
			if(_scrollTarget != null)
			{
				if(direction == ScrollBarDirection.HORIZONTAL)
				{
					_loc_2 = _loc_2 > _scrollTarget.maxScrollH ? _scrollTarget.maxScrollH : _loc_2;
				}
				else
				{
					_loc_2 = _loc_2 > _scrollTarget.maxScrollV ? _scrollTarget.maxScrollV : _loc_2;
				}
			}
		}

		protected function updateTargetScroll(param1:ScrollEvent = null) : void
		{
			if(inEdit)
			{
				return;
			}
			if(direction == ScrollBarDirection.HORIZONTAL)
			{
				_scrollTarget.scrollH = scrollPosition;
			}
			else
			{
				_scrollTarget.scrollV = scrollPosition;
			}
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.DATA))
			{
				updateScrollTargetProperties();
			}
			super.draw();
		}

		public function set scrollTarget(param1:TextField) : void
		{
			if(_scrollTarget != null)
			{
				_scrollTarget.removeEventListener(Event.CHANGE, handleTargetChange, false);
				_scrollTarget.removeEventListener(TextEvent.TEXT_INPUT, handleTargetChange, false);
				_scrollTarget.removeEventListener(Event.SCROLL, handleTargetScroll, false);
				removeEventListener(ScrollEvent.SCROLL, updateTargetScroll, false);
			}
			_scrollTarget = param1;
			if(_scrollTarget != null)
			{
				_scrollTarget.addEventListener(Event.CHANGE, handleTargetChange, false, 0, true);
				_scrollTarget.addEventListener(TextEvent.TEXT_INPUT, handleTargetChange, false, 0, true);
				_scrollTarget.addEventListener(Event.SCROLL, handleTargetScroll, false, 0, true);
				addEventListener(ScrollEvent.SCROLL, updateTargetScroll, false, 0, true);
			}
			invalidate(InvalidationType.DATA);
		}

		override public function get direction() : String
		{
			return super.direction;
		}
	}
}
