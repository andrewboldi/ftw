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
