package com.electrotank.electroserver4.connection
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.utils.*;
	import flash.utils.*;

	public class AbstractConnection extends Observable
	{
		private var ip:String;
		private var port:Number;
		private var id:Number;
		private var outboundId:Number = -1;
		private var expectedInboundId:Number = 0;
		private var isConnected:Boolean = false;
		private var protocol:String;
		public var onConnect:Function;
		public var onClose:Function;

		public function AbstractConnection(param1:String, param2:Number, param3:String)
		{
			super();
			this.ip = param1;
			this.port = param2;
			this.protocol = param3;
		}

		public function getIp() : String
		{
			return ip;
		}

		public function getPort() : Number
		{
			return port;
		}

		public function setId(param1:Number) : void
		{
			this.id = param1;
		}

		public function getId() : Number
		{
			return id;
		}

		public function getProtocol() : String
		{
			return protocol;
		}

		public function setExpectedInboundId(param1:Number) : void
		{
			expectedInboundId = param1;
		}

		public function getExpectedInboundId() : Number
		{
			return expectedInboundId;
		}

		public function getNextOutboundId() : Number
		{
			var _loc_2:* = this.outboundId + 1;
			this.outboundId = _loc_2;
			if(outboundId == 10000)
			{
				outboundId = 0;
			}
			return outboundId;
		}

		public function getIsConnected() : Boolean
		{
			return isConnected;
		}

		public function send(param1:String) : void
		{
			if(getProtocol() == Protocol.TEXT)
			{
				throw new Error("Must implement for text protocol");
			}
			throw new Error("Use sendBinary for binary connections");
		}

		public function sendBinary(param1:ByteArray) : void
		{
			if(getProtocol() == Protocol.BINARY)
			{
				throw new Error("Must implement for binary protocol");
			}
			throw new Error("Use send for text connections");
		}

		final public function close() : void
		{
			doClose();
			onPreClose();
		}

		protected function doClose() : void
		{
			throw new Error("Must implement close");
		}

		public function onPreConnect(param1:Boolean) : void
		{
			isConnected = param1;
			notifyListeners("onConnect", {target:this, success:param1});
		}

		public function connect() : void
		{
			throw new Error("Must implement connect");
		}

		public function onPreClose() : void
		{
			isConnected = false;
			notifyListeners("onClose", {target:this});
		}
	}
}
