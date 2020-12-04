package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class UpdateRoomVariableRequest extends RequestImpl
	{
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var lockChanged:Boolean;
		private var valueChanged:Boolean;

		public function UpdateRoomVariableRequest()
		{
			super();
			setMessageType(MessageType.UpdateRoomVariableRequest);
			lockChanged = false;
			valueChanged = false;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function hasValueChanged() : Boolean
		{
			return valueChanged;
		}

		public function setValue(param1:EsObject) : void
		{
			valueChanged = true;
			this.value = param1;
		}

		public function hasLockStatusChanged() : Boolean
		{
			return lockChanged;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function getValue() : EsObject
		{
			return value;
		}

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setLocked(param1:Boolean) : void
		{
			lockChanged = true;
			this.locked = param1;
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
