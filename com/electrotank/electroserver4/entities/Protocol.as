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
