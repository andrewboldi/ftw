package com.adobe.serialization.json
{
	public class JSON extends Object
	{
		final public static function encode(param1:Object) : String
		{
			var _loc_2:JSONEncoder = new JSONEncoder(param1);
			return _loc_2.getString();
		}

		final public static function decode(param1:String)
		{
			var _loc_2:JSONDecoder = new JSONDecoder(param1);
			return _loc_2.getValue();
		}

		public function JSON()
		{
			super();
		}
	}
}
