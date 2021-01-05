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
