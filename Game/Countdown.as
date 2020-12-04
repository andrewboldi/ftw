package Game
{
	import Game.Countdown.*;
	import Misc.*;
	import flash.events.*;

	public class Countdown extends FTWBase
	{
		private var userlist:Userlist;

		public function Countdown()
		{
			super();
			userlist = new Userlist();
			userlist.x = 520;
			userlist.y = 52;
			addChild(userlist);
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
					userlist.update_score(_loc_4[0], uint(_loc_4[1]));
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
			switch(param1.response.Action)
			{
			case "cd_response":
				userlist.response(param1.response.name, param1.response.score, param1.response.answer, param1.response.correct);
				break;
			case "add_player":
				userlist.add_player(param1.response.name, param1.response.points, param1.response.rating);
				break;
			case "add_spectator":
				userlist.add_spectator(param1.response.msg);
				break;
			case "RemoveUser":
				userlist.remove_user(param1.response.msg);
				break;
			case "scores":
				update_scores(param1.response.scores);
				break;
			case "GameUserList":
				if(param1.response.players.length > 0)
				{
					_loc_4 = String(param1.response.players).split("\n");
					_loc_2 = 0;
					while(_loc_2 < _loc_4.length)
					{
						_loc_5 = String(_loc_4[_loc_2]).split("\t");
						_loc_3 = new Object();
						_loc_3.name = _loc_5[0];
						_loc_3.rating = _loc_5[1];
						_loc_3.points = _loc_5[2];
						userlist.add_player(_loc_3.name, Math.round(Number(_loc_3.points)), _loc_3.rating);
						_loc_2++;
					}
				}
				if(param1.response.spectators.length > 0)
				{
					_loc_6 = String(param1.response.spectators).split("\n");
					_loc_2 = 0;
					while(_loc_2 < _loc_6.length)
					{
						userlist.add_spectator(_loc_6[_loc_2]);
						_loc_2++;
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
			text_header_left.text = _loc_2;
			userlist.clear_answers();
			panel_problem.show_response_area();
			super.begin_problem(param1);
		}

		override protected function end_problem(param1:uint) : void
		{
			trace("*** CD END PROBLEM");
			super.end_problem(param1);
		}

		override protected function on_got_answer(param1:ProblemAnswerEvent) : void
		{
			panel_problem.hide_response_area();
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
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			super.on_removed_from_stage(param1);
		}
	}
}
