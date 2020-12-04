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
