package Game.Countdown
{
	import flash.display.*;
	import flash.text.*;

	public class Player extends Sprite
	{
		private var _score:uint;
		private var _username:String;
		private var _answer:String;
		public var active:Boolean;
		private var username_text:TextField;
		private var score_text:TextField;
		private var answer_text:TextField;

		public function Player(param1:String)
		{
			super();
			username_text = new TextField();
			score_text = new TextField();
			answer_text = new TextField();
			var _loc_2:TextFormat = new TextFormat();
			_loc_2.font = "_sans";
			_loc_2.size = 48;
			_loc_2.bold = true;
			_loc_2.align = "center";
			score_text.width = 180;
			score_text.defaultTextFormat = _loc_2;
			var _loc_3:TextFormat = new TextFormat();
			_loc_3.font = "_sans";
			_loc_3.size = 13;
			_loc_3.align = "center";
			username_text.height = 25;
			username_text.width = 180;
			username_text.y = 50;
			username_text.defaultTextFormat = _loc_3;
			answer_text.height = 25;
			answer_text.width = 180;
			answer_text.y = 68;
			answer_text.defaultTextFormat = _loc_3;
			this.score = 0;
			this.username = param1;
			this.answer = "";
			this.active = true;
			addChild(answer_text);
			addChild(score_text);
			addChild(username_text);
		}

		public function get score() : uint
		{
			return this._score;
		}

		public function set score(param1:uint) : void
		{
			this._score = param1;
			this.score_text.text = String(param1);
		}

		public function get username() : String
		{
			return this._username;
		}

		public function set username(param1:String) : void
		{
			this._username = param1;
			this.username_text.text = param1;
		}

		public function get answer() : String
		{
			return this._answer;
		}

		public function set answer(param1:String) : void
		{
			this._answer = param1;
			this.answer_text.text = param1;
		}

		public function reset() : void
		{
			this.answer = "";
		}
	}
}
package Game.Countdown
{
	import flash.display.*;

	public class Userlist extends Sprite
	{
		private var players:Array;
		private var spectators:Array;
		private var number_of_players:uint = 0;

		public function Userlist()
		{
			super();
			players = new Array(4);
			spectators = new Array();
			var _loc_1:uint = 0;
			while(_loc_1 < 4)
			{
				players[_loc_1] = null;
				_loc_1 = _loc_1 + 1;
			}
			this.graphics.beginFill(15663086);
			this.graphics.drawRect(0, 0, 189, 316);
			this.graphics.endFill();
		}

		public function update_score(param1:String, param2:uint) : void
		{
			var _loc_3:Player = find_player_by_name(param1);
			if(_loc_3 != null)
			{
				_loc_3.score = param2;
			}
		}

		public function response(param1:String, param2:String, param3:String, param4:String) : void
		{
			trace((param1 + " ") + param3 + " " + param4);
			var _loc_5:Player = find_player_by_name(param1);
			if(_loc_5 != null)
			{
				if(param4 == "true")
				{
					_loc_5.answer = "Correct " + param3;
				}
				else
				{
					_loc_5.answer = "Incorrect " + param3;
				}
				_loc_5.score = uint(param2);
			}
		}

		public function clear_answers()
		{
			var _loc_1:uint = 0;
			while(_loc_1 < players.length)
			{
				if(players[_loc_1] != null)
				{
					players[_loc_1].answer = "";
				}
				_loc_1 = _loc_1 + 1;
			}
		}

		public function add_player(param1:String, param2:uint, param3:String) : Boolean
		{
			var _loc_5:uint = 0;
			var _loc_4:Player = find_player_by_name(param1);
			if(_loc_4 == null)
			{
				if(number_of_players > 4)
				{
					return false;
				}
				_loc_4 = new Player(param1);
				_loc_4.score = param2;
				_loc_5 = 0;
				while(_loc_5 < players.length)
				{
					if(players[_loc_5] == null)
					{
						players[_loc_5] = _loc_4;
						var _loc_7:* = this.number_of_players + 1;
						this.number_of_players = _loc_7;
						break;
					}
					_loc_5 = _loc_5 + 1;
				}
			}
			else
			{
				if(_loc_4.active == false)
				{
					_loc_4.active = true;
					var _loc_7:* = this.number_of_players + 1;
					this.number_of_players = _loc_7;
				}
			}
			repaint();
			return true;
		}

		public function add_spectator(param1:String) : Boolean
		{
			var _loc_2:uint = 0;
			while(_loc_2 < spectators.length)
			{
				if(spectators[_loc_2] == param1)
				{
					return false;
				}
				_loc_2 = _loc_2 + 1;
			}
			spectators.push(param1);
			repaint();
			return true;
		}

		public function remove_player(param1:String) : Boolean
		{
			var _loc_2:Player = find_player_by_name(param1);
			if(_loc_2 != null)
			{
				var _loc_4:* = this.number_of_players - 1;
				this.number_of_players = _loc_4;
				_loc_2.active = false;
				repaint();
				return true;
			}
			return false;
		}

		public function remove_spectator(param1:String) : void
		{
			var _loc_2:uint = 0;
			while(_loc_2 < spectators.length)
			{
				if(spectators[_loc_2] == param1)
				{
					spectators.splice(_loc_2, 1);
					repaint();
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function remove_user(param1:String) : void
		{
			if(!remove_player(param1))
			{
				remove_spectator(param1);
			}
		}

		public function find_player_by_name(param1:String) : Player
		{
			var _loc_2:uint = players.length;
			while(_loc_2)
			{
				if(!(players[_loc_2] == null) && players[_loc_2].username == param1)
				{
					return players[_loc_2];
				}
			}
			return null;
		}

		public function player_count() : uint
		{
			var _loc_1:uint = players.length;
			var _loc_2:uint = 0;
			while(_loc_1)
			{
				if(!(players[_loc_1] == null) && players[_loc_1].active)
				{
					_loc_2 = _loc_2 + 1;
				}
			}
			return _loc_2;
		}

		public function repaint() : void
		{
			var _loc_1:uint = 0;
			erase();
			number_of_players = player_count();
			var _loc_2:uint = 5;
			while(_loc_1 < players.length)
			{
				if(!(players[_loc_1] == null) && players[_loc_1].active)
				{
					players[_loc_1].x = 0;
					players[_loc_1].y = _loc_2;
					addChild(players[_loc_1]);
					_loc_2 = _loc_2 + 70;
					if(number_of_players == 2)
					{
						_loc_2 = _loc_2 + 70;
					}
					else
					{
						if(number_of_players == 3)
						{
							_loc_2 = _loc_2 + 35;
						}
					}
				}
				_loc_1 = _loc_1 + 1;
			}
		}

		public function erase() : void
		{
			while(this.numChildren)
			{
				removeChildAt(0);
			}
		}
	}
}
