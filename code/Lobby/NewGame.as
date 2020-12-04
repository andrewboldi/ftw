package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class NewGame extends Sprite
	{
		public static var class_name:* = "Lobby.NewGame";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var scoring_method:ComboBox;
		private var problem_count:NumericStepper;
		private var time_per_problem:NumericStepper;
		private var rated:CheckBox;
		private var spectators:CheckBox;
		private var ok:Button;
		private var cancel:Button;
		private var password:TextInput;
		private var scoring_method_label:TextField;
		private var problem_count_label:TextField;
		private var time_per_problem_label:TextField;
		private var rated_label:TextField;
		private var spectators_label:TextField;
		private var password_label:TextField;
		private var school:CheckBox;
		private var chapter:CheckBox;
		private var state:CheckBox;
		private var sprint:CheckBox;
		private var target:CheckBox;
		private var countdown:CheckBox;
		private var school_label:TextField;
		private var chapter_label:TextField;
		private var state_label:TextField;
		private var sprint_label:TextField;
		private var target_label:TextField;
		private var countdown_label:TextField;

		public function NewGame()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			window = new YakDialog("New Game", 250, 290);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			scoring_method = new ComboBox();
			scoring_method.setSize(100, 22);
			scoring_method.addItem({label:"Ranking", data:ScoringType.RANK});
			scoring_method.addItem({label:"Time", data:ScoringType.TIME});
			scoring_method.addItem({label:"Responses", data:ScoringType.CORRECT});
			scoring_method.addItem({label:"Time/Rank", data:ScoringType.COMPOSITE});
			scoring_method.move(120, 10);
			window.canvas.addChild(scoring_method);
			problem_count = new NumericStepper();
			problem_count.stepSize = 1;
			problem_count.minimum = 4;
			problem_count.maximum = 20;
			problem_count.value = 10;
			problem_count.width = 45;
			problem_count.move(120, 45);
			window.canvas.addChild(problem_count);
			time_per_problem = new NumericStepper();
			time_per_problem.stepSize = 1;
			time_per_problem.minimum = 5;
			time_per_problem.maximum = 120;
			time_per_problem.value = 45;
			time_per_problem.width = 45;
			time_per_problem.move(120, 80);
			window.canvas.addChild(time_per_problem);
			rated = new CheckBox();
			rated.move(115, 115);
			rated.label = " ";
			rated.selected = true;
			window.canvas.addChild(rated);
			spectators = new CheckBox();
			spectators.move(115, 150);
			spectators.label = " ";
			window.canvas.addChild(spectators);
			password = new TextInput();
			password.move(115, 185);
			window.canvas.addChild(password);
			ok = new Button();
			ok.label = "Create Game";
			ok.x = 25;
			ok.y = 220;
			EventManager.add(ok, MouseEvent.CLICK, on_create_game, "NewGame.Create");
			ok.setSize(90, ok.height);
			ok.mouseEnabled = true;
			window.canvas.addChild(ok);
			cancel = new Button();
			cancel.label = "Cancel";
			cancel.x = 125;
			cancel.y = 220;
			EventManager.add(cancel, MouseEvent.CLICK, on_cancel, "NewGame.Cancel");
			cancel.setSize(90, cancel.height);
			cancel.mouseEnabled = true;
			window.canvas.addChild(cancel);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.font = "_sans";
			_loc_1.bold = true;
			_loc_1.align = "right";
			scoring_method_label = new TextField();
			scoring_method_label.width = 105;
			scoring_method_label.height = 25;
			scoring_method_label.text = "Game Type";
			scoring_method_label.x = 10;
			scoring_method_label.y = 10;
			scoring_method_label.setTextFormat(_loc_1);
			window.canvas.addChild(scoring_method_label);
			problem_count_label = new TextField();
			problem_count_label.width = 105;
			problem_count_label.height = 25;
			problem_count_label.text = "Problem Count";
			problem_count_label.x = 10;
			problem_count_label.y = 45;
			problem_count_label.setTextFormat(_loc_1);
			window.canvas.addChild(problem_count_label);
			time_per_problem_label = new TextField();
			time_per_problem_label.width = 105;
			time_per_problem_label.height = 25;
			time_per_problem_label.text = "Time Per Problem";
			time_per_problem_label.x = 10;
			time_per_problem_label.y = 80;
			time_per_problem_label.setTextFormat(_loc_1);
			window.canvas.addChild(time_per_problem_label);
			rated_label = new TextField();
			rated_label.width = 105;
			rated_label.height = 25;
			rated_label.text = "Rated";
			rated_label.x = 10;
			rated_label.y = 115;
			rated_label.setTextFormat(_loc_1);
			window.canvas.addChild(rated_label);
			spectators_label = new TextField();
			spectators_label.width = 105;
			spectators_label.height = 25;
			spectators_label.text = "Spectators";
			spectators_label.x = 10;
			spectators_label.y = 150;
			spectators_label.setTextFormat(_loc_1);
			window.canvas.addChild(spectators_label);
			password_label = new TextField();
			password_label.width = 105;
			password_label.height = 25;
			password_label.text = "Password";
			password_label.x = 10;
			password_label.y = 185;
			password_label.setTextFormat(_loc_1);
			window.canvas.addChild(password_label);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_create_game(param1:MouseEvent) : void
		{
			g.game.reset();
			g.game.type = "FTW";
			g.game.max_players = -1;
			g.game.problem_count = problem_count.value;
			g.game.time_per_problem = time_per_problem.value;
			g.game.rated = rated.selected;
			g.game.spectators = spectators.selected;
			g.game.scoring_method = scoring_method.selectedItem.data;
			g.game.password = password.text;
			var _loc_2:Boolean = true;
			g.game.countdown = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.team = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.target = _loc_2;
			g.game.sprint = _loc_2;
			var _loc_2:Boolean = true;
			g.game.national = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.state = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.chapter = _loc_2;
			g.game.school = _loc_2;
			g.game.amc8 = true;
			g.replay = g.game.clone();
			g.game.create();
			close(param1);
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			close(param1);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event) : void
		{
			scoring_method.close();
			parent.removeChild(this);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(ok, MouseEvent.CLICK, on_create_game);
			EventManager.remove(cancel, MouseEvent.CLICK, on_cancel);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}
	}
}
