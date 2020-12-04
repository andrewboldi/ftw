package Game
{
	import flash.display.*;
	import flash.text.*;

	public class InformationPanel extends Sprite
	{
		public var _t_large:TextField;
		public var _t_small:TextField;

		public function InformationPanel()
		{
			super();
		}

		public function Information()
		{
		}

		public function set small(param1:String) : void
		{
			_t_small.text = param1;
		}

		public function set large(param1:String) : void
		{
			_t_large.text = param1;
		}

		public function show()
		{
			this.visible = true;
		}

		public function hide()
		{
			this.large = "";
			this.small = "";
			this.visible = false;
		}
	}
}
