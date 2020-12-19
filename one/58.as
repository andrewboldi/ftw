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
package net.theyak.net
{
	import flash.events.*;
	import flash.net.*;

	public class XMLLoader extends Object
	{
		private var file:String;
		private var xmlLoader:URLLoader;
		private var options:Object;

		public function XMLLoader(param1:String, param2:Function, param3:Object = null)
		{
			super();
			this.file = param1;
			if(param3 == null)
			{
				param3 = new Object();
			}
			param3.success = param2;
			this.options = param3;
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onComplete);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			xmlLoader.load(new URLRequest(param1));
		}

		private function onComplete(param1:Event) : void
		{
			removeListeners();
			XML.ignoreWhitespace = true;
			options.success(new XML(param1.target.data));
		}

		private function ioError(param1:IOErrorEvent) : void
		{
			removeListeners();
			trace("Error loading XML file. " + param1.toString());
			if(!(options.ioError == undefined) && options.ioError is Function)
			{
				options.ioError(param1);
			}
		}

		private function securityError(param1:SecurityErrorEvent) : void
		{
			removeListeners();
			trace("Security error loading XML file. " + param1.toString());
			if(!(options.securityError == undefined) && options.securityError is Function)
			{
				options.securityError(param1);
			}
		}

		private function removeListeners() : void
		{
			xmlLoader.removeEventListener(Event.COMPLETE, onComplete);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, options.ioError);
			xmlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, options.securityError);
		}
	}
}
