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
package Type
{
	public class User extends Object
	{
		private var _id:int;
		private var _token:String;
		private var _login_rating:Number;
		private var _current_rating:Number;
		private var _ip:String;
		private var _name:String;
		private var _access:uint;
		private var _gamesToday:uint;
		private var _muted:Boolean;
		private var _showTime:Boolean;
		private var _lobbyChat:Boolean;
		private var _gameChat:Boolean;
		private var _gameNumber:uint;
		private var _font_size:uint = 11;
		private var _font:String = "_sans";
		private var _leading:uint = 2;
		private var _s3:Boolean = true;
		public var flood_mute:Number;

		public function User()
		{
			super();
		}

		public function set id(param1:int) : void
		{
			this._id = param1;
		}

		public function get id() : int
		{
			return this._id;
		}

		public function set token(param1:String) : void
		{
			this._token = param1;
		}

		public function get token() : String
		{
			return this._token;
		}

		public function set rating(param1:Number) : void
		{
			if(param1 > 0)
			{
				this._current_rating = param1;
			}
			else
			{
				this._current_rating = 0;
			}
		}

		public function get rating() : Number
		{
			return this._current_rating;
		}

		public function set current_rating(param1:Number) : void
		{
			if(param1 > 0)
			{
				this._current_rating = param1;
			}
			else
			{
				this._current_rating = 0;
			}
		}

		public function get current_rating() : Number
		{
			return this._current_rating;
		}

		public function set login_rating(param1:Number) : void
		{
			if(param1 > 0)
			{
				this._login_rating = param1;
			}
			else
			{
				this._login_rating = 0;
			}
		}

		public function get login_rating() : Number
		{
			return this._current_rating;
		}

		public function get login_rating_display() : String
		{
			if(this._login_rating <= 0)
			{
				return "None";
			}
			return String(Math.round(this._login_rating));
		}

		public function get current_rating_display() : String
		{
			if(this._current_rating <= 0)
			{
				return "None";
			}
			return String(Math.round(this._current_rating));
		}

		public function get rating_display() : String
		{
			return this.current_rating_display;
		}

		public function set ip(param1:String) : void
		{
			this._ip = param1;
		}

		public function get ip() : String
		{
			return this._ip;
		}

		public function set name(param1:String) : void
		{
			this._name = param1;
		}

		public function get name() : String
		{
			return this._name;
		}

		public function set access(param1:uint) : void
		{
			this._access = param1;
		}

		public function get access() : uint
		{
			return this._access;
		}

		public function set gamesToday(param1:uint) : void
		{
			if(param1 > 0)
			{
				this._gamesToday = param1;
			}
			else
			{
				this._gamesToday = 0;
			}
		}

		public function get gamesToday() : uint
		{
			return this._gamesToday;
		}

		public function set muted(param1:Boolean) : void
		{
			this._muted = param1;
		}

		public function get muted() : Boolean
		{
			return this._muted;
		}

		public function set showTime(param1:Boolean) : void
		{
			this._showTime = param1;
		}

		public function get showTime() : Boolean
		{
			return this._showTime;
		}

		public function set lobbyChat(param1:Boolean) : void
		{
			this._lobbyChat = param1;
		}

		public function get lobbyChat() : Boolean
		{
			return this._lobbyChat;
		}

		public function set gameChat(param1:Boolean) : void
		{
			this._gameChat = param1;
		}

		public function get gameChat() : Boolean
		{
			return this._gameChat;
		}

		public function set gameNumber(param1:uint) : void
		{
			this._gameNumber = param1;
		}

		public function get gameNumber() : uint
		{
			return _gameNumber;
		}

		public function set font_size(param1:uint) : void
		{
			if(param1 < 10)
			{
				param1 = 10;
			}
			if(param1 > 16)
			{
				param1 = 16;
			}
			_font_size = param1;
		}

		public function get font_size() : uint
		{
			return _font_size;
		}

		public function set font(param1:String) : void
		{
			param1 = param1.toLowerCase();
			if(param1 == "mono" || param1 == "monospace" || param1 == "courier" || param1 == "consolas")
			{
				param1 = "_typewriter";
			}
			if(param1 == "times" || param1 == "times new roman" || param1 == "serif")
			{
				param1 = "_serif";
			}
			if(param1 == "arial" || param1 == "helvetica" || param1 == "tahoma" || param1 == "sans")
			{
				param1 = "_sans";
			}
			if(!(param1 == "_sans") && param1 == "_typewriter" && param1 == "_serif")
			{
				param1 = "_sans";
			}
			_font = param1;
		}

		public function get font() : String
		{
			return _font;
		}

		public function set leading(param1:uint) : void
		{
			if(param1 > 6)
			{
				param1 = 6;
			}
			if(param1 < 0)
			{
				param1 = 0;
			}
			_leading = param1;
		}

		public function get leading() : uint
		{
			return _leading;
		}

		public function set s3(param1:Boolean) : void
		{
			_s3 = param1;
		}

		public function get s3() : Boolean
		{
			return _s3;
		}
	}
}
