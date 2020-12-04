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
