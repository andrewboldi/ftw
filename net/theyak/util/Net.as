package net.theyak.util
{
	import flash.net.*;

	public class Net extends Object
	{
		final public static function callServer(param1:String) : void
		{
			var url:String = param1;
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			try
			{
				loader.load(request);
			}
			catch(error:SecurityError)
			{
			}
		}

		final public static function getURL(param1:String, param2:String = null) : void
		{
			var url:String = param1;
			var window:String = param2;
			var req:URLRequest = new URLRequest(url);
			try
			{
				Net.navigateToURL(req, window);
			}
			catch(e:Error)
			{
				Net.trace("Navigate to URL failed", e.message);
			}
		}

		public function Net()
		{
			super();
		}
	}
}
