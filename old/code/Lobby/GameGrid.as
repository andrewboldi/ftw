package Lobby
{
	import Misc.*;
	import fl.containers.*;
	import flash.display.*;
	import flash.events.*;

	public class GameGrid extends Sprite
	{
		public static var class_name:* = "Lobby.GameInfo";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var games:Array;
		public var _spGames:ScrollPane;

		public function GameGrid()
		{
			super();
			var _loc_2:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_2;
			instance_number = instance_number_counter;
			games = new Array();
			EventManager.add(this, "HIDE_GAME_CLIP", final_hide);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			__setProp__spGames_GameGrid_Layer1_0();
		}

		public function is_game(param1:uint) : Boolean
		{
			var _loc_2:GameClip = find_clip(param1);
			if(_loc_2 == null || _loc_2.visible == false)
			{
				return false;
			}
			return true;
		}

		public function new_game(param1:uint, param2:String, param3:String, param4:uint, param5:uint) : void
		{
			var _loc_6:GameClip = new GameClip(param1, param2, param3, param4, param5);
			_loc_6.visible = false;
			Sprite(_spGames.content).addChild(_loc_6);
			games.push(_loc_6);
		}

		public function game_list(param1:String) : void
		{
			var _loc_4:Array = null;
			var _loc_5:GameClip = null;
			var _loc_6:uint = 0;
			var _loc_7:String = null;
			var _loc_8:String = null;
			var _loc_9:uint = 0;
			var _loc_10:uint = 0;
			var _loc_11:uint = 0;
			var _loc_12:uint = 0;
			var _loc_13:uint = 0;
			if(param1.length <= 0)
			{
				return;
			}
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = _loc_2[_loc_3].split("\t");
				_loc_5 = find_clip(_loc_4[0]);
				if(_loc_5 == null)
				{
					_loc_6 = uint(_loc_4[0]);
					_loc_7 = _loc_4[1];
					_loc_8 = _loc_4[2];
					_loc_9 = uint(_loc_4[3]);
					_loc_10 = uint(_loc_4[4]);
					_loc_11 = uint(_loc_4[5]);
					_loc_12 = uint(_loc_4[6]);
					_loc_13 = uint(_loc_4[7]);
					_loc_5 = new GameClip(_loc_6, _loc_7, _loc_8, _loc_9, _loc_12, _loc_11, _loc_10);
					_loc_5.problem = _loc_13;
					_loc_5.visible = false;
					Sprite(_spGames.content).addChild(_loc_5);
					this.games.push(_loc_5);
					if((_loc_11 > 0 && _loc_11 <= 50 || g.user.access > 100 && _loc_10 == GameClip.ENDED) && _loc_10 == GameClip.ENDING)
					{
						display_game(_loc_4[0]);
					}
				}
				_loc_3 = _loc_3 + 1;
			}
		}

		public function remove_game(param1:uint) : void
		{
			var _loc_2:int = find_clip_position(param1);
			if(_loc_2 >= 0)
			{
				hide_game(param1);
			}
		}

		public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint) : void
		{
			var _loc_6:GameClip = find_clip(param1);
			if(_loc_6 == null)
			{
				return;
			}
			if(param2 == GameClip.ENDED || param2 == GameClip.ENDING || param5 <= 0 || param5 > 50 || param4 > 50)
			{
				_loc_6.destroy = param2 == GameClip.ENDED || param2 == GameClip.ENDING;
				hide_game(param1);
			}
			else
			{
				display_game(param1);
			}
			_loc_6.status = param2;
			_loc_6.players = param5;
			_loc_6.problem = param3;
		}

		private function display_game(param1:uint) : void
		{
			var _loc_3:int = 0;
			var _loc_4:int = 0;
			var _loc_2:int = find_clip_position(param1);
			if(_loc_2 >= 0 && games[_loc_2].visible == false)
			{
				_loc_3 = 0;
				_loc_4 = 0;
				while(_loc_4 < _loc_2)
				{
					if(games[_loc_4].visible == true)
					{
						_loc_3++;
					}
					_loc_4++;
				}
				games[_loc_2].show();
				set_display_position(games[_loc_2], _loc_3);
				_loc_4 = _loc_2 + 1;
				while(_loc_4 < games.length)
				{
					if(games[_loc_4].visible == true)
					{
						_loc_3++;
						set_display_position(games[_loc_4], _loc_3);
					}
					_loc_4++;
				}
			}
			_spGames.update();
		}

		private function hide_game(param1:uint) : void
		{
			var _loc_2:GameClip = find_clip(param1);
			if(!(_loc_2 == null) && _loc_2.visible)
			{
				_loc_2.hide();
			}
		}

		private function final_hide(param1:Event) : void
		{
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			var _loc_2:GameClip = GameClip(param1.target);
			var _loc_3:uint = _loc_2.id;
			var _loc_4:int = find_clip_position(_loc_3);
			if(_loc_4 >= 0)
			{
				_loc_5 = 0;
				_loc_6 = 0;
				while(_loc_6 < _loc_4)
				{
					if(games[_loc_6].visible == true)
					{
						_loc_5++;
					}
					_loc_6++;
				}
				games[_loc_4].visible = false;
				_loc_6 = _loc_4 + 1;
				while(_loc_6 < games.length)
				{
					if(games[_loc_6].visible == true)
					{
						set_display_position(games[_loc_6], _loc_5);
						_loc_5++;
					}
					_loc_6++;
				}
				games[_loc_4].destroy;
				if(games[_loc_4].destroy || 1 == 1)
				{
					Sprite(_spGames.content).removeChild(games[_loc_4]);
					games.splice(_loc_4, 1);
				}
			}
		}

		private function set_display_position(param1:DisplayObject, param2:uint) : void
		{
			var _loc_3:uint = (param2 % 4) * 125;
			var _loc_4:uint = (Math.floor(param2 / 4)) * 105;
			param1.x = _loc_3;
			param1.y = _loc_4;
		}

		private function find_clip(param1:uint) : GameClip
		{
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				if(games[_loc_2].id == param1)
				{
					return games[_loc_2];
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		private function find_clip_position(param1:uint) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				if(games[_loc_2].id == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		public function on_added_to_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		public function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, "HIDE_GAME_CLIP", final_hide);
		}

		override public function toString() : String
		{
			var _loc_1:String = "[object GameGrid] ";
			if(games.length <= 0)
			{
				return _loc_1 + "No games";
			}
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				_loc_1 = _loc_1 + (games[_loc_2].toString() + "\n");
				_loc_2 = _loc_2 + 1;
			}
			return _loc_1;
		}

		public function __setProp__spGames_GameGrid_Layer1_0()
		{
			try
			{
				_spGames["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_spGames.enabled = true;
			_spGames.horizontalLineScrollSize = 4;
			_spGames.horizontalPageScrollSize = 0;
			_spGames.horizontalScrollPolicy = "auto";
			_spGames.scrollDrag = false;
			_spGames.source = "EmptyClip";
			_spGames.verticalLineScrollSize = 4;
			_spGames.verticalPageScrollSize = 0;
			_spGames.verticalScrollPolicy = "auto";
			_spGames.visible = true;
			try
			{
				_spGames["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
