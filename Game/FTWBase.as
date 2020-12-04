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
