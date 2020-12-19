package com.jumpeye.core
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	dynamic public class JUIComponent extends Sprite
	{
		public static var inCallLaterPhase:Boolean = false;
		protected var callLaterMethods:Dictionary;
		protected var invalidateFlag:Boolean = false;
		protected var _inspector:Boolean = false;
		protected var invalidHash:Object;
		protected var isLivePreview:Boolean = false;
		public var version:String = "3.0.0.15";

		public function JUIComponent()
		{
			version = "3.0.0.15";
			invalidateFlag = false;
			_inspector = false;
			isLivePreview = false;
			super();
			invalidHash = {};
			callLaterMethods = new Dictionary();
			configUI();
			invalidate("all");
		}

		protected function checkLivePreview() : Boolean
		{
			var className:String = null;
			if(parent == null)
			{
				return false;
			}
			try
			{
				className = getQualifiedClassName(parent);
			}
			catch(e:Error)
			{
			}
			return className == "fl.livepreview::LivePreviewParent";
		}

		private function callLaterDispatcher(param1:Event) : void
		{
			var _loc_2:Dictionary = null;
			var _loc_3:Object = null;
			if(param1.type == Event.ADDED_TO_STAGE)
			{
				removeEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher);
				stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
				return;
			}
			param1.target.removeEventListener(Event.RENDER, callLaterDispatcher);
			if(stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
				return;
			}
			inCallLaterPhase = true;
			_loc_2 = callLaterMethods;
			var _loc_4:int = 0;
			var _loc_5:* = _loc_2;
			for each(_loc_3 in _loc_5)
			{
				_loc_3();
			}
			inCallLaterPhase = false;
		}

		protected function validate() : void
		{
			invalidHash = {};
		}

		public function invalidate(param1:String = "all", param2:Boolean = true) : void
		{
			invalidHash[param1] = true;
			if(param2)
			{
				callLater(draw);
			}
		}

		protected function draw() : void
		{
			validate();
		}

		protected function configUI() : void
		{
			isLivePreview = checkLivePreview();
			if(numChildren > 0)
			{
				removeChildAt(0);
			}
		}

		protected function isInvalid(param1:String, ...restArguments) : Boolean
		{
			invalidHash[param1];
			if(invalidHash[param1] || invalidHash["all"])
			{
				return true;
			}
			while(restArguments.length > 0)
			{
				if(invalidHash[restArguments.pop()])
				{
					return true;
				}
			}
			return false;
		}

		protected function callLater(param1:Function) : void
		{
			if(inCallLaterPhase)
			{
				return;
			}
			callLaterMethods[param1] = true;
			if(stage != null)
			{
				stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
			}
		}

		public function validateNow() : void
		{
			invalidate("all", false);
			draw();
		}

		public function drawNow() : void
		{
			draw();
		}
	}
}
