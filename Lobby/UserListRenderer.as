package Lobby
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;

	public class UserListRenderer extends UIComponent implements ICellRenderer
	{
		protected var _selected:Boolean;
		protected var _listData:ListData;
		protected var _data:Object;

		public function UserListRenderer() : void
		{
			super();
			focusEnabled = true;
		}

		override public function setSize(param1:Number, param2:Number) : void
		{
			super.setSize(param1, param2);
		}

		public function get listData() : ListData
		{
			return _listData;
		}

		public function set listData(param1:ListData) : void
		{
			_listData = param1;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(param1:Object) : void
		{
			_data = param1;
		}

		public function get selected() : Boolean
		{
			return _selected;
		}

		public function set selected(param1:Boolean) : void
		{
			_selected = param1;
			drawLayout();
		}

		protected function toggleSelected(param1:MouseEvent) : void
		{
			_selected = !_selected;
		}

		public function setMouseState(param1:String) : void
		{
		}

		protected function drawLayout() : void
		{
			var _loc_1:Array = null;
			var _loc_4:Matrix = null;
			var _loc_5:TextField = null;
			var _loc_6:TextField = null;
			var _loc_7:TextFormat = null;
			var _loc_2:Array = [1, 1, 1, 1, 1];
			var _loc_3:Array = [0, 1, 127, 224, 255];
			if(_data.name.length > 0)
			{
				graphics.clear();
				if(_selected)
				{
					_loc_1 = [0, 15663086, 13434828, 15663086, 0];
					_loc_4 = new Matrix();
					_loc_4.createGradientBox(this.width, this.height, Math.PI / 2, 0, 0);
					this.graphics.beginGradientFill(GradientType.LINEAR, _loc_1, _loc_2, _loc_3, _loc_4, SpreadMethod.PAD);
					this.graphics.drawRect(1, 0, this.width - 1, this.height);
					this.graphics.endFill();
				}
				if(numChildren <= 0)
				{
					_loc_5 = new TextField();
					_loc_6 = new TextField();
					var _loc_8:Boolean = false;
					_loc_6.selectable = _loc_8;
					_loc_5.selectable = _loc_8;
					var _loc_8:Boolean = true;
					_loc_6.mouseEnabled = _loc_8;
					_loc_5.mouseEnabled = _loc_8;
					var _loc_8:* = this.width;
					_loc_6.width = _loc_8;
					_loc_5.width = _loc_8;
					_loc_5.doubleClickEnabled = true;
					_loc_7 = new TextFormat();
					_loc_7.align = "right";
					_loc_7.font = "_sans";
					_loc_6.defaultTextFormat = _loc_7;
					_loc_7 = new TextFormat();
					_loc_7.align = "left";
					_loc_7.font = "_sans";
					_loc_5.defaultTextFormat = _loc_7;
					addChildAt(_loc_6, 0);
					addChildAt(_loc_5, 1);
				}
				else
				{
					_loc_6 = TextField(getChildAt(0));
					_loc_5 = TextField(getChildAt(1));
				}
				_loc_5.x = 2;
				_loc_5.text = _data.name;
				_loc_6.text = _data.rating;
				_loc_7 = new TextFormat();
				_loc_7.font = "_sans";
				if(_data.away)
				{
					_loc_7.color = 12303291;
				}
				_loc_5.setTextFormat(_loc_7);
				_loc_7 = new TextFormat();
				_loc_7.font = "_sans";
				if(_data.away)
				{
					_loc_7.color = 12303291;
				}
				_loc_7.align = "right";
				_loc_6.setTextFormat(_loc_7);
			}
			else
			{
				this.visible = false;
			}
		}
	}
}
