package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PluginRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var esObject:EsObject;
		private var pluginName:String;
		private var sentToRoom:Boolean;

		public function PluginRequest()
		{
			super();
			setMessageType(MessageType.PluginRequest);
			esObject = new EsObject();
			setSentToRoom(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function getEsObject() : EsObject
		{
			return this.esObject;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
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

		private function setSentToRoom(param1:Boolean) : void
		{
			sentToRoom = param1;
		}

		public function setZoneId(param1:Number) : void
		{
			setSentToRoom(true);
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}
	}
}
