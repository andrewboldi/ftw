package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class PublicMessageRequest extends RequestImpl
	{
		private var zoneId:Number;
		private var roomId:Number;
		private var message:String;
		private var esObject:EsObject;

		public function PublicMessageRequest()
		{
			super();
			setMessageType(MessageType.PublicMessageRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(isNaN(getZoneId()))
			{
				_loc_2.push("zoneId cannot be null");
			}
			if(isNaN(getRoomId()))
			{
				_loc_2.push("roomId cannot be null");
			}
			if(getMessage() == null)
			{
				_loc_2.push("message cannot be null");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setEsObject(param1:EsObject) : void
		{
			esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setMessage(param1:String) : void
		{
			this.message = param1;
		}

		public function getMessage() : String
		{
			return message;
		}

		public function setZoneId(param1:Number) : void
		{
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
