package com.electrotank.electroserver4.esobject
{
	public class EsObjectMap extends Object
	{
		private var value:EsObject;
		private var key:String;

		public function EsObjectMap(param1:String, param2:EsObject)
		{
			super();
			key = param1;
			value = param2;
		}

		public function getValue() : EsObject
		{
			return value;
		}

		public function getName() : String
		{
			return key;
		}
	}
}
