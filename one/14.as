package com.electrotank.electroserver4.entities
{
	public class Protocol extends Object
	{
		public static var TEXT:String = "text";
		public static var BINARY:String = "binary";
		private var protocolId:Number;

		public function Protocol()
		{
			super();
		}

		public function setProtocolId(param1:Number) : void
		{
			this.protocolId = param1;
		}

		public function getProtocolId() : Number
		{
			return protocolId;
		}
	}
}
package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class RoomVariable extends Object
	{
		private var persistent:Boolean;
		private var locked:Boolean;
		private var name:String;
		private var value:EsObject;

		public function RoomVariable(param1:String, param2:EsObject, param3:Boolean, param4:Boolean)
		{
			super();
			setName(param1);
			setValue(param2);
			setPersistent(param3);
			setLocked(param4);
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function setValue(param1:EsObject) : void
		{
			this.value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}

		public function setPersistent(param1:Boolean) : void
		{
			this.persistent = param1;
		}

		public function getPersistent() : Boolean
		{
			return persistent;
		}

		public function setLocked(param1:Boolean) : void
		{
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}
	}
}
package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class SearchCriteria extends Object
	{
		private var gameType:String;
		private var locked:Boolean;
		private var gameDetails:EsObject;
		private var gameId:Number;
		private var lockedSet:Boolean;

		public function SearchCriteria()
		{
			super();
			setGameId(-1);
			lockedSet = false;
		}

		public function setGameId(param1:Number) : void
		{
			this.gameId = param1;
		}

		public function getGameId() : Number
		{
			return gameId;
		}

		public function setGameDetails(param1:EsObject) : void
		{
			this.gameDetails = param1;
		}

		public function getGameDetails() : EsObject
		{
			return gameDetails;
		}

		public function getLockedSet() : Boolean
		{
			return lockedSet;
		}

		public function setLocked(param1:Boolean) : void
		{
			lockedSet = true;
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return this.locked;
		}

		public function setGameType(param1:String) : void
		{
			this.gameType = param1;
		}

		public function getGameType() : String
		{
			return gameType;
		}
	}
}
package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class ServerGame extends Object
	{
		private var passwordProtected:Boolean;
		private var gameDetails:EsObject;
		private var locked:Boolean;
		private var gameId:Number;

		public function ServerGame()
		{
			super();
		}

		public function setPasswordProtected(param1:Boolean) : void
		{
			this.passwordProtected = param1;
		}

		public function getPasswordProtected() : Boolean
		{
			return passwordProtected;
		}

		public function setGameDetails(param1:EsObject) : void
		{
			this.gameDetails = param1;
		}

		public function getGameDetails() : EsObject
		{
			return gameDetails;
		}

		public function setLocked(param1:Boolean) : void
		{
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setGameId(param1:Number) : void
		{
			this.gameId = param1;
		}

		public function getGameId() : Number
		{
			return gameId;
		}
	}
}
package com.electrotank.electroserver4.entities
{
	import com.electrotank.electroserver4.esobject.*;

	public class UserVariable extends Object
	{
		private var name:String;
		private var value:EsObject;

		public function UserVariable(param1:String, param2:EsObject)
		{
			super();
			setName(param1);
			setValue(param2);
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function setValue(param1:EsObject) : void
		{
			this.value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}
	}
}
