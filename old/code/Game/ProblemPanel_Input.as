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
