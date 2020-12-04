package com.jumpeye.flashEff2.symbol.desertIllusion
{
	import com.jumpeye.Events.*;
	import com.jumpeye.core.*;
	import com.jumpeye.flashEff2.core.interfaces.*;
	import com.jumpeye.flashEff2.utils.wavesEffect.*;
	import com.jumpeye.transitions.*;
	import flash.filters.*;

	public class FESDesertIllusion extends IFlashEffSymbol
	{
		private var _preset:Number;
		private var _wavesIntensity:Number = -48;
		private var transitionType:String;
		private var waveIntensity:*;
		private var maxWaveSize:*;
		private var _blurAmount:* = 3;
		private var t:*;
		private var _scaleAmount:Number = 1;
		private var radius:Number;
		private var owner:Object;
		private var bounds:Object;
		private var _smooth:Boolean = true;
		private var _blurQuality:Number = 1;
		private var _waveSize:Number = -48;

		public function FESDesertIllusion(param1:JUIComponent = null)
		{
			_blurQuality = 1;
			_wavesIntensity = 80;
			_waveSize = 80;
			_smooth = true;
			owner = {};
			_scaleAmount = 1;
			_blurAmount = 3;
			super();
			this.component = param1;
			init();
		}

		override public function show() : void
		{
			startTransition("show");
		}

		private function destroy() : void
		{
			if(!owner)
			{
				return;
			}
			TweenLite.killTweensOf(target, false);
			TweenLite.killTweensOf(owner["wave"], false);
			TweenLite.killTweensOf(owner.blurFilterTween, false);
			if(owner["wave"])
			{
				owner["wave"].bitmap.dispose();
			}
			if(target)
			{
				target.filters = [];
				target.alpha = 1;
			}
		}

		protected function init() : void
		{
			_tweenDuration = 1.50;
			_easeType = "easeNone";
			_tweenType = "Quadratic";
		}

		public function set waveSize(param1:Number) : void
		{
			this._waveSize = param1;
		}

		public function set blurQuality(param1:Number) : void
		{
			if(param1 < 0)
			{
				param1 = 0;
			}
			this._blurQuality = param1;
		}

		override public function hide() : void
		{
			startTransition("hide");
		}

		private function hdlChangeFilter(param1:Object) : void
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			if(!target)
			{
				return;
			}
			_loc_2 = param1.value;
			_loc_3 = getBlurFilter(_loc_2);
			_loc_4 = target.filters;
			_loc_4.push(_loc_3);
			target.filters = _loc_4;
		}

		public function set smooth(param1:Boolean) : void
		{
			this._smooth = param1;
		}

		public function get scaleAmount() : Number
		{
			return this._scaleAmount;
		}

		private function hdlMotionFinished()
		{
			this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_END));
		}

		public function set blurAmount(param1:Number) : void
		{
			this._blurAmount = param1;
		}

		private function transition()
		{
			var _loc_1:* = undefined;
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:* = undefined;
			var _loc_5:* = undefined;
			var _loc_6:* = undefined;
			var _loc_7:* = undefined;
			var _loc_8:* = undefined;
			var _loc_9:* = undefined;
			var _loc_10:* = undefined;
			this.target.visible = true;
			owner.scX = target.width / target.getBounds(target).width;
			owner.scY = target.height / target.getBounds(target).height;
			owner.origX = target.x + (target.width / 2);
			owner.origY = target.y + (target.height / 2);
			_loc_1 = transitionType == "show" ? 0 : 1;
			_loc_2 = transitionType == "show" ? 1 : 0;
			_loc_3 = transitionType == "show" ? maxWaveSize : 0;
			_loc_4 = transitionType == "show" ? 0 : maxWaveSize;
			owner["wave"] = new JWavesEffect(target, smooth, _blurQuality, component.width, component.height);
			owner["wave"].baseX = waveIntensity;
			owner["wave"].baseY = waveIntensity;
			target.alpha = _loc_1;
			TweenLite.obfuscatedName0E12(target, t, {alpha:_loc_2, delay:0, onComplete:hdlMotionFinished, ease:this.easeFunc, overwrite:false});
			owner["wave"].value = _loc_3;
			TweenLite.obfuscatedName0E12(owner["wave"], t, {value:_loc_4, delay:0, onComplete:hdlMotionFinished, ease:this.easeFunc, overwrite:false});
			_loc_5 = transitionType == "show" ? target.scaleX * scaleAmount : owner.scX;
			_loc_6 = transitionType == "show" ? owner.scX : target.scaleX * scaleAmount;
			_loc_7 = transitionType == "show" ? target.scaleY * scaleAmount : owner.scY;
			_loc_8 = transitionType == "show" ? owner.scY : target.scaleY * scaleAmount;
			_loc_9 = transitionType == "show" ? blurAmount : 0;
			_loc_10 = transitionType == "show" ? 0 : blurAmount;
			owner.blurFilterTween = {};
			owner.blurFilterTween.value = _loc_9;
			TweenLite.obfuscatedName0E12(owner.blurFilterTween, t, {value:_loc_10, delay:0, onUpdate:hdlChangeFilter, onUpdateParams:[owner.blurFilterTween], ease:this.easeFunc, overwrite:false});
			this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_START));
		}

		override public function remove() : void
		{
			destroy();
		}

		public function get blurQuality() : Number
		{
			return this._blurQuality;
		}

		private function startTransition(param1:String)
		{
			var _loc_2:* = undefined;
			owner.gain = waveSize;
			owner.customParam1 = wavesIntensity;
			radius = (Math.abs(component.rotation) / 180) * Math.PI;
			transitionType = param1;
			maxWaveSize = owner.gain == "" || isNaN(Number(owner.gain)) ? 100 : owner.gain;
			maxWaveSize = Math.max(0, maxWaveSize);
			waveIntensity = owner.customParam1 == "" || isNaN(Number(owner.customParam1)) ? 100 : owner.customParam1;
			t = this._tweenDuration;
			bounds = target.getBounds(target);
			_loc_2 = target.getBounds(target.parent);
			owner["targetObj"] = {x:target.x, y:target.y, width:_loc_2.width * target.scaleX, height:_loc_2.height * target.scaleY, scaleX:target.scaleX, scaleY:target.scaleY, xMin:_loc_2.x, yMin:_loc_2.y};
			transition();
		}

		public function get blurAmount() : Number
		{
			return this._blurAmount;
		}

		public function get waveSize() : Number
		{
			return _waveSize;
		}

		public function set scaleAmount(param1:Number) : void
		{
			this._scaleAmount = param1;
		}

		public function get smooth() : Boolean
		{
			return this._smooth;
		}

		public function set preset(param1:Number) : void
		{
			this._preset = param1;
		}

		public function get wavesIntensity() : Number
		{
			return _wavesIntensity;
		}

		private function hdlScaleXChange()
		{
			this.component.targetOwner.x = owner.origX - (this.component.targetOwner.width / 2);
		}

		public function set wavesIntensity(param1:Number) : void
		{
			this._wavesIntensity = param1;
		}

		private function getBlurFilter(param1:*) : BlurFilter
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_2 = param1;
			_loc_3 = param1;
			return new BlurFilter(_loc_2, _loc_3, _blurQuality);
		}

		public function get preset() : Number
		{
			return this._preset;
		}

		private function hdlScaleYChange()
		{
			this.component.targetOwner.y = owner.origY - (this.component.targetOwner.height / 2);
		}
	}
}
