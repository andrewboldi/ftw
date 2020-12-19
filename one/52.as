package fl.events
{
	import flash.events.*;

	public class ComponentEvent extends Event
	{
		public static const HIDE:String = "hide";
		public static const BUTTON_DOWN:String = "buttonDown";
		public static const MOVE:String = "move";
		public static const RESIZE:String = "resize";
		public static const ENTER:String = "enter";
		public static const LABEL_CHANGE:String = "labelChange";
		public static const SHOW:String = "show";

		public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
		{
			super(param1, param2, param3);
		}

		override public function toString() : String
		{
			return formatToString("ComponentEvent", "type", "bubbles", "cancelable");
		}

		override public function clone() : Event
		{
			return new ComponentEvent(type, bubbles, cancelable);
		}
	}
}
package fl.events
{
	import flash.events.*;

	public class DataChangeEvent extends Event
	{
		public static const PRE_DATA_CHANGE:String = "preDataChange";
		public static const DATA_CHANGE:String = "dataChange";
		protected var _items:Array;
		protected var _endIndex:uint;
		protected var _changeType:String;
		protected var _startIndex:uint;

		public function DataChangeEvent(param1:String, param2:String, param3:Array, param4:int = -1, param5:int = -1) : void
		{
			super(param1);
			_changeType = param2;
			_startIndex = param4;
			_items = param3;
			_endIndex = param5 == -1 ? _startIndex : param5;
		}

		public function get changeType() : String
		{
			return _changeType;
		}

		public function get startIndex() : uint
		{
			return _startIndex;
		}

		public function get items() : Array
		{
			return _items;
		}

		override public function clone() : Event
		{
			return new DataChangeEvent(type, _changeType, _items, _startIndex, _endIndex);
		}

		override public function toString() : String
		{
			return formatToString("DataChangeEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable");
		}

		public function get endIndex() : uint
		{
			return _endIndex;
		}
	}
}
package fl.events
{
	public class DataChangeType extends Object
	{
		public static const ADD:String = "add";
		public static const REMOVE:String = "remove";
		public static const REMOVE_ALL:String = "removeAll";
		public static const CHANGE:String = "change";
		public static const REPLACE:String = "replace";
		public static const INVALIDATE:String = "invalidate";
		public static const INVALIDATE_ALL:String = "invalidateAll";
		public static const SORT:String = "sort";

		public function DataChangeType()
		{
			super();
		}
	}
}
package fl.events
{
	import flash.events.*;

	public class DataGridEvent extends ListEvent
	{
		public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
		public static const ITEM_EDIT_END:String = "itemEditEnd";
		public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
		public static const HEADER_RELEASE:String = "headerRelease";
		public static const ITEM_FOCUS_IN:String = "itemFocusIn";
		public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
		public static const COLUMN_STRETCH:String = "columnStretch";
		protected var _itemRenderer:Object;
		protected var _reason:String;
		protected var _dataField:String;

		public function DataGridEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:int = -1, param6:Object = null, param7:String = null, param8:String = null)
		{
			super(param1, param2, param3, param4, param5);
			_itemRenderer = param6;
			_dataField = param7;
			_reason = param8;
		}

		public function get reason() : String
		{
			return _reason;
		}

		public function set dataField(param1:String) : void
		{
			_dataField = param1;
		}

		override public function toString() : String
		{
			return formatToString("DataGridEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "itemRenderer", "dataField", "reason");
		}

		public function get dataField() : String
		{
			return _dataField;
		}

		override public function clone() : Event
		{
			return new DataGridEvent(type, bubbles, cancelable, columnIndex, int(rowIndex), _itemRenderer, _dataField, _reason);
		}

		public function get itemRenderer() : Object
		{
			return _itemRenderer;
		}
	}
}
package fl.events
{
	public class DataGridEventReason extends Object
	{
		public static const OTHER:String = "other";
		public static const CANCELLED:String = "cancelled";
		public static const NEW_COLUMN:String = "newColumn";
		public static const NEW_ROW:String = "newRow";

		public function DataGridEventReason()
		{
			super();
		}
	}
}
package fl.events
{
	import flash.events.*;

	public class ListEvent extends Event
	{
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
		public static const ITEM_CLICK:String = "itemClick";
		protected var _index:int;
		protected var _item:Object;
		protected var _columnIndex:int;
		protected var _rowIndex:int;

		public function ListEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:int = -1, param6:int = -1, param7:Object = null)
		{
			super(param1, param2, param3);
			_rowIndex = param5;
			_columnIndex = param4;
			_index = param6;
			_item = param7;
		}

		public function get rowIndex() : Object
		{
			return _rowIndex;
		}

		public function get index() : int
		{
			return _index;
		}

		public function get item() : Object
		{
			return _item;
		}

		public function get columnIndex() : int
		{
			return _columnIndex;
		}

		override public function clone() : Event
		{
			return new ListEvent(type, bubbles, cancelable, _columnIndex, _rowIndex);
		}

		override public function toString() : String
		{
			return formatToString("ListEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "index", "item");
		}
	}
}
package fl.events
{
	import flash.events.*;

	public class ScrollEvent extends Event
	{
		public static const SCROLL:String = "scroll";
		private var _position:Number;
		private var _direction:String;
		private var _delta:Number;

		public function ScrollEvent(param1:String, param2:Number, param3:Number)
		{
			super(ScrollEvent.SCROLL, false, false);
			_direction = param1;
			_delta = param2;
			_position = param3;
		}

		override public function clone() : Event
		{
			return new ScrollEvent(_direction, _delta, _position);
		}

		public function get position() : Number
		{
			return _position;
		}

		override public function toString() : String
		{
			return formatToString("ScrollEvent", "type", "bubbles", "cancelable", "direction", "delta", "position");
		}

		public function get delta() : Number
		{
			return _delta;
		}

		public function get direction() : String
		{
			return _direction;
		}
	}
}
