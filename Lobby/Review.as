package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.containers.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class Review extends Sprite
	{
		public static var class_name:* = "Lobby.Review";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var pane:ScrollPane;
		private var next_button:Button;
		private var previous_button:Button;
		private var report_button:Button;
		private var ask_button:Button;
		private var problem_number:uint;

		public function Review()
		{
			super();
			g.debuglog("Review Constructor");
			var _loc_2:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_2;
			instance_number = instance_number_counter;
			g.debuglog("In Review");
			window = new YakDialog("Review Problems", 492, 360);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			EventManager.add(window, KeyboardEvent.KEY_UP, on_key_up);
			pane = new ScrollPane();
			pane.move(5, 5);
			pane.setSize(470, 220);
			pane.source = new Sprite();
			window.canvas.addChild(pane);
			problem_number = 1;
			display_problem();
			next_button = new Button();
			next_button.label = "Next";
			next_button.x = 110;
			next_button.y = 300;
			window.canvas.addChild(next_button);
			previous_button = new Button();
			previous_button.label = "Previous";
			previous_button.x = 5;
			previous_button.y = 300;
			window.canvas.addChild(previous_button);
			ask_button = new Button();
			ask_button.label = "Ask on Forum";
			ask_button.x = 270;
			ask_button.y = 300;
			window.canvas.addChild(ask_button);
			report_button = new Button();
			report_button.label = "Report";
			report_button.x = 375;
			report_button.y = 300;
			window.canvas.addChild(report_button);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(previous_button, MouseEvent.CLICK, on_previous_button);
			EventManager.add(ask_button, MouseEvent.CLICK, on_ask_button);
			EventManager.add(report_button, MouseEvent.CLICK, on_report_button);
			EventManager.add(next_button, MouseEvent.CLICK, on_next_button);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added);
		}

		private function display_problem() : void
		{
			if(problem_number < 1)
			{
				problem_number = g.game.last_problem_number_displayed;
			}
			else
			{
				if(problem_number > g.game.last_problem_number_displayed)
				{
					problem_number = 1;
				}
			}
			var _loc_1:uint = 100000;
			while(g.game.problems[problem_number] && problem_number == _loc_1)
			{
				if(_loc_1 == 100000)
				{
					_loc_1 = problem_number;
				}
				var _loc_6:* = this.problem_number + 1;
				this.problem_number = _loc_6;
				if(problem_number > g.game.last_problem_number_displayed)
				{
					problem_number = 1;
				}
			}
			while(Sprite(pane.content).numChildren)
			{
				Sprite(pane.content).removeChildAt(0);
			}
			var _loc_2:Problem = g.game.problems[problem_number];
			_loc_2.image.x = 5;
			_loc_2.image.y = 5;
			var _loc_3:Sprite = new Sprite();
			_loc_3.graphics.beginFill(16777215);
			_loc_3.graphics.drawRect(0, 0, _loc_2.image.width + 10, _loc_2.image.height + 10);
			_loc_3.visible = false;
			var _loc_4:Sprite = Sprite(pane.content);
			_loc_4.addChild(_loc_3);
			_loc_4.addChild(_loc_2.image);
			if(_loc_2.user_answer != null)
			{
				window.setTitle("Problem " + problem_number + "; Answer: " + _loc_2.real_answer + "; Your answer: " + _loc_2.user_answer);
			}
			else
			{
				window.setTitle("Problem " + problem_number + "; Answer: " + _loc_2.real_answer + "; Your answer: None");
			}
			pane.update();
		}

		private function on_report_button(param1:MouseEvent) : void
		{
			addChild(new Review_Report(g.game.problems[problem_number]));
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			parent.removeChild(this);
		}

		private function on_ask_button(param1:MouseEvent) : void
		{
			var _loc_2:URLRequest = new URLRequest((g.phpPath + "ask_forum.php?problem_id=") + g.game.problems[problem_number].id);
			navigateToURL(_loc_2, "_blank");
		}

		private function on_key_up(param1:KeyboardEvent) : void
		{
			if(param1.keyCode == 37)
			{
				var _loc_3:* = this.problem_number - 1;
				this.problem_number = _loc_3;
			}
			else
			{
				if(param1.keyCode == 39)
				{
					var _loc_3:* = this.problem_number + 1;
					this.problem_number = _loc_3;
				}
			}
			display_problem();
		}

		private function on_next_button(param1:MouseEvent) : void
		{
			var _loc_3:* = this.problem_number + 1;
			this.problem_number = _loc_3;
			display_problem();
		}

		private function on_previous_button(param1:MouseEvent) : void
		{
			var _loc_3:* = this.problem_number - 1;
			this.problem_number = _loc_3;
			display_problem();
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(window, KeyboardEvent.KEY_UP, on_key_up);
			EventManager.remove(previous_button, MouseEvent.CLICK, on_previous_button);
			EventManager.remove(ask_button, MouseEvent.CLICK, on_ask_button);
			EventManager.remove(report_button, MouseEvent.CLICK, on_report_button);
			EventManager.remove(next_button, MouseEvent.CLICK, on_next_button);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added);
		}

		private function on_added(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added);
			next_button.setFocus();
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
			pane.scrollDrag = false;
			parent.removeChild(this);
		}
	}
}
