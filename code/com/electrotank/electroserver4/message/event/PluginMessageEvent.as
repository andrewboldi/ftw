package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PluginMessageEvent extends EventImpl
	{
		private var originZoneId:Number;
		private var originRoomId:Number;
		private var destinationZoneId:Number;
		private var destinationRoomId:Number;
		private var esObject:EsObject;
		private var pluginName:String;
		private var sentToRoom:Boolean;
		private var isRoomLevelPlugin:Boolean;

		public function PluginMessageEvent()
		{
			super();
			setMessageType(MessageType.PluginMessageEvent);
			setIsRoomLevelPlugin(false);
		}

		public function setIsRoomLevelPlugin(param1:Boolean) : void
		{
			isRoomLevelPlugin = param1;
		}

		public function getIsRoomLevelPlugin() : Boolean
		{
			return isRoomLevelPlugin;
		}

		public function setPluginName(param1:String) : void
		{
			pluginName = param1;
		}

		public function getPluginName() : String
		{
			return pluginName;
		}

		public function wasSentToRoom() : Boolean
		{
			return sentToRoom;
		}

		public function setSentToRoom(param1:Boolean) : void
		{
			sentToRoom = param1;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return this.esObject;
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

		public function setDestinationZoneId(param1:Number) : void
		{
			destinationZoneId = param1;
		}

		public function getDestinationZoneId() : Number
		{
			return destinationZoneId;
		}

		public function setDestinationRoomId(param1:Number) : void
		{
			destinationRoomId = param1;
		}

		public function getDestinationRoomId() : Number
		{
			return destinationRoomId;
		}
	}
}
