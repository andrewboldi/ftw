package fl.controls.listClasses
{
	import fl.controls.*;
	import flash.events.*;

	public class CellRenderer extends LabelButton implements ICellRenderer
	{
		private static var defaultStyles:Object = {upSkin:"CellRenderer_upSkin", downSkin:"CellRenderer_downSkin", overSkin:"CellRenderer_overSkin", disabledSkin:"CellRenderer_disabledSkin", selectedDisabledSkin:"CellRenderer_selectedDisabledSkin", selectedUpSkin:"CellRenderer_selectedUpSkin", selectedDownSkin:"CellRenderer_selectedDownSkin", selectedOverSkin:"CellRenderer_selectedOverSkin", textFormat:null, disabledTextFormat:null, embedFonts:null, textPadding:5};
		protected var _data:Object;
		protected var _listData:ListData;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function CellRenderer() : void
		{
			super();
			toggle = true;
			focusEnabled = false;
		}

		override protected function toggleSelected(param1:MouseEvent) : void
		{
		}

		override public function get selected() : Boolean
		{
			return super.selected;
		}

		public function set listData(param1:ListData) : void
		{
			_listData = param1;
			label = _listData.label;
			setStyle("icon", _listData.icon);
		}

		override public function set selected(param1:Boolean) : void
		{
		}

		public function set data(param1:Object) : void
		{
			_data = param1;
		}

		public function get listData() : ListData
		{
			return _listData;
		}

		override public function setSize(param1:Number, param2:Number) : void
		{
			super.setSize(param1, param2);
		}

		override protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_1 = Number(getStyleValue("textPadding"));
			_loc_2 = 0;
			if(icon != null)
			{
				icon.x = _loc_1;
				icon.y = Math.round((height - icon.height) >> 1);
				_loc_2 = icon.width + _loc_1;
			}
			if(label.length > 0)
			{
				textField.visible = true;
				_loc_3 = Math.max(0, (width - _loc_2) - (_loc_1 * 2));
				textField.width = _loc_3;
				textField.height = textField.textHeight + 4;
				textField.x = _loc_2 + _loc_1;
				textField.y = Math.round((height - textField.height) >> 1);
			}
			else
			{
				textField.visible = false;
			}
			background.width = width;
			background.height = height;
		}

		public function get data() : Object
		{
			return _data;
		}
	}
}
package fl.controls.listClasses
{
	public interface ICellRenderer
	{
		function setSize(param1:Number, param2:Number) : void;

		function get listData() : ListData;

		function get data() : Object;

		function setMouseState(param1:String) : void;

		function set x(param1:Number) : void;

		function set y(param1:Number) : void;

		function set data(param1:Object) : void;

		function set selected(param1:Boolean) : void;

		function set listData(param1:ListData) : void;

		function get selected() : Boolean;
	}
}
package fl.controls.listClasses
{
	import fl.core.*;

	public class ListData extends Object
	{
		protected var _index:uint;
		protected var _owner:UIComponent;
		protected var _label:String;
		protected var _icon:Object = null;
		protected var _row:uint;
		protected var _column:uint;

		public function ListData(param1:String, param2:Object, param3:UIComponent, param4:uint, param5:uint, param6:uint = 0)
		{
			_icon = null;
			super();
			_label = param1;
			_icon = param2;
			_owner = param3;
			_index = param4;
			_row = param5;
			_column = param6;
		}

		public function get owner() : UIComponent
		{
			return _owner;
		}

		public function get label() : String
		{
			return _label;
		}

		public function get row() : uint
		{
			return _row;
		}

		public function get index() : uint
		{
			return _index;
		}

		public function get icon() : Object
		{
			return _icon;
		}

		public function get column() : uint
		{
			return _column;
		}
	}
}
