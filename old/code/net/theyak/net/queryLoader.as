package net.theyak.net
{
	import flash.events.*;
	import flash.net.*;

	public class queryLoader extends Object
	{
		private var file:String;
		private var loader:URLLoader;
		private var options:Object;

		public function queryLoader(param1:String, param2:Function, param3:Object = null)
		{
			super();
			this.file = param1;
			if(param3 == null)
			{
				param3 = new Object();
			}
			param3.success = param2;
			this.options = param3;
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			loader.load(new URLRequest(param1));
		}

		private function onComplete(param1:Event) : void
		{
			var _loc_2:URLLoader = URLLoader(param1.target);
			options.success(_loc_2.data);
		}

		private function ioError(param1:IOErrorEvent) : void
		{
			removeListeners();
			trace("Error loading XML " + file);
			if(!(options.ioError == undefined) && options.ioError is Function)
			{
				options.ioError(param1);
			}
		}

		private function securityError(param1:SecurityErrorEvent) : void
		{
			removeListeners();
			trace("Security error loading XML " + file);
			if(!(options.securityError == undefined) && options.securityError is Function)
			{
				options.securityError(param1);
			}
		}

		private function removeListeners() : void
		{
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, options.ioError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, options.securityError);
		}
	}
}
