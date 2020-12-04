package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class CreateRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var persistent:Boolean;

		public function CreateRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.CreateRoomVariableRequest);
			setLocked(false);
			setPersistent(false);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
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
			value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}

		public function setLocked(param1:Boolean) : void
		{
			this.locked = param1;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setPersistent(param1:Boolean) : void
		{
			persistent = param1;
		}

		public function getPersistent() : Boolean
		{
			return persistent;
		}

		public function setRoomId(param1:Number) : void
		{
			roomId = param1;
		}

		public function getRoomId() : Number
		{
			return roomId;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}
	}
}
