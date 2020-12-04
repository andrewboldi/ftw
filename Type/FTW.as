package Type
{
	import Game.*;
	import Misc.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.net.*;
	import flash.utils.*;
	import net.theyak.util.*;

	public class FTW extends Object
	{
		public static var PLAYER:uint = 0;
		public static var GAMEMASTER:uint = 1;
		public static var SPECTATOR:uint = 9;
		public var id:uint;
		public var time_per_problem:uint;
		public var problem_count:uint;
		public var max_players:int = -1;
		public var rated:Boolean = true;
		public var scoring_method:uint;
		public var password:String = "";
		public var spectators:Boolean = true;
		public var sprint:Boolean = true;
		public var target:Boolean = true;
		public var team:Boolean = true;
		public var countdown:Boolean = true;
		public var school:Boolean = true;
		public var chapter:Boolean = true;
		public var state:Boolean = true;
		public var national:Boolean = true;
		public var amc8:Boolean = true;
		public var ended:Boolean = false;
		public var last_problem_number_displayed:uint = 0;
		public var problemNumber:uint;
		public var playerType:int;
		public var type:String;
		public var room_name:String;
		public var zone_name:String;
		public var problems:Array;
		public var can_start_game:Boolean = false;

		public function FTW()
		{
			scoring_method = ScoringMethod.RANK;
			super();
			reset();
		}

		public function reset()
		{
			can_start_game = false;
			id = 0;
			time_per_problem = 0;
			problem_count = 0;
			problemNumber = 0;
			max_players = -1;
			scoring_method = ScoringMethod.RANK;
			rated = true;
			spectators = true;
			playerType = -1;
			type = "FTW";
			zone_name = "";
			room_name = "";
			password = "";
			ended = false;
			problems = new Array();
			sprint = true;
			target = true;
			team = true;
			countdown = true;
			school = true;
			chapter = true;
			state = true;
			national = true;
			amc8 = true;
			spectators = true;
			last_problem_number_displayed = 0;
		}

		public function create() : void
		{
			can_start_game = true;
			player_type = FTW.GAMEMASTER;
			if(!(type == "Countdown" && this.scoring_method == ScoringType.COUNTDOWN))
			{
				this.scoring_method = ScoringType.COUNTDOWN;
				Net.callServer((g.URLPath + "PHP/log.php?msg=") + (escape("Bad scoring type for countdown, blah")));
			}
			var _loc_1:EsObject = new EsObject();
			_loc_1.setString("zone", g.activeZoneName);
			_loc_1.setString("lobby", g.activeRoomName);
			_loc_1.setString("type", type);
			_loc_1.setInteger("players", max_players);
			_loc_1.setInteger("problems", problem_count);
			_loc_1.setInteger("time", this.time_per_problem);
			_loc_1.setBoolean("rated", rated);
			_loc_1.setBoolean("spectators", spectators);
			_loc_1.setBoolean("sprint", sprint);
			_loc_1.setBoolean("target", target);
			_loc_1.setBoolean("team", team);
			_loc_1.setBoolean("countdown", countdown);
			_loc_1.setBoolean("school", school);
			_loc_1.setBoolean("chapter", chapter);
			_loc_1.setBoolean("state", state);
			_loc_1.setBoolean("national", national);
			_loc_1.setBoolean("amc8", amc8);
			_loc_1.setInteger("scoring", scoring_method);
			_loc_1.setString("password", password);
			_loc_1.setInteger("user_id", g.user.id);
			g.server.esServerPlugin(g.manager, "new_game", _loc_1);
		}

		public function get player_type() : uint
		{
			return this.playerType;
		}

		public function set player_type(param1:uint) : void
		{
			if(param1 == FTW.PLAYER || param1 == FTW.SPECTATOR || param1 == FTW.GAMEMASTER)
			{
				this.playerType = param1;
			}
		}

		public function clone() : FTW
		{
			var _loc_1:String = getQualifiedClassName(this).replace("::", ".");
			var _loc_2:ByteArray = new ByteArray();
			registerClassAlias(_loc_1, getDefinitionByName(_loc_1));
			_loc_2.writeObject(this);
			_loc_2.position = 0;
			return _loc_2.readObject();
		}
	}
}
