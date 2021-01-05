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
