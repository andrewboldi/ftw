package 
{
	import Misc.*;
	import Scene.*;
	import flash.display.*;
	import flash.events.*;

	public class Main extends MovieClip
	{
		public function Main()
		{
			super();
			new g(this);
			addEventListener("connected", connected, true);
			g.scene = new Manager(this);
			g.scene.loader();
			this.stage.addEventListener(Event.ACTIVATE, on_activate);
		}

		private function connected(param1:Event) : void
		{
			removeEventListener("connected", connected, true);
			g.scene.lobby();
		}

		private function on_activate(param1:Event)
		{
			if(g.scene.activeScene == "Lobby")
			{
				BaseChat(g.scene.getScene())._tInput.setFocus();
			}
		}
	}
}
