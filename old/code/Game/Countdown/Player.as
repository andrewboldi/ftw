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
