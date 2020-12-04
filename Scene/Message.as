package Scene
{
	import flash.display.*;
	import flash.text.*;

	public class Message extends Sprite
	{
		public var _tText:TextField;

		public function Message(param1:String = null)
		{
			super();
			if(param1 != null)
			{
				this.message = param1;
			}
		}

		public function set message(param1:String) : void
		{
			_tText.text = param1;
		}
	}
}
