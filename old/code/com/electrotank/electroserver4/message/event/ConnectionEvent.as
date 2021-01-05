package com.electrotank.electroserver4.message.event
{
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;

	public class ConnectionEvent extends EventImpl
	{
		private var accepted:Boolean;
		private var esError:EsError;
		private var hashId:int;
		private var prime:String;
		private var base:String;

		public function ConnectionEvent()
		{
			super();
			setMessageType(MessageType.ConnectionEvent);
		}

		public function setHashId(param1:int) : void
		{
			this.hashId = param1;
		}

		public function getHashId() : int
		{
			return hashId;
		}

		public function setEsError(param1:EsError) : void
		{
			this.esError = param1;
		}

		public function getEsError() : EsError
		{
			return this.esError;
		}

		public function setPrime(param1:String) : void
		{
			this.prime = param1;
		}

		public function getPrime() : String
		{
			return this.prime;
		}

		public function setBase(param1:String) : void
		{
			this.base = param1;
		}

		public function getBase() : String
		{
			return this.base;
		}

		public function get success() : Boolean
		{
			return getAccepted();
		}

		public function setAccepted(param1:Boolean) : void
		{
			accepted = param1;
		}

		public function getAccepted() : Boolean
		{
			return accepted;
		}

		public function toString() : String
		{
			return "ConnectionEvent[id: " + getHashId() + ", accepted: " + accepted + "]";
		}
	}
}
