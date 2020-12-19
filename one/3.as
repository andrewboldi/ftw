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
package Game
{
	import Lobby.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;

	public class FinalScoreboardPanel extends Sprite
	{
		public var scoreboard:DataGrid;
		public var _bLeave:GreenButton;
		public var _bReview:GreenButton;

		public function FinalScoreboardPanel()
		{
			super();
			scoreboard.columns = ["User", "Score", "Response", "Time"];
			scoreboard.setStyle("borderStyle", "none");
			_bLeave.tText.text = "Leave";
			_bReview.tText.text = "Review";
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			__setProp_scoreboard_FinalScoreboardPanel_Layer1_0();
		}

		public function board(param1:String) : void
		{
			var _loc_4:Array = null;
			var _loc_5:* = undefined;
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = _loc_2[_loc_3].split("\t");
				if(_loc_4.length > 2)
				{
					_loc_5 = {User:_loc_4[0], Response:response_text(uint(_loc_4[1])), Time:_loc_4[2], Score:Math.round(_loc_4[3])};
					scoreboard.addItem(_loc_5);
				}
				_loc_3 = _loc_3 + 1;
			}
			scoreboard.sortItemsOn("Score", Array.NUMERIC | Array.DESCENDING);
		}

		public function add(param1:String, param2:uint, param3:Number, param4:Number) : void
		{
			var _loc_5:* = {User:param1, Response:response_text(param2), Time:param3, Score:param4};
			scoreboard.addItem(_loc_5);
			scoreboard.sortItemsOn("Score", Array.NUMERIC | Array.DESCENDING);
		}

		private function response_text(param1:uint) : String
		{
			switch(param1)
			{
			case 0:
				return "Incorrect";
			case 1:
				return "Correct";
			case 2:
				return "Give Up";
			case 4:
				return "Time Out";
			default:
				break;
			}
			return "";
		}

		public function show() : void
		{
			scoreboard.removeAll();
			this.visible = true;
		}

		public function hide() : void
		{
			this.visible = false;
		}

		private function on_leave(param1:MouseEvent) : void
		{
			FTWBase(parent).on_leave_game(param1);
		}

		private function on_review(param1:MouseEvent) : void
		{
			FTWBase(parent).addChild(new Review());
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(_bLeave, MouseEvent.CLICK, on_leave);
			EventManager.remove(_bReview, MouseEvent.CLICK, on_review);
		}

		private function on_added_to_stage(param1:Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(_bLeave, MouseEvent.CLICK, on_leave, "FinalScoreBoardPanel._bLeave.CLICK");
			EventManager.add(_bReview, MouseEvent.CLICK, on_review, "FinalScoreBoardPanel._bReview.CLICK");
		}

		public function __setProp_scoreboard_FinalScoreboardPanel_Layer1_0()
		{
			try
			{
				scoreboard["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			scoreboard.allowMultipleSelection = false;
			scoreboard.editable = false;
			scoreboard.headerHeight = 25;
			scoreboard.horizontalLineScrollSize = 4;
			scoreboard.horizontalPageScrollSize = 0;
			scoreboard.horizontalScrollPolicy = "off";
			scoreboard.resizableColumns = false;
			scoreboard.rowHeight = 20;
			scoreboard.showHeaders = true;
			scoreboard.sortableColumns = true;
			scoreboard.verticalLineScrollSize = 4;
			scoreboard.verticalPageScrollSize = 0;
			scoreboard.verticalScrollPolicy = "auto";
			try
			{
				scoreboard["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
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
package Game
{
	import Misc.*;
	import Scene.*;
	import Type.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class FTWBase extends BaseChat
	{
		public var button_leave:FTWButton;
		public var button_start:FTWButton;
		public var text_game_id:TextField;
		public var text_header_left:TextField;
		public var text_header_right:TextField;
		protected var panel_problem:ProblemPanel;
		protected var panel_spectator:SpectatorPanel;
		protected var panel_timer:TimerPanel;
		protected var panel_information:InformationPanel;
		protected var panel_scoreboard:ScoreboardPanel;
		protected var panel_final_scoreboard:FinalScoreboardPanel;
		private var problem_start_time:uint;
		private var problem_interval:Timer;
		private var problem_time_remaining:uint;
		private var start_enabled:Boolean = false;
		private var leave_button_interval:uint;
		private var responded:Boolean = false;

		public function FTWBase()
		{
			super();
			button_leave.text.text = "Leave";
			button_start.text.text = "Start";
			text_header_left.text = "";
			text_header_right.text = "";
			panel_problem = new ProblemPanel(g.game.playerType == 9);
			panel_problem.x = 10;
			panel_problem.y = 53;
			EventManager.add(panel_problem, ProblemAnswerEvent.ANSWER, got_answer);
			panel_spectator = new SpectatorPanel();
			panel_spectator.x = 10;
			panel_spectator.y = 53;
			panel_timer = new TimerPanel();
			panel_timer.x = 10;
			panel_timer.y = 53;
			panel_information = new InformationPanel();
			panel_information.x = 10;
			panel_information.y = 53;
			panel_scoreboard = new ScoreboardPanel();
			panel_scoreboard.x = 10;
			panel_scoreboard.y = 53;
			panel_final_scoreboard = new FinalScoreboardPanel();
			panel_final_scoreboard.x = 10;
			panel_final_scoreboard.y = 53;
			text_game_id.text = "Game# " + g.game.id;
			problem_interval = null;
		}

		private function hide_panels() : void
		{
			panel_scoreboard.hide();
			panel_information.hide();
			panel_problem.hide();
			panel_timer.hide();
			panel_final_scoreboard.hide();
			panel_spectator.hide();
		}

		private function stop_problem_timer()
		{
			if(problem_interval != null)
			{
				EventManager.remove(problem_interval, "timer", problem_countdown);
				problem_interval.stop();
				problem_interval.reset();
				problem_interval = null;
			}
		}

		public function on_leave_game(param1:MouseEvent) : void
		{
			var _loc_2:String = null;
			EventManager.remove(button_start, MouseEvent.CLICK, on_start_game);
			EventManager.remove(button_leave, MouseEvent.CLICK, on_leave_game);
			EventManager.remove(panel_timer, TimerEvent.TIMER_COMPLETE, on_start_game_timer);
			if(start_enabled)
			{
				EventManager.remove(g.game.problems[1], Event.COMPLETE, enable_start);
				start_enabled = false;
			}
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			stop_problem_timer();
			var _loc_3:int = 0;
			var _loc_4:* = g.game.problems;
			for each(_loc_2 in _loc_4)
			{
				g.game.problems[_loc_2].cleanup();
			}
			g.server.leaveRoom(g.game.zone_name, g.game.room_name);
			g.server.addEventListener("leaveRoom", "on_leave_room_event", this);
		}

		public function on_leave_room_event(param1:Object) : void
		{
			g.server.removeEventListener("leaveRoom", "on_leave_room_event", this);
			g.activeRoomName = "Lobby";
			g.activeZoneName = "FTW";
			g.scene.lobby();
		}

		public function on_start_game(param1:MouseEvent) : void
		{
			var _loc_2:EsObject = null;
			button_start.enabled;
			if(button_start.enabled && start_enabled)
			{
				_loc_2 = new EsObject();
				_loc_2.setInteger("id", g.game.id);
				g.server.esServerPlugin(g.manager, "start_game", _loc_2);
				disable_start();
			}
		}

		protected function on_start_game_timer(param1:TimerEvent) : void
		{
			EventManager.remove(panel_timer, TimerEvent.TIMER_COMPLETE, on_start_game_timer);
			begin_problem(1);
		}

		protected function begin_problem(param1:uint) : void
		{
			if(!(param1 == 1 && g.game.problemNumber == 1))
			{
				g.game.problemNumber = 1;
				hide_panels();
				panel_timer.message = "Game will begin in...";
				panel_timer.show();
				panel_timer.start(3);
				setTimeout(loadProblem, 2000, 1);
				EventManager.add(panel_timer, TimerEvent.TIMER_COMPLETE, on_start_game_timer);
				return;
			}
			if((g.game.problems.length - 1) < param1 || g.game.problems[param1] == undefined)
			{
				panel_information.large = "\n\nPlease wait for next problem.\n\n";
				panel_information.show();
			}
			g.chat.displayChat = false;
			g.game.problemNumber = param1;
			g.game.last_problem_number_displayed = param1;
			stop_problem_timer();
			problem_interval = new Timer(1000, g.game.time_per_problem);
			EventManager.add(problem_interval, "timer", problem_countdown);
			problem_interval.start();
			problem_time_remaining = g.game.time_per_problem;
			text_header_right.text = "Time remaining: " + problem_time_remaining;
			problem_start_time = getTimer();
			hide_panels();
			if(g.game.problems[param1].loaded)
			{
				if(g.game.player_type != FTW.SPECTATOR)
				{
					panel_problem.attach(g.game.problems[param1]);
					panel_problem.show();
				}
				else
				{
					g.scene.debug("Showing Panel Spectator");
					panel_spectator.attach(g.game.problems[param1]);
					panel_spectator.show();
				}
			}
			else
			{
				panel_information.large = "\n\nUnable to load problem.\n\n";
				panel_information.show();
			}
			this.responded = false;
		}

		public function check_answer(param1:String, param2:int) : Boolean
		{
			param1 = g.clean_answer(param1);
			var _loc_3:int = 0;
			while(_loc_3 < g.game.problems[param2].answers.length)
			{
				if(param1 == g.game.problems[param2].answers[_loc_3])
				{
					return true;
				}
				_loc_3++;
			}
			return false;
		}

		private function got_answer(param1:ProblemAnswerEvent) : void
		{
			var _loc_2:int = NaN;
			var _loc_3:EsObject = null;
			if(param1.answer.length > 0 && this.responded == false)
			{
				if(g.chat.checkLanguage(param1.answer))
				{
					param1.answer = "Censored";
				}
				g.chat.displayChat = true;
				this.responded = true;
				g.game.problems[param1.problem_number].user_answer = param1.answer;
				_loc_2 = (Number(getTimer() - problem_start_time)) / 1000;
				if(_loc_2 > g.game.time_per_problem)
				{
					_loc_2 = g.game.time_per_problem;
					stop_problem_timer();
				}
				_loc_3 = new EsObject();
				_loc_3.setInteger("id", g.user.id);
				_loc_3.setInteger("r", check_answer(param1.answer, param1.problem_number) ? 1 : 0);
				_loc_3.setDouble("t", _loc_2);
				_loc_3.setString("answer", param1.answer);
				plugin("response", _loc_3);
				on_got_answer(param1);
				if(!g.user.muted && g.user.gameChat)
				{
					stage.focus = _tInput;
				}
			}
		}

		protected function on_got_answer(param1:ProblemAnswerEvent) : void
		{
		}

		public function loadProblem(param1:Number) : void
		{
			if(g.game.problems[param1] === undefined || !g.game.problems[param1].loaded)
			{
				g.game.problems[param1] = new Problem(param1);
			}
		}

		protected function end_problem(param1:uint) : void
		{
			if(g.game.last_problem_number_displayed < g.game.problem_count)
			{
				setTimeout(loadProblem, 5000, g.game.last_problem_number_displayed + 1);
			}
			g.chat.displayChat = true;
			if(panel_scoreboard.visible == false)
			{
				hide_panels();
				panel_scoreboard.show();
			}
			stop_problem_timer();
			this.text_header_right.text = "";
			panel_scoreboard.countdown(param1);
		}

		protected function end_game(param1:String) : void
		{
			g.chat.displayChat = true;
			stop_problem_timer();
			hide_panels();
			panel_final_scoreboard.show();
			panel_final_scoreboard.board(param1);
			text_header_right.text = "";
			g.game.ended = true;
		}

		private function timeout()
		{
			var _loc_1:EsObject = null;
			if(this.responded == false)
			{
				this.responded = true;
				_loc_1 = new EsObject();
				_loc_1.setInteger("id", g.user.id);
				_loc_1.setInteger("r", 4);
				_loc_1.setDouble("t", g.game.time_per_problem);
				_loc_1.setString("answer", "time");
				plugin("response", _loc_1);
			}
		}

		private function problem_countdown(param1:TimerEvent) : void
		{
			var _loc_3:* = this.problem_time_remaining - 1;
			this.problem_time_remaining = _loc_3;
			if(problem_time_remaining > 0)
			{
				this.text_header_right.text = "Time remaining: " + problem_time_remaining;
			}
			else
			{
				timeout();
				this.text_header_right.text = "Time's up";
				stop_problem_timer();
			}
		}

		public function enable_start(param1:Event) : void
		{
			start_enabled = true;
			button_start.visible = true;
			button_start.alpha = 1;
			button_start.enabled = true;
			EventManager.add(button_start, MouseEvent.CLICK, on_start_game, "FTWBase.button_start");
			panel_information.large = "\n\nClick the Start button\nto begin game.";
		}

		public function disable_start() : void
		{
			button_start.alpha = 0.40;
			button_start.enabled = false;
			EventManager.remove(button_start, MouseEvent.CLICK, on_start_game);
			start_enabled = false;
		}

		public function on_leave_button_interval() : void
		{
			button_leave.alpha = 1;
			EventManager.add(button_leave, MouseEvent.CLICK, on_leave_game, "FTWBase.button_leave");
			clearInterval(leave_button_interval);
		}

		override public function on_plugin_message(param1:Object) : void
		{
			var _loc_2:EsObject = null;
			switch(param1.response.Action)
			{
			case "problem_number":
				if(param1.response.number > 1 && panel_information.visible == true)
				{
					panel_information.large = "\n\nPlease wait for next problem to start...";
				}
				if(param1.response.number > 1)
				{
					loadProblem(param1.response.number + 1);
				}
				g.game.can_start_game;
				if(g.game.can_start_game && param1.response.number == 0)
				{
					enable_start(null);
				}
				else
				{
					disable_start();
				}
				break;
			case "end_problem":
				disable_start();
				end_problem(param1.response.interval);
				break;
			case "end_game":
				disable_start();
				end_game(param1.response.scoreboard);
				break;
			case "scoreboard":
				hide_panels();
				panel_scoreboard.show();
				panel_scoreboard.board(param1.response.scoreboard);
				break;
			case "scoreboard_update":
				panel_scoreboard.add(param1.response.user, uint(param1.response.resp), Number(param1.response.time));
				break;
			case "ready":
				if(g.game.problems.length > 0)
				{
					if(g.game.problems[param1.response.problem] != undefined)
					{
						if(g.game.problems[param1.response.problem] is Problem)
						{
							if(g.game.problems[param1.response.problem].loaded)
							{
								_loc_2 = new EsObject();
								_loc_2.setInteger("n", param1.response.problem);
								_loc_2.setInteger("id", g.user.id);
								plugin("ready", _loc_2);
							}
						}
						else
						{
							server_log("on_ready: g.game.problems[" + param1.response.problem + "] is not of type Problem. Attempting reload");
							loadProblem(param1.response.problem);
						}
					}
					else
					{
						server_log("on_ready: g.game.problems[" + param1.response.problem + "] is undefined. Trying to reload problem.");
						loadProblem(param1.response.problem);
					}
				}
				else
				{
					server_log("on_ready: g.game.problems.length <= 0. Trying to reload problem.");
					loadProblem(param1.response.problem);
				}
				break;
			case "go":
				if(g.game.problems.length > 0)
				{
					if(g.game.problems[param1.response.problem] != undefined)
					{
						if(g.game.problems[param1.response.problem] is Problem && g.game.problems[param1.response.problem].loaded)
						{
							begin_problem(param1.response.problem);
						}
					}
				}
				break;
			case "GMLeft":
				enable_start(null);
				panel_information.large = "\n\nGame creator left\n\nYou now can start the game.";
				break;
			case "player_type":
				if(param1.response.type == "spectator")
				{
					g.game.player_type = FTW.SPECTATOR;
				}
				else
				{
					g.game.player_type = FTW.PLAYER;
				}
				break;
			case "load_problem":
				if(param1.response.problem > 1)
				{
					loadProblem(param1.response.problem);
				}
				break;
			default:
				super.on_plugin_message(param1);
				break;
			}
		}

		override protected function on_added(param1:Event) : void
		{
			super.on_added(param1);
		}

		override protected function on_added_to_stage(param1:Event) : void
		{
			super.on_added_to_stage(param1);
			panel_problem.hide();
			addChild(panel_problem);
			panel_spectator.hide();
			addChild(panel_spectator);
			panel_information.show();
			addChild(panel_information);
			panel_timer.hide();
			addChild(panel_timer);
			panel_scoreboard.hide();
			addChild(panel_scoreboard);
			panel_final_scoreboard.hide();
			addChild(panel_final_scoreboard);
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("user_id", g.user.id);
			_loc_2.setInteger("game_id", g.game.id);
			_loc_2.setString("user_ip", g.user.ip);
			_loc_2.setString("rating", String(g.user.current_rating));
			_loc_2.setInteger("player_type", g.game.player_type);
			_loc_2.setString("version", g.version);
			g.server.esServerPlugin(g.manager, "enter_game", _loc_2);
			button_leave.alpha = 0.50;
			leave_button_interval = setInterval(on_leave_button_interval, 1000);
			if(g.game.can_start_game)
			{
				button_start.visible = true;
				button_start.alpha = 0.50;
				panel_information.large = "\n\nPreparing game...";
			}
			else
			{
				button_start.visible = false;
				panel_information.large = "\n\nPlease wait for game to begin...";
			}
			button_start.enabled = false;
		}

		override protected function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(panel_problem, ProblemAnswerEvent.ANSWER, got_answer);
			super.on_removed_from_stage(param1);
		}

		override protected function on_removed(param1:Event) : void
		{
			EventManager.remove(panel_problem, ProblemAnswerEvent.ANSWER, got_answer);
			super.on_removed(param1);
		}

		public function plugin(param1:String, param2:EsObject = null) : void
		{
			g.server.esRoomPlugin("Game", g.game.zone_name, g.game.room_name, param1, param2);
		}

		public function server_log(param1:String) : void
		{
			var _loc_2:EsObject = new EsObject();
			_loc_2.setString("message", param1);
			plugin("log", _loc_2);
		}
	}
}
package Game
{
	import flash.display.*;
	import flash.text.*;

	public class InformationPanel extends Sprite
	{
		public var _t_large:TextField;
		public var _t_small:TextField;

		public function InformationPanel()
		{
			super();
		}

		public function Information()
		{
		}

		public function set small(param1:String) : void
		{
			_t_small.text = param1;
		}

		public function set large(param1:String) : void
		{
			_t_large.text = param1;
		}

		public function show()
		{
			this.visible = true;
		}

		public function hide()
		{
			this.large = "";
			this.small = "";
			this.visible = false;
		}
	}
}
package Game
{
	import Misc.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class Problem extends EventDispatcher
	{
		public var number:uint = 0;
		public var id:uint = 0;
		public var filename:String = "";
		public var answer:String = "";
		public var real_answer:String = "";
		public var answers:Array;
		public var user_answer:String = "";
		public var book:uint = -28;
		public var image:Loader = null;
		public var loaded:Boolean = false;
		public var error:String = "";
		public var reported:Boolean = false;
		public var loadInterval:uint = 0;
		public var loadCount:uint = 0;

		public function Problem(param1:uint)
		{
			super();
			this.number = param1;
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			this.answers = new Array();
			loadCount = 0;
			poll();
		}

		override public function toString() : String
		{
			var _loc_1:String = null;
			_loc_1 = "Problem Number: " + number + "\n" + "Problem ID: " + id + "\n" + "Filename: " + filename + "\n" + "Answer: " + answer + "\n" + "User Answer: " + user_answer + "\n" + "Book: " + book + "\n" + "Loaded: " + loaded + "\n" + "Error: " + error + "\n" + "Reported: " + reported + "\n" + "Load Interval: " + loadInterval + "\n" + "Load Count: " + loadCount;
			return _loc_1;
		}

		public function load_image() : void
		{
			if(loadInterval != 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
			var _loc_1:URLRequest = new URLRequest(filename);
			image = new Loader();
			image.load(_loc_1);
			EventManager.add(image.contentLoaderInfo, Event.COMPLETE, setloaded);
			EventManager.add(image.contentLoaderInfo, IOErrorEvent.IO_ERROR, seterror);
			g.debug;
			if(g.debug && 1 == 0)
			{
				EventManager.add(image.contentLoaderInfo, HTTPStatusEvent.HTTP_STATUS, http_status_handler);
				EventManager.add(image.contentLoaderInfo, Event.INIT, init_handler);
				EventManager.add(image.contentLoaderInfo, Event.OPEN, open_handler);
				EventManager.add(image.contentLoaderInfo, Event.UNLOAD, unload_handler);
				EventManager.add(image.contentLoaderInfo, ProgressEvent.PROGRESS, progress_handler);
			}
		}

		public function on_plugin_message(param1:Object) : void
		{
			var _loc_2:int = 0;
			var _loc_3:Array = null;
			var _loc_4:int = 0;
			switch(param1.response.Action)
			{
			case "Problem":
				if(param1.response.number != this.number)
				{
					return;
				}
				if(param1.response.file.length > 10)
				{
					g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
					if(!g.user.s3)
					{
						_loc_2 = 0;
						_loc_2 = this.filename.lastIndexOf("/");
						param1.response.file = "http://www.artofproblemsolving.com/Forum/latexrender/pictures/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 1)) + "/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 2)) + "/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 3)) + "/";
						param1.response.file = param1.response.file + (this.filename.substr(_loc_2 + 1));
					}
					this.id = param1.response.id;
					this.book = param1.response.book;
					this.answer = g.clean_answer(param1.response.answer);
					this.real_answer = param1.response.answer;
					this.filename = param1.response.file;
					load_image();
					this.answers = new Array();
					this.answers.push(this.answer);
					if(param1.response.alt_answers.length > 0)
					{
						_loc_3 = String(param1.response.alt_answers).split("\n");
						if(_loc_3.length > 0)
						{
							_loc_4 = _loc_3.length - 1;
							while(_loc_4 >= 0)
							{
								this.answers.push(g.clean_answer(_loc_3[_loc_4]));
								_loc_4 = _loc_4 - 1;
							}
						}
					}
				}
				else
				{
					if(loadInterval > 0)
					{
						clearInterval(loadInterval);
					}
					g.scene.debug("on-plugin_message: Setting interval");
					loadInterval = setInterval(poll, 1000);
				}
				break;
			default:
				break;
			}
		}

		private function poll() : void
		{
			var _loc_1:EsObject = null;
			if(loadInterval > 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
			if(g.server.isConnected)
			{
				_loc_1 = new EsObject();
				_loc_1.setInteger("n", this.number);
				g.server.esRoomPlugin("Game", g.game.zone_name, g.game.room_name, "Problem", _loc_1);
			}
		}

		private function setloaded(param1:Event) : void
		{
			remove_load_event_listeners();
			this.loaded = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function seterror(param1:IOErrorEvent) : void
		{
			var _loc_2:EsObject = new EsObject();
			_loc_2.setString("message", "I/O Error loading " + number + " " + filename + " " + param1.text);
			g.server.esRoomPlugin("Game", g.game.zone_name, g.game.room_name, "log", _loc_2);
			remove_load_event_listeners();
			var _loc_4:* = this.loadCount + 1;
			this.loadCount = _loc_4;
			if(loadCount >= 3)
			{
				this.error = param1.text;
			}
			else
			{
				loadInterval = setInterval(load_image, 3000);
				var _loc_4:* = this.loadCount + 1;
				this.loadCount = _loc_4;
			}
		}

		private function remove_load_event_listeners() : void
		{
			if(image)
			{
				EventManager.remove(image.contentLoaderInfo, Event.COMPLETE, setloaded);
				EventManager.remove(image.contentLoaderInfo, IOErrorEvent.IO_ERROR, seterror);
				g.debug;
				if(g.debug && 1 == 0)
				{
					EventManager.remove(image.contentLoaderInfo, HTTPStatusEvent.HTTP_STATUS, http_status_handler);
					EventManager.remove(image.contentLoaderInfo, Event.INIT, init_handler);
					EventManager.remove(image.contentLoaderInfo, Event.OPEN, open_handler);
					EventManager.remove(image.contentLoaderInfo, Event.UNLOAD, unload_handler);
					EventManager.remove(image.contentLoaderInfo, ProgressEvent.PROGRESS, progress_handler);
				}
			}
		}

		public function cleanup()
		{
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			remove_load_event_listeners();
			if(loadInterval > 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
		}

		private function http_status_handler(param1:HTTPStatusEvent) : void
		{
			g.debuglog("HTTPStatusEvent.HTTP_Status: " + param1.status);
		}

		private function init_handler(param1:Event) : void
		{
			g.debuglog("Event.INIT: " + param1);
		}

		private function open_handler(param1:Event) : void
		{
			g.debuglog("Event.OPEN: " + param1);
		}

		private function unload_handler(param1:Event) : void
		{
			g.debuglog("Event.UNLOAD: " + param1);
		}

		private function progress_handler(param1:ProgressEvent) : void
		{
			g.debuglog("ProgressEvent.PROGRESS: " + param1);
		}
	}
}
package Game
{
	import flash.events.*;

	public class ProblemAnswerEvent extends Event
	{
		public static const ANSWER:String = "answer";
		public var answer:String;
		public var problem_number:uint;

		public function ProblemAnswerEvent(param1:uint, param2:String, param3:Boolean = false, param4:Boolean = false) : void
		{
			super(ANSWER);
			this.answer = param2;
			this.problem_number = param1;
		}

		override public function toString() : String
		{
			return "Problem Number: " + this.problem_number + " Answer: " + answer + " Event: " + super.toString();
		}

		override public function clone() : Event
		{
			return new ProblemAnswerEvent(this.problem_number, this.answer, this.bubbles, this.cancelable);
		}
	}
}
package Game
{
	import Misc.*;
	import fl.containers.*;
	import flash.display.*;
	import flash.events.*;

	public class ProblemPanel extends Sprite
	{
		public var _sp_problem:ScrollPane;
		public var input:ProblemPanel_Input;
		private var problem_number:uint;

		public function ProblemPanel(param1:Boolean = false)
		{
			super();
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			spectator(param1);
			__setProp__sp_problem_ProblemPanel_Layer1_0();
		}

		public function spectator(param1:Boolean = true)
		{
			if(param1)
			{
				input.visible = false;
				_sp_problem.height = 285;
			}
			else
			{
				input.create_listeners();
				EventManager.add(input, ProblemAnswerEvent.ANSWER, on_answer);
				input.visible = true;
				_sp_problem.height = 265;
			}
		}

		public function attach(param1:Problem) : void
		{
			problem_number = param1.number;
			clear();
			var _loc_2:Sprite = new Sprite();
			_loc_2.graphics.beginFill(16777215);
			_loc_2.graphics.drawRect(0, 0, param1.image.width + 10, param1.image.height + 10);
			_loc_2.visible = false;
			param1.image.x = 5;
			param1.image.y = 5;
			var _loc_3:Sprite = Sprite(_sp_problem.content);
			_loc_3.addChild(_loc_2);
			_loc_3.addChild(param1.image);
			_sp_problem.update();
		}

		public function clear() : void
		{
			while(Sprite(_sp_problem.content).numChildren)
			{
				Sprite(_sp_problem.content).removeChildAt(0);
			}
		}

		public function show() : void
		{
			this.visible = true;
			input.visible = true;
			input.problem_number = problem_number;
			input.reset();
		}

		public function hide() : void
		{
			this.visible = false;
		}

		public function show_response_area() : void
		{
			input.visible = true;
		}

		public function hide_response_area() : void
		{
			input.visible = false;
		}

		private function on_answer(param1:ProblemAnswerEvent) : void
		{
			dispatchEvent(param1);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(input, ProblemAnswerEvent.ANSWER, on_answer);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			input.remove_listeners();
		}

		private function on_added_to_stage(param1:Event) : void
		{
			if(param1.currentTarget == this)
			{
				EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			}
		}

		public function __setProp__sp_problem_ProblemPanel_Layer1_0()
		{
			try
			{
				_sp_problem["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_sp_problem.enabled = true;
			_sp_problem.horizontalLineScrollSize = 4;
			_sp_problem.horizontalPageScrollSize = 0;
			_sp_problem.horizontalScrollPolicy = "auto";
			_sp_problem.scrollDrag = false;
			_sp_problem.source = "EmptyClip";
			_sp_problem.verticalLineScrollSize = 4;
			_sp_problem.verticalPageScrollSize = 0;
			_sp_problem.verticalScrollPolicy = "auto";
			_sp_problem.visible = true;
			try
			{
				_sp_problem["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
package Game
{
	import Misc.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;

	public class ProblemPanel_Input extends Sprite
	{
		public var answer:TextField;
		public var problem_number:uint;

		public function ProblemPanel_Input()
		{
			super();
			answer.maxChars = 12;
		}

		public function reset() : void
		{
			if(answer)
			{
				stage.focus = answer;
				answer.text = "";
				answer.visible = true;
				answer.setSelection(0, 0);
			}
		}

		public function create_listeners() : void
		{
			EventManager.add(answer, KeyboardEvent.KEY_DOWN, this.on_key_down);
		}

		public function remove_listeners() : void
		{
			EventManager.remove(answer, KeyboardEvent.KEY_DOWN, on_key_down);
		}

		private function on_key_down(param1:KeyboardEvent) : void
		{
			if(param1.charCode == Keyboard.ENTER)
			{
				if(answer.text.length > 0 && answer.text.length <= 12)
				{
					dispatchEvent(new ProblemAnswerEvent(problem_number, answer.text));
					answer.text = "";
				}
			}
		}
	}
}
package Game
{
	import Ad.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class ScoreboardPanel extends Sprite
	{
		public var scoreboard:DataGrid;
		public var next_problem:TextField;
		public var seconds:uint;
		public var countdown_interval:uint;
		public var ad:Ad;

		public function ScoreboardPanel()
		{
			super();
			__setProp_scoreboard_ScoreboardPanel_Layer1_0();
		}

		public function EndProblemPanel()
		{
			scoreboard.columns = ["Time", "Response", "User"];
			scoreboard.setStyle("borderStyle", "none");
			scoreboard.sortItemsOn("Time");
			countdown_interval = 0;
		}

		public function countdown(param1:uint) : void
		{
			this.seconds = param1;
			if(countdown_interval == 0)
			{
				countdown_interval = setInterval(update_countdown, 1000);
				next_problem.text = "Next problem in " + param1;
			}
		}

		private function update_countdown() : void
		{
			var _loc_2:* = this.seconds - 1;
			this.seconds = _loc_2;
			if(seconds > 0)
			{
				next_problem.text = "Next problem in " + seconds;
			}
			else
			{
				next_problem.text = "";
				clearInterval(countdown_interval);
				countdown_interval = 0;
			}
		}

		public function board(param1:String) : void
		{
			var _loc_4:Array = null;
			var _loc_5:* = undefined;
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = _loc_2[_loc_3].split("\t");
				if(_loc_4.length > 2)
				{
					_loc_5 = {User:_loc_4[0], Response:response_text(uint(_loc_4[1])), Time:Number(_loc_4[2]).toFixed(3)};
					scoreboard.addItem(_loc_5);
				}
				_loc_3 = _loc_3 + 1;
			}
		}

		public function add(param1:String, param2:uint, param3:Number) : void
		{
			var _loc_4:* = {User:param1, Response:response_text(param2), Time:param3.toFixed(3)};
			scoreboard.addItem(_loc_4);
		}

		private function response_text(param1:uint) : String
		{
			switch(param1)
			{
			case 0:
				return "Incorrect";
			case 1:
				return "Correct";
			case 2:
				return "Give Up";
			case 4:
				return "Time Out";
			default:
				break;
			}
			return "";
		}

		public function show() : void
		{
			try
			{
				if(g.game.problemNumber > 0)
				{
					if(g.game.problems[g.game.problemNumber] == undefined)
					{
						ad.book = 100;
					}
					else
					{
						if(g.game.problems[g.game.problemNumber] == null)
						{
							ad.book = 100;
						}
						else
						{
							ad.book = 100;
							ad.book = g.game.problems[g.game.problemNumber].book;
						}
					}
				}
				else
				{
					ad.book = 100;
				}
				scoreboard.removeAll();
				this.visible = true;
			}
			catch(e:*)
			{
				g.server.log("Exception: " + e.toString());
			}
		}

		public function hide() : void
		{
			if(countdown_interval != 0)
			{
				clearInterval(countdown_interval);
				countdown_interval = 0;
			}
			next_problem.text = "";
			this.visible = false;
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_added_to_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		public function __setProp_scoreboard_ScoreboardPanel_Layer1_0()
		{
			try
			{
				scoreboard["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			scoreboard.allowMultipleSelection = false;
			scoreboard.editable = false;
			scoreboard.headerHeight = 25;
			scoreboard.horizontalLineScrollSize = 4;
			scoreboard.horizontalPageScrollSize = 0;
			scoreboard.horizontalScrollPolicy = "off";
			scoreboard.resizableColumns = false;
			scoreboard.rowHeight = 20;
			scoreboard.showHeaders = true;
			scoreboard.sortableColumns = true;
			scoreboard.verticalLineScrollSize = 4;
			scoreboard.verticalPageScrollSize = 0;
			scoreboard.verticalScrollPolicy = "auto";
			try
			{
				scoreboard["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
package Game
{
	public class ScoringType extends Object
	{
		public static var RANK:uint = 1;
		public static var TIME:uint = 2;
		public static var CORRECT:uint = 3;
		public static var COMPOSITE:uint = 4;
		public static var COUNTDOWN:uint = 5;

		final public static function toString(param1:uint) : String
		{
			if(param1 == ScoringType.RANK)
			{
				return "Ranking";
			}
			if(param1 == ScoringType.TIME)
			{
				return "Time";
			}
			if(param1 == ScoringType.CORRECT)
			{
				return "Responses";
			}
			if(param1 == ScoringType.COMPOSITE)
			{
				return "Composite";
			}
			if(param1 == ScoringType.COUNTDOWN)
			{
				return "Countdown";
			}
			return "Unknown";
		}

		public function ScoringType()
		{
			super();
		}
	}
}
package Game
{
	import fl.containers.*;
	import flash.display.*;

	public class SpectatorPanel extends Sprite
	{
		public var _sp_problem:ScrollPane;
		private var problem_number:uint;

		public function SpectatorPanel(param1:Boolean = false)
		{
			super();
			__setProp__sp_problem_SpectatorPanel_Layer1_0();
		}

		public function attach(param1:Problem) : void
		{
			problem_number = param1.number;
			clear();
			var _loc_2:Sprite = new Sprite();
			_loc_2.graphics.beginFill(16777215);
			_loc_2.graphics.drawRect(0, 0, param1.image.width + 10, param1.image.height + 10);
			_loc_2.visible = false;
			param1.image.x = 5;
			param1.image.y = 5;
			var _loc_3:Sprite = Sprite(_sp_problem.content);
			_loc_3.addChild(_loc_2);
			_loc_3.addChild(param1.image);
			_sp_problem.update();
		}

		public function clear() : void
		{
			while(Sprite(_sp_problem.content).numChildren)
			{
				Sprite(_sp_problem.content).removeChildAt(0);
			}
		}

		public function show() : void
		{
			this.visible = true;
		}

		public function hide() : void
		{
			this.visible = false;
		}

		public function __setProp__sp_problem_SpectatorPanel_Layer1_0()
		{
			try
			{
				_sp_problem["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_sp_problem.enabled = true;
			_sp_problem.horizontalLineScrollSize = 4;
			_sp_problem.horizontalPageScrollSize = 0;
			_sp_problem.horizontalScrollPolicy = "auto";
			_sp_problem.scrollDrag = false;
			_sp_problem.source = "EmptyClip";
			_sp_problem.verticalLineScrollSize = 4;
			_sp_problem.verticalPageScrollSize = 0;
			_sp_problem.verticalScrollPolicy = "auto";
			_sp_problem.visible = true;
			try
			{
				_sp_problem["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
package Game
{
	import Misc.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class TimerPanel extends Sprite
	{
		public var _message:TextField;
		public var _time:TextField;
		private var _seconds:uint;
		private var _start_time:uint;

		public function TimerPanel()
		{
			super();
		}

		public function Timer()
		{
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function start(param1:uint = 0) : void
		{
			if(param1 > 0)
			{
				this._seconds = param1;
				this._start_time = getTimer();
			}
			EventManager.add(this, Event.ENTER_FRAME, update_time);
		}

		public function stop() : void
		{
			remove_events();
		}

		public function update_time(param1:Event)
		{
			var _loc_3:TimerEvent = null;
			var _loc_2:int = this._seconds - (int((getTimer() - this._start_time) / 1000));
			_time.text = String(_loc_2);
			if(_loc_2 <= 0)
			{
				remove_events();
				_loc_3 = new TimerEvent(TimerEvent.TIMER_COMPLETE);
				dispatchEvent(_loc_3);
			}
		}

		public function set message(param1:String) : void
		{
			_message.text = param1;
		}

		public function show()
		{
			this.visible = true;
		}

		public function hide()
		{
			this.visible = false;
			remove_events();
		}

		public function remove_events()
		{
			EventManager.remove(this, Event.ENTER_FRAME, update_time);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function on_removed_from_stage()
		{
			remove_events();
		}
	}
}
