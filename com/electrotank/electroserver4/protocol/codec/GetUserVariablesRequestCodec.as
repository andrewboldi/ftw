package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserVariablesRequestCodec extends MessageCodecImpl
	{
		public function GetUserVariablesRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetUserVariablesRequest = GetUserVariablesRequest(param2);
			param1.writeString(_loc_3.getUserName());
			var _loc_4:Array = _loc_3.getUserVariableNames();
			trace(param1);
			param1.writeInteger(_loc_4.length);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4.length)
			{
				param1.writeString(_loc_4[_loc_5]);
				_loc_5 = _loc_5 + 1;
			}
		}
	}
}
