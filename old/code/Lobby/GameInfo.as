package Lobby
{
	import Misc.*;
	import Type.*;
	import com.electrotank.electroserver4.esobject.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class GameInfo extends Sprite
	{
		public static var class_name:* = "Lobby.GameInfo";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var status:TextField;
		private var join:Button;
		private var spectate:Button;
		private var password:TextInput;
		private var password_label:TextField;
		private var time_per_problem:TextField;
		private var number_of_problems:TextField;
		private var rated:TextField;
		private var scoring_method:TextField;
		private var rounds:TextField;
		private var levels:TextField;
		private var game_password:String;
		public var userlist:Userlist;
		private var game_id:uint;

		public function GameInfo(param1:uint)
		{
			super();
			var _loc_7:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_7;
			instance_number = instance_number_counter;
			game_id = param1;
			window = new YakDialog("Game Information", 250, 375);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("game_id", game_id);
			g.server.esServerPlugin(g.manager, "subscribe", _loc_2);
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			join = new Button();
			spectate = new Button();
			join.label = "Join";
			join.y = 314;
			join.setSize(90, join.height);
			join.mouseEnabled = true;
			join.visible = false;
			window.canvas.addChild(join);
			spectate.label = "Spectate";
			spectate.y = 314;
			spectate.setSize(90, spectate.height);
			spectate.mouseEnabled = true;
			spectate.visible = false;
			window.canvas.addChild(spectate);
			userlist = new Userlist();
			userlist.width = 228;
			userlist.height = 150;
			userlist.x = 5;
			userlist.y = 5;
			window.canvas.addChild(userlist);
			var _loc_3:TextFormat = new TextFormat();
			_loc_3.font = "_sans";
			var _loc_4:TextFormat = new TextFormat();
			_loc_4.font = "_sans";
			_loc_4.align = "center";
			var _loc_5:TextFormat = new TextFormat();
			_loc_5.font = "_sans";
			_loc_5.align = "right";
			status = new TextField();
			status.width = userlist.width;
			status.height = 22;
			status.defaultTextFormat = _loc_4;
			status.text = "Obtaining Status";
			status.y = 160;
			status.x = 2;
			window.canvas.addChild(status);
			time_per_problem = new TextField();
			time_per_problem.width = window.canvas.width;
			time_per_problem.height = 22;
			time_per_problem.defaultTextFormat = _loc_4;
			time_per_problem.text = "";
			time_per_problem.y = 178;
			time_per_problem.x = 2;
			window.canvas.addChild(time_per_problem);
			number_of_problems = new TextField();
			number_of_problems.width = window.canvas.width;
			number_of_problems.height = 22;
			number_of_problems.defaultTextFormat = _loc_4;
			number_of_problems.text = "";
			number_of_problems.y = 196;
			number_of_problems.x = 2;
			window.canvas.addChild(number_of_problems);
			rated = new TextField();
			rated.width = window.canvas.width;
			rated.height = 22;
			rated.defaultTextFormat = _loc_4;
			rated.text = "";
			rated.y = 214;
			rated.x = 2;
			window.canvas.addChild(rated);
			scoring_method = new TextField();
			scoring_method.width = window.canvas.width;
			scoring_method.height = 22;
			scoring_method.defaultTextFormat = _loc_4;
			scoring_method.text = "";
			scoring_method.y = 232;
			scoring_method.x = 2;
			window.canvas.addChild(scoring_method);
			rounds = new TextField();
			rounds.width = window.canvas.width;
			rounds.height = 22;
			rounds.defaultTextFormat = _loc_4;
			rounds.text = "";
			rounds.y = 250;
			rounds.x = 2;
			window.canvas.addChild(rounds);
			levels = new TextField();
			levels.width = window.canvas.width;
			levels.height = 22;
			levels.defaultTextFormat = _loc_4;
			levels.text = "";
			levels.y = 268;
			levels.x = 2;
			window.canvas.addChild(levels);
			password_label = new TextField();
			password_label.width = 90;
			password_label.height = 22;
			password_label.defaultTextFormat = _loc_5;
			password_label.text = "Password";
			password_label.y = 287;
			password_label.x = 2;
			password_label.visible = false;
			window.canvas.addChild(password_label);
			password = new TextInput();
			password.move(95, 287);
			password.visible = false;
			window.canvas.addChild(password);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "sub_player_list":
				on_player_list(param1.response.players);
				break;
			case "sub_player_add":
				on_player_add(param1.response.name, param1.response.rating);
				break;
			case "sub_player_leave":
				on_player_leave(param1.response.name);
				break;
			case "sub_game_status":
				on_game_status(uint(param1.response.status));
				break;
			case "sub_game_info":
				on_game_information(param1.response);
				break;
			case "sub_game_full":
				on_game_full(true, 1);
				break;
			case "sub_close":
				close();
				break;
			default:
				break;
			}
		}

		private function on_player_list(param1:String) : void
		{
			var _loc_4:Array = null;
			if(param1.length <= 0)
			{
				return;
			}
			userlist.clear();
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = String(_loc_2[_loc_3]).split("\t");
				userlist.addUser(_loc_4[0], _loc_4[1], false);
				_loc_3 = _loc_3 + 1;
			}
		}

		private function on_player_add(param1:String, param2:String) : void
		{
			userlist.addUser(param1, param2);
		}

		private function on_player_leave(param1:String) : void
		{
			userlist.removeUser(param1);
		}

		private function on_game_status(param1:uint) : void
		{
			if(param1 == GameStatus.STARTING || param1 == GameStatus.STARTED)
			{
				join.visible = false;
				this.status.text = "Game has started";
			}
			else
			{
				if(param1 == GameStatus.ENDING || param1 == GameStatus.ENDED)
				{
					join.visible = false;
					spectate.visible = false;
					this.status.text = "Game has ended";
				}
				else
				{
					join.visible = true;
					this.status.text = "";
				}
			}
		}

		private function on_game_information(param1:*) : void
		{
			var _loc_2:Array = new Array();
			var _loc_3:Array = new Array();
			if(param1.sprint)
			{
				_loc_2.push("Sprint");
			}
			if(param1.target)
			{
				_loc_2.push("Target");
			}
			if(param1.team)
			{
				_loc_2.push("Team");
			}
			if(param1.countdown)
			{
				_loc_2.push("Countdown");
			}
			if(param1.school)
			{
				_loc_3.push("School");
			}
			if(param1.chapter)
			{
				_loc_3.push("Chapter");
			}
			if(param1.state)
			{
				_loc_3.push("State");
			}
			if(param1.national)
			{
				_loc_3.push("Nats");
			}
			rounds.text = _loc_2.length == 4 ? "" : _loc_2.join(", ");
			levels.text = _loc_3.length == 4 ? "" : _loc_3.join(", ");
			on_number_of_problems(int(param1.problems));
			on_time_per_problem(int(param1.time));
			on_rated(param1.rated);
			on_scoring_method(int(param1.scoring));
			on_password(param1.pw);
			EventManager.add(join, MouseEvent.CLICK, on_join_game, "GameInfo.Join");
			if(int(param1.max_players) < 0 || int(param1.max_players) > int(param1.players))
			{
				join.visible = true;
			}
			else
			{
				join.x = 20;
				join.y = 20;
				join.visible = false;
			}
			if(param1.spectators)
			{
				EventManager.add(spectate, MouseEvent.CLICK, on_spectate_game, "GameInfo.Spectate");
				join.x = 25;
				if(join.visible)
				{
					spectate.x = 125;
				}
				else
				{
					spectate.x = 75;
				}
				spectate.visible = true;
			}
			else
			{
				spectate.visible = false;
				join.x = 75;
			}
			on_game_status(int(param1.status));
		}

		private function on_game_full(param1:Boolean, param2:uint) : void
		{
			if(param1)
			{
				join.visible = false;
				this.status.text = "Game is full";
			}
			else
			{
				on_game_status(param2);
			}
		}

		private function on_number_of_problems(param1:uint) : void
		{
			number_of_problems.text = "Number of Problems: " + param1;
		}

		private function on_time_per_problem(param1:uint) : void
		{
			time_per_problem.text = "Time Per Problem: " + param1 + " seconds";
		}

		private function on_rated(param1:Boolean) : void
		{
			if(param1)
			{
				this.rated.text = "Game is rated";
			}
			else
			{
				this.rated.text = "Game is not rated";
			}
		}

		private function on_scoring_method(param1:uint) : void
		{
			scoring_method.text = "Scoring method: " + ScoringMethod.LABELS[param1];
			if(param1 == ScoringMethod.COUNTDOWN)
			{
				number_of_problems.text = "";
			}
		}

		private function on_password(param1:String) : void
		{
			game_password = param1;
			if(param1.length > 0)
			{
				password.visible = true;
				password_label.visible = true;
			}
			else
			{
				password.visible = false;
				password_label.visible = false;
			}
		}

		private function on_button(param1:uint) : void
		{
			var _loc_2:EsObject = null;
			var _loc_3:YakAlert = null;
			if(password.text == game_password)
			{
				g.game.reset();
				g.game.player_type = param1;
				_loc_2 = new EsObject();
				_loc_2.setInteger("id", game_id);
				_loc_2.setString("pw", password.text);
				_loc_2.setInteger("user_id", g.user.id);
				g.server.esServerPlugin(g.manager, "join_game", _loc_2);
			}
			else
			{
				_loc_3 = new YakAlert("Invalid Password", "Error", "OK");
				_loc_3.center(g.scene.getScene());
				g.scene.getScene().addChild(_loc_3);
			}
			close();
		}

		private function on_join_game(param1:MouseEvent) : void
		{
			on_button(FTW.PLAYER);
		}

		private function on_spectate_game(param1:MouseEvent) : void
		{
			on_button(FTW.SPECTATOR);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(join, MouseEvent.CLICK, on_join_game);
			EventManager.remove(spectate, MouseEvent.CLICK, on_spectate_game);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("game_id", game_id);
			g.server.esServerPlugin(g.manager, "unsubscribe", _loc_2);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event = null) : void
		{
			if(parent != null)
			{
				parent.removeChild(this);
			}
		}
	}
}
