package Type
{
	public class ScoringMethod extends Object
	{
		public static var RANK:uint = 1;
		public static var TIME:uint = 2;
		public static var CORRECT:uint = 3;
		public static var COMPOSITE:uint = 4;
		public static var COUNTDOWN:uint = 5;
		public static var LABELS:Array = ["", "Ranking", "Time", "Responses", "Composite", "Countdown"];

		public function ScoringMethod()
		{
			super();
		}
	}
}
