package Game
{
	public class ScoringType extends Object
	{
		public static var RANK:uint = 1;
		public static var TIME:uint = 2;
		public static var CORRECT:uint = 3;
		public static var COMPOSITE:uint = 4;
		public static var COUNTDOWN:uint = 5;

		final public static function toString(param1:uint) : String
		{
			if(param1 == ScoringType.RANK)
			{
				return "Ranking";
			}
			if(param1 == ScoringType.TIME)
			{
				return "Time";
			}
			if(param1 == ScoringType.CORRECT)
			{
				return "Responses";
			}
			if(param1 == ScoringType.COMPOSITE)
			{
				return "Composite";
			}
			if(param1 == ScoringType.COUNTDOWN)
			{
				return "Countdown";
			}
			return "Unknown";
		}

		public function ScoringType()
		{
			super();
		}
	}
}
