package Game
{
	import Game.FTW.*;
	import Misc.*;
	import flash.events.*;

	public class FTW extends FTWBase
	{
		private var _userlist:Userlist;

		public function FTW()
		{
			super();
			_userlist = new Userlist();
			_userlist.width = 189;
			_userlist.height = 315;
			_userlist.x = 520;
			_userlist.y = 52;
			addChild(_userlist);
			EventManager.add(this, Event.ADDED, on_added);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function update_scores(param1:String) : void
		{
			var _loc_2:Array = null;
			var _loc_3:int = 0;
			var _loc_4:Array = null;
			if(param1.length > 0)
			{
				_loc_2 = param1.split("\n");
				_loc_3 = 0;
				while(_loc_3 < _loc_2.length)
				{
					_loc_4 = String(_loc_2[_loc_3]).split("\t");
					_userlist.updatePlayer(_loc_4[0], Number(_loc_4[1]));
					_loc_3++;
				}
			}
		}

		override public function on_plugin_message(param1:Object) : void
		{
			var _loc_2:int = 0;
			var _loc_3:Object = null;
			var _loc_4:Array = null;
			var _loc_5:Array = null;
			var _loc_6:Array = null;
			var _loc_7:Array = null;
			switch(param1.response.Action)
			{
			case "add_player":
				_userlist.addPlayer(param1.response.name, Number(param1.response.points), Number(param1.response.rating));
				break;
			case "add_spectator":
				_userlist.addSpectator(param1.response.msg);
				break;
			case "RemoveUser":
				_userlist.removeUser(param1.response.msg);
				break;
			case "GameUserList":
				if(param1.response.players.length > 0)
				{
					_loc_4 = String(param1.response.players).split("\n");
					_loc_5 = new Array();
					_loc_2 = 0;
					while(_loc_2 < _loc_4.length)
					{
						_loc_6 = String(_loc_4[_loc_2]).split("\t");
						_loc_3 = new Object();
						_loc_3.name = _loc_6[0];
						_loc_3.rating = _loc_6[1];
						_loc_3.points = _loc_6[2];
						_loc_5.push(_loc_3);
						_loc_2++;
					}
					_userlist.addPlayers(_loc_5);
				}
				if(param1.response.spectators.length > 0)
				{
					_loc_7 = String(param1.response.spectators).split("\n");
					if(_loc_7.length > 0)
					{
						_userlist.addSpectators(_loc_7);
					}
				}
				break;
			case "scores":
				update_scores(String(param1.response.scores));
				break;
			default:
				super.on_plugin_message(param1);
				break;
			}
		}

		override protected function begin_problem(param1:uint) : void
		{
			var _loc_2:String = null;
			_loc_2 = "Problem " + param1;
			_loc_2 = _loc_2 + " of " + g.game.problem_count;
			text_header_left.text = _loc_2;
			super.begin_problem(param1);
		}

		override protected function end_problem(param1:uint) : void
		{
			super.end_problem(param1);
		}

		override protected function on_added(param1:Event) : void
		{
			if(param1.eventPhase == EventPhase.AT_TARGET)
			{
				super.on_added(param1);
				EventManager.remove(this, Event.ADDED, on_added);
			}
		}

		override protected function on_added_to_stage(param1:Event) : void
		{
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			super.on_added_to_stage(param1);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		override protected function on_removed_from_stage(param1:Event) : void
		{
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			super.on_removed_from_stage(param1);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}
	}
}
