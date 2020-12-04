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
