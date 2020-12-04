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

	public class NewCountdown extends Sprite
	{
		public static var class_name:* = "Lobby.NewCountdown";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var player_count:NumericStepper;
		private var rated:CheckBox;
		private var ok:Button;
		private var cancel:Button;
		private var password:TextInput;
		private var school:CheckBox;
		private var chapter:CheckBox;
		private var state:CheckBox;
		private var sprint:CheckBox;
		private var target:CheckBox;
		private var countdown:CheckBox;
		private var player_count_label:TextField;
		private var rated_label:TextField;
		private var password_label:TextField;
		private var school_label:TextField;
		private var chapter_label:TextField;
		private var state_label:TextField;
		private var sprint_label:TextField;
		private var target_label:TextField;
		private var countdown_label:TextField;

		public function NewCountdown()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			window = new YakDialog("New Countdown", 250, 290);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			player_count = new NumericStepper();
			player_count.stepSize = 1;
			player_count.minimum = 2;
			player_count.maximum = 4;
			player_count.value = 2;
			player_count.width = 45;
			player_count.move(120, 45);
			window.canvas.addChild(player_count);
			rated = new CheckBox();
			rated.move(115, 80);
			rated.label = " ";
			rated.selected = true;
			window.canvas.addChild(rated);
			password = new TextInput();
			password.move(115, 150);
			window.canvas.addChild(password);
			ok = new Button();
			ok.label = "Create";
			ok.x = 10;
			ok.y = 220;
			EventManager.add(ok, MouseEvent.CLICK, on_create_game, "NewCountdown.Create");
			ok.setSize(60, ok.height);
			ok.mouseEnabled = true;
			window.canvas.addChild(ok);
			cancel = new Button();
			cancel.label = "Cancel";
			cancel.x = 80;
			cancel.y = 220;
			EventManager.add(cancel, MouseEvent.CLICK, on_cancel, "NewCountdown.Cancel");
			cancel.setSize(60, cancel.height);
			cancel.mouseEnabled = true;
			window.canvas.addChild(cancel);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.font = "_sans";
			_loc_1.bold = true;
			_loc_1.align = "right";
			player_count_label = new TextField();
			player_count_label.width = 105;
			player_count_label.height = 25;
			player_count_label.text = "Player Count";
			player_count_label.x = 10;
			player_count_label.y = 45;
			player_count_label.setTextFormat(_loc_1);
			window.canvas.addChild(player_count_label);
			rated_label = new TextField();
			rated_label.width = 105;
			rated_label.height = 25;
			rated_label.text = "Rated";
			rated_label.x = 10;
			rated_label.y = 80;
			rated_label.setTextFormat(_loc_1);
			window.canvas.addChild(rated_label);
			password_label = new TextField();
			password_label.width = 105;
			password_label.height = 25;
			password_label.text = "Password";
			password_label.x = 10;
			password_label.y = 150;
			password_label.setTextFormat(_loc_1);
			window.canvas.addChild(password_label);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_create_game(param1:MouseEvent) : void
		{
			g.game.reset();
			g.game.type = "Countdown";
			g.game.max_players = player_count.value;
			g.game.problem_count = 20;
			g.game.time_per_problem = 45;
			g.game.rated = rated.selected;
			g.game.spectators = true;
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
			g.game.scoring_method = ScoringType.COUNTDOWN;
			g.game.password = password.text;
			g.replay = g.game.clone();
			g.game.create();
			parent.removeChild(this);
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(ok, MouseEvent.CLICK, on_create_game);
			EventManager.remove(cancel, MouseEvent.CLICK, on_cancel);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
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
			parent.removeChild(this);
		}
	}
}
