package com.electrotank.electroserver4.errors
{
	public class EsError extends Object
	{
		private var id:Number;
		private var description:String;

		public function EsError(param1:Number, param2:String)
		{
			super();
			id = param1;
			description = param2;
		}

		public function getDescription() : String
		{
			return description;
		}

		public function getId() : Number
		{
			return id;
		}
	}
}
