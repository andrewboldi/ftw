package com.electrotank.electroserver4.plugin
{
	import com.electrotank.electroserver4.esobject.*;

	public class Plugin extends Object
	{
		private var data:EsObject;
		private var extensionName:String;
		private var pluginName:String;
		private var pluginHandle:String;

		public function Plugin()
		{
			super();
			data = new EsObject();
		}

		public function setExtensionName(param1:String) : void
		{
			this.extensionName = param1;
		}

		public function getExtensionName() : String
		{
			return extensionName;
		}

		public function setPluginName(param1:String) : void
		{
			this.pluginName = param1;
		}

		public function getPluginName() : String
		{
			return pluginName;
		}

		public function setPluginHandle(param1:String) : void
		{
			this.pluginHandle = param1;
		}

		public function getPluginHandle() : String
		{
			return pluginHandle;
		}

		public function getData() : EsObject
		{
			return data;
		}
	}
}
