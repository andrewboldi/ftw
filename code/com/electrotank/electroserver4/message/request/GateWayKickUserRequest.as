package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GateWayKickUserRequest extends RequestImpl
	{
		private var eserror:EsError;
		private var esObject:EsObject;

		public function GateWayKickUserRequest()
		{
			super();
			setMessageType(MessageType.GateWayKickUserRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
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

		public function setEsError(param1:EsError) : void
		{
			this.eserror = param1;
		}

		public function getEsError() : EsError
		{
			return eserror;
		}
	}
}
