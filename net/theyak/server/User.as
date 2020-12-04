package net.theyak.server
{
	public class User extends Object
	{
		public var name:String;
		public var isMe:Boolean;
		public var isSendingVideo:Boolean;
		public var isSendingAudio:Boolean;
		public var videoStreamName:String;
		public var audioStreamName:String;
		private var variables:Array;

		public function User(param1:String)
		{
			super();
			variables = new Array();
			this.name = param1;
			this.isSendingVideo = false;
			this.isSendingAudio = false;
		}

		public function setVariable(param1:String, param2:String) : void
		{
			var _loc_3:uint = 0;
			while(_loc_3 < variables.length)
			{
				if(variables[_loc_3].name == param1)
				{
					variables[_loc_3].value = param2;
					return;
				}
				_loc_3 = _loc_3 + 1;
			}
			var _loc_4:Object = new Object();
			_loc_4.name = param1;
			_loc_4.value = param2;
			variables.push(_loc_4);
		}

		public function getVariable(param1:String) : String
		{
			var _loc_2:uint = 0;
			while(_loc_2 < variables.length)
			{
				if(variables[_loc_2].name == param1)
				{
					return variables[_loc_2].value;
				}
				_loc_2 = _loc_2 + 1;
			}
			return null;
		}

		public function variableExists(param1:String) : Boolean
		{
			return !(getVariable(param1) == null);
		}

		public function toString() : String
		{
			var _loc_1:String = "";
			_loc_1 = _loc_1 + "Name: " + name + "\n";
			_loc_1 = _loc_1 + "isMe: " + isMe + "\n";
			_loc_1 = _loc_1 + "isSendingVideo: " + isSendingVideo + "\n";
			_loc_1 = _loc_1 + "isSendingAudio: " + isSendingAudio + "\n";
			_loc_1 = _loc_1 + "videoStreamName: " + videoStreamName + "\n";
			_loc_1 = _loc_1 + "audioStreamName: " + audioStreamName + "\n";
			_loc_1 = _loc_1 + "Variables:\n";
			var _loc_2:uint = 0;
			while(_loc_2 < variables.length)
			{
				_loc_1 = _loc_1 + "        " + variables[_loc_2].name + ": " + variables[_loc_2].value;
				_loc_2 = _loc_2 + 1;
			}
			return _loc_1;
		}
	}
}
