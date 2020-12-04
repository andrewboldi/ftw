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
