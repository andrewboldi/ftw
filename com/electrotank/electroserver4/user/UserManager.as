package com.electrotank.electroserver4.user
{
	public class UserManager extends Object
	{
		private var users:Array;
		private var usersById:Object;
		private var me:User;
		private var usersByName:Object;

		public function UserManager()
		{
			super();
			users = new Array();
			usersById = new Object();
			usersByName = new Object();
		}

		public function setMe(param1:User) : void
		{
			me = param1;
		}

		public function getMe() : User
		{
			return me;
		}

		public function addUser(param1:User) : void
		{
			getUsers().push(param1);
			usersById[param1.getUserId()] = param1;
			usersByName[param1.getUserName()] = param1;
		}

		public function addReference(param1:User) : void
		{
			param1.setReferences(param1.getReferences() + 1);
		}

		public function removeReference(param1:User) : void
		{
			if(getUserByName(param1.getUserName()) != null)
			{
				param1.setReferences(param1.getReferences() - 1);
				if(param1.getReferences() == 0)
				{
					removeUser(param1);
				}
			}
			else
			{
				trace("Error: tried to remove reference to a user that wasn't being managed by the UserManager. Name: " + param1.getUserName());
			}
		}

		private function removeUser(param1:User) : void
		{
			var _loc_2:int = NaN;
			if(getUserByName(param1.getUserName()) != null)
			{
				_loc_2 = 0;
				while(_loc_2 < getUsers().length)
				{
					if(getUsers()[_loc_2] == param1)
					{
						getUsers().splice(_loc_2, 1);
						break;
					}
					_loc_2 = _loc_2 + 1;
				}
				usersById[param1.getUserId()] = null;
				usersByName[param1.getUserName()] = null;
			}
			else
			{
				trace("Error: tried to remove a user that isn't being managed by the UserManager. Name: " + param1.getUserName());
			}
		}

		public function doesUserExist(param1:String) : Boolean
		{
			return !(getUserById(param1) == null);
		}

		public function getUserById(param1:String) : User
		{
			return usersById[param1];
		}

		public function getUserByName(param1:String) : User
		{
			return usersByName[param1];
		}

		public function getUsers() : Array
		{
			return users;
		}
	}
}
