package Game
{
	import flash.events.*;

	public class ProblemAnswerEvent extends Event
	{
		public static const ANSWER:String = "answer";
		public var answer:String;
		public var problem_number:uint;

		public function ProblemAnswerEvent(param1:uint, param2:String, param3:Boolean = false, param4:Boolean = false) : void
		{
			super(ANSWER);
			this.answer = param2;
			this.problem_number = param1;
		}

		override public function toString() : String
		{
			return "Problem Number: " + this.problem_number + " Answer: " + answer + " Event: " + super.toString();
		}

		override public function clone() : Event
		{
			return new ProblemAnswerEvent(this.problem_number, this.answer, this.bubbles, this.cancelable);
		}
	}
}
