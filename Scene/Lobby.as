package Scene
{
	import Game.*;
	import Misc.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import net.theyak.ui.*;

	public class Lobby extends BaseChat
	{
		public static var class_name:* = "Scene.Lobby";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		public var userlist:Userlist;
		public var _tUsers:TextField;
		public var username:TextField;
		public var _userInfo:UserInformation;
		public var _gameGrid:GameGrid;
		public var _gameGridBackground:Sprite;
		public var _mcCover:Sprite;
		public var _separator:Sprite;
		public var _bNewGame:RedButton;
		public var _bCountdown:RedButton;
		public var _bReview:RedButton;
		private var new_game_box:NewGame;
		private var new_countdown_box:NewCountdown;
		private var review_box:Review;

		public function Lobby()
		{
			super();
			var _loc_5:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_5;
			instance_number = instance_number_counter;
			_mcCover.visible = false;
			g.chat.displayChat = g.user.lobbyChat;
			EventManager.add(this, Event.ADDED, on_added);
			EventManager.add(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.add(_separator, MouseEvent.MOUSE_DOWN, moveSeparator, "Move separator");
			EventManager.add(this, MouseEvent.MOUSE_UP, stopSeparator, "Stop Separator");
			EventManager.add(userlist, MouseEvent.DOUBLE_CLICK, whois, "Whois user");
			_bNewGame.tText.text = "New Game";
			_bReview.tText.text = "Review";
			_bCountdown.tText.text = "Countdown";
			var _loc_1:Array = [8388608, 13369344];
			if(g.user.name == "ilovepink")
			{
				_loc_1 = [16738047, 16764159];
			}
			var _loc_2:Array = [1, 1];
			var _loc_3:Array = [0, 255];
			tab(10, 35, 501, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 380, 190, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 128, 190, 18, 6, _loc_1, _loc_2, _loc_3);
			tab(520, 35, 190, 18, 6, _loc_1, _loc_2, _loc_3);
		}

		private function tab(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Array, param7:Array, param8:Array)
		{
			var _loc_9:Graphics = this.graphics;
			var _loc_10:Matrix = new Matrix();
			_loc_10.createGradientBox(param3, param4, Math.PI / 2, 0, param2);
			_loc_9.beginGradientFill(GradientType.LINEAR, param6, param7, param8, _loc_10, SpreadMethod.PAD);
			_loc_9.moveTo(param1 + param5, param2);
			_loc_9.lineTo((param1 + param3) - param5, param2);
			_loc_9.curveTo(param1 + param3, param2, param1 + param3, param2 + param5);
			_loc_9.lineTo(param1 + param3, param2 + param4);
			_loc_9.lineTo(param1, param2 + param4);
			_loc_9.lineTo(param1, param2 + param5);
			_loc_9.curveTo(param1, param2, param1 + param5, param2);
			_loc_9.endFill();
		}

		private function whois(param1:MouseEvent) : void
		{
			var _loc_3:Whois = null;
			var _loc_2:String = userlist.getSelectedUser();
			if(_loc_2 != null)
			{
				_loc_3 = new Whois(_loc_2);
				g.scene.getScene().addChild(_loc_3);
			}
		}

		public function display_grid_info() : void
		{
			g.chat.noticeEvent(_gameGrid.toString());
		}

		private function moveSeparator(param1:MouseEvent) : void
		{
			EventManager.add(_separator, Event.ENTER_FRAME, separator_move, "_sperator:moveIt");
			Sprite(_separator).startDrag(false, new Rectangle(10, 175, 540, 198));
		}

		private function separator_move(param1:Event) : void
		{
			_tOutput.y = _separator.y + 8;
			_tOutput.setSize(_tOutput.width, 510 - _tOutput.y);
			_gameGrid._spGames.setSize(GameGrid(_gameGrid).width, _tOutput.y - 63);
			_gameGridBackground.height = _gameGrid._spGames.height;
			_separator.x = 10;
		}

		private function stopSeparator(param1:MouseEvent) : void
		{
			EventManager.remove(_separator, Event.ENTER_FRAME, separator_move);
			Sprite(_separator).stopDrag();
		}

		public function on_join_room(param1:Object) : void
		{
			var _loc_2:Array = null;
			var _loc_3:uint = 0;
			if(param1.zonename == "FTW")
			{
				enable_buttons();
				_loc_2 = param1.users;
				userlist.clear();
				_loc_3 = 0;
				while(_loc_3 < _loc_2.length)
				{
					if(!_loc_2[_loc_3].getVariable("hidden") || _loc_2[_loc_3].getVariable("hidden") == "false")
					{
						userlist.addUser(_loc_2[_loc_3].name, _loc_2[_loc_3].getVariable("rating"), _loc_2[_loc_3].getVariable("away") == "true");
					}
					_loc_3 = _loc_3 + 1;
				}
				g.activeZoneName = param1.zonename;
				g.activeRoomName = param1.roomname;
				_tUsers.text = "Users in " + param1.roomname;
			}
		}

		public function onLeaveRoomEvent(param1:Object) : void
		{
			userlist.clear();
			var _loc_2:Array = g.server.getRoomList();
			if(_loc_2.length > 0)
			{
				g.activeZoneName = _loc_2[0].zonename;
				g.activeRoomName = _loc_2[0].roomname;
				refresh_userlist();
				g.chat.noticeEvent("Now chatting in room " + g.activeZoneName + ":" + g.activeRoomName);
			}
		}

		public function onUserListUpdate(param1:Object) : void
		{
			if(param1.roomname == g.activeRoomName && param1.zonename == g.activeZoneName)
			{
				if(param1.action == "add")
				{
					userlist.addUser(param1.user.name, param1.user.getVariable("rating"), false);
				}
				else
				{
					if(param1.action == "remove")
					{
						userlist.removeUser(param1.user.name);
					}
				}
			}
		}

		override protected function do_private_message(param1:String) : void
		{
			var _loc_2:String = userlist.getSelectedUser();
			if(!(_loc_2 == null) && param1.length > 0)
			{
				g.chat.whisper({command:"whisper", target:_loc_2, str:param1});
			}
		}

		override public function refresh_userlist() : void
		{
			userlist.clear();
			var _loc_1:Array = g.server.getUsersInRoom(g.activeZoneName, g.activeRoomName);
			var _loc_2:uint = 0;
			while(_loc_2 < _loc_1.length)
			{
				userlist.addUser(_loc_1[_loc_2].name, _loc_1[_loc_2].getVariable("rating"), _loc_1[_loc_2].getVariable("away") == "true");
				_loc_2 = _loc_2 + 1;
			}
			_tUsers.text = "Users in " + g.activeRoomName;
		}

		public function setAway(param1:String, param2:String) : void
		{
			userlist.setAway(param1, param2 == "true");
		}

		public function setRating(param1:String, param2:Number) : void
		{
			if(param1 == g.user.name)
			{
				_userInfo.current_rating = String(param2);
			}
			userlist.setRating(param1, param2);
		}

		override public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "update":
				_gameGrid.update(uint(param1.response.id), uint(param1.response.s), uint(param1.response.p), uint(param1.response.of), uint(param1.response.pl));
				break;
			case "remove":
				_gameGrid.remove_game(int(param1.response.id));
				break;
			case "game_list":
				_gameGrid.game_list(param1.response.games);
				break;
			case "new_game":
				_gameGrid.new_game(param1.response.id, param1.response.name, param1.response.type, uint(param1.response.scoring), uint(param1.response.problems));
				break;
			default:
				super.on_plugin_message(param1);
				break;
			}
		}

		private function enable_buttons() : void
		{
			if(g.game.last_problem_number_displayed > 0 && g.game.problems.length > 0)
			{
				EventManager.add(_bReview, MouseEvent.CLICK, on_review, "Scene.Lobby._bReview");
				_bReview.alpha = 1;
			}
			else
			{
				_bReview.alpha = 0.20;
			}
			if(g.user.id > 0)
			{
				EventManager.add(_bNewGame, MouseEvent.CLICK, on_ftw, "Scene.Lobby._bNewGame");
				EventManager.add(_bCountdown, MouseEvent.CLICK, on_countdown, "Scene.Lobby._bCountdown");
				_bNewGame.alpha = 1;
				_bCountdown.alpha = 1;
			}
			else
			{
				_bNewGame.visible = false;
				_bCountdown.visible = false;
				_bReview.x = _bNewGame.x;
			}
		}

		private function disable_buttons() : void
		{
			EventManager.remove(_bReview, MouseEvent.CLICK, on_review);
			EventManager.remove(_bNewGame, MouseEvent.CLICK, on_ftw);
			EventManager.remove(_bCountdown, MouseEvent.CLICK, on_countdown);
			_bNewGame.alpha = 0.20;
			_bCountdown.alpha = 0.20;
			_bReview.alpha = 0.20;
		}

		private function on_ftw_removed(param1:Event) : void
		{
			EventManager.remove(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			enable_buttons();
		}

		private function on_ftw(param1:MouseEvent) : void
		{
			disable_buttons();
			new_game_box = new NewGame();
			EventManager.add(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			addChild(new_game_box);
		}

		private function on_countdown_removed(param1:Event) : void
		{
			EventManager.remove(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
			enable_buttons();
		}

		public function on_countdown(param1:MouseEvent) : void
		{
			disable_buttons();
			if(param1.shiftKey)
			{
				EventManager.remove(_bCountdown, MouseEvent.CLICK, on_countdown);
				new_countdown_box = new NewCountdown();
				EventManager.add(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
				addChild(new_countdown_box);
			}
			else
			{
				g.game.reset();
				g.game.type = "Countdown";
				g.game.max_players = 2;
				g.game.problem_count = 20;
				g.game.time_per_problem = 45;
				g.game.rated = true;
				g.game.sprint = true;
				g.game.target = false;
				g.game.team = true;
				g.game.countdown = true;
				g.game.school = true;
				g.game.chapter = true;
				g.game.state = true;
				g.game.national = true;
				g.game.amc8 = true;
				g.game.scoring_method = ScoringType.COUNTDOWN;
				g.game.password = "";
				g.replay = g.game.clone();
				g.game.create();
			}
		}

		private function on_review_removed(param1:Event) : void
		{
			enable_buttons();
			EventManager.remove(review_box, Event.REMOVED_FROM_STAGE, on_review_removed);
			_bReview.alpha = 1;
		}

		public function on_review(param1:Object) : void
		{
			var _loc_2:Boolean = false;
			var _loc_3:uint = 0;
			var _loc_4:YakAlert = null;
			g.game.problems;
			if(g.game.problems && !_gameGrid.is_game(g.game.id) && g.game.last_problem_number_displayed > 0)
			{
				_loc_2 = false;
				_loc_3 = 0;
				while(_loc_3 <= g.game.last_problem_number_displayed)
				{
					if(g.game.problems[_loc_3])
					{
						_loc_2 = true;
						break;
					}
					_loc_3 = _loc_3 + 1;
				}
				_loc_4 = new YakAlert("There are no problems to review.", "Review Game", "OK");
				_loc_4.center(g.scene.getScene());
				g.scene.getScene().addChild(_loc_4);
			}
			else
			{
				if(!g.game.problems || g.game.last_problem_number_displayed <= 0)
				{
					_loc_4 = new YakAlert("There are no problems to view.", "Review Game", "OK");
					_loc_4.center(g.scene.getScene());
					g.scene.getScene().addChild(_loc_4);
				}
				else
				{
					_loc_4 = new YakAlert("Please wait for game to finish before reviewing. If you start or join another game before the game finishes, you will no longer be able to review the game.", "Review Game", "OK");
					_loc_4.center(g.scene.getScene());
					g.scene.getScene().addChild(_loc_4);
				}
			}
		}

		override protected function on_added(param1:Event) : void
		{
			if(param1.eventPhase == EventPhase.AT_TARGET)
			{
				super.on_added(param1);
				EventManager.remove(this, Event.ADDED, on_added);
			}
		}

		override protected function on_added_to_stage(param1:Event) : void
		{
			disable_buttons();
			username.text = g.user.name;
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			super.on_added_to_stage(param1);
			g.server.addEventListener("userListUpdate", "onUserListUpdate", this);
			g.server.addEventListener("joinRoom", "on_join_room", this);
			g.server.addEventListener("leaveRoom", "onLeaveRoomEvent", this);
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			g.server.toServerPlugin(g.manager, "get_games", {zone:g.activeZoneName});
			g.activeZoneName = "FTW";
			g.activeRoomName = "Lobby";
			g.server.joinRoom(g.activeZoneName, g.activeRoomName);
			var _loc_2:GlowFilter = new GlowFilter(0, 0.10, 16, 16, 0, 3, false, false);
			_bNewGame.filters = new Array(_loc_2);
			_bCountdown.filters = new Array(_loc_2);
			_bReview.filters = new Array(_loc_2);
		}

		override protected function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(this, Event.ADDED, on_added);
			EventManager.remove(this, Event.ADDED_TO_STAGE, on_added_to_stage);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			EventManager.remove(this, MouseEvent.MOUSE_UP, stopSeparator);
			EventManager.remove(_separator, MouseEvent.MOUSE_DOWN, moveSeparator);
			EventManager.remove(_separator, Event.ENTER_FRAME, separator_move);
			EventManager.remove(userlist, MouseEvent.DOUBLE_CLICK, whois);
			EventManager.remove(new_game_box, Event.REMOVED_FROM_STAGE, on_ftw_removed);
			EventManager.remove(new_countdown_box, Event.REMOVED_FROM_STAGE, on_countdown_removed);
			EventManager.remove(review_box, Event.REMOVED_FROM_STAGE, on_review_removed);
			disable_buttons();
			g.server.removeEventListener("userListUpdate", "onUserListUpdate", this);
			g.server.removeEventListener("joinRoom", "on_join_room", this);
			g.server.removeEventListener("leaveRoom", "onLeaveRoomEvent", this);
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			super.on_removed_from_stage(param1);
		}
	}
}
