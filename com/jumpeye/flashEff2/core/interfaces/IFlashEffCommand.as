package com.jumpeye.flashEff2.core.interfaces
{
	import flash.display.*;

	public class IFlashEffCommand extends IFlashEffPattern
	{
		protected var _target:DisplayObject;
		private var _commandEventType:String;

		public function IFlashEffCommand()
		{
			super();
		}

		public function get target() : DisplayObject
		{
			return _target;
		}

		public function set target(param1:DisplayObject) : void
		{
			_target = param1;
		}

		public function get commandEventType() : String
		{
			return this._commandEventType;
		}

		public function set commandEventType(param1:String) : void
		{
			_commandEventType = param1;
		}

		public function run() : void
		{
		}
	}
}
