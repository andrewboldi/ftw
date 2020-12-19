package com.electrotank.electroserver4
{
	import com.electrotank.electroserver4.connection.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.protocol.binary.*;
	import com.electrotank.electroserver4.protocol.text.*;
	import com.electrotank.electroserver4.rtmpconnection.*;
	import com.electrotank.electroserver4.transaction.*;
	import com.electrotank.electroserver4.user.*;
	import com.electrotank.electroserver4.utils.*;
	import com.electrotank.electroserver4.zone.*;
	import flash.events.*;
	import flash.utils.*;

	public class ElectroServer extends Observable
	{
		private var protocol:String;
		private var connections:Array;
		private var as2ProtocolHandler:As2ProtocolHandler;
		private var transactionHandler:TransactionHandler;
		private var zoneManager:ZoneManager;
		private var userManager:UserManager;
		private var debug:Boolean;
		private var buddyList:Object;
		private var messageQueue:Array;
		private var history:Array;
		private var additionalLoginPassword:String;
		private var isConnected:Boolean;
		private var expectedInboundId:Number;
		private var isLoggedIn:Boolean;
		private var rtmpConnection:RtmpConnection;
		private var isSimulatingLatency:Boolean;
		private var simulatedLatency:Number;
		private var inboundLatencyQueue:Array;
		private var outboundLatencyQueue:Array;
		private var timerId:Number;
		private var latencyTimer:Timer;

		public function ElectroServer()
		{
			super();
			initialize();
		}

		public function addBuddy(param1:String, param2:EsObject) : void
		{
			var _loc_3:AddBuddyRequest = new AddBuddyRequest();
			_loc_3.setBuddyName(param1);
			_loc_3.setEsObject(param2);
			getBuddyList()[param1] = param2;
			send(_loc_3);
		}

		public function additionalLogin(param1:LoginRequest) : void
		{
			additionalLoginPassword = param1.getSharedSecret();
			send(param1);
		}

		public function close() : void
		{
			var _loc_2:AbstractConnection = null;
			if(getRtmpConnection() != null)
			{
				if(getRtmpConnection().getIsConnected())
				{
					getRtmpConnection().close();
				}
			}
			var _loc_1:Number = 0;
			while(_loc_1 < getConnections().length)
			{
				_loc_2 = getConnections()[_loc_1];
				_loc_2.close();
				_loc_1 = _loc_1 + 1;
			}
		}

		public function closeRtmpConnection() : void
		{
			rtmpConnection.close();
		}

		public function createConnection(param1:String, param2:Number) : Connection
		{
			var _loc_3:Connection = new Connection(param1, param2, getProtocol());
			_loc_3.setId(getConnections().length);
			_loc_3.addListener(this);
			_loc_3.connect();
			addConnection(_loc_3);
			return _loc_3;
		}

		public function createHttpConnection(param1:String, param2:Number) : HttpConnection
		{
			if(getProtocol() != Protocol.BINARY)
			{
				throw new Error("ElectroServer#getProtocol() must be Protocol.BINARY");
			}
			var _loc_3:HttpConnection = new HttpConnection(param1, param2, this);
			_loc_3.setId(getConnections().length);
			_loc_3.addListener(this);
			_loc_3.connect();
			addConnection(_loc_3);
			return _loc_3;
		}

		public function createRtmpConnection(param1:String, param2:Number) : RtmpConnection
		{
			rtmpConnection = new RtmpConnection(this);
			var _loc_3:String = escape(userManager.getMe().getUserName());
			additionalLoginPassword = (Math.round(1000000 * Math.random())).toString();
			var _loc_4:String = "rtmp://" + param1 + ":" + param2 + "/" + _loc_3 + "/" + additionalLoginPassword;
			rtmpConnection.connect(_loc_4);
			return this.rtmpConnection;
		}

		public function getBuddyList() : Object
		{
			return buddyList;
		}

		public function getConnections() : Array
		{
			return connections;
		}

		public function getDebug() : Boolean
		{
			return this.debug;
		}

		public function getIsLoggedIn() : Boolean
		{
			return isLoggedIn;
		}

		public function getRtmpConnection() : RtmpConnection
		{
			return rtmpConnection;
		}

		public function getUserManager() : UserManager
		{
			return userManager;
		}

		public function getZoneManager() : ZoneManager
		{
			return zoneManager;
		}

		public function handleError(param1:GenericErrorResponse) : void
		{
			Logger.log("Error occurred", Logger.info);
			var _loc_2:MessageType = param1.getRequestMessageType();
			Logger.log(_loc_2.getMessageTypeName(), Logger.info);
			Logger.log(param1.getErrorType().getDescription(), Logger.info);
		}

		public function handleLoginResponse(param1:LoginResponse) : void
		{
			var _loc_2:User = null;
			if(!isLoggedIn && param1.getAccepted())
			{
				isLoggedIn = true;
				_loc_2 = new User();
				_loc_2.setUserId(param1.getUserId());
				_loc_2.setUserName(param1.getUserName());
				_loc_2.setIsMe(true);
				_loc_2.setUserVariables(param1.getUserVariables());
				buddyList = param1.getBuddies();
				userManager.addUser(_loc_2);
				userManager.addReference(_loc_2);
				userManager.setMe(_loc_2);
			}
		}

		public function processCompositeMessages(param1:Array) : void
		{
			var _loc_3:Message = null;
			var _loc_4:MessageType = null;
			var _loc_2:Number = 0;
			while(_loc_2 < param1.length)
			{
				_loc_3 = Message(param1[_loc_2]);
				_loc_4 = _loc_3.getMessageType();
				transactionHandler.getTransaction(_loc_4).execute(_loc_3, this);
				_loc_2 = _loc_2 + 1;
			}
		}

		public function removeBuddy(param1:String) : void
		{
			var _loc_2:RemoveBuddyRequest = new RemoveBuddyRequest();
			_loc_2.setBuddyName(param1);
			getBuddyList()[param1] = null;
			send(_loc_2);
		}

		public function send(param1:Message) : SendStatus
		{
			var _loc_2:SendStatus = new SendStatus();
			if(!isSimulatingLatency)
			{
				_loc_2 = reallySend(param1);
			}
			else
			{
				addToOutboundLatencyQueue({time:getTimer(), message:param1});
			}
			return _loc_2;
		}

		private function addToOutboundLatencyQueue(param1:Object) : void
		{
			outboundLatencyQueue.push(param1);
		}

		private function reallySend(param1:Message) : SendStatus
		{
			var _loc_7:int = NaN;
			var _loc_8:String = null;
			var _loc_2:SendStatus = new SendStatus();
			if(!isConnected)
			{
				_loc_2.setIsSent(false);
				_loc_2.setReason(SendStatus.NOT_CONNECTED);
				return _loc_2;
			}
			var _loc_3:ValidationResponse = param1.validate();
			_loc_2.setValidationResponse(_loc_3);
			if(!_loc_3.getIsValid())
			{
				_loc_2.setIsSent(false);
				_loc_2.setReason(SendStatus.VALIDATION_FAILED);
				Logger.log("Request failed validation for these reasons:", Logger.info);
				_loc_7 = 0;
				while(_loc_7 < _loc_3.getProblems().length)
				{
					_loc_8 = _loc_3.getProblems()[_loc_7];
					Logger.log(_loc_8, Logger.info);
					_loc_7 = _loc_7 + 1;
				}
				return _loc_2;
			}
			while(!param1.getIsRealServerMessage())
			{
				param1 = param1.getRealMessage();
			}
			var _loc_4:AbstractConnection = getConnections()[getConnections().length - 1];
			if(param1.getMessageType().getMessageTypeId() == "&")
			{
				_loc_4 = getConnections()[0];
			}
			var _loc_5:MessageWriter = getMessageWriter();
			_loc_5.writeCharacter(param1.getMessageType().getMessageTypeId());
			var _loc_6:Number = _loc_4.getNextOutboundId();
			_loc_5.writeInteger(_loc_6, MessageConstants.MESSAGE_ID_SIZE);
			as2ProtocolHandler.getMessageCodec(param1.getMessageType()).encode(_loc_5, param1);
			Logger.log("--> Sending :: conId: " + _loc_4.getId(), Logger.info);
			Logger.log((param1.getMessageType().getMessageTypeName() + ": ") + _loc_5.getData(), Logger.info);
			storeMessage(_loc_6, param1);
			if(getProtocol() == Protocol.TEXT)
			{
				_loc_4.send(_loc_5.getData());
			}
			else
			{
				if(getProtocol() == Protocol.BINARY)
				{
					_loc_4.sendBinary(BinaryMessageWriter(_loc_5).getBuffer());
				}
			}
			_loc_2.setIsSent(true);
			return _loc_2;
		}

		public function setDebug(param1:Boolean) : void
		{
			this.debug = param1;
		}

		public function setProtocol(param1:String) : void
		{
			this.protocol = param1;
		}

		public function getProtocol() : String
		{
			return protocol;
		}

		public function onStringData(param1:Object) : void
		{
			if(!isSimulatingLatency)
			{
				processStringData(param1);
			}
			else
			{
				param1.protocol = Protocol.TEXT;
				addToInboundLatencyQueue(param1);
			}
		}

		private function processStringData(param1:Object) : void
		{
			var _loc_5:int = NaN;
			var _loc_2:AbstractConnection = AbstractConnection(param1.target);
			var _loc_3:MessageReader = getMessageReader();
			StringMessageReader(_loc_3).setMessage(param1.data);
			var _loc_4:String = _loc_3.nextCharacter();
			if(_loc_4 != "<")
			{
				_loc_5 = _loc_3.nextInteger(MessageConstants.MESSAGE_ID_SIZE);
				processMessage(_loc_3, _loc_4, _loc_5, _loc_2);
			}
		}

		public function startSimulatingLatency(param1:Number) : void
		{
			isSimulatingLatency = true;
			simulatedLatency = param1;
			latencyTimer = new Timer(30);
			latencyTimer.start();
			latencyTimer.addEventListener(TimerEvent.TIMER, checkLatencyQueueEvent);
		}

		public function stopSimulatingLatency() : void
		{
			isSimulatingLatency = false;
			if(latencyTimer != null)
			{
				latencyTimer.stop();
				latencyTimer.removeEventListener(TimerEvent.TIMER, checkLatencyQueueEvent);
				latencyTimer = null;
			}
			purgeLatencyQueue();
		}

		private function purgeLatencyQueue() : void
		{
			purgeOutboundLatencyQueue();
			purgeInboundLatencyQueue();
		}

		private function purgeInboundLatencyQueue() : void
		{
			var _loc_2:Object = null;
			var _loc_1:Number = 0;
			while(_loc_1 < inboundLatencyQueue.length)
			{
				_loc_2 = inboundLatencyQueue[_loc_1];
				if(_loc_2.protocol == Protocol.TEXT)
				{
					processStringData(_loc_2);
				}
				else
				{
					if(_loc_2.protocol == Protocol.BINARY)
					{
						processBinaryData(_loc_2);
					}
				}
				_loc_1 = _loc_1 + 1;
			}
			inboundLatencyQueue = new Array();
		}

		private function addToInboundLatencyQueue(param1:Object) : void
		{
			param1.time = getTimer();
			inboundLatencyQueue.push(param1);
		}

		private function checkLatencyQueueEvent(param1:TimerEvent) : void
		{
			checkLatencyQueue();
		}

		private function checkLatencyQueue() : void
		{
			checkInboundLatencyQueue();
			checkOutboundLatencyQueue();
		}

		private function checkInboundLatencyQueue() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:Object = null;
			if(inboundLatencyQueue.length > 0)
			{
				_loc_1 = getTimer();
				_loc_2 = 0;
				_loc_3 = inboundLatencyQueue[_loc_2];
				if(_loc_1 >= (_loc_3.time + simulatedLatency))
				{
					if(_loc_3.protocol == Protocol.TEXT)
					{
						processStringData(_loc_3);
					}
					else
					{
						if(_loc_3.protocol == Protocol.BINARY)
						{
							processBinaryData(_loc_3);
						}
					}
					inboundLatencyQueue.shift();
					checkLatencyQueue();
				}
			}
		}

		private function checkOutboundLatencyQueue() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:Object = null;
			if(outboundLatencyQueue.length > 0)
			{
				_loc_1 = getTimer();
				_loc_2 = 0;
				_loc_3 = outboundLatencyQueue[_loc_2];
				if(_loc_1 >= (_loc_3.time + simulatedLatency))
				{
					reallySend(_loc_3.message);
					outboundLatencyQueue.shift();
					checkOutboundLatencyQueue();
				}
			}
		}

		private function purgeOutboundLatencyQueue() : void
		{
			var _loc_1:Number = 0;
			while(_loc_1 < outboundLatencyQueue.length)
			{
				reallySend(outboundLatencyQueue[_loc_1].message);
				_loc_1 = _loc_1 + 1;
			}
			outboundLatencyQueue = new Array();
		}

		public function onBinaryData(param1:Object) : void
		{
			if(!isSimulatingLatency)
			{
				processBinaryData(param1);
			}
			else
			{
				param1.protocol = Protocol.BINARY;
				addToInboundLatencyQueue(param1);
			}
		}

		private function processBinaryData(param1:Object) : void
		{
			var _loc_2:AbstractConnection = AbstractConnection(param1.target);
			var _loc_3:MessageReader = getMessageReader();
			BinaryMessageReader(_loc_3).setBuffer(param1.data);
			var _loc_4:String = _loc_3.nextCharacter();
			var _loc_5:Number = _loc_3.nextInteger(MessageConstants.MESSAGE_ID_SIZE);
			processMessage(_loc_3, _loc_4, _loc_5, _loc_2);
		}

		private function processMessage(param1:MessageReader, param2:String, param3:Number, param4:AbstractConnection) : void
		{
			var _loc_6:Message = null;
			var _loc_7:QueuedMessage = null;
			var _loc_8:int = NaN;
			var _loc_5:MessageType = MessageType.findTypeById(param2);
			if(expectedInboundId == param3 || param3 == 0)
			{
				Logger.log("<-- Receiving :: conId: " + param4.getId(), Logger.info);
				Logger.log(_loc_5.getMessageTypeName(), Logger.info);
				_loc_6 = as2ProtocolHandler.getMessageCodec(_loc_5).decode(param1);
				_loc_6.setMessageId(param3);
				transactionHandler.getTransaction(_loc_5).execute(_loc_6, this);
				if(param4.getId() == 0)
				{
					expectedInboundId = param3 + 1;
				}
				else
				{
					if(param3 != 0)
					{
						var _loc_10:* = this.expectedInboundId + 1;
						this.expectedInboundId = _loc_10;
					}
				}
				checkQueue();
			}
			else
			{
				if(param3 == -1)
				{
					_loc_8 = expectedInboundId;
					processMessage(param1, param2, _loc_8, param4);
					expectedInboundId = _loc_8;
					return;
				}
				Logger.log("<-- Receiving [QUEUED] :: conId: " + param4.getId(), Logger.info);
				Logger.log(_loc_5.getMessageTypeName(), Logger.info);
				_loc_7 = new QueuedMessage(param1, param2, param3, param4);
				messageQueue.push(_loc_7);
				messageQueue.sortOn("messageId", Array.NUMERIC);
			}
		}

		private function checkQueue() : void
		{
			var _loc_1:QueuedMessage = null;
			if(messageQueue.length > 0)
			{
				_loc_1 = messageQueue[0];
				if(_loc_1.messageId == expectedInboundId)
				{
					messageQueue.shift();
					processMessage(_loc_1.getMessageReader(), _loc_1.getId(), _loc_1.messageId, _loc_1.getConnection());
				}
			}
		}

		private function getMessageWriter() : MessageWriter
		{
			var _loc_1:MessageWriter = null;
			switch(getProtocol())
			{
			case Protocol.TEXT:
				_loc_1 = new StringMessageWriter();
				break;
			case Protocol.BINARY:
				_loc_1 = new BinaryMessageWriter();
				break;
			default:
				throw new Error("Protocol not supported: " + getProtocol());
				break;
			}
			return _loc_1;
		}

		private function getMessageReader() : MessageReader
		{
			var _loc_1:MessageReader = null;
			switch(getProtocol())
			{
			case Protocol.TEXT:
				_loc_1 = new StringMessageReader();
				break;
			case Protocol.BINARY:
				_loc_1 = new BinaryMessageReader();
				break;
			default:
				throw new Error("Protocol not supported: " + getProtocol());
				break;
			}
			return _loc_1;
		}

		private function storeMessage(param1:Number, param2:Message) : void
		{
			var _loc_3:Object = new Object();
			_loc_3.outId = param1;
			_loc_3.message = param2;
			history.unshift(_loc_3);
			if(history.length > 10)
			{
				history.pop();
			}
		}

		private function getOldMessage(param1:Number) : Message
		{
			var _loc_2:Message = null;
			var _loc_4:Object = null;
			var _loc_3:Number = 0;
			while(_loc_3 < history.length)
			{
				_loc_4 = history[_loc_3];
				if(_loc_4.id == param1)
				{
					_loc_2 = _loc_4.message;
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}

		public function onConnect(param1:Object) : void
		{
			var _loc_2:AbstractConnection = null;
			var _loc_4:ConnectionEvent = null;
			isConnected = false;
			var _loc_3:Number = 0;
			while(_loc_3 < connections.length)
			{
				_loc_2 = connections[_loc_3];
				if(_loc_2.getIsConnected())
				{
					isConnected = true;
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
			if(param1.success)
			{
			}
			else
			{
				_loc_4 = new ConnectionEvent();
				_loc_4.setAccepted(false);
				_loc_4.setEsError(Errors.FailedToConnect);
				dispatchEvent(_loc_4);
			}
		}

		public function onClose(param1:Object) : void
		{
			var _loc_2:AbstractConnection = AbstractConnection(param1.target);
			Logger.log("--connection closed-- id: " + _loc_2.getId(), Logger.info);
			var _loc_3:ConnectionClosedEvent = new ConnectionClosedEvent();
			_loc_3.setConnection(_loc_2);
			dispatchEvent(_loc_3);
		}

		public function onLog(param1:Object) : void
		{
			var _loc_2:Object = param1.log;
			if(debug)
			{
				trace(_loc_2.message);
			}
		}

		private function initialize() : void
		{
			setProtocol(Protocol.TEXT);
			setDebug(false);
			expectedInboundId = 0;
			isConnected = false;
			Logger.init();
			Logger.getInstance().addEventListener(Logger.LOGGED, "onLog", this);
			history = new Array();
			connections = new Array();
			messageQueue = new Array();
			buddyList = new Object();
			as2ProtocolHandler = new As2ProtocolHandler();
			transactionHandler = new TransactionHandler();
			zoneManager = new ZoneManager();
			userManager = new UserManager();
			isSimulatingLatency = false;
			inboundLatencyQueue = new Array();
			outboundLatencyQueue = new Array();
			addEventListener(MessageType.ValidateAdditionalLoginRequest, "onValidateAdditionalLoginRequest", this);
		}

		public function onValidateAdditionalLoginRequest(param1:ValidateAdditionalLoginRequest) : void
		{
			var _loc_2:Boolean = param1.getSecret() == additionalLoginPassword;
			var _loc_3:ValidateAdditionalLoginResponse = new ValidateAdditionalLoginResponse();
			_loc_3.setApproved(_loc_2);
			_loc_3.setSecret(additionalLoginPassword);
			send(_loc_3);
		}

		private function addConnection(param1:AbstractConnection) : void
		{
			getConnections().push(param1);
		}
	}
}
package com.electrotank.electroserver4
{
	public class MessageConstants extends Object
	{
		public static var MESSAGE_HEADER_SIZE:Number = 1;
		public static var MESSAGE_ID_SIZE:Number = 4;
		public static var GATEWAY_ID_LENGTH:Number = 13;
		public static var GATEWAY_STATE_LENGTH:Number = 2;
		public static var USER_ID_LENGTH:Number = 13;
		public static var USER_NAME_PREFIX_LENGTH:Number = 2;
		public static var USER_COUNT_LENGTH:Number = 4;
		public static var FULL_USER_COUNT_LENGTH:Number = 6;
		public static var USER_VARIABLE_COUNT_LENGTH:Number = 2;
		public static var USER_VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var USER_VARIABLE_VALUE_PREFIX_LENGTH:Number = 4;
		public static var PASSWORD_PREFIX_LENGTH:Number = 2;
		public static var VIDEO_STREAM_NAME_PREFIX_LENGTH:Number = 2;
		public static var VARIABLE_COUNT_LENGTH:Number = 2;
		public static var VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var VARIABLE_VALUE_PREFIX_LENGTH:Number = 5;
		public static var ZONE_COUNT_LENGTH:Number = 5;
		public static var ZONE_ID_LENGTH:Number = 5;
		public static var ZONE_NAME_PREFIX_LENGTH:Number = 3;
		public static var UPDATE_ACTION_LENGTH:Number = 1;
		public static var ROOM_ID_LENGTH:Number = 5;
		public static var ROOM_NAME_PREFIX_LENGTH:Number = 3;
		public static var ROOM_COUNT_LENGTH:Number = 5;
		public static var ROOM_CAPACITY_LENGTH:Number = 3;
		public static var ROOM_PASSWORD_PREFIX_LENGTH:Number = 2;
		public static var ROOM_DESCRIPTION_PREFIX_LENGTH:Number = 3;
		public static var ROOM_EVICTION_REASON_PREFIX_LENGTH:Number = 3;
		public static var ROOM_BAN_DURATION_LENGTH:Number = 6;
		public static var ROOM_VARIABLE_COUNT_LENGTH:Number = 2;
		public static var ROOM_VARIABLE_NAME_PREFIX_LENGTH:Number = 2;
		public static var FILTER_NAME_PREFIX_LENGTH:Number = 2;
		public static var FILTER_FAILURES_BEFORE_KICK_LENGTH:Number = 2;
		public static var FILTER_KICKS_BEFORE_BAN_LENGTH:Number = 2;
		public static var FLOODING_FILTER_MAX_DUP_MESSAGES_LENGTH:Number = 2;
		public static var FLOODING_FILTER_WINDOW_DURATION_LENGTH:Number = 3;
		public static var FLOODING_FILTER_MAX_MESSAGE_IN_WINDOW_LENGTH:Number = 2;
		public static var PUBLIC_MESSAGE_PREFIX_LENGTH:Number = 4;
		public static var PRIVATE_MESSAGE_PREFIX_LENGTH:Number = 4;
		public static var MESSAGE_NUMBER_LENGTH:Number = 4;
		public static var REQUEST_ID_LENGTH:Number = 4;
		public static var ERROR_ID_LENGTH:Number = 3;
		public static var DEFAULT_LONG_LENGTH:Number = 64;
		public static var DEFAULT_DOUBLE_LENGTH:Number = 64;
		public static var PASSPHRASE_PREFIX_LENGTH:Number = 4;
		public static var ZONE_AND_ROOM_ID_LIST_LENGTH:Number = 2;
		public static var SHARED_SECRET_LENGTH:Number = 2;
		public static var PLUGIN_COUNT_LENGTH:Number = 2;
		public static var EXTENSION_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_HANDLE_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_PARM_COUNT_LENGTH:Number = 2;
		public static var PLUGIN_PARM_NAME_PREFIX_LENGTH:Number = 2;
		public static var PLUGIN_PARM_VALUE_PREFIX_LENGTH:Number = 4;
		public static var PROTOCOL_COUNT_LENGTH:Number = 3;
		public static var PROTOCOL_HOST_PREFIX_LENGTH:Number = 2;
		public static var PROTOCOL_PORT_LENGTH:Number = 5;
		public static var PROTOCOL_LENGTH:Number = 2;
		public static var CUSTOM_POLICY_FILE_CONTENTS_PREFIX_LENGTH:Number = 4;
		public static var COMPOSITE_ESOBJECT_ARRAY_PREFIX_LENGTH:Number = 2;
		public static var HASH_ID_LENGTH:Number = 11;

		public function MessageConstants()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4
{
	import com.electrotank.electroserver4.message.*;

	public class SendStatus extends Object
	{
		public static var NOT_CONNECTED:String = "not_connected";
		public static var VALIDATION_FAILED:String = "validation_failed";
		private var isSent:Boolean;
		private var reason:String;
		private var validationResponse:ValidationResponse;

		public function SendStatus()
		{
			super();
		}

		public function setValidationResponse(param1:ValidationResponse) : void
		{
			this.validationResponse = param1;
		}

		public function getValidationResponse() : ValidationResponse
		{
			return this.validationResponse;
		}

		public function setIsSent(param1:Boolean) : void
		{
			this.isSent = param1;
		}

		public function getIsSent() : Boolean
		{
			return isSent;
		}

		public function setReason(param1:String) : void
		{
			this.reason = param1;
		}

		public function getReason() : String
		{
			return reason;
		}
	}
}
