package net.theyak.net
{
	import com.adobe.serialization.json.*;
	import flash.events.*;
	import flash.net.*;

	public class JSONLoader extends Object
	{
		private var file:String;
		private var jsonLoader:URLLoader;
		private var options:Object;

		public function JSONLoader(param1:String, param2:Function, param3:Object = null)
		{
			super();
			this.file = param1;
			if(param3 == null)
			{
				param3 = new Object();
			}
			param3.success = param2;
			this.options = param3;
			jsonLoader = new URLLoader();
			jsonLoader.addEventListener(Event.COMPLETE, onComplete);
			jsonLoader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			jsonLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			jsonLoader.load(new URLRequest(param1));
		}

		private function onComplete(param1:Event) : void
		{
			removeListeners();
			options.success((new JSONDecoder(param1.target.data)).getValue());
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
			jsonLoader.removeEventListener(Event.COMPLETE, onComplete);
			jsonLoader.removeEventListener(IOErrorEvent.IO_ERROR, options.ioError);
			jsonLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, options.securityError);
		}
	}
}
