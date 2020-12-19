package Game.FTW
{
	import fl.controls.*;
	import fl.data.*;

	public class Userlist extends List
	{
		private var players:Array;
		private var spectators:Array;
		private var playerLabel:Object;
		private var spectatorLabel:Object;
		private var sortMethod:String = "points";

		public function Userlist()
		{
			super();
			players = new Array();
			spectators = new Array();
			spectatorLabel = new Object();
			spectatorLabel.type = 2;
			spectatorLabel.text = "Spectators";
			playerLabel = new Object();
			playerLabel.type = 2;
			playerLabel.text = "Players";
			setStyle("cellRenderer", UserlistRenderer);
		}

		public function addPlayer(param1:String, param2:Number, param3:Number) : void
		{
			var _loc_4:Object = null;
			if(!isOnList(param1))
			{
				_loc_4 = new Object();
				_loc_4.name = param1;
				_loc_4.points = param2;
				if(param3 > 0)
				{
					_loc_4.rating = Math.round(param3);
				}
				else
				{
					_loc_4.rating = "None";
				}
				_loc_4.ratingVal = int(param3);
				_loc_4.type = 0;
				players.push(_loc_4);
				refresh();
			}
		}

		public function addPlayers(param1:Array) : void
		{
			var _loc_2:int = 0;
			while(_loc_2 < param1.length)
			{
				if(!isOnList(param1[_loc_2].name))
				{
					if(param1[_loc_2].rating > 0)
					{
						param1[_loc_2].rating = Math.round(param1[_loc_2].rating);
					}
					else
					{
						param1[_loc_2].rating = "None";
					}
					param1[_loc_2].ratingVal = int(param1[_loc_2].rating);
					param1[_loc_2].type = 0;
					this.players.push(param1[_loc_2]);
				}
				_loc_2++;
			}
			refresh();
		}

		public function addSpectator(param1:String) : void
		{
			var _loc_2:Object = null;
			if(!isOnList(param1))
			{
				_loc_2 = new Object();
				_loc_2.name = param1;
				_loc_2.type = 1;
				spectators.push(_loc_2);
				refresh();
			}
		}

		public function addSpectators(param1:Array) : void
		{
			var _loc_2:int = 0;
			while(_loc_2 < param1.length)
			{
				addSpectator(param1[_loc_2]);
				_loc_2++;
			}
			refresh();
		}

		public function updatePlayer(param1:String, param2:Number) : void
		{
			var _loc_3:Object = getPlayer(param1);
			if(_loc_3 != null)
			{
				_loc_3.points = Math.round(param2);
				refresh();
			}
		}

		public function updatePoints(param1:Array) : void
		{
			var _loc_3:Object = null;
			var _loc_2:uint = 0;
			while(_loc_2 < param1.length)
			{
				_loc_3 = getPlayer(param1[_loc_2].name);
				if(_loc_3 != null)
				{
					_loc_3.points = Math.round(param1[_loc_2].points);
				}
				_loc_2 = _loc_2 + 1;
			}
			refresh();
		}

		public function removeUser(param1:String) : void
		{
			var _loc_2:int = 0;
			_loc_2 = findPlayer(param1);
			if(_loc_2 >= 0)
			{
				players.splice(_loc_2, 1);
			}
			else
			{
				_loc_2 = findSpectator(param1);
				if(_loc_2 >= 0)
				{
					spectators.splice(_loc_2, 1);
				}
			}
			if(_loc_2 >= 0)
			{
				refresh();
			}
		}

		public function setSortMethod(param1:String) : void
		{
			if(param1 == "points")
			{
				this.sortMethod = param1;
			}
			else
			{
				if(param1 == "rating")
				{
					this.sortMethod = "ratingVal";
				}
				else
				{
					this.sortMethod = "name";
				}
			}
			refresh();
		}

		public function getSelectedUser() : String
		{
			return selectedItem != null ? selectedItem.name : null;
		}

		private function refresh() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:String = null;
			var _loc_3:Array = null;
			var _loc_4:uint = 0;
			_loc_1 = this.verticalScrollPosition;
			_loc_2 = getSelectedUser();
			if(this.sortMethod == "name")
			{
				players.sortOn(this.sortMethod, Array.CASEINSENSITIVE);
			}
			else
			{
				players.sortOn(this.sortMethod, Array.NUMERIC + Array.DESCENDING);
			}
			spectators.sortOn("name", Array.CASEINSENSITIVE);
			if(spectators.length > 0)
			{
				_loc_3 = [playerLabel].concat(players, spectatorLabel, spectators);
			}
			else
			{
				_loc_3 = players;
			}
			dataProvider = new DataProvider(_loc_3);
			this.verticalScrollPosition = _loc_1;
			if(_loc_2)
			{
				_loc_4 = 0;
				while(_loc_4 < _loc_3.length)
				{
					if(_loc_3[_loc_4].name == _loc_2)
					{
						this.selectedIndex = _loc_4;
						break;
					}
					_loc_4 = _loc_4 + 1;
				}
			}
		}

		private function findPlayer(param1:String) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < players.length)
			{
				if(players[_loc_2].name == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		private function findSpectator(param1:String) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < spectators.length)
			{
				if(spectators[_loc_2].name == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		private function isOnList(param1:String) : Boolean
		{
			var _loc_2:int = findPlayer(param1);
			if(_loc_2 >= 0)
			{
				return true;
			}
			return findSpectator(param1) >= 0;
		}

		private function getPlayer(param1:String) : Object
		{
			var _loc_2:uint = 0;
			while(_loc_2 < players.length)
			{
				if(players[_loc_2].name == param1)
				{
					return players[_loc_2];
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}
	}
}
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
