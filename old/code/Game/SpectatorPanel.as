package Game
{
	import fl.containers.*;
	import flash.display.*;

	public class SpectatorPanel extends Sprite
	{
		public var _sp_problem:ScrollPane;
		private var problem_number:uint;

		public function SpectatorPanel(param1:Boolean = false)
		{
			super();
			__setProp__sp_problem_SpectatorPanel_Layer1_0();
		}

		public function attach(param1:Problem) : void
		{
			problem_number = param1.number;
			clear();
			var _loc_2:Sprite = new Sprite();
			_loc_2.graphics.beginFill(16777215);
			_loc_2.graphics.drawRect(0, 0, param1.image.width + 10, param1.image.height + 10);
			_loc_2.visible = false;
			param1.image.x = 5;
			param1.image.y = 5;
			var _loc_3:Sprite = Sprite(_sp_problem.content);
			_loc_3.addChild(_loc_2);
			_loc_3.addChild(param1.image);
			_sp_problem.update();
		}

		public function clear() : void
		{
			while(Sprite(_sp_problem.content).numChildren)
			{
				Sprite(_sp_problem.content).removeChildAt(0);
			}
		}

		public function show() : void
		{
			this.visible = true;
		}

		public function hide() : void
		{
			this.visible = false;
		}

		public function __setProp__sp_problem_SpectatorPanel_Layer1_0()
		{
			try
			{
				_sp_problem["componentInspectorSetting"] = true;
			}
			catch(e:Error)
			{
			}
			_sp_problem.enabled = true;
			_sp_problem.horizontalLineScrollSize = 4;
			_sp_problem.horizontalPageScrollSize = 0;
			_sp_problem.horizontalScrollPolicy = "auto";
			_sp_problem.scrollDrag = false;
			_sp_problem.source = "EmptyClip";
			_sp_problem.verticalLineScrollSize = 4;
			_sp_problem.verticalPageScrollSize = 0;
			_sp_problem.verticalScrollPolicy = "auto";
			_sp_problem.visible = true;
			try
			{
				_sp_problem["componentInspectorSetting"] = false;
			}
			catch(e:Error)
			{
			}
		}
	}
}
