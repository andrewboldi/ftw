package Game
{
	import Misc.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class TimerPanel extends Sprite
	{
		public var _message:TextField;
		public var _time:TextField;
		private var _seconds:uint;
		private var _start_time:uint;

		public function TimerPanel()
		{
			super();
		}

		public function Timer()
		{
			EventManager.add(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function start(param1:uint = 0) : void
		{
			if(param1 > 0)
			{
				this._seconds = param1;
				this._start_time = getTimer();
			}
			EventManager.add(this, Event.ENTER_FRAME, update_time);
		}

		public function stop() : void
		{
			remove_events();
		}

		public function update_time(param1:Event)
		{
			var _loc_3:TimerEvent = null;
			var _loc_2:int = this._seconds - (int((getTimer() - this._start_time) / 1000));
			_time.text = String(_loc_2);
			if(_loc_2 <= 0)
			{
				remove_events();
				_loc_3 = new TimerEvent(TimerEvent.TIMER_COMPLETE);
				dispatchEvent(_loc_3);
			}
		}

		public function set message(param1:String) : void
		{
			_message.text = param1;
		}

		public function show()
		{
			this.visible = true;
		}

		public function hide()
		{
			this.visible = false;
			remove_events();
		}

		public function remove_events()
		{
			EventManager.remove(this, Event.ENTER_FRAME, update_time);
			EventManager.remove(this, Event.REMOVED_FROM_STAGE, on_removed_from_stage);
		}

		public function on_removed_from_stage()
		{
			remove_events();
		}
	}
}
