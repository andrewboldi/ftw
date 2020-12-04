package Type
{
	public class GameStatus extends Object
	{
		public static var CREATED:uint = 1;
		public static var STARTING:uint = 2;
		public static var STARTED:uint = 3;
		public static var ENDING:uint = 4;
		public static var ENDED:uint = 5;
		public static var LABELS:Array = ["", "Created", "Starting", "Started", "Ending", "Ended"];

		public function GameStatus()
		{
			super();
		}
	}
}
