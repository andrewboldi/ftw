package com.electrotank.electroserver4.message.response
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class GenericErrorResponse extends ResponseImpl
	{
		private var requestMessageType:MessageType;
		private var errorType:EsError;
		private var esObject:EsObject;
		private var hasEsObject:Boolean;

		public function GenericErrorResponse()
		{
			super();
			setMessageType(MessageType.GenericErrorResponse);
			hasEsObject = false;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
			hasEsObject = true;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setRequestMessageType(param1:MessageType) : void
		{
			requestMessageType = param1;
		}

		public function getRequestMessageType() : MessageType
		{
			return requestMessageType;
		}

		public function setErrorType(param1:EsError) : void
		{
			errorType = param1;
		}

		public function getErrorType() : EsError
		{
			return errorType;
		}
	}
}
