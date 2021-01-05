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
