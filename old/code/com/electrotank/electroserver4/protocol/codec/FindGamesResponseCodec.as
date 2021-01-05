package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindGamesResponseCodec extends MessageCodecImpl
	{
		public function FindGamesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:int = NaN;
			var _loc_8:Boolean = false;
			var _loc_9:Boolean = false;
			var _loc_10:EsObject = null;
			var _loc_11:ServerGame = null;
			var _loc_2:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_3:FindGamesResponse = new FindGamesResponse();
			var _loc_4:Number = param1.nextInteger();
			var _loc_5:Array = new Array();
			_loc_3.setGames(_loc_5);
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_4)
			{
				_loc_7 = param1.nextInteger();
				_loc_8 = param1.nextBoolean();
				_loc_9 = param1.nextBoolean();
				_loc_10 = null;
				if(param1.nextBoolean())
				{
					_loc_10 = EsObjectCodec.decode(param1);
				}
				_loc_11 = new ServerGame();
				_loc_11.setGameId(_loc_7);
				_loc_11.setLocked(_loc_8);
				_loc_11.setPasswordProtected(_loc_9);
				_loc_11.setGameDetails(_loc_10);
				_loc_5.push(_loc_11);
				_loc_6 = _loc_6 + 1;
			}
			return _loc_3;
		}
	}
}
