package com.electrotank.electroserver4.message
{
	import com.electrotank.electroserver4.connection.*;
	import com.electrotank.electroserver4.protocol.*;

	public class QueuedMessage extends Object
	{
		private var messageReader:MessageReader;
		private var _messageId:Number;
		private var id:String;
		private var connection:AbstractConnection;

		public function QueuedMessage(param1:MessageReader, param2:String, param3:Number, param4:AbstractConnection)
		{
			super();
			this.messageReader = param1;
			this.id = param2;
			this._messageId = param3;
			this.connection = param4;
		}

		public function getConnection() : AbstractConnection
		{
			return connection;
		}

		public function getMessageReader() : MessageReader
		{
			return messageReader;
		}

		public function get messageId() : Number
		{
			return _messageId;
		}

		public function getId() : String
		{
			return id;
		}
	}
}
