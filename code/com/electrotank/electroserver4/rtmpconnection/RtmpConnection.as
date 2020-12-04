package com.electrotank.electroserver4.rtmpconnection
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.utils.*;
	import flash.events.*;
	import flash.net.*;

	public class RtmpConnection extends Object
	{
		private var netConnection:NetConnection;
		private var es:ElectroServer;
		private var netStreams:Array;
		private var isConnected:Boolean;

		public function RtmpConnection(param1:ElectroServer)
		{
			super();
			this.es = param1;
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
			netConnection = new NetConnection();
			netStreams = new Array();
			isConnected = false;
		}

		public function getNetConnection() : NetConnection
		{
			return this.netConnection;
		}

		public function disposeOfNetStream(param1:NetStream) : void
		{
			param1.close();
			var _loc_2:Number = 0;
			while(_loc_2 < netStreams.length)
			{
				if(netStreams[_loc_2] == param1)
				{
					netStreams.splice(_loc_2, 1);
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function getIsConnected() : Boolean
		{
			return isConnected;
		}

		public function getNewNetStream() : NetStream
		{
			var _loc_1:NetStream = new NetStream(netConnection);
			netStreams.push(_loc_1);
			return _loc_1;
		}

		public function getNetStreams() : Array
		{
			return netStreams;
		}

		public function onStatus(param1:Object) : void
		{
			var _loc_2:RtmpConnectionEvent = null;
			var _loc_4:RtmpConnectionClosedEvent = null;
			Logger.log(param1.code, Logger.info);
			if(param1.level == "status")
			{
				switch(param1.code)
				{
				case "NetConnection.Connect.Success":
					isConnected = true;
					_loc_2 = new RtmpConnectionEvent();
					_loc_2.setAccepted(true);
					es.dispatchEvent(_loc_2);
					break;
				case "NetConnection.Connect.Closed":
					isConnected = false;
					_loc_4 = new RtmpConnectionClosedEvent();
					es.dispatchEvent(_loc_4);
					break;
				default:
					break;
				}
			}
			else
			{
				if(param1.level == "error")
				{
					switch(param1.code)
					{
					case "NetConnection.Connect.Failed":
						isConnected = false;
						_loc_2 = new RtmpConnectionEvent();
						_loc_2.setAccepted(false);
						es.dispatchEvent(_loc_2);
						break;
					case "NetConnection.Connect.Rejected":
						isConnected = false;
						_loc_2 = new RtmpConnectionEvent();
						_loc_2.setAccepted(false);
						es.dispatchEvent(_loc_2);
						break;
					case "NetConnection.Call.Failed":
						break;
					case "NetConnection.Connect.AppShutdown":
						break;
					case "NetConnection.Connect.InvalidApp":
						break;
					default:
						break;
					}
				}
			}
			var _loc_3:RtmpOnStatusEvent = new RtmpOnStatusEvent();
			_loc_3.setInfo(param1);
			es.dispatchEvent(_loc_3);
		}

		private function netStatusHandler(param1:NetStatusEvent) : void
		{
			onStatus(param1.info);
		}

		private function securityErrorHandler(param1:SecurityError) : void
		{
			trace("security error");
			trace(param1);
		}

		public function connect(param1:String) : void
		{
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			netConnection.connect(param1);
		}

		public function close() : void
		{
			netConnection.close();
		}
	}
}
