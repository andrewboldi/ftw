package com.electrotank.electroserver4.user
{
	import com.electrotank.electroserver4.entities.*;

	public class User extends Object
	{
		private var userName:String;
		private var userId:String;
		private var userVariables:Array;
		private var userVariablesByName:Object;
		private var references:Number;
		private var isMe:Boolean;
		private var isSendingVideo:Boolean;
		private var videoStreamName:String;

		public function User()
		{
			super();
			setIsMe(false);
			setIsSendingVideo(false);
			setUserVariables(new Array());
			userVariablesByName = new Object();
			setReferences(0);
		}

		public function setVideoStreamName(param1:String) : void
		{
			this.videoStreamName = param1;
		}

		public function getVideoStreamName() : String
		{
			return this.videoStreamName;
		}

		public function setIsSendingVideo(param1:Boolean) : void
		{
			this.isSendingVideo = param1;
		}

		public function getIsSendingVideo() : Boolean
		{
			return this.isSendingVideo;
		}

		public function getIsMe() : Boolean
		{
			return isMe;
		}

		public function setIsMe(param1:Boolean) : void
		{
			this.isMe = param1;
		}

		public function getRealUserId() : String
		{
			var _loc_1:String = null;
			return _loc_1;
		}

		public function setReferences(param1:Number) : void
		{
			references = param1;
		}

		public function getReferences() : Number
		{
			return references;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = new Array();
			var _loc_2:Number = 0;
			while(_loc_2 < param1.length)
			{
				addUserVariable(param1[_loc_2]);
				_loc_2 = _loc_2 + 1;
			}
		}

		public function doesUserVariableExist(param1:String) : Boolean
		{
			return !(userVariablesByName[param1] == null);
		}

		public function addUserVariable(param1:UserVariable) : void
		{
			if(doesUserVariableExist(param1.getName()))
			{
				removeUserVariable(param1.getName());
			}
			getUserVariables().push(param1);
			userVariablesByName[param1.getName()] = param1;
		}

		public function removeUserVariable(param1:String) : void
		{
			var _loc_2:UserVariable = userVariablesByName[param1];
			var _loc_3:Number = 0;
			while(_loc_3 < getUserVariables().length)
			{
				if(getUserVariables()[_loc_3] == _loc_2)
				{
					getUserVariables().splice(_loc_3, 1);
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
		}

		public function getUserVariable(param1:String) : UserVariable
		{
			return userVariablesByName[param1];
		}

		public function setUserName(param1:String) : void
		{
			userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setUserId(param1:String) : void
		{
			userId = param1;
		}

		public function getUserId() : String
		{
			return userId;
		}
	}
}
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
