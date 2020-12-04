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
