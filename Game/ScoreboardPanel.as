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
