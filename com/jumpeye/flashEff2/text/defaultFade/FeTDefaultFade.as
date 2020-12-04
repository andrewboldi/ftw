package com.jumpeye.flashEff2.text.defaultFade
{
	import com.jumpeye.Events.*;
	import com.jumpeye.core.*;
	import com.jumpeye.flashEff2.core.interfaces.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.utils.*;

	public class FeTDefaultFade extends IFlashEffSymbol
	{
		private var _partialStart:Number = 50;
		private var _partialBlurAmount:Number = 0;
		protected var delay:Number;
		protected var finishPos:uint;
		protected var time:Number = 0;
		protected var startPos:uint;
		protected var duration:Number = 1;
		protected var tweenTimer:Timer;
		protected var change:int;
		protected var isTimer:Boolean = false;

		public function FeTDefaultFade(param1:JUIComponent = null)
		{
			super();
			this.component = param1;
			_easeType = "easeOut";
			_tweenType = "Quadratic";
		}

		override public function remove() : void
		{
			if(this.tweenTimer != null)
			{
				this.tweenTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
			}
			if(this.component != null)
			{
				this.component.removeEventListener(Event.ENTER_FRAME, enterFrame);
			}
			this.tweenTimer = null;
			if(this.target != null)
			{
				this.target.filters = [];
			}
		}

		protected function timerHandler(param1:TimerEvent) : void
		{
			this.time = this.time + this.delay;
			if(this.time > this.duration)
			{
				this.time = this.duration;
				this.tweenTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
				this.isTimer = false;
			}
		}

		public function set partialStart(param1:Number) : void
		{
			this._partialStart = param1;
		}

		public function get partialBlurAmount() : Number
		{
			return this._partialBlurAmount;
		}

		protected function startTransition(param1:Boolean = true) : void
		{
			startPos = 1;
			finishPos = 0;
			if(param1 == true)
			{
				startPos = 0;
				finishPos = 1;
			}
			this.change = finishPos - startPos;
			this.target.alpha = startPos;
			this.duration = (this.tweenDuration * (1 - (this.partialStart / 100))) * 1000;
			if(duration <= 0)
			{
				duration = 1;
			}
			this.delay = 30;
			if(duration > (this.delay / 2))
			{
				this.tweenTimer = new Timer(delay);
				this.tweenTimer.addEventListener(TimerEvent.TIMER, timerHandler);
				this.time = 0;
				this.isTimer = true;
				this.tweenTimer.start();
				this.component.addEventListener(Event.ENTER_FRAME, enterFrame);
			}
			else
			{
				this.time = this.duration;
				enterFrame();
			}
		}

		public function set partialBlurAmount(param1:Number) : void
		{
			this._partialBlurAmount = param1;
		}

		public function get partialStart() : Number
		{
			return this._partialStart;
		}

		override public function hide() : void
		{
			if(this.target != null)
			{
				startTransition(false);
			}
		}

		protected function enterFrame(param1:Event = null) : void
		{
			var _loc_6:FLASHEFFEvents = null;
			var _loc_2:Number = (this.change * this.time) / this.duration + this.startPos;
			this.target.alpha = _loc_2;
			var _loc_3:Number = this.partialBlurAmount * (1 - _loc_2);
			var _loc_4:BitmapFilter = new BlurFilter(_loc_3, _loc_3, 2);
			var _loc_5:Array = new Array();
			_loc_5.push(_loc_4);
			this.target.filters = _loc_5;
			if(this.isTimer == false)
			{
				remove();
				_loc_6 = new FLASHEFFEvents("defaultPatternFinish");
				this.component.dispatchEvent(_loc_6);
			}
		}

		protected function motionFinish(param1:Event) : void
		{
		}

		override public function show() : void
		{
			if(this.target != null)
			{
				startTransition(true);
			}
		}
	}
}
