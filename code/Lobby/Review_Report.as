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
	import net.theyak.util.*;

	public class Review_Report extends Sprite
	{
		public static var class_name:* = "Lobby.Review_Report";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var ok_button:Button;
		private var cancel_button:Button;
		private var report:TextArea;
		private var problem:Problem;

		public function Review_Report(param1:Problem)
		{
			super();
			var _loc_4:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_4;
			instance_number = instance_number_counter;
			this.problem = param1;
			window = new YakDialog("Report Problem", 400, 300);
			var _loc_2:TextField = new TextField();
			_loc_2.text = "Please describe the issue and click submit.";
			_loc_2.x = 5;
			_loc_2.y = 5;
			_loc_2.width = 390;
			window.canvas.addChild(_loc_2);
			ok_button = new Button();
			ok_button.label = "Submit";
			ok_button.x = 97;
			ok_button.y = 240;
			window.canvas.addChild(ok_button);
			cancel_button = new Button();
			cancel_button.label = "Cancel";
			cancel_button.x = 202;
			cancel_button.y = 240;
			window.canvas.addChild(cancel_button);
			report = new TextArea();
			report.setSize(380, 190);
			report.x = 5;
			report.y = 35;
			window.canvas.addChild(report);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(ok_button, MouseEvent.CLICK, on_ok_button);
			EventManager.add(cancel_button, MouseEvent.CLICK, close);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		private function on_ok_button(param1:MouseEvent) : void
		{
			Net.callServer((g.phpPath + "problem_report.php?pid=") + problem.id + "&uid=" + g.user.id + "&r=" + escape(report.text) + "&a=" + escape(problem.user_answer));
			var _loc_2:YakAlert = new YakAlert("Thanks, your report has been received.", "Report", "OK");
			_loc_2.center(g.scene.getScene());
			g.scene.getScene().addChild(_loc_2);
			close(param1);
		}

		private function on_added_to_stage(param1:Event) : void
		{
			report.setFocus();
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(ok_button, MouseEvent.CLICK, on_ok_button);
			EventManager.remove(cancel_button, MouseEvent.CLICK, close);
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
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
