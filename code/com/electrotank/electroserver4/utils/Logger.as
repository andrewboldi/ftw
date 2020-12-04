package com.electrotank.electroserver4.utils
{
	public class Logger extends Dispatcher
	{
		public static var LOGGED:String = "logged";
		private static var _instance:Logger;
		public static var info:Number = 4;
		public static var debug:Number = 2;
		public static var severe:Number = 1;
		private static var levelNames:Array = [null, "[SEVERE]", "[DEBUG]", null, "[INFO]"];
		public static var LogLevel:Number = info;

		final public static function log(param1:String, param2:Number) : void
		{
			if(param2 > LogLevel)
			{
				return;
			}
			var _loc_3:String = "   ";
			param1 = (levelNames[param2] + " ") + param1;
			var _loc_4:Object = {message:param1, level:param2};
			var _loc_5:Object = {target:_instance, log:_loc_4, type:LOGGED};
			_instance.dispatchEvent(_loc_5);
		}

		final public static function init() : void
		{
			_instance = new Logger();
		}

		final public static function getInstance() : Logger
		{
			return _instance;
		}

		public function Logger()
		{
			super();
		}
	}
}
