package com.electrotank.electroserver4.message
{
	public class MessageImpl extends Object implements Message
	{
		private var messageId:Number;
		private var messageType:MessageType;
		private var isRealServerMessage:Boolean = true;
		public var type:String;
		public var target:Object;

		public function MessageImpl()
		{
			super();
		}

		public function getIsRealServerMessage() : Boolean
		{
			return isRealServerMessage;
		}

		public function setIsRealServerMessage(param1:Boolean) : void
		{
			this.isRealServerMessage = param1;
		}

		public function getRealMessage() : Message
		{
			var _loc_1:Message = null;
			return _loc_1;
		}

		public function getMessageId() : Number
		{
			return messageId;
		}

		public function setMessageId(param1:Number) : void
		{
			messageId = param1;
		}

		public function setMessageType(param1:MessageType) : void
		{
			messageType = param1;
			type = messageType.getMessageTypeName();
		}

		public function getMessageType() : MessageType
		{
			return messageType;
		}

		public function validate() : ValidationResponse
		{
			return new ValidationResponse(true, new Array());
		}
	}
}
