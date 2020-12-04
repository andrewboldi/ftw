package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;

	public class SearchCriteriaCodec extends MessageCodecImpl
	{
		final public static function encode(param1:MessageWriter, param2:SearchCriteria) : void
		{
			var _loc_3:EsObject = null;
			if(param2 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				if(param2.getGameId() == -1)
				{
					param1.writeBoolean(false);
				}
				else
				{
					param1.writeBoolean(true);
					param1.writeInteger(param2.getGameId());
				}
				param1.writeString(param2.getGameType());
				param1.writeBoolean(param2.getLockedSet());
				if(param2.getLockedSet())
				{
					param1.writeBoolean(param2.getLocked());
				}
				_loc_3 = param2.getGameDetails();
				if(_loc_3 == null)
				{
					param1.writeBoolean(false);
				}
				else
				{
					param1.writeBoolean(true);
					EsObjectCodec.encode(param1, _loc_3);
				}
			}
		}

		public function SearchCriteriaCodec()
		{
			super();
		}
	}
}
