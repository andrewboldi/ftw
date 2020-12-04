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
