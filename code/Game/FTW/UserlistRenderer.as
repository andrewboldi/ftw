package Game.FTW
{
	import Misc.*;
	import fl.controls.listClasses.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;

	public class UserlistRenderer extends UIComponent implements ICellRenderer
	{
		protected var _selected:Boolean;
		protected var _listData:ListData;
		protected var _data:Object;

		public function UserlistRenderer() : void
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

		private function showRating(param1:Event) : void
		{
			var _loc_2:TextField = TextField(getChildAt(0));
			_loc_2.text = String(this.data.rating);
		}

		private function hideRating(param1:Event) : void
		{
			var _loc_2:TextField = TextField(getChildAt(0));
			_loc_2.text = String(this.data.points);
		}

		protected function drawLayout() : void
		{
			var _loc_1:Array = null;
			var _loc_4:Matrix = null;
			var _loc_5:TextField = null;
			var _loc_6:TextField = null;
			var _loc_7:TextField = null;
			var _loc_8:TextFormat = null;
			this.graphics.clear();
			var _loc_2:Array = [1, 1, 1, 1, 1];
			var _loc_3:Array = [0, 1, 127, 224, 255];
			if(_selected)
			{
				if(_data.type == 1)
				{
					_loc_1 = [0, 16772846, 16764108, 16772846, 0];
				}
				else
				{
					_loc_1 = [0, 15658751, 13421823, 15658751, 0];
				}
				_loc_4 = new Matrix();
				_loc_4.createGradientBox(this.width, this.height, Math.PI / 2, 0, 0);
				this.graphics.beginGradientFill(GradientType.LINEAR, _loc_1, _loc_2, _loc_3, _loc_4, SpreadMethod.PAD);
				this.graphics.drawRect(0, 0, this.width, this.height);
				this.graphics.endFill();
			}
			if(this.numChildren <= 0)
			{
				_loc_5 = new TextField();
				_loc_7 = new TextField();
				_loc_6 = new TextField();
				var _loc_9:Boolean = false;
				_loc_6.selectable = _loc_9;
				var _loc_9:Boolean = _loc_9;
				_loc_7.selectable = _loc_9;
				_loc_5.selectable = _loc_9;
				var _loc_9:Boolean = true;
				_loc_6.mouseEnabled = _loc_9;
				var _loc_9:Boolean = _loc_9;
				_loc_7.mouseEnabled = _loc_9;
				_loc_5.mouseEnabled = _loc_9;
				var _loc_9:* = this.width;
				_loc_6.width = _loc_9;
				var _loc_9:* = _loc_9;
				_loc_7.width = _loc_9;
				_loc_5.width = _loc_9;
				var _loc_9:* = this.height;
				_loc_6.height = _loc_9;
				var _loc_9:* = _loc_9;
				_loc_7.height = _loc_9;
				_loc_5.height = _loc_9;
				_loc_8 = new TextFormat();
				_loc_8.align = "center";
				_loc_8.bold = true;
				_loc_8.font = "_sans";
				_loc_7.defaultTextFormat = _loc_8;
				_loc_8 = new TextFormat();
				_loc_8.align = "right";
				_loc_8.font = "_sans";
				_loc_6.defaultTextFormat = _loc_8;
				_loc_8 = new TextFormat();
				_loc_8.align = "left";
				_loc_8.font = "_sans";
				_loc_5.defaultTextFormat = _loc_8;
				addChildAt(_loc_6, 0);
				addChildAt(_loc_7, 1);
				addChildAt(_loc_5, 2);
				EventManager.add(this, MouseEvent.MOUSE_OVER, showRating);
				EventManager.add(this, MouseEvent.MOUSE_OUT, hideRating);
				EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			}
			else
			{
				_loc_6 = TextField(getChildAt(0));
				_loc_7 = TextField(getChildAt(1));
				_loc_5 = TextField(getChildAt(2));
			}
			switch(_data.type)
			{
			case 0:
				_loc_5.visible = true;
				_loc_7.visible = false;
				_loc_6.visible = true;
				_loc_5.text = _data.name;
				if(_data.points != undefined)
				{
					_loc_6.text = String(Math.round(_data.points));
				}
				if(_data.rating != undefined)
				{
					this.data.rating = _data.rating;
				}
				if(_data.points != undefined)
				{
					this.data.points = _data.points;
				}
				break;
			case 1:
				_loc_5.visible = true;
				_loc_7.visible = false;
				_loc_6.visible = false;
				_loc_5.text = _data.name;
				_loc_7.text = "";
				_loc_6.text = "";
				break;
			case 2:
				_loc_1 = [0, 15658734, 13421772, 15658734, 0];
				_loc_4 = new Matrix();
				_loc_4.createGradientBox(this.width, this.height, Math.PI / 2, 0, 0);
				this.graphics.beginGradientFill(GradientType.LINEAR, _loc_1, _loc_2, _loc_3, _loc_4, SpreadMethod.PAD);
				this.graphics.drawRect(0, 0, this.width, this.height);
				this.graphics.endFill();
				_loc_5.visible = false;
				_loc_6.visible = false;
				_loc_7.visible = true;
				_loc_7.text = _data.text;
				break;
			default:
				this.visible = false;
				break;
			}
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, MouseEvent.MOUSE_OVER, showRating);
			EventManager.remove(this, MouseEvent.MOUSE_OUT, hideRating);
		}
	}
}
