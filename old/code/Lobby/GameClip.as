package Lobby
{
	import Misc.*;
	import fl.motion.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class GameClip extends Sprite
	{
		public static var class_name:* = "Lobby.GameClip";
		public static var instance_number_counter:int = 0;
		public static var CREATED:uint = 1;
		public static var STARTING:uint = 2;
		public static var STARTED:uint = 3;
		public static var ENDING:uint = 4;
		public static var ENDED:uint = 5;
		private var instance_number:int = 0;
		private var _id:uint;
		private var _name:String;
		private var _players:uint;
		private var _type:String;
		private var _status:uint;
		private var _problems:uint;
		public var destroy:Boolean = false;
		public var _tType:TextField;
		public var _tName:TextField;
		public var _tPlayers:TextField;
		public var _tInfo:TextField;
		public var _sBackground:Sprite;

		public function GameClip(param1:uint, param2:String, param3:String, param4:uint, param5:uint, param6:uint = 0, param7:uint = 1) : void
		{
			super();
			var _loc_9:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_9;
			instance_number = instance_number_counter;
			_tPlayers.text = "Players: " + param6;
			_tPlayers.blendMode = BlendMode.LAYER;
			_tName.blendMode = BlendMode.LAYER;
			_tType.blendMode = BlendMode.LAYER;
			this.name = param2;
			this.type = param3;
			this.players = param6;
			this.status = param7;
			this.id = param1;
			this._problems = param5;
			EventManager.add(this, MouseEvent.CLICK, on_clicked, "GameClip");
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_clicked(param1:MouseEvent) : void
		{
			var _loc_2:GameInfo = new GameInfo(_id);
			g.scene.getScene().addChild(_loc_2);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, MouseEvent.CLICK, on_clicked);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, Event.ENTER_FRAME, fade_in);
			EventManager.remove(this, Event.ENTER_FRAME, fade_out);
		}

		public function show() : void
		{
			this.visible = true;
			this.alpha = 0;
			EventManager.add(this, Event.ENTER_FRAME, fade_in);
		}

		private function fade_in(param1:Event) : void
		{
			var _loc_2:Number = this.alpha;
			_loc_2 = _loc_2 + 0.05;
			if(_loc_2 >= 1)
			{
				_loc_2 = 1;
				EventManager.remove(this, Event.ENTER_FRAME, fade_in);
			}
			this.alpha = _loc_2;
		}

		public function hide() : void
		{
			_tInfo.text = "";
			EventManager.add(this, Event.ENTER_FRAME, fade_out);
		}

		private function fade_out(param1:Event) : void
		{
			var _loc_2:Number = this.alpha;
			_loc_2 = _loc_2 - 0.05;
			if(_loc_2 <= 0)
			{
				EventManager.remove(this, Event.ENTER_FRAME, fade_out);
				dispatchEvent(new Event("HIDE_GAME_CLIP", true));
			}
			this.alpha = _loc_2;
		}

		public function set id(param1:uint) : void
		{
			this._id = param1;
		}

		public function get id() : uint
		{
			return _id;
		}

		override public function set name(param1:String) : void
		{
			this._name = param1;
			_tName.text = param1;
		}

		override public function get name() : String
		{
			return this._name;
		}

		public function set type(param1:String) : void
		{
			this._type = param1;
			_tType.text = param1;
		}

		public function get type() : String
		{
			return this._type;
		}

		public function set players(param1:uint) : void
		{
			this._players = param1;
			if(param1 > 0)
			{
				_tPlayers.text = "Players: " + param1;
			}
			else
			{
				_tPlayers.text = "";
			}
		}

		public function get players() : uint
		{
			return this._players;
		}

		public function set status(param1:uint) : void
		{
			var _loc_2:uint = 0;
			var _loc_3:Color = null;
			if(param1 >= GameClip.CREATED && param1 <= GameClip.ENDED)
			{
				this._status = param1;
				_loc_2 = 13489660;
				if(param1 == GameClip.STARTED || param1 == GameClip.STARTING)
				{
					_loc_2 = 49877;
				}
				_loc_3 = new Color();
				_loc_3.setTint(_loc_2, 1);
				_sBackground.transform.colorTransform = _loc_3;
			}
			switch(param1)
			{
			case GameClip.CREATED:
				_tInfo.text = "Forming";
				break;
			case GameClip.STARTING:
				_tInfo.text = "Starting";
				break;
			case GameClip.STARTED:
				this.problem = 1;
				break;
			case GameClip.ENDING:
				_tInfo.text = "Ending";
				break;
			case GameClip.ENDED:
				_tInfo.text = "Ended";
				break;
			default:
				break;
			}
		}

		public function get status() : uint
		{
			return this._status;
		}

		public function set problem(param1:uint) : void
		{
			if(_type != "Countdown")
			{
				if(param1 > 0)
				{
					_tInfo.text = "Problem " + param1 + " of " + this._problems;
				}
				else
				{
					_tInfo.text = this._problems + " problems";
				}
			}
			else
			{
				if(param1 > 0)
				{
					_tInfo.text = "Problem " + param1;
				}
				else
				{
					_tInfo.text = "Not started";
				}
			}
		}

		override public function toString() : String
		{
			return "[Object GameClip] id=" + _id + " name=" + _name + " type=" + _type + " Players=" + _players + " status=" + _status + " visible=" + String(visible);
		}
	}
}
