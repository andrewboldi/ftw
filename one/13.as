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
package com.electrotank.electroserver4.connection
{
	import com.electrotank.electroserver4.entities.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;

	public class Connection extends AbstractConnection
	{
		private var socket:XMLSocket;
		private var binarySocket:Socket;
		private var handledPolicyFile:Boolean;
		private var waitingForHeader:Boolean;
		private var bytesNeeded:int;
		public var onData:Function;

		public function Connection(param1:String, param2:Number, param3:String)
		{
			super(param1, param2, param3);
			trace("Connection:init()");
			if(param3 == Protocol.BINARY)
			{
				waitingForHeader = true;
				handledPolicyFile = false;
				binarySocket = new Socket();
				binarySocket.addEventListener(Event.CONNECT, onBinaryConnect);
				binarySocket.addEventListener(Event.CLOSE, onBinaryClose);
				binarySocket.addEventListener(ProgressEvent.SOCKET_DATA, onBinarySocketData);
				binarySocket.addEventListener(IOErrorEvent.IO_ERROR, onBinaryIOErrorEvent);
			}
			Security.loadPolicyFile("xmlsocket://" + getIp() + ":" + getPort());
			socket = new XMLSocket();
			configureListeners(socket);
		}

		private function onBinaryIOErrorEvent(param1:IOErrorEvent) : void
		{
			onPreConnect(false);
		}

		private function onBinaryClose(param1:Event) : void
		{
			onPreClose();
		}

		private function onBinaryConnect(param1:Event) : void
		{
			onPreConnect(true);
		}

		private function onBinarySocketData(param1:ProgressEvent) : void
		{
			if(!handledPolicyFile)
			{
				if(binarySocket.readUTFBytes(1) == "<")
				{
					do
					{
					}
					while(binarySocket.readByte() != 0);
					handledPolicyFile = true;
				}
			}
			processBinarySocketData();
		}

		private function processBinarySocketData() : void
		{
			var _loc_1:ByteArray = null;
			if(!binarySocket.connected)
			{
				return;
			}
			if(waitingForHeader)
			{
				if(binarySocket.bytesAvailable >= 4)
				{
					bytesNeeded = binarySocket.readInt();
					waitingForHeader = false;
				}
			}
			if(!waitingForHeader)
			{
				if(binarySocket.bytesAvailable >= bytesNeeded)
				{
					_loc_1 = new ByteArray();
					binarySocket.readBytes(_loc_1, 0, bytesNeeded);
					notifyListeners("onBinaryData", {target:this, data:_loc_1});
					waitingForHeader = true;
					processBinarySocketData();
				}
			}
		}

		override public function sendBinary(param1:ByteArray) : void
		{
			binarySocket.writeBytes(param1);
			binarySocket.flush();
		}

		private function configureListeners(param1:IEventDispatcher) : void
		{
			param1.addEventListener(Event.CLOSE, closeHandler);
			param1.addEventListener(Event.CONNECT, connectHandler);
			param1.addEventListener(DataEvent.DATA, dataHandler);
			param1.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			param1.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function closeHandler(param1:Event) : void
		{
			onPreClose();
		}

		private function connectHandler(param1:Event) : void
		{
			onPreConnect(true);
		}

		private function dataHandler(param1:DataEvent) : void
		{
			onPreData(param1.data);
		}

		private function ioErrorHandler(param1:IOErrorEvent) : void
		{
			onPreConnect(false);
		}

		private function progressHandler(param1:ProgressEvent) : void
		{
		}

		private function securityErrorHandler(param1:SecurityErrorEvent) : void
		{
			trace("securityErrorHandler: " + param1);
		}

		override public function send(param1:String) : void
		{
			socket.send(param1);
		}

		override protected function doClose() : void
		{
			if(getProtocol() == Protocol.TEXT)
			{
				socket.close();
			}
			else
			{
				if(getProtocol() == Protocol.BINARY)
				{
					binarySocket.close();
				}
			}
		}

		override public function connect() : void
		{
			if(getProtocol() == Protocol.TEXT)
			{
				socket.connect(getIp(), getPort());
			}
			else
			{
				if(getProtocol() == Protocol.BINARY)
				{
					binarySocket.connect(getIp(), getPort());
				}
			}
		}

		public function onPreData(param1:String) : void
		{
			notifyListeners("onStringData", {target:this, data:param1});
		}
	}
}
package com.electrotank.electroserver4.connection
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.*;

	public class HttpConnection extends AbstractConnection
	{
		private var workers:Array;
		private var sessionKey:String = null;
		private var closing:Boolean = false;
		private var _retryCount:uint = 7;
		private var _retryDelay:uint = 1000;

		final public static function log(param1:Object) : void
		{
			HttpConnection.trace((new Date()) + " " + param1);
		}

		public function HttpConnection(param1:String, param2:Number, param3:ElectroServer)
		{
			workers = new Array();
			super(param1, param2, Protocol.BINARY);
			param3.addEventListener(MessageType.ConnectionEvent, "onConnectionEvent", this, true);
			Security.loadPolicyFile("http://" + param1 + ":" + param2 + "/cross-domain");
		}

		public function get retryCount() : uint
		{
			return _retryCount;
		}

		public function set retryCount(param1:uint) : void
		{
			_retryCount = param1;
		}

		public function get retryDelay() : uint
		{
			return _retryDelay;
		}

		public function set retryDelay(param1:uint) : void
		{
			_retryDelay = param1;
		}

		override public function sendBinary(param1:ByteArray) : void
		{
			var worker:HttpWorker = null;
			var timer:Timer = null;
			var listener:Function = null;
			var message:ByteArray = param1;
			if(null == sessionKey)
			{
				throw new Error("Cannot send a message until the connection process is complete");
			}
			worker = new HttpWorker(this);
			if(retryCount > 0)
			{
				timer = null;
				function _func_1511() : void
				{
					function _func_1509() : void
					{
						if(timer.currentCount <= timer.repeatCount)
						{
							timer.start();
						}
						else
						{
							onPreConnect(false);
						}
					}
					worker.addEventListener(IOErrorEvent.IO_ERROR, _func_1509);
					worker.removeEventListener(IOErrorEvent.IO_ERROR, listener);
					timer = new Timer(retryDelay, retryCount);
					function _func_1510() : void
					{
						timer.stop();
						worker.send("/s/" + sessionKey, message);
					}
					timer.addEventListener(TimerEvent.TIMER, _func_1510);
					timer.start();
				}
				listener = _func_1511;
				worker.addEventListener(IOErrorEvent.IO_ERROR, listener);
			}
			worker.send("/s/" + sessionKey, message);
		}

		override public function connect() : void
		{
			var data:ByteArray = new ByteArray();
			data.writeByte(0);
			var worker:HttpWorker = new HttpWorker(this);
			function _func_1513() : void
			{
				onPreConnect(true);
			}
			worker.addEventListener(Event.OPEN, _func_1513);
			function _func_1514() : void
			{
				onPreConnect(false);
			}
			worker.addEventListener(IOErrorEvent.IO_ERROR, _func_1514);
			worker.send("/connect/binary", data);
		}

		override protected function doClose() : void
		{
			var _loc_1:int = 0;
			closing = true;
			while(workers.length > 0)
			{
				while(0)
				{
					HttpWorker(workers[_loc_1]).close();
				}
			}
		}

		public function onConnectionEvent(param1:ConnectionEvent) : void
		{
			sessionKey = param1.getHashId().toString();
		}

		public function addWorker(param1:HttpWorker) : void
		{
			workers.push(param1);
		}

		public function removeWorker(param1:HttpWorker) : void
		{
			var _loc_2:int = workers.indexOf(param1);
			if(_loc_2 >= 0)
			{
				workers.splice(_loc_2, 1);
			}
			if(!closing && workers.length == 0)
			{
				sendBinary(null);
			}
		}
	}
}
package com.electrotank.electroserver4.connection
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class HttpWorker extends Object implements IEventDispatcher
	{
		private static var counter:uint = 0;
		private var connection:HttpConnection;
		private var stream:URLStream;
		private var bytesNeeded:int = 0;
		private var _id:uint;

		public function HttpWorker(param1:HttpConnection)
		{
			var worker:HttpWorker = null;
			var connection:HttpConnection = param1;
			super();
			this.connection = connection;
			var _loc_4:Number = this.counter + 1;
			this.counter = _loc_4;
			this._id = this.counter;
			worker = this;
			this.stream = new URLStream();
			function _func_914() : void
			{
				connection.removeWorker(worker);
			}
			this.stream.addEventListener(Event.COMPLETE, _func_914);
			function _func_915() : void
			{
				connection.addWorker(worker);
			}
			this.stream.addEventListener(Event.OPEN, _func_915);
			function _func_916(param1:Event) : void
			{
				readData();
			}
			this.stream.addEventListener(ProgressEvent.PROGRESS, _func_916);
			function _func_917(param1:ErrorEvent) : void
			{
				HttpConnection.log(param1);
			}
			this.stream.addEventListener(IOErrorEvent.IO_ERROR, _func_917);
			function _func_918(param1:ErrorEvent) : void
			{
				HttpConnection.log(param1);
			}
			this.stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _func_918);
		}

		public function send(param1:String, param2:ByteArray) : void
		{
			var _loc_3:URLRequest = new URLRequest();
			_loc_3.url = "http://" + connection.getIp() + ":" + connection.getPort() + param1 + "?_=" + _id;
			_loc_3.data = param2;
			_loc_3.method = URLRequestMethod.POST;
			stream.load(_loc_3);
		}

		public function close() : void
		{
			stream.close();
		}

		private function readData() : void
		{
			var _loc_1:ByteArray = null;
			if(!stream.connected)
			{
			}
			else
			{
				if(bytesNeeded > 0)
				{
					if(stream.bytesAvailable >= bytesNeeded)
					{
						_loc_1 = new ByteArray();
						stream.readBytes(_loc_1, 0, bytesNeeded);
						bytesNeeded = 0;
						if(0 == _loc_1[0] && 0 == _loc_1[1])
						{
						}
						else
						{
							connection.notifyListeners("onBinaryData", {target:connection, data:_loc_1});
						}
						readData();
					}
				}
				else
				{
					if(stream.bytesAvailable >= 4)
					{
						bytesNeeded = stream.readInt();
						readData();
					}
				}
			}
		}

		public function dispatchEvent(param1:Event) : Boolean
		{
			return stream.dispatchEvent(param1);
		}

		public function hasEventListener(param1:String) : Boolean
		{
			return stream.hasEventListener(param1);
		}

		public function willTrigger(param1:String) : Boolean
		{
			return stream.willTrigger(param1);
		}

		public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
		{
			stream.removeEventListener(param1, param2, param3);
		}

		public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
		{
			stream.addEventListener(param1, param2, param3, param4, param5);
		}

		public function toString() : String
		{
			return "[HttpWorker " + _id + "]";
		}
	}
}
