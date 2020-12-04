package fl.controls.dataGridClasses
{
	import fl.controls.*;

	public class HeaderRenderer extends LabelButton
	{
		private static var defaultStyles:Object = {upSkin:"HeaderRenderer_upSkin", downSkin:"HeaderRenderer_downSkin", overSkin:"HeaderRenderer_overSkin", disabledSkin:"HeaderRenderer_disabledSkin", selectedDisabledSkin:"HeaderRenderer_selectedDisabledSkin", selectedUpSkin:"HeaderRenderer_selectedUpSkin", selectedDownSkin:"HeaderRenderer_selectedDownSkin", selectedOverSkin:"HeaderRenderer_selectedOverSkin", textFormat:null, disabledTextFormat:null, textPadding:5};
		public var _column:uint;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		public function HeaderRenderer() : void
		{
			super();
			focusEnabled = false;
		}

		public function set column(param1:uint) : void
		{
			_column = param1;
		}

		public function get column() : uint
		{
			return _column;
		}

		override protected function drawLayout() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			_loc_1 = Number(getStyleValue("textPadding"));
			textField.height = textField.textHeight + 4;
			textField.visible = label.length > 0;
			_loc_2 = textField.textWidth + 4;
			_loc_3 = textField.textHeight + 4;
			_loc_4 = icon == null ? 0 : icon.width + 4;
			_loc_5 = Math.max(0, Math.min(_loc_2, (width - (2 * _loc_1)) - _loc_4));
			if(icon != null)
			{
				icon.x = (width - _loc_1) - icon.width - 2;
				icon.y = Math.round((height - icon.height) / 2);
			}
			textField.width = _loc_5;
			textField.x = _loc_1;
			textField.y = Math.round((height - textField.height) / 2);
			background.width = width;
			background.height = height;
		}
	}
}
