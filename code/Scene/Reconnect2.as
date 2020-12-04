package Scene
{
	import Misc.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class Reconnect2 extends Sprite
	{
		public var _bReconnect:Button;
		public var _tText:TextField;
		private var _interval:uint;

		public function Reconnect2()
		{
			super();
			_tText.text = "Lost connection to server - trying to reconnect";
			_interval = setInterval(failedConnect, 5000);
			g.server.reset();
			g.server.addEventListener("connection", "reconnection", this);
			g.server.addEventListener("reconnection", "reconnection", this);
			g.server.connect();
			_bReconnect.visible = false;
			_bReconnect.label = "Try to Reconnect";
		}

		public function reconnection(param1:Object) : void
		{
			g.scene.debug("reconnection");
			if(_interval)
			{
				clearInterval(_interval);
				_interval = 0;
			}
			g.server.removeEventListener("reconnection", "reconnection", this);
			g.server.removeEventListener("connection", "reconnection", this);
			if(param1.connected)
			{
				g.server.addEventListener("login", "loginResponse", this);
				_tText.text = "Connected. Logging in...";
				g.server.login(g.user.name, g.user.token);
			}
			else
			{
				_tText.text = "The server has gone down.";
				_bReconnect.visible = true;
				_bReconnect.addEventListener(MouseEvent.CLICK, attemptConnection);
			}
		}

		public function failedConnect() : void
		{
			g.scene.debug("failedConnect");
			reconnection({connected:false});
		}

		public function loginResponse(param1:Object)
		{
			g.scene.debug("login response");
			g.server.removeEventListener("login", "loginResponse", this);
			g.server.setUserVariable("rating", String(g.user.current_rating));
			g.server.setUserVariable("away", "false");
			g.scene.lobby();
		}

		private function attemptConnection(param1:MouseEvent) : void
		{
			g.scene.debug("attemptConnection");
			_bReconnect.removeEventListener(MouseEvent.CLICK, attemptConnection);
			g.server.addEventListener("reconnection", "reconnection", this);
			g.server.addEventListener("connection", "reconnection", this);
			g.server.reset();
			g.server.connect();
		}
	}
}
