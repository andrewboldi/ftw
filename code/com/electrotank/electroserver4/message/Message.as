package com.electrotank.electroserver4.message
{
	public interface Message
	{
		function getMessageId() : Number;

		function setMessageId(param1:Number) : void;

		function setMessageType(param1:MessageType) : void;

		function getMessageType() : MessageType;

		function validate() : ValidationResponse;

		function getIsRealServerMessage() : Boolean;

		function getRealMessage() : Message;
	}
}
