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
