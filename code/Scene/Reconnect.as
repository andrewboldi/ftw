package Scene
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;

	public class Reconnect extends Sprite
	{
		public var _bReconnect:Button;

		public function Reconnect()
		{
			super();
			_bReconnect.addEventListener(MouseEvent.CLICK, attemptConnection);
			__setProp__bReconnect_Reconnect_Layer1_0();
		}

		private function attemptConnection(param1:MouseEvent) : void
		{
			_bReconnect.removeEventListener(MouseEvent.CLICK, attemptConnection);
			g.server.reset();
			g.server.connect();
		}

		public function __setProp__bReconnect_Reconnect_Layer1_0()
		{
			try
			{
				_bReconnect["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_bReconnect.emphasized = false;
			_bReconnect.enabled = true;
			_bReconnect.label = "Try to Reconnect";
			_bReconnect.labelPlacement = "right";
			_bReconnect.selected = false;
			_bReconnect.toggle = false;
			_bReconnect.visible = true;
			try
			{
				_bReconnect["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
