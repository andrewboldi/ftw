package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.message.*;

	public class CompositePluginMessageEvent extends EventImpl
	{
		private var parameters:Array;
		private var pluginName:String;
		private var originZoneId:Number;
		private var originRoomId:Number;

		public function CompositePluginMessageEvent()
		{
			super();
			setMessageType(MessageType.CompositePluginMessageEvent);
		}

		public function setOriginZoneId(param1:Number) : void
		{
			originZoneId = param1;
		}

		public function getOriginZoneId() : Number
		{
			return originZoneId;
		}

		public function setOriginRoomId(param1:Number) : void
		{
			originRoomId = param1;
		}

		public function getOriginRoomId() : Number
		{
			return originRoomId;
		}

		public function setPluginName(param1:String) : void
		{
			pluginName = param1;
		}

		public function getPluginName() : String
		{
			return pluginName;
		}

		public function setParameters(param1:Array) : void
		{
			parameters = param1;
		}

		public function getParameters() : Array
		{
			return parameters;
		}
	}
}
