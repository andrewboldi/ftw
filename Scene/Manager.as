package Scene
{
	import Game.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;

	public class Manager extends Object
	{
		private var stage:Sprite;
		private var ldr:Loader;
		private var debugPanel:DebugPanel;
		public var activeScene:String = "";
		public var isReceivingPluginMessages:Boolean = false;

		public function Manager(param1:Sprite)
		{
			super();
			this.stage = param1;
			while(param1.numChildren > 0)
			{
				param1.removeChildAt(0);
			}
			param1.addChild(new Background());
			param1.addChild(new Background());
			debugPanel = new DebugPanel();
			debugPanel.y = 540;
			debugPanel.visible = false;
			param1.addChild(debugPanel);
		}

		public function loader()
		{
			activeScene = "Loader";
			remove();
			var _loc_1:DisplayObject = stage.addChildAt(new LoadAndLogin(), 1);
			_loc_1.visible = true;
		}

		public function message(param1:String) : void
		{
			activeScene = "Message";
			remove();
			stage.addChildAt(new Message(param1), 1);
		}

		public function lobby()
		{
			activeScene = "Lobby";
			remove();
			stage.addChildAt(new Lobby(), 1);
		}

		public function ftw()
		{
			activeScene = "FTW";
			remove();
			stage.addChildAt(new FTW(), 1);
		}

		public function countdown()
		{
			activeScene = "Countdown";
			remove();
			stage.addChildAt(new Countdown(), 1);
		}

		public function race()
		{
			activeScene = "Race";
			remove();
		}

		public function reconnect()
		{
			activeScene = "Reconnect";
			remove();
			stage.addChildAt(new Reconnect(), 1);
		}

		public function reconnect2() : void
		{
			activeScene = "Reconnect";
			remove();
			stage.addChildAt(new Reconnect2(), 1);
		}

		public function set background(param1:String) : void
		{
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			var _loc_2:URLRequest = new URLRequest(param1);
			ldr.load(_loc_2);
		}

		private function backgroundDisplay(param1:Event) : void
		{
			ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			ldr.width = this.stage.width;
			ldr.height = this.stage.height;
			this.stage.removeChildAt(0);
			this.stage.addChildAt(ldr, 0);
		}

		private function backgroundError(param1:Event) : void
		{
			ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, backgroundDisplay);
			ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, backgroundError);
			debug("Unable to load background");
		}

		private function remove() : void
		{
			if(stage.numChildren > 1)
			{
				stage.removeChildAt(1);
			}
		}

		public function getScene() : Sprite
		{
			return Sprite(stage.getChildAt(1));
		}

		public function debug(param1:String, param2:String = null) : void
		{
			var _loc_3:Date = null;
			var _loc_4:String = null;
			if(debugPanel != null)
			{
				_loc_3 = new Date();
				_loc_4 = "[" + _loc_3.toString() + "] ";
				if(param2 == null)
				{
					debugPanel._text.htmlText = debugPanel._text.htmlText + (_loc_4 + param1) + "\n";
				}
				else
				{
					debugPanel._text.htmlText = debugPanel._text.htmlText + (_loc_4 + "<font color=\"") + param2 + "\">" + param1 + "</font>\n";
				}
				debugPanel._text.verticalScrollPosition = debugPanel._text.maxVerticalScrollPosition;
				debugPanel._text.invalidate();
			}
			else
			{
				trace("Debug panel is null: " + param1);
			}
		}
	}
}
