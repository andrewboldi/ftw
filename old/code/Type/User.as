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
