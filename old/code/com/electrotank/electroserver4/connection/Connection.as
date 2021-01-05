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
