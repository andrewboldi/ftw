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
package Lobby
{
	import Misc.*;
	import fl.containers.*;
	import flash.display.*;
	import flash.events.*;

	public class GameGrid extends Sprite
	{
		public static var class_name:* = "Lobby.GameInfo";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var games:Array;
		public var _spGames:ScrollPane;

		public function GameGrid()
		{
			super();
			var _loc_2:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_2;
			instance_number = instance_number_counter;
			games = new Array();
			EventManager.add(this, "HIDE_GAME_CLIP", final_hide);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			__setProp__spGames_GameGrid_Layer1_0();
		}

		public function is_game(param1:uint) : Boolean
		{
			var _loc_2:GameClip = find_clip(param1);
			if(_loc_2 == null || _loc_2.visible == false)
			{
				return false;
			}
			return true;
		}

		public function new_game(param1:uint, param2:String, param3:String, param4:uint, param5:uint) : void
		{
			var _loc_6:GameClip = new GameClip(param1, param2, param3, param4, param5);
			_loc_6.visible = false;
			Sprite(_spGames.content).addChild(_loc_6);
			games.push(_loc_6);
		}

		public function game_list(param1:String) : void
		{
			var _loc_4:Array = null;
			var _loc_5:GameClip = null;
			var _loc_6:uint = 0;
			var _loc_7:String = null;
			var _loc_8:String = null;
			var _loc_9:uint = 0;
			var _loc_10:uint = 0;
			var _loc_11:uint = 0;
			var _loc_12:uint = 0;
			var _loc_13:uint = 0;
			if(param1.length <= 0)
			{
				return;
			}
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = _loc_2[_loc_3].split("\t");
				_loc_5 = find_clip(_loc_4[0]);
				if(_loc_5 == null)
				{
					_loc_6 = uint(_loc_4[0]);
					_loc_7 = _loc_4[1];
					_loc_8 = _loc_4[2];
					_loc_9 = uint(_loc_4[3]);
					_loc_10 = uint(_loc_4[4]);
					_loc_11 = uint(_loc_4[5]);
					_loc_12 = uint(_loc_4[6]);
					_loc_13 = uint(_loc_4[7]);
					_loc_5 = new GameClip(_loc_6, _loc_7, _loc_8, _loc_9, _loc_12, _loc_11, _loc_10);
					_loc_5.problem = _loc_13;
					_loc_5.visible = false;
					Sprite(_spGames.content).addChild(_loc_5);
					this.games.push(_loc_5);
					if((_loc_11 > 0 && _loc_11 <= 50 || g.user.access > 100 && _loc_10 == GameClip.ENDED) && _loc_10 == GameClip.ENDING)
					{
						display_game(_loc_4[0]);
					}
				}
				_loc_3 = _loc_3 + 1;
			}
		}

		public function remove_game(param1:uint) : void
		{
			var _loc_2:int = find_clip_position(param1);
			if(_loc_2 >= 0)
			{
				hide_game(param1);
			}
		}

		public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint) : void
		{
			var _loc_6:GameClip = find_clip(param1);
			if(_loc_6 == null)
			{
				return;
			}
			if(param2 == GameClip.ENDED || param2 == GameClip.ENDING || param5 <= 0 || param5 > 50 || param4 > 50)
			{
				_loc_6.destroy = param2 == GameClip.ENDED || param2 == GameClip.ENDING;
				hide_game(param1);
			}
			else
			{
				display_game(param1);
			}
			_loc_6.status = param2;
			_loc_6.players = param5;
			_loc_6.problem = param3;
		}

		private function display_game(param1:uint) : void
		{
			var _loc_3:int = 0;
			var _loc_4:int = 0;
			var _loc_2:int = find_clip_position(param1);
			if(_loc_2 >= 0 && games[_loc_2].visible == false)
			{
				_loc_3 = 0;
				_loc_4 = 0;
				while(_loc_4 < _loc_2)
				{
					if(games[_loc_4].visible == true)
					{
						_loc_3++;
					}
					_loc_4++;
				}
				games[_loc_2].show();
				set_display_position(games[_loc_2], _loc_3);
				_loc_4 = _loc_2 + 1;
				while(_loc_4 < games.length)
				{
					if(games[_loc_4].visible == true)
					{
						_loc_3++;
						set_display_position(games[_loc_4], _loc_3);
					}
					_loc_4++;
				}
			}
			_spGames.update();
		}

		private function hide_game(param1:uint) : void
		{
			var _loc_2:GameClip = find_clip(param1);
			if(!(_loc_2 == null) && _loc_2.visible)
			{
				_loc_2.hide();
			}
		}

		private function final_hide(param1:Event) : void
		{
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			var _loc_2:GameClip = GameClip(param1.target);
			var _loc_3:uint = _loc_2.id;
			var _loc_4:int = find_clip_position(_loc_3);
			if(_loc_4 >= 0)
			{
				_loc_5 = 0;
				_loc_6 = 0;
				while(_loc_6 < _loc_4)
				{
					if(games[_loc_6].visible == true)
					{
						_loc_5++;
					}
					_loc_6++;
				}
				games[_loc_4].visible = false;
				_loc_6 = _loc_4 + 1;
				while(_loc_6 < games.length)
				{
					if(games[_loc_6].visible == true)
					{
						set_display_position(games[_loc_6], _loc_5);
						_loc_5++;
					}
					_loc_6++;
				}
				games[_loc_4].destroy;
				if(games[_loc_4].destroy || 1 == 1)
				{
					Sprite(_spGames.content).removeChild(games[_loc_4]);
					games.splice(_loc_4, 1);
				}
			}
		}

		private function set_display_position(param1:DisplayObject, param2:uint) : void
		{
			var _loc_3:uint = (param2 % 4) * 125;
			var _loc_4:uint = (Math.floor(param2 / 4)) * 105;
			param1.x = _loc_3;
			param1.y = _loc_4;
		}

		private function find_clip(param1:uint) : GameClip
		{
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				if(games[_loc_2].id == param1)
				{
					return games[_loc_2];
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		private function find_clip_position(param1:uint) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				if(games[_loc_2].id == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		public function on_added_to_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		public function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, "HIDE_GAME_CLIP", final_hide);
		}

		override public function toString() : String
		{
			var _loc_1:String = "[object GameGrid] ";
			if(games.length <= 0)
			{
				return _loc_1 + "No games";
			}
			var _loc_2:uint = 0;
			while(_loc_2 < games.length)
			{
				_loc_1 = _loc_1 + (games[_loc_2].toString() + "\n");
				_loc_2 = _loc_2 + 1;
			}
			return _loc_1;
		}

		public function __setProp__spGames_GameGrid_Layer1_0()
		{
			try
			{
				_spGames["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_spGames.enabled = true;
			_spGames.horizontalLineScrollSize = 4;
			_spGames.horizontalPageScrollSize = 0;
			_spGames.horizontalScrollPolicy = "auto";
			_spGames.scrollDrag = false;
			_spGames.source = "EmptyClip";
			_spGames.verticalLineScrollSize = 4;
			_spGames.verticalPageScrollSize = 0;
			_spGames.verticalScrollPolicy = "auto";
			_spGames.visible = true;
			try
			{
				_spGames["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
package Lobby
{
	import Misc.*;
	import Type.*;
	import com.electrotank.electroserver4.esobject.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class GameInfo extends Sprite
	{
		public static var class_name:* = "Lobby.GameInfo";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var status:TextField;
		private var join:Button;
		private var spectate:Button;
		private var password:TextInput;
		private var password_label:TextField;
		private var time_per_problem:TextField;
		private var number_of_problems:TextField;
		private var rated:TextField;
		private var scoring_method:TextField;
		private var rounds:TextField;
		private var levels:TextField;
		private var game_password:String;
		public var userlist:Userlist;
		private var game_id:uint;

		public function GameInfo(param1:uint)
		{
			super();
			var _loc_7:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_7;
			instance_number = instance_number_counter;
			game_id = param1;
			window = new YakDialog("Game Information", 250, 375);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("game_id", game_id);
			g.server.esServerPlugin(g.manager, "subscribe", _loc_2);
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			join = new Button();
			spectate = new Button();
			join.label = "Join";
			join.y = 314;
			join.setSize(90, join.height);
			join.mouseEnabled = true;
			join.visible = false;
			window.canvas.addChild(join);
			spectate.label = "Spectate";
			spectate.y = 314;
			spectate.setSize(90, spectate.height);
			spectate.mouseEnabled = true;
			spectate.visible = false;
			window.canvas.addChild(spectate);
			userlist = new Userlist();
			userlist.width = 228;
			userlist.height = 150;
			userlist.x = 5;
			userlist.y = 5;
			window.canvas.addChild(userlist);
			var _loc_3:TextFormat = new TextFormat();
			_loc_3.font = "_sans";
			var _loc_4:TextFormat = new TextFormat();
			_loc_4.font = "_sans";
			_loc_4.align = "center";
			var _loc_5:TextFormat = new TextFormat();
			_loc_5.font = "_sans";
			_loc_5.align = "right";
			status = new TextField();
			status.width = userlist.width;
			status.height = 22;
			status.defaultTextFormat = _loc_4;
			status.text = "Obtaining Status";
			status.y = 160;
			status.x = 2;
			window.canvas.addChild(status);
			time_per_problem = new TextField();
			time_per_problem.width = window.canvas.width;
			time_per_problem.height = 22;
			time_per_problem.defaultTextFormat = _loc_4;
			time_per_problem.text = "";
			time_per_problem.y = 178;
			time_per_problem.x = 2;
			window.canvas.addChild(time_per_problem);
			number_of_problems = new TextField();
			number_of_problems.width = window.canvas.width;
			number_of_problems.height = 22;
			number_of_problems.defaultTextFormat = _loc_4;
			number_of_problems.text = "";
			number_of_problems.y = 196;
			number_of_problems.x = 2;
			window.canvas.addChild(number_of_problems);
			rated = new TextField();
			rated.width = window.canvas.width;
			rated.height = 22;
			rated.defaultTextFormat = _loc_4;
			rated.text = "";
			rated.y = 214;
			rated.x = 2;
			window.canvas.addChild(rated);
			scoring_method = new TextField();
			scoring_method.width = window.canvas.width;
			scoring_method.height = 22;
			scoring_method.defaultTextFormat = _loc_4;
			scoring_method.text = "";
			scoring_method.y = 232;
			scoring_method.x = 2;
			window.canvas.addChild(scoring_method);
			rounds = new TextField();
			rounds.width = window.canvas.width;
			rounds.height = 22;
			rounds.defaultTextFormat = _loc_4;
			rounds.text = "";
			rounds.y = 250;
			rounds.x = 2;
			window.canvas.addChild(rounds);
			levels = new TextField();
			levels.width = window.canvas.width;
			levels.height = 22;
			levels.defaultTextFormat = _loc_4;
			levels.text = "";
			levels.y = 268;
			levels.x = 2;
			window.canvas.addChild(levels);
			password_label = new TextField();
			password_label.width = 90;
			password_label.height = 22;
			password_label.defaultTextFormat = _loc_5;
			password_label.text = "Password";
			password_label.y = 287;
			password_label.x = 2;
			password_label.visible = false;
			window.canvas.addChild(password_label);
			password = new TextInput();
			password.move(95, 287);
			password.visible = false;
			window.canvas.addChild(password);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "sub_player_list":
				on_player_list(param1.response.players);
				break;
			case "sub_player_add":
				on_player_add(param1.response.name, param1.response.rating);
				break;
			case "sub_player_leave":
				on_player_leave(param1.response.name);
				break;
			case "sub_game_status":
				on_game_status(uint(param1.response.status));
				break;
			case "sub_game_info":
				on_game_information(param1.response);
				break;
			case "sub_game_full":
				on_game_full(true, 1);
				break;
			case "sub_close":
				close();
				break;
			default:
				break;
			}
		}

		private function on_player_list(param1:String) : void
		{
			var _loc_4:Array = null;
			if(param1.length <= 0)
			{
				return;
			}
			userlist.clear();
			var _loc_2:Array = param1.split("\n");
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = String(_loc_2[_loc_3]).split("\t");
				userlist.addUser(_loc_4[0], _loc_4[1], false);
				_loc_3 = _loc_3 + 1;
			}
		}

		private function on_player_add(param1:String, param2:String) : void
		{
			userlist.addUser(param1, param2);
		}

		private function on_player_leave(param1:String) : void
		{
			userlist.removeUser(param1);
		}

		private function on_game_status(param1:uint) : void
		{
			if(param1 == GameStatus.STARTING || param1 == GameStatus.STARTED)
			{
				join.visible = false;
				this.status.text = "Game has started";
			}
			else
			{
				if(param1 == GameStatus.ENDING || param1 == GameStatus.ENDED)
				{
					join.visible = false;
					spectate.visible = false;
					this.status.text = "Game has ended";
				}
				else
				{
					join.visible = true;
					this.status.text = "";
				}
			}
		}

		private function on_game_information(param1:*) : void
		{
			var _loc_2:Array = new Array();
			var _loc_3:Array = new Array();
			if(param1.sprint)
			{
				_loc_2.push("Sprint");
			}
			if(param1.target)
			{
				_loc_2.push("Target");
			}
			if(param1.team)
			{
				_loc_2.push("Team");
			}
			if(param1.countdown)
			{
				_loc_2.push("Countdown");
			}
			if(param1.school)
			{
				_loc_3.push("School");
			}
			if(param1.chapter)
			{
				_loc_3.push("Chapter");
			}
			if(param1.state)
			{
				_loc_3.push("State");
			}
			if(param1.national)
			{
				_loc_3.push("Nats");
			}
			rounds.text = _loc_2.length == 4 ? "" : _loc_2.join(", ");
			levels.text = _loc_3.length == 4 ? "" : _loc_3.join(", ");
			on_number_of_problems(int(param1.problems));
			on_time_per_problem(int(param1.time));
			on_rated(param1.rated);
			on_scoring_method(int(param1.scoring));
			on_password(param1.pw);
			EventManager.add(join, MouseEvent.CLICK, on_join_game, "GameInfo.Join");
			if(int(param1.max_players) < 0 || int(param1.max_players) > int(param1.players))
			{
				join.visible = true;
			}
			else
			{
				join.x = 20;
				join.y = 20;
				join.visible = false;
			}
			if(param1.spectators)
			{
				EventManager.add(spectate, MouseEvent.CLICK, on_spectate_game, "GameInfo.Spectate");
				join.x = 25;
				if(join.visible)
				{
					spectate.x = 125;
				}
				else
				{
					spectate.x = 75;
				}
				spectate.visible = true;
			}
			else
			{
				spectate.visible = false;
				join.x = 75;
			}
			on_game_status(int(param1.status));
		}

		private function on_game_full(param1:Boolean, param2:uint) : void
		{
			if(param1)
			{
				join.visible = false;
				this.status.text = "Game is full";
			}
			else
			{
				on_game_status(param2);
			}
		}

		private function on_number_of_problems(param1:uint) : void
		{
			number_of_problems.text = "Number of Problems: " + param1;
		}

		private function on_time_per_problem(param1:uint) : void
		{
			time_per_problem.text = "Time Per Problem: " + param1 + " seconds";
		}

		private function on_rated(param1:Boolean) : void
		{
			if(param1)
			{
				this.rated.text = "Game is rated";
			}
			else
			{
				this.rated.text = "Game is not rated";
			}
		}

		private function on_scoring_method(param1:uint) : void
		{
			scoring_method.text = "Scoring method: " + ScoringMethod.LABELS[param1];
			if(param1 == ScoringMethod.COUNTDOWN)
			{
				number_of_problems.text = "";
			}
		}

		private function on_password(param1:String) : void
		{
			game_password = param1;
			if(param1.length > 0)
			{
				password.visible = true;
				password_label.visible = true;
			}
			else
			{
				password.visible = false;
				password_label.visible = false;
			}
		}

		private function on_button(param1:uint) : void
		{
			var _loc_2:EsObject = null;
			var _loc_3:YakAlert = null;
			if(password.text == game_password)
			{
				g.game.reset();
				g.game.player_type = param1;
				_loc_2 = new EsObject();
				_loc_2.setInteger("id", game_id);
				_loc_2.setString("pw", password.text);
				_loc_2.setInteger("user_id", g.user.id);
				g.server.esServerPlugin(g.manager, "join_game", _loc_2);
			}
			else
			{
				_loc_3 = new YakAlert("Invalid Password", "Error", "OK");
				_loc_3.center(g.scene.getScene());
				g.scene.getScene().addChild(_loc_3);
			}
			close();
		}

		private function on_join_game(param1:MouseEvent) : void
		{
			on_button(FTW.PLAYER);
		}

		private function on_spectate_game(param1:MouseEvent) : void
		{
			on_button(FTW.SPECTATOR);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(join, MouseEvent.CLICK, on_join_game);
			EventManager.remove(spectate, MouseEvent.CLICK, on_spectate_game);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			var _loc_2:EsObject = new EsObject();
			_loc_2.setInteger("game_id", game_id);
			g.server.esServerPlugin(g.manager, "unsubscribe", _loc_2);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event = null) : void
		{
			if(parent != null)
			{
				parent.removeChild(this);
			}
		}
	}
}
package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class NewCountdown extends Sprite
	{
		public static var class_name:* = "Lobby.NewCountdown";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var player_count:NumericStepper;
		private var rated:CheckBox;
		private var ok:Button;
		private var cancel:Button;
		private var password:TextInput;
		private var school:CheckBox;
		private var chapter:CheckBox;
		private var state:CheckBox;
		private var sprint:CheckBox;
		private var target:CheckBox;
		private var countdown:CheckBox;
		private var player_count_label:TextField;
		private var rated_label:TextField;
		private var password_label:TextField;
		private var school_label:TextField;
		private var chapter_label:TextField;
		private var state_label:TextField;
		private var sprint_label:TextField;
		private var target_label:TextField;
		private var countdown_label:TextField;

		public function NewCountdown()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			window = new YakDialog("New Countdown", 250, 290);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			player_count = new NumericStepper();
			player_count.stepSize = 1;
			player_count.minimum = 2;
			player_count.maximum = 4;
			player_count.value = 2;
			player_count.width = 45;
			player_count.move(120, 45);
			window.canvas.addChild(player_count);
			rated = new CheckBox();
			rated.move(115, 80);
			rated.label = " ";
			rated.selected = true;
			window.canvas.addChild(rated);
			password = new TextInput();
			password.move(115, 150);
			window.canvas.addChild(password);
			ok = new Button();
			ok.label = "Create";
			ok.x = 10;
			ok.y = 220;
			EventManager.add(ok, MouseEvent.CLICK, on_create_game, "NewCountdown.Create");
			ok.setSize(60, ok.height);
			ok.mouseEnabled = true;
			window.canvas.addChild(ok);
			cancel = new Button();
			cancel.label = "Cancel";
			cancel.x = 80;
			cancel.y = 220;
			EventManager.add(cancel, MouseEvent.CLICK, on_cancel, "NewCountdown.Cancel");
			cancel.setSize(60, cancel.height);
			cancel.mouseEnabled = true;
			window.canvas.addChild(cancel);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.font = "_sans";
			_loc_1.bold = true;
			_loc_1.align = "right";
			player_count_label = new TextField();
			player_count_label.width = 105;
			player_count_label.height = 25;
			player_count_label.text = "Player Count";
			player_count_label.x = 10;
			player_count_label.y = 45;
			player_count_label.setTextFormat(_loc_1);
			window.canvas.addChild(player_count_label);
			rated_label = new TextField();
			rated_label.width = 105;
			rated_label.height = 25;
			rated_label.text = "Rated";
			rated_label.x = 10;
			rated_label.y = 80;
			rated_label.setTextFormat(_loc_1);
			window.canvas.addChild(rated_label);
			password_label = new TextField();
			password_label.width = 105;
			password_label.height = 25;
			password_label.text = "Password";
			password_label.x = 10;
			password_label.y = 150;
			password_label.setTextFormat(_loc_1);
			window.canvas.addChild(password_label);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_create_game(param1:MouseEvent) : void
		{
			g.game.reset();
			g.game.type = "Countdown";
			g.game.max_players = player_count.value;
			g.game.problem_count = 20;
			g.game.time_per_problem = 45;
			g.game.rated = rated.selected;
			g.game.spectators = true;
			var _loc_2:Boolean = true;
			g.game.countdown = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.team = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.target = _loc_2;
			g.game.sprint = _loc_2;
			var _loc_2:Boolean = true;
			g.game.national = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.state = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.chapter = _loc_2;
			g.game.school = _loc_2;
			g.game.amc8 = true;
			g.game.scoring_method = ScoringType.COUNTDOWN;
			g.game.password = password.text;
			g.replay = g.game.clone();
			g.game.create();
			parent.removeChild(this);
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(ok, MouseEvent.CLICK, on_create_game);
			EventManager.remove(cancel, MouseEvent.CLICK, on_cancel);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event) : void
		{
			parent.removeChild(this);
		}
	}
}
package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class NewGame extends Sprite
	{
		public static var class_name:* = "Lobby.NewGame";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var scoring_method:ComboBox;
		private var problem_count:NumericStepper;
		private var time_per_problem:NumericStepper;
		private var rated:CheckBox;
		private var spectators:CheckBox;
		private var ok:Button;
		private var cancel:Button;
		private var password:TextInput;
		private var scoring_method_label:TextField;
		private var problem_count_label:TextField;
		private var time_per_problem_label:TextField;
		private var rated_label:TextField;
		private var spectators_label:TextField;
		private var password_label:TextField;
		private var school:CheckBox;
		private var chapter:CheckBox;
		private var state:CheckBox;
		private var sprint:CheckBox;
		private var target:CheckBox;
		private var countdown:CheckBox;
		private var school_label:TextField;
		private var chapter_label:TextField;
		private var state_label:TextField;
		private var sprint_label:TextField;
		private var target_label:TextField;
		private var countdown_label:TextField;

		public function NewGame()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			window = new YakDialog("New Game", 250, 290);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			scoring_method = new ComboBox();
			scoring_method.setSize(100, 22);
			scoring_method.addItem({label:"Ranking", data:ScoringType.RANK});
			scoring_method.addItem({label:"Time", data:ScoringType.TIME});
			scoring_method.addItem({label:"Responses", data:ScoringType.CORRECT});
			scoring_method.addItem({label:"Time/Rank", data:ScoringType.COMPOSITE});
			scoring_method.move(120, 10);
			window.canvas.addChild(scoring_method);
			problem_count = new NumericStepper();
			problem_count.stepSize = 1;
			problem_count.minimum = 4;
			problem_count.maximum = 20;
			problem_count.value = 10;
			problem_count.width = 45;
			problem_count.move(120, 45);
			window.canvas.addChild(problem_count);
			time_per_problem = new NumericStepper();
			time_per_problem.stepSize = 1;
			time_per_problem.minimum = 5;
			time_per_problem.maximum = 120;
			time_per_problem.value = 45;
			time_per_problem.width = 45;
			time_per_problem.move(120, 80);
			window.canvas.addChild(time_per_problem);
			rated = new CheckBox();
			rated.move(115, 115);
			rated.label = " ";
			rated.selected = true;
			window.canvas.addChild(rated);
			spectators = new CheckBox();
			spectators.move(115, 150);
			spectators.label = " ";
			window.canvas.addChild(spectators);
			password = new TextInput();
			password.move(115, 185);
			window.canvas.addChild(password);
			ok = new Button();
			ok.label = "Create Game";
			ok.x = 25;
			ok.y = 220;
			EventManager.add(ok, MouseEvent.CLICK, on_create_game, "NewGame.Create");
			ok.setSize(90, ok.height);
			ok.mouseEnabled = true;
			window.canvas.addChild(ok);
			cancel = new Button();
			cancel.label = "Cancel";
			cancel.x = 125;
			cancel.y = 220;
			EventManager.add(cancel, MouseEvent.CLICK, on_cancel, "NewGame.Cancel");
			cancel.setSize(90, cancel.height);
			cancel.mouseEnabled = true;
			window.canvas.addChild(cancel);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.font = "_sans";
			_loc_1.bold = true;
			_loc_1.align = "right";
			scoring_method_label = new TextField();
			scoring_method_label.width = 105;
			scoring_method_label.height = 25;
			scoring_method_label.text = "Game Type";
			scoring_method_label.x = 10;
			scoring_method_label.y = 10;
			scoring_method_label.setTextFormat(_loc_1);
			window.canvas.addChild(scoring_method_label);
			problem_count_label = new TextField();
			problem_count_label.width = 105;
			problem_count_label.height = 25;
			problem_count_label.text = "Problem Count";
			problem_count_label.x = 10;
			problem_count_label.y = 45;
			problem_count_label.setTextFormat(_loc_1);
			window.canvas.addChild(problem_count_label);
			time_per_problem_label = new TextField();
			time_per_problem_label.width = 105;
			time_per_problem_label.height = 25;
			time_per_problem_label.text = "Time Per Problem";
			time_per_problem_label.x = 10;
			time_per_problem_label.y = 80;
			time_per_problem_label.setTextFormat(_loc_1);
			window.canvas.addChild(time_per_problem_label);
			rated_label = new TextField();
			rated_label.width = 105;
			rated_label.height = 25;
			rated_label.text = "Rated";
			rated_label.x = 10;
			rated_label.y = 115;
			rated_label.setTextFormat(_loc_1);
			window.canvas.addChild(rated_label);
			spectators_label = new TextField();
			spectators_label.width = 105;
			spectators_label.height = 25;
			spectators_label.text = "Spectators";
			spectators_label.x = 10;
			spectators_label.y = 150;
			spectators_label.setTextFormat(_loc_1);
			window.canvas.addChild(spectators_label);
			password_label = new TextField();
			password_label.width = 105;
			password_label.height = 25;
			password_label.text = "Password";
			password_label.x = 10;
			password_label.y = 185;
			password_label.setTextFormat(_loc_1);
			window.canvas.addChild(password_label);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_create_game(param1:MouseEvent) : void
		{
			g.game.reset();
			g.game.type = "FTW";
			g.game.max_players = -1;
			g.game.problem_count = problem_count.value;
			g.game.time_per_problem = time_per_problem.value;
			g.game.rated = rated.selected;
			g.game.spectators = spectators.selected;
			g.game.scoring_method = scoring_method.selectedItem.data;
			g.game.password = password.text;
			var _loc_2:Boolean = true;
			g.game.countdown = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.team = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.target = _loc_2;
			g.game.sprint = _loc_2;
			var _loc_2:Boolean = true;
			g.game.national = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.state = _loc_2;
			var _loc_2:Boolean = _loc_2;
			g.game.chapter = _loc_2;
			g.game.school = _loc_2;
			g.game.amc8 = true;
			g.replay = g.game.clone();
			g.game.create();
			close(param1);
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			close(param1);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event) : void
		{
			scoring_method.close();
			parent.removeChild(this);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(ok, MouseEvent.CLICK, on_create_game);
			EventManager.remove(cancel, MouseEvent.CLICK, on_cancel);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}
	}
}
package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.containers.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class Review extends Sprite
	{
		public static var class_name:* = "Lobby.Review";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var pane:ScrollPane;
		private var next_button:Button;
		private var previous_button:Button;
		private var report_button:Button;
		private var ask_button:Button;
		private var problem_number:uint;

		public function Review()
		{
			super();
			g.debuglog("Review Constructor");
			var _loc_2:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_2;
			instance_number = instance_number_counter;
			g.debuglog("In Review");
			window = new YakDialog("Review Problems", 492, 360);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			EventManager.add(window, KeyboardEvent.KEY_UP, on_key_up);
			pane = new ScrollPane();
			pane.move(5, 5);
			pane.setSize(470, 220);
			pane.source = new Sprite();
			window.canvas.addChild(pane);
			problem_number = 1;
			display_problem();
			next_button = new Button();
			next_button.label = "Next";
			next_button.x = 110;
			next_button.y = 300;
			window.canvas.addChild(next_button);
			previous_button = new Button();
			previous_button.label = "Previous";
			previous_button.x = 5;
			previous_button.y = 300;
			window.canvas.addChild(previous_button);
			ask_button = new Button();
			ask_button.label = "Ask on Forum";
			ask_button.x = 270;
			ask_button.y = 300;
			window.canvas.addChild(ask_button);
			report_button = new Button();
			report_button.label = "Report";
			report_button.x = 375;
			report_button.y = 300;
			window.canvas.addChild(report_button);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(previous_button, MouseEvent.CLICK, on_previous_button);
			EventManager.add(ask_button, MouseEvent.CLICK, on_ask_button);
			EventManager.add(report_button, MouseEvent.CLICK, on_report_button);
			EventManager.add(next_button, MouseEvent.CLICK, on_next_button);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added);
		}

		private function display_problem() : void
		{
			if(problem_number < 1)
			{
				problem_number = g.game.last_problem_number_displayed;
			}
			else
			{
				if(problem_number > g.game.last_problem_number_displayed)
				{
					problem_number = 1;
				}
			}
			var _loc_1:uint = 100000;
			while(g.game.problems[problem_number] && problem_number == _loc_1)
			{
				if(_loc_1 == 100000)
				{
					_loc_1 = problem_number;
				}
				var _loc_6:* = this.problem_number + 1;
				this.problem_number = _loc_6;
				if(problem_number > g.game.last_problem_number_displayed)
				{
					problem_number = 1;
				}
			}
			while(Sprite(pane.content).numChildren)
			{
				Sprite(pane.content).removeChildAt(0);
			}
			var _loc_2:Problem = g.game.problems[problem_number];
			_loc_2.image.x = 5;
			_loc_2.image.y = 5;
			var _loc_3:Sprite = new Sprite();
			_loc_3.graphics.beginFill(16777215);
			_loc_3.graphics.drawRect(0, 0, _loc_2.image.width + 10, _loc_2.image.height + 10);
			_loc_3.visible = false;
			var _loc_4:Sprite = Sprite(pane.content);
			_loc_4.addChild(_loc_3);
			_loc_4.addChild(_loc_2.image);
			if(_loc_2.user_answer != null)
			{
				window.setTitle("Problem " + problem_number + "; Answer: " + _loc_2.real_answer + "; Your answer: " + _loc_2.user_answer);
			}
			else
			{
				window.setTitle("Problem " + problem_number + "; Answer: " + _loc_2.real_answer + "; Your answer: None");
			}
			pane.update();
		}

		private function on_report_button(param1:MouseEvent) : void
		{
			addChild(new Review_Report(g.game.problems[problem_number]));
		}

		private function on_cancel(param1:MouseEvent) : void
		{
			parent.removeChild(this);
		}

		private function on_ask_button(param1:MouseEvent) : void
		{
			var _loc_2:URLRequest = new URLRequest((g.phpPath + "ask_forum.php?problem_id=") + g.game.problems[problem_number].id);
			navigateToURL(_loc_2, "_blank");
		}

		private function on_key_up(param1:KeyboardEvent) : void
		{
			if(param1.keyCode == 37)
			{
				var _loc_3:* = this.problem_number - 1;
				this.problem_number = _loc_3;
			}
			else
			{
				if(param1.keyCode == 39)
				{
					var _loc_3:* = this.problem_number + 1;
					this.problem_number = _loc_3;
				}
			}
			display_problem();
		}

		private function on_next_button(param1:MouseEvent) : void
		{
			var _loc_3:* = this.problem_number + 1;
			this.problem_number = _loc_3;
			display_problem();
		}

		private function on_previous_button(param1:MouseEvent) : void
		{
			var _loc_3:* = this.problem_number - 1;
			this.problem_number = _loc_3;
			display_problem();
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(window, KeyboardEvent.KEY_UP, on_key_up);
			EventManager.remove(previous_button, MouseEvent.CLICK, on_previous_button);
			EventManager.remove(ask_button, MouseEvent.CLICK, on_ask_button);
			EventManager.remove(report_button, MouseEvent.CLICK, on_report_button);
			EventManager.remove(next_button, MouseEvent.CLICK, on_next_button);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added);
		}

		private function on_added(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added);
			next_button.setFocus();
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event) : void
		{
			pane.scrollDrag = false;
			parent.removeChild(this);
		}
	}
}
package Lobby
{
	import Game.*;
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;
	import net.theyak.util.*;

	public class Review_Report extends Sprite
	{
		public static var class_name:* = "Lobby.Review_Report";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var window:YakDialog;
		private var ok_button:Button;
		private var cancel_button:Button;
		private var report:TextArea;
		private var problem:Problem;

		public function Review_Report(param1:Problem)
		{
			super();
			var _loc_4:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_4;
			instance_number = instance_number_counter;
			this.problem = param1;
			window = new YakDialog("Report Problem", 400, 300);
			var _loc_2:TextField = new TextField();
			_loc_2.text = "Please describe the issue and click submit.";
			_loc_2.x = 5;
			_loc_2.y = 5;
			_loc_2.width = 390;
			window.canvas.addChild(_loc_2);
			ok_button = new Button();
			ok_button.label = "Submit";
			ok_button.x = 97;
			ok_button.y = 240;
			window.canvas.addChild(ok_button);
			cancel_button = new Button();
			cancel_button.label = "Cancel";
			cancel_button.x = 202;
			cancel_button.y = 240;
			window.canvas.addChild(cancel_button);
			report = new TextArea();
			report.setSize(380, 190);
			report.x = 5;
			report.y = 35;
			window.canvas.addChild(report);
			window.center(g.scene.getScene());
			addChild(window);
			EventManager.add(ok_button, MouseEvent.CLICK, on_ok_button);
			EventManager.add(cancel_button, MouseEvent.CLICK, close);
			EventManager.add(window, "DialogEvent", on_dialog_closed);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		private function on_ok_button(param1:MouseEvent) : void
		{
			Net.callServer((g.phpPath + "problem_report.php?pid=") + problem.id + "&uid=" + g.user.id + "&r=" + escape(report.text) + "&a=" + escape(problem.user_answer));
			var _loc_2:YakAlert = new YakAlert("Thanks, your report has been received.", "Report", "OK");
			_loc_2.center(g.scene.getScene());
			g.scene.getScene().addChild(_loc_2);
			close(param1);
		}

		private function on_added_to_stage(param1:Event) : void
		{
			report.setFocus();
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		private function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(ok_button, MouseEvent.CLICK, on_ok_button);
			EventManager.remove(cancel_button, MouseEvent.CLICK, close);
			EventManager.remove(window, "DialogEvent", on_dialog_closed);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
		}

		private function on_dialog_closed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function close(param1:Event) : void
		{
			parent.removeChild(this);
		}
	}
}
package Lobby
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import net.theyak.events.*;
	import net.theyak.ui.*;

	public class Status extends Sprite
	{
		public static var class_name:* = "Lobby.Status";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var _alert:YakAlert;
		private var _username:String;
		private var _reason:TextInput;
		private var _time:TextInput;
		public var variables:URLLoader;

		public function Status(param1:String)
		{
			var username:String = param1;
			variables = new URLLoader();
			super();
			var _loc_4:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_4;
			instance_number = instance_number_counter;
			_username = username;
			var request:URLRequest = new URLRequest((g.URLPath + "PHP/Status.php?u=") + escape(username));
			variables.dataFormat = URLLoaderDataFormat.VARIABLES;
			EventManager.add(variables, Event.COMPLETE, userLoaded);
			EventManager.add(variables, IOErrorEvent.IO_ERROR, userLoadedError);
			EventManager.add(variables, SecurityErrorEvent.SECURITY_ERROR, securityError);
			try
			{
				variables.load(request);
			}
			catch(err:SecurityError)
			{
				error("Security error");
			}
		}

		private function userLoaded(param1:Event) : void
		{
			var _loc_3:Boolean = false;
			var _loc_4:Boolean = false;
			var _loc_5:* = undefined;
			var _loc_6:* = undefined;
			remove_url_loader_listeners();
			var _loc_2:URLLoader = URLLoader(param1.target);
			if(_loc_2.data.error)
			{
				error(_loc_2.data.error);
			}
			else
			{
				_loc_3 = g.user.access < 100 || _loc_2.data.banned == "true";
				_loc_4 = _loc_2.data.muted == "true";
				_loc_5 = _loc_4 ? "Unmute" : "Mute";
				_loc_6 = "Ban";
				if(g.user.access >= 255)
				{
					_alert = new YakAlert("", "Status for " + _username, _loc_5, _loc_6);
				}
				else
				{
					_alert = new YakAlert("", "Status for " + _username, _loc_5);
				}
				_alert.center(g.scene.getScene());
				add_alert_listeners();
				field("Muted", "No", 20, 20);
				field("Banned", "No", 20, 40);
				_reason = new TextInput();
				_time = new TextInput();
				if(!_loc_4 || !_loc_3)
				{
					field("Reason", "", 20, 60);
					_reason.x = 75;
					_reason.y = 60;
					_reason.setSize(200, 20);
					_reason.mouseEnabled = false;
					_alert.canvas.addChild(_reason);
					field("Minutes", "", 20, 86);
					_time.x = 75;
					_time.y = 86;
					_time.setSize(30, 20);
					_alert.canvas.addChild(_time);
				}
				addChild(_alert);
			}
		}

		private function field(param1:String, param2:String, param3:uint, param4:uint, param5:uint = 0)
		{
			var _loc_6:TextField = new TextField();
			var _loc_7:TextFormat = new TextFormat();
			var _loc_8:TextFormat = new TextFormat();
			_loc_6.x = param3;
			_loc_6.y = param4;
			_loc_6.autoSize = "left";
			_loc_6.text = " " + param1 + ": " + param2;
			_loc_7.font = "_sans";
			_loc_7.size = 12;
			_loc_7.bold = true;
			_loc_7.color = param5;
			_loc_8.font = "_sans";
			_loc_8.color = param5;
			_loc_8.bold = false;
			_loc_6.setTextFormat(_loc_8, param1.length + 2, _loc_6.text.length);
			_loc_6.setTextFormat(_loc_7, 0, param1.length + 2);
			_alert.canvas.addChild(_loc_6);
		}

		private function userLoadedError(param1:Event) : void
		{
			remove_url_loader_listeners();
			error("Load Error");
		}

		private function securityError(param1:Event) : void
		{
			remove_url_loader_listeners();
			error("A security error");
		}

		private function error(param1:String) : void
		{
			_alert = new YakAlert(param1, "Error", "OK");
			_alert.center(g.scene.getScene());
			add_alert_listeners();
			g.scene.getScene().addChild(_alert);
		}

		private function onAlertClosed(param1:DialogEvent) : void
		{
			if(param1.action == "close")
			{
				close(param1);
			}
		}

		private function onAlertButton(param1:AlertEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:String = "";
			switch(param1.button)
			{
			case "Mute":
				if(_time.text.length > 0)
				{
					_loc_2 = parseInt(_time.text);
				}
				if(_loc_2 <= 0)
				{
					_loc_2 = 240;
				}
				if(_reason.text.length > 0)
				{
					_loc_3 = _reason.text;
				}
				g.server.toServerPlugin(g.auxiliary, "Mute", {name:_username, time:_loc_2, reason:_loc_3});
				g.chat.noticeEvent("User " + _username + " muted for " + _loc_2 + " minutes.");
				break;
			case "Ban":
				if(_time.text.length > 0)
				{
					_loc_2 = parseInt(_time.text);
				}
				if(_loc_2 <= 0)
				{
					_loc_2 = 2880;
				}
				if(_reason.text.length > 0)
				{
					_loc_3 = _reason.text;
				}
				g.server.toServerPlugin(g.auxiliary, "Ban", {name:_username, time:_loc_2, reason:_loc_3});
				g.chat.noticeEvent("User " + _username + " banned for " + _loc_2 + " minutes.");
				break;
			case "Unban":
				g.server.toServerPlugin(g.auxiliary, "Unban", {name:_username});
				g.chat.noticeEvent("User " + _username + " no longer banned");
				break;
			case "Unmute":
				g.server.toServerPlugin(g.auxiliary, "Unmute", {name:_username});
				g.chat.noticeEvent("User " + _username + " no longer muted");
				break;
			default:
				break;
			}
		}

		private function add_alert_listeners()
		{
			EventManager.add(_alert, "AlertEvent", onAlertButton);
			EventManager.add(_alert, "DialogEvent", onAlertClosed);
			EventManager.add(_alert, Event.REMOVED_FROM_STAGE, on_alert_removed_from_stage);
		}

		private function on_alert_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(_alert, "AlertEvent", onAlertButton);
			EventManager.remove(_alert, "DialogEvent", onAlertClosed);
			EventManager.remove(_alert, Event.REMOVED_FROM_STAGE, on_alert_removed_from_stage);
		}

		private function remove_url_loader_listeners()
		{
			EventManager.remove(variables, Event.COMPLETE, userLoaded);
			EventManager.remove(variables, IOErrorEvent.IO_ERROR, userLoadedError);
			EventManager.remove(variables, SecurityErrorEvent.SECURITY_ERROR, securityError);
		}

		private function close(param1:Event) : void
		{
			on_alert_removed_from_stage(param1);
			remove_url_loader_listeners();
			parent.removeChild(this);
		}
	}
}
package Lobby
{
	import Misc.*;
	import fl.motion.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class UserInformation extends Sprite
	{
		public static var class_name:* = "Lobby.UserInformation";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var _games_today:TextField;
		private var _current_rating:TextField;
		private var _login_rating:TextField;
		private var _login_box:WhiteBox = null;

		public function UserInformation()
		{
			var _loc_4:uint = 0;
			var _loc_5:Color = null;
			super();
			var _loc_7:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_7;
			instance_number = instance_number_counter;
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.bold = true;
			_loc_1.font = "_sans";
			var _loc_2:TextField = new TextField();
			_loc_2.x = 3;
			_loc_2.y = 3;
			_loc_2.width = 190;
			_loc_2.height = 22;
			_loc_2.selectable = false;
			_loc_2.text = "Games Today";
			_loc_2.setTextFormat(_loc_1);
			addChild(_loc_2);
			if(g.user.access > 0)
			{
				_loc_2 = new TextField();
				_loc_2.x = 3;
				_loc_2.y = 21;
				_loc_2.width = 190;
				_loc_2.height = 22;
				_loc_2.text = "Rating at login";
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
				_loc_2 = new TextField();
				_loc_2.x = 3;
				_loc_2.y = 39;
				_loc_2.width = 190;
				_loc_2.height = 22;
				_loc_2.text = "Current Rating";
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
			}
			else
			{
				_login_box = new WhiteBox();
				_login_box.x = 0;
				_login_box.y = 45;
				_login_box.width = 190;
				_login_box.height = 20;
				_loc_4 = 11388412;
				_loc_5 = new Color();
				_loc_5.setTint(_loc_4, 0.80);
				_login_box.transform.colorTransform = _loc_5;
				addChild(_login_box);
				EventManager.add(_login_box, MouseEvent.CLICK, on_login);
				_loc_1 = new TextFormat();
				_loc_1.color = 16777215;
				_loc_1.bold = true;
				_loc_1.align = "center";
				_loc_1.font = "_sans";
				_loc_2 = new TextField();
				_loc_2.width = 190;
				_loc_2.height = 20;
				_loc_2.x = 0;
				_loc_2.y = 45;
				_loc_2.text = "Login / Register";
				_loc_2.selectable = false;
				_loc_2.mouseEnabled = false;
				_loc_2.setTextFormat(_loc_1);
				addChild(_loc_2);
			}
			var _loc_3:TextFormat = new TextFormat();
			_loc_3.align = "right";
			_loc_3.font = "_sans";
			_games_today = new TextField();
			_games_today.defaultTextFormat = _loc_3;
			_games_today.text = String(g.user.gamesToday);
			_games_today.x = 0;
			_games_today.y = 3;
			_games_today.width = 186;
			_games_today.height = 22;
			_games_today.selectable = false;
			addChild(_games_today);
			if(g.user.access > 0)
			{
				_login_rating = new TextField();
				_login_rating.defaultTextFormat = _loc_3;
				_login_rating.text = g.user.login_rating_display;
				_login_rating.x = 0;
				_login_rating.y = 21;
				_login_rating.width = 186;
				_login_rating.height = 22;
				_login_rating.selectable = false;
				addChild(_login_rating);
				_current_rating = new TextField();
				_current_rating.defaultTextFormat = _loc_3;
				_current_rating.text = g.user.current_rating_display;
				_current_rating.x = 0;
				_current_rating.y = 39;
				_current_rating.width = 186;
				_current_rating.height = 22;
				_current_rating.selectable = false;
				addChild(_current_rating);
			}
		}

		public function set games_today(param1:uint) : void
		{
			_games_today.text = String(param1);
		}

		public function set rating(param1:String) : void
		{
			this.current_rating = param1;
		}

		public function set current_rating(param1:String) : void
		{
			if(param1 == "")
			{
				_current_rating.text = g.user.current_rating_display;
			}
			else
			{
				_current_rating.text = param1;
			}
		}

		public function set login_rating(param1:String) : void
		{
			if(param1 == "")
			{
				_login_rating.text = g.user.login_rating_display;
			}
			else
			{
				_login_rating.text = param1;
			}
		}

		private function on_login(param1:MouseEvent) : void
		{
			navigateToURL(new URLRequest("http://" + g.host + "/user/login.php"), "_self");
		}

		public function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(_login_box, MouseEvent.CLICK, on_login);
		}
	}
}
package Lobby
{
	import Misc.*;
	import com.electrotank.electroserver4.esobject.*;
	import fl.controls.*;
	import fl.data.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;

	public class Userlist extends List
	{
		public static var class_name:* = "Lobby.Userlist";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		private var users:Array;
		private var guests:Array;
		private var myContextMenu:ContextMenu;
		private var item_statistics:ContextMenuItem;
		private var item_status:ContextMenuItem;
		private var item_kick:ContextMenuItem;

		public function Userlist()
		{
			super();
			var _loc_2:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_2;
			instance_number = instance_number_counter;
			doubleClickEnabled = true;
			users = new Array();
			guests = new Array();
			setStyle("cellRenderer", UserListRenderer);
			myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			item_statistics = new ContextMenuItem("Statistics");
			EventManager.add(item_statistics, ContextMenuEvent.MENU_ITEM_SELECT, on_context_select_item);
			myContextMenu.customItems.push(item_statistics);
			this.contextMenu = g.user.access >= 100 && g.user.access >= 100 && myContextMenu;
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		private function on_context_select_item(param1:ContextMenuEvent) : void
		{
			var _loc_3:TextField = null;
			var _loc_4:Whois = null;
			var _loc_5:Status = null;
			var _loc_6:EsObject = null;
			var _loc_2:String = param1.target.caption;
			_loc_3 = TextField(param1.mouseTarget);
			if(_loc_3.text != "Guests")
			{
				switch(_loc_2)
				{
				case "Statistics":
					_loc_4 = new Whois(_loc_3.text);
					g.scene.getScene().addChild(_loc_4);
					break;
				case "Status":
					_loc_5 = new Status(_loc_3.text);
					g.scene.getScene().addChild(_loc_5);
					break;
				case "Kick from room":
					_loc_6 = new EsObject();
					_loc_6.setString("user", _loc_3.text);
					_loc_6.setInteger("zone_id", g.server.toZoneId(g.activeZoneName));
					_loc_6.setInteger("room_id", g.server.toRoomId(g.activeZoneName, g.activeRoomName));
					_loc_6.setString("reason", "I have no reason");
					g.server.esServerPlugin(g.auxiliary, "KickRoom", _loc_6);
					break;
				default:
					break;
				}
			}
		}

		public function addUser(param1:String, param2:String, param3:Boolean = false) : void
		{
			var _loc_5:Object = null;
			if(param1 == null || param1.length <= 0)
			{
				return;
			}
			var _loc_4:Object = findUser(param1);
			if(_loc_4 != null)
			{
				_loc_4.rating = rating_to_string(Number(param2));
				_loc_4.away = param3;
				return;
			}
			if(findGuest(param1) != null)
			{
				return;
			}
			if(param1.indexOf("Guest") != 0)
			{
				_loc_5 = new Object();
				_loc_5.name = param1;
				_loc_5.rating = rating_to_string(Number(param2));
				_loc_5.away = param3;
				users.push(_loc_5);
			}
			else
			{
				guests.push(param1);
			}
			update();
		}

		public function removeUser(param1:String) : void
		{
			if(param1 == null || param1.length <= 0)
			{
				return;
			}
			var _loc_2:int = findUserIndex(param1);
			if(_loc_2 >= 0)
			{
				users.splice(_loc_2, 1);
				update();
				return;
			}
			_loc_2 = findGuestIndex(param1);
			if(_loc_2 >= 0)
			{
				guests.splice(_loc_2, 1);
				update();
			}
		}

		public function setRating(param1:String, param2:Number) : void
		{
			if(param1 == null || param1.length <= 0)
			{
				return;
			}
			var _loc_3:Object = findUser(param1);
			if(_loc_3 != null)
			{
				_loc_3.rating = rating_to_string(param2);
				update();
			}
		}

		public function setAway(param1:String, param2:Boolean) : void
		{
			if(param1 == null || param1.length <= 0)
			{
				return;
			}
			var _loc_3:Object = findUser(param1);
			if(_loc_3 != null)
			{
				_loc_3.away = param2;
				update();
			}
		}

		public function clear() : void
		{
			users = new Array();
			guests = new Array();
			update();
		}

		public function getSelectedUser() : String
		{
			return selectedItem != null ? selectedItem.name : null;
		}

		private function update() : void
		{
			var _loc_4:uint = 0;
			var _loc_1:Number = this.verticalScrollPosition;
			users.sortOn("name", Array.CASEINSENSITIVE);
			var _loc_2:String = getSelectedUser();
			var _loc_3:int = findUserIndex(_loc_2);
			if(guests.length > 0)
			{
				dataProvider = new DataProvider(users.concat([{name:"Guests", rating:guests.length}]));
			}
			else
			{
				dataProvider = new DataProvider(users);
			}
			this.verticalScrollPosition = _loc_1;
			if(_loc_2 != "")
			{
				_loc_4 = 0;
				while(_loc_4 < users.length)
				{
					if(users[_loc_4].name == _loc_2)
					{
						this.selectedIndex = _loc_4;
					}
					_loc_4 = _loc_4 + 1;
				}
			}
		}

		private function findUser(param1:String) : Object
		{
			var _loc_2:uint = 0;
			while(_loc_2 < users.length)
			{
				if(users[_loc_2].name == param1)
				{
					return users[_loc_2];
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		private function findUserIndex(param1:String) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < users.length)
			{
				if(users[_loc_2].name == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		private function findGuest(param1:String) : String
		{
			var _loc_2:uint = 0;
			while(_loc_2 < guests.length)
			{
				if(guests[_loc_2] == param1)
				{
					return guests[_loc_2];
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		private function findGuestIndex(param1:String) : int
		{
			var _loc_2:uint = 0;
			while(_loc_2 < guests.length)
			{
				if(guests[_loc_2] == param1)
				{
					return _loc_2;
				}
				_loc_2 = _loc_2 + 1;
			}
			return -1;
		}

		private function rating_to_string(param1:Number) : String
		{
			if(param1 <= 0)
			{
				return "None";
			}
			return String(Math.round(param1));
		}

		public function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(item_statistics, ContextMenuEvent.MENU_ITEM_SELECT, on_context_select_item);
			if(item_status)
			{
				EventManager.remove(item_status, ContextMenuEvent.MENU_ITEM_SELECT, on_context_select_item);
			}
			if(item_kick)
			{
				EventManager.remove(item_kick, ContextMenuEvent.MENU_ITEM_SELECT, on_context_select_item);
			}
		}
	}
}
package Lobby
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;

	public class UserListRenderer extends UIComponent implements ICellRenderer
	{
		protected var _selected:Boolean;
		protected var _listData:ListData;
		protected var _data:Object;

		public function UserListRenderer() : void
		{
			super();
			focusEnabled = true;
		}

		override public function setSize(param1:Number, param2:Number) : void
		{
			super.setSize(param1, param2);
		}

		public function get listData() : ListData
		{
			return _listData;
		}

		public function set listData(param1:ListData) : void
		{
			_listData = param1;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(param1:Object) : void
		{
			_data = param1;
		}

		public function get selected() : Boolean
		{
			return _selected;
		}

		public function set selected(param1:Boolean) : void
		{
			_selected = param1;
			drawLayout();
		}

		protected function toggleSelected(param1:MouseEvent) : void
		{
			_selected = !_selected;
		}

		public function setMouseState(param1:String) : void
		{
		}

		protected function drawLayout() : void
		{
			var _loc_1:Array = null;
			var _loc_4:Matrix = null;
			var _loc_5:TextField = null;
			var _loc_6:TextField = null;
			var _loc_7:TextFormat = null;
			var _loc_2:Array = [1, 1, 1, 1, 1];
			var _loc_3:Array = [0, 1, 127, 224, 255];
			if(_data.name.length > 0)
			{
				graphics.clear();
				if(_selected)
				{
					_loc_1 = [0, 15663086, 13434828, 15663086, 0];
					_loc_4 = new Matrix();
					_loc_4.createGradientBox(this.width, this.height, Math.PI / 2, 0, 0);
					this.graphics.beginGradientFill(GradientType.LINEAR, _loc_1, _loc_2, _loc_3, _loc_4, SpreadMethod.PAD);
					this.graphics.drawRect(1, 0, this.width - 1, this.height);
					this.graphics.endFill();
				}
				if(numChildren <= 0)
				{
					_loc_5 = new TextField();
					_loc_6 = new TextField();
					var _loc_8:Boolean = false;
					_loc_6.selectable = _loc_8;
					_loc_5.selectable = _loc_8;
					var _loc_8:Boolean = true;
					_loc_6.mouseEnabled = _loc_8;
					_loc_5.mouseEnabled = _loc_8;
					var _loc_8:* = this.width;
					_loc_6.width = _loc_8;
					_loc_5.width = _loc_8;
					_loc_5.doubleClickEnabled = true;
					_loc_7 = new TextFormat();
					_loc_7.align = "right";
					_loc_7.font = "_sans";
					_loc_6.defaultTextFormat = _loc_7;
					_loc_7 = new TextFormat();
					_loc_7.align = "left";
					_loc_7.font = "_sans";
					_loc_5.defaultTextFormat = _loc_7;
					addChildAt(_loc_6, 0);
					addChildAt(_loc_5, 1);
				}
				else
				{
					_loc_6 = TextField(getChildAt(0));
					_loc_5 = TextField(getChildAt(1));
				}
				_loc_5.x = 2;
				_loc_5.text = _data.name;
				_loc_6.text = _data.rating;
				_loc_7 = new TextFormat();
				_loc_7.font = "_sans";
				if(_data.away)
				{
					_loc_7.color = 12303291;
				}
				_loc_5.setTextFormat(_loc_7);
				_loc_7 = new TextFormat();
				_loc_7.font = "_sans";
				if(_data.away)
				{
					_loc_7.color = 12303291;
				}
				_loc_7.align = "right";
				_loc_6.setTextFormat(_loc_7);
			}
			else
			{
				this.visible = false;
			}
		}
	}
}
