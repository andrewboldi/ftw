package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class LoginRequest extends RequestImpl
	{
		private var userName:String;
		private var password:String;
		private var pairs:Array;
		private var userVariables:Array;
		private var sharedSecret:String;
		private var isAutoDiscoverProtocol:Boolean;
		private var protocols:Array;
		private var esObject:EsObject;
		private var isAdditionalLoginRequest:Boolean;

		public function LoginRequest()
		{
			super();
			setMessageType(MessageType.LoginRequest);
			isAdditionalLoginRequest = false;
			pairs = new Array();
			protocols = new Array();
			userVariables = new Array();
			setIsAutoDiscoverProtocol(true);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if((isAdditionalLoginRequest && userName == null) && userName == "")
			{
				_loc_2.push("Additional login request requires a null UserName");
			}
			if(_loc_2.length > 0)
			{
				_loc_1 = false;
			}
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setSharedSecret(param1:String) : void
		{
			this.sharedSecret = param1;
			setMessageType(MessageType.AdditionalLoginRequest);
			isAdditionalLoginRequest = true;
		}

		public function getSharedSecret() : String
		{
			return sharedSecret;
		}

		public function setEsObject(param1:EsObject) : void
		{
			this.esObject = param1;
		}

		public function getEsObject() : EsObject
		{
			return esObject;
		}

		public function setProtocols(param1:Array) : void
		{
			this.protocols = param1;
		}

		public function getProtocols() : Array
		{
			return this.protocols;
		}

		public function setIsAutoDiscoverProtocol(param1:Boolean) : void
		{
			this.isAutoDiscoverProtocol = param1;
		}

		public function getIsAutoDiscoverProtocol() : Boolean
		{
			return isAutoDiscoverProtocol;
		}

		public function getUserVariables() : Array
		{
			return userVariables;
		}

		public function addUserVariable(param1:String, param2:EsObject) : void
		{
			var _loc_3:EsObjectMap = new EsObjectMap(param1, param2);
			getUserVariables().push(_loc_3);
		}

		public function setUserVariables(param1:Array) : void
		{
			userVariables = param1;
		}

		public function setUserName(param1:String) : void
		{
			this.userName = param1;
		}

		public function getUserName() : String
		{
			return userName;
		}

		public function setPassword(param1:String) : void
		{
			this.password = param1;
		}

		public function getPassword() : String
		{
			return password;
		}
	}
}
