package com.electrotank.electroserver4.room
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.user.*;
	import com.electrotank.electroserver4.zone.*;

	public class Room extends Object
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var roomName:String;
		private var userCount:Number;
		private var users:Array;
		private var usersById:Object;
		private var zone:Zone;
		private var hasPassword:Boolean;
		private var description:String;
		private var capacity:Number;
		private var isHidden:Boolean;
		private var password:String;
		private var roomVariables:Array;
		private var roomVariablesByName:Object;
		private var isJoined:Boolean;

		public function Room()
		{
			super();
			users = new Array();
			usersById = new Object();
			roomVariables = new Array();
			roomVariablesByName = new Object();
			setIsJoined(false);
		}

		public function getIsJoined() : Boolean
		{
			return this.isJoined;
		}

		public function setIsJoined(param1:Boolean) : void
		{
			this.isJoined = param1;
		}

		public function doesRoomVariableExist(param1:String) : Boolean
		{
			return !(roomVariablesByName[param1] == null);
		}

		public function addRoomVariable(param1:RoomVariable) : void
		{
			getRoomVariables().push(param1);
			roomVariablesByName[param1.getName()] = param1;
		}

		public function removeRoomVariable(param1:String) : void
		{
			var _loc_3:RoomVariable = null;
			var _loc_2:Number = 0;
			while(_loc_2 < getRoomVariables().length)
			{
				_loc_3 = getRoomVariables()[_loc_2];
				if(_loc_3.getName() == param1)
				{
					getRoomVariables().splice(_loc_2, 1);
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function getRoomVariable(param1:String) : RoomVariable
		{
			return roomVariablesByName[param1];
		}

		public function setRoomVariables(param1:Array) : void
		{
			var _loc_3:RoomVariable = null;
			roomVariables = new Array();
			var _loc_2:Number = 0;
			while(_loc_2 < param1.length)
			{
				_loc_3 = param1[_loc_2];
				addRoomVariable(_loc_3);
				_loc_2 = _loc_2 + 1;
			}
		}

		public function getRoomVariables() : Array
		{
			return roomVariables;
		}

		public function setPassword(param1:String) : void
		{
			password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}

		public function setIsHidden(param1:Boolean) : void
		{
			isHidden = param1;
		}

		public function getIsHidden() : Boolean
		{
			return isHidden;
		}

		public function setCapacity(param1:Number) : void
		{
			capacity = param1;
		}

		public function getCapacity() : Number
		{
			return capacity;
		}

		public function setDescription(param1:String) : void
		{
			description = param1;
		}

		public function getDescription() : String
		{
			return description;
		}

		public function setHasPassword(param1:Boolean) : void
		{
			hasPassword = param1;
		}

		public function getHasPassword() : Boolean
		{
			return hasPassword;
		}

		public function addUser(param1:User) : void
		{
			if(getUserById(param1.getUserId()) == null)
			{
				usersById[param1.getUserId()] = param1;
				getUsers().push(param1);
			}
			else
			{
				trace("Error: tried to add a user and that id is in use. userId: " + param1.getUserId() + " - userName: " + param1.getUserName());
			}
			setUserCount(getUsers().length);
		}

		public function removeUser(param1:String) : void
		{
			var _loc_2:User = getUserById(param1);
			var _loc_3:Number = 0;
			while(_loc_3 < getUsers().length)
			{
				if(_loc_2 == getUsers()[_loc_3])
				{
					getUsers().splice(_loc_3, 1);
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
			setUserCount(getUsers().length);
		}

		public function setZone(param1:Zone) : void
		{
			zone = param1;
		}

		public function getZone() : Zone
		{
			return zone;
		}

		public function getUsers() : Array
		{
			return users;
		}

		public function getUserById(param1:String) : User
		{
			return usersById[param1];
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setRoomName(param1:String) : void
		{
			roomName = param1;
		}

		public function getRoomName() : String
		{
			return roomName;
		}

		public function setUserCount(param1:Number) : void
		{
			userCount = param1;
		}

		public function getUserCount() : Number
		{
			return userCount;
		}
	}
}
