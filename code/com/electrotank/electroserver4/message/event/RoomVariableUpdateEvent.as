package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.room.*;

	public class RoomVariableUpdateEvent extends EventImpl
	{
		public static var VariableCreated:Number = 1;
		public static var VariableUpdated:Number = 2;
		public static var VariableDeleted:Number = 3;
		private var roomId:Number;
		private var zoneId:Number;
		private var name:String;
		private var value:EsObject;
		private var locked:Boolean;
		private var lockChanged:Boolean;
		private var valueChanged:Boolean;
		private var updateAction:Number;
		private var persistent:Boolean;
		private var _room:Room;
		private var _minorType:String;
		private var _variable:RoomVariable;

		public function RoomVariableUpdateEvent()
		{
			super();
			setMessageType(MessageType.RoomVariableUpdateEvent);
		}

		public function set room(param1:Room) : void
		{
			_room = param1;
		}

		public function get room() : Room
		{
			return _room;
		}

		public function set minorType(param1:String) : void
		{
			_minorType = param1;
		}

		public function get minorType() : String
		{
			return _minorType;
		}

		public function set variable(param1:RoomVariable) : void
		{
			_variable = param1;
		}

		public function get variable() : RoomVariable
		{
			return _variable;
		}

		public function setPersistent(param1:Boolean) : void
		{
			persistent = param1;
		}

		public function getPersistent() : Boolean
		{
			return persistent;
		}

		public function setUpdateAction(param1:Number) : void
		{
			updateAction = param1;
		}

		public function getUpdateAction() : Number
		{
			return updateAction;
		}

		public function setLockChanged(param1:Boolean) : void
		{
			lockChanged = param1;
		}

		public function getLockChanged() : Boolean
		{
			return lockChanged;
		}

		public function setValueChanged(param1:Boolean) : void
		{
			valueChanged = param1;
		}

		public function getValueChanged() : Boolean
		{
			return valueChanged;
		}

		public function setName(param1:String) : void
		{
			name = param1;
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

		public function getLocked() : Boolean
		{
			return locked;
		}

		public function setLocked(param1:Boolean) : void
		{
			locked = param1;
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
