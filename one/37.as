package com.jumpeye.flashEff2.symbol.badTransmission
{
	public class CustomMotion extends Object
	{
		protected var _points:Array;
		protected var pLen:uint;

		public function CustomMotion()
		{
			var _loc_1:* = undefined;
			super();
			_points = [];
			_loc_1 = 0;
			while(_loc_1 < 30)
			{
				_points[_loc_1] = 1;
				_loc_1 = _loc_1 + 1;
			}
		}

		public function get points() : Array
		{
			return this._points;
		}

		public function set points(param1:Array) : void
		{
			if(param1 is Array)
			{
				this._points = param1;
				pLen = param1.length - 1;
			}
		}

		public function getValue(param1:Number, param2:Number, param3:Number, param4:Number) : Number
		{
			var _loc_5:* = undefined;
			var _loc_6:uint = 0;
			if(param4 <= 0)
			{
				return NaN;
			}
			_loc_5 = param1 / param4;
			_loc_6 = Math.floor(this.pLen * _loc_5);
			return param2 + (this._points[_loc_6] * param3);
		}
	}
}
package com.jumpeye.flashEff2.symbol.badTransmission
{
	import com.jumpeye.Events.*;
	import com.jumpeye.core.*;
	import com.jumpeye.flashEff2.core.interfaces.*;
	import com.jumpeye.transitions.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;

	public class FESBadTransmission extends IFlashEffSymbol
	{
		protected var noiseBmp:Bitmap;
		protected var backBmp:Bitmap;
		private var _disturbance:Number = 50;
		protected var targetBmp:Bitmap;
		protected var isShow:Boolean = false;
		private var _maxNoise:Number = 0.500000;
		protected var overlayNoiseBmp:Bitmap;
		protected var screenNoiseBmp:Bitmap;
		protected var tweenObject:Object;
		protected var targetBD:BitmapData;
		protected var perlinBD:BitmapData;
		protected var effectOwner:Sprite;
		private var updateParams:Array;
		protected var noiseBD:BitmapData;
		protected var outputEffect:Sprite;

		public function FESBadTransmission(param1:JUIComponent = null)
		{
			isShow = false;
			_disturbance = 50;
			_maxNoise = 0.50;
			super();
			this.component = param1;
			init();
		}

		override public function show() : void
		{
			remove();
			startMotion(true);
		}

		protected function motionChange(...restArguments) : void
		{
			var _loc_2:* = undefined;
			var _loc_3:Object = null;
			var _loc_4:int = 0;
			var _loc_5:* = restArguments;
			for each(_loc_2 in _loc_5)
			{
				_loc_3 = _loc_5[_loc_2];
				_loc_3.target[_loc_3.prop] = _loc_3.getValue(this.tweenObject.pos, _loc_3.begin, _loc_3.change, this._tweenDuration);
			}
			if((Math.floor(this.tweenObject.pos * 100)) % 3 == 0)
			{
				this.outputEffect.filters = [createDisplacementMap()];
			}
			else
			{
				if((Math.floor(this.tweenObject.pos * 100)) + 1 % 3 == 0)
				{
					this.overlayNoiseBmp.bitmapData.noise(Math.random() * int.MAX_VALUE, 0, 255, 7, true);
				}
			}
		}

		protected function init() : void
		{
			_tweenDuration = 2;
			_tweenType = "Quadratic";
			_easeType = "easeOut";
		}

		protected function createDisplacementMap() : BitmapFilter
		{
			var _loc_1:BitmapData = null;
			var _loc_2:Point = null;
			var _loc_3:uint = 0;
			var _loc_4:uint = 0;
			var _loc_5:uint = 0;
			var _loc_6:int = NaN;
			var _loc_7:int = NaN;
			var _loc_8:String = null;
			var _loc_9:uint = 0;
			var _loc_10:int = NaN;
			_loc_1 = createPerlinBD();
			_loc_2 = new Point();
			_loc_3 = 1;
			_loc_4 = _loc_3;
			_loc_5 = _loc_4;
			_loc_6 = (this.disturbance / 2) + (Math.random() * this.disturbance) / 2;
			_loc_7 = 0.50;
			_loc_8 = DisplacementMapFilterMode.CLAMP;
			_loc_9 = 0;
			_loc_10 = 0;
			return new DisplacementMapFilter(_loc_1, _loc_2, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10);
		}

		public function set maxNoise(param1:Number) : void
		{
			if(param1 > 1)
			{
				param1 = 1;
			}
			else
			{
				if(param1 < 0)
				{
					param1 = 0;
				}
			}
			_maxNoise = param1;
		}

		public function get maxNoise() : Number
		{
			return _maxNoise;
		}

		override public function hide() : void
		{
			remove();
			startMotion(false);
		}

		protected function waitAFrame(param1:Event)
		{
			this.component.removeEventListener(Event.ENTER_FRAME, this.waitAFrame);
			TweenLite.obfuscatedName0E12(this.tweenObject, this.tweenDuration, {pos:this.tweenDuration * Number(isShow), onUpdate:this.motionChange, onUpdateParams:updateParams, onComplete:this.motionFinish});
			this.motionChange.apply(this, updateParams);
			this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_START));
		}

		override public function remove() : void
		{
			if(this.tweenObject != null)
			{
				TweenLite.killTweensOf(this.tweenObject, false);
				this.tweenObject = null;
			}
			if(this.component != null)
			{
				if(this.effectOwner != null)
				{
					if(this.component.targetOwner.contains(this.effectOwner))
					{
						this.component.targetOwner.removeChild(this.effectOwner);
					}
					this.effectOwner = null;
				}
				this.component.removeEventListener(Event.ENTER_FRAME, this.waitAFrame);
			}
			if(this.target != null)
			{
				this.target.alpha = 1;
			}
			if(perlinBD != null)
			{
				perlinBD.dispose();
			}
			perlinBD = null;
			if(targetBD != null)
			{
				targetBD.dispose();
			}
			targetBD = null;
			if(noiseBD != null)
			{
				noiseBD.dispose();
			}
			noiseBD = null;
			targetBmp = null;
			backBmp = null;
			noiseBmp = null;
			screenNoiseBmp = null;
			overlayNoiseBmp = null;
			updateParams = null;
		}

		protected function createPerlinBD() : BitmapData
		{
			var _loc_1:BitmapData = null;
			_loc_1 = new BitmapData(this.component.width, this.component.height, true, 16711680);
			_loc_1.perlinNoise(10, 1.50, 1, Math.random() * 1000, true, true, 3);
			return _loc_1;
		}

		public function set disturbance(param1:Number) : void
		{
			_disturbance = param1;
		}

		public function get disturbance() : Number
		{
			return _disturbance;
		}

		protected function startMotion(param1:Boolean) : void
		{
			var _loc_2:Rectangle = null;
			var _loc_3:Matrix = null;
			var _loc_4:Sprite = null;
			var _loc_5:Sprite = null;
			var _loc_6:Sprite = null;
			var _loc_7:CustomMotion = null;
			var _loc_8:CustomMotion = null;
			var _loc_9:CustomMotion = null;
			var _loc_10:CustomMotion = null;
			var _loc_11:CustomMotion = null;
			var _loc_12:CustomMotion = null;
			var _loc_13:CustomMotion = null;
			var _loc_14:CustomMotion = null;
			var _loc_15:CustomMotion = null;
			_loc_2 = this.target.getBounds(this.target);
			_loc_3 = new Matrix();
			this.isShow = param1;
			this.outputEffect = new Sprite();
			this.effectOwner = new Sprite();
			this.component.targetOwner.addChild(this.effectOwner);
			this.effectOwner.addChild(this.outputEffect);
			this.effectOwner.x = _loc_2.x * this.target.scaleX;
			this.effectOwner.y = _loc_2.y * this.target.scaleY;
			_loc_3.translate(-_loc_2.x, -_loc_2.y);
			_loc_3.scale(this.target.scaleX, this.target.scaleY);
			this.targetBD = new BitmapData(this.target.width, this.target.height, true, 16711680);
			this.targetBD.draw(this.target, _loc_3);
			this.targetBmp = new Bitmap(this.targetBD);
			this.backBmp = new Bitmap(this.targetBD.clone());
			this.backBmp.alpha = 0.34;
			this.outputEffect.addChild(this.backBmp);
			this.outputEffect.addChild(this.targetBmp);
			this.noiseBD = new BitmapData(this.target.width, this.target.height, false);
			this.noiseBD.noise(Math.random() * int.MAX_VALUE, 0, 255, 7, true);
			this.noiseBmp = new Bitmap(this.noiseBD);
			this.noiseBmp.alpha = 0.15 * this.maxNoise;
			this.outputEffect.addChild(this.noiseBmp);
			this.outputEffect.filters = [createDisplacementMap()];
			this.overlayNoiseBmp = new Bitmap(this.noiseBD.clone());
			this.overlayNoiseBmp.alpha = 0;
			this.effectOwner.addChild(this.overlayNoiseBmp);
			this.screenNoiseBmp = new Bitmap(this.noiseBD.clone());
			this.screenNoiseBmp.bitmapData.noise(Math.random() * int.MAX_VALUE, 0, 255, 7, true);
			this.screenNoiseBmp.blendMode = BlendMode.SCREEN;
			this.screenNoiseBmp.alpha = 0.10 * this.maxNoise;
			this.screenNoiseBmp.cacheAsBitmap = true;
			this.effectOwner.addChild(this.screenNoiseBmp);
			_loc_4 = new Sprite();
			_loc_4.graphics.beginFill(10066329, 0.32);
			_loc_4.graphics.drawRect(0, 0, this.target.width, 1);
			_loc_4.alpha = 0;
			_loc_5 = new Sprite();
			_loc_5.graphics.beginFill(10066329, 0.32);
			_loc_5.graphics.drawRect(0, 0, this.target.width, 1);
			_loc_6 = new Sprite();
			_loc_6.graphics.beginFill(10066329);
			_loc_6.graphics.drawRect(0, 0, this.target.width, this.target.height / 10);
			_loc_6.cacheAsBitmap = true;
			this.screenNoiseBmp.mask = _loc_6;
			this.effectOwner.addChild(_loc_4);
			this.effectOwner.addChild(_loc_5);
			this.effectOwner.addChild(_loc_6);
			this.tweenObject = {pos:this.tweenDuration * Number(!param1)};
			this.outputEffect.alpha = 0;
			this.effectOwner.alpha = 0;
			this.target.alpha = 0;
			_loc_7 = new CustomMotion();
			_loc_7.points = [0.07, 0.14, 0.21, 0.29, 0.36, 0.43, 0.50, 0.57, 0.64, 0.71, 0.79, 0.86, 0.93, 1, 0.12, 0.95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.45, 0, 0, 0, 0, 0, 0.57, 1, 1, 0.66, 0.23, 0, 0.45, 0.84, 0.42, 0, 0.01, 0.01, 0.01, 0.36, 0.62, 0.57, 0.52, 0.48, 0.37, 0.29, 0.24, 0.19, 0.15, 0.12, 0.09, 0.07, 0.05, 0.04, 0.03, 0.02, 0.01, 0, 0];
			_loc_8 = new CustomMotion();
			_loc_8.points = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.01, 0.01, 0.02, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.21, 0.23, 0.26, 0.30, 0.34, 0.38, 0.43, 0.48, 0.54, 0.62, 0.70, 0.81, 1];
			_loc_9 = new CustomMotion();
			_loc_9.points = [0, 0.01, 0.02, 0.03, 0.04, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.18, 0.19, 0.20, 0.21, 0.22, 0.24, 0.25, 0.26, 0.27, 0.29, 0.30, 0.32, 0.33, 0.35, 0.37, 0.39, 0.41, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.30, 0.09, 0.06, 0, 0.04, 0.11, 0.18, 0.20, 0.20, 0.20, 0.19, 0.19, 0.18, 0.17, 0.16, 0.15, 0.14, 0.13, 0.11, 0.10, 0.09, 0.07, 0.06, 0.05, 0.03, 0.02, 0];
			_loc_10 = new CustomMotion();
			_loc_10.points = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.80, 0.80, 0, 0, 1, 0.95, 0.80, 0.58, 0.35, 0.16, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, -0.40, -0.40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_loc_11 = new CustomMotion();
			_loc_11.points = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.80, 0.80, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0.95, 0.80, 0.58, 0.35, 0.16, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_loc_12 = new CustomMotion();
			_loc_12.points = [0, 0, 0, 0, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.30, 0.31, 0.32, 0.34, 0.35, 0.36, 0.38, 0.39, 0.41, 0.42, 0.44, 0.46, 0.47, 0.49, 0.51, 0.53, 0.55, 0.57, 0.59, 0.61, 0.64, 0.66, 0.69, 0.71, 0.74, 0.77, 0.80, 0.84, 0.87, 0.91, 0.95, 1, 1, 0.45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_loc_13 = new CustomMotion();
			_loc_13.points = [0.90, 0.88, 0.84, 0.76, 0.68, 0.61, 0.54, 0.47, 0.41, 0.36, 0.30, 0.26, 0.21, 0.17, 0.14, 0.10, 0.08, 0.05, 0.03, 0.02, 0.01, 0, 0, 0.03, 0.07, 0.10, 0.13, 0.16, 0.19, 0.22, 0.25, 0.27, 0.29, 0.31, 0.33, 0.34, 0.35, 0.36, 0.36, 0.36, 0.35, 0.34, 0.32, 0.30, 0.28, 0.25, 0.23, 0.20, 0.17, 0.14, 0.11, 0.07, 0.04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_loc_14 = new CustomMotion();
			_loc_14.points = [0, 0, 0, 0, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.30, 0.31, 0.32, 0.34, 0.35, 0.36, 0.38, 0.39, 0.41, 0.42, 0.44, 0.46, 0.47, 0.49, 0.51, 0.53, 0.55, 0.57, 0.59, 0.61, 0.64, 0.66, 0.69, 0.71, 0.74, 0.77, 0.80, 0.84, 0.87, 0.91, 0.95, 1, 0.81, 0.45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_loc_15 = new CustomMotion();
			_loc_15.points = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.01, 0.03, 0.06, 0.11, 0.16, 0.22, 0.28, 0.34, 0.41, 0.48, 0.55, 0.61, 0.68, 0.74, 0.80, 0.85, 0.90, 0.94, 0.97, 0.99, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
			updateParams = [];
			updateParams.push({target:this.outputEffect, prop:"alpha", getValue:_loc_7.getValue, begin:0, change:1});
			updateParams.push({target:this.overlayNoiseBmp, prop:"alpha", getValue:_loc_9.getValue, begin:0, change:this.maxNoise});
			updateParams.push({target:this.backBmp, prop:"x", getValue:_loc_10.getValue, begin:this.outputEffect.x, change:-(Math.random() * this.disturbance) / 2 + (this.disturbance / 2)});
			updateParams.push({target:this.outputEffect, prop:"x", getValue:_loc_11.getValue, begin:this.outputEffect.x, change:this.disturbance / 5});
			updateParams.push({target:_loc_4, prop:"y", getValue:_loc_12.getValue, begin:_loc_4.y, change:this.target.height * 0.80});
			updateParams.push({target:_loc_4, prop:"alpha", getValue:_loc_14.getValue, begin:0, change:1});
			updateParams.push({target:_loc_5, prop:"y", getValue:_loc_13.getValue, begin:_loc_5.y, change:this.target.height});
			updateParams.push({target:_loc_5, prop:"alpha", getValue:_loc_13.getValue, begin:0, change:1});
			updateParams.push({target:_loc_6, prop:"y", getValue:_loc_15.getValue, begin:-2 * _loc_6.height, change:this.target.height + (2 * _loc_6.height)});
			updateParams.push({target:this.target, prop:"alpha", getValue:_loc_8.getValue, begin:0, change:1});
			updateParams.push({target:this.effectOwner, prop:"alpha", getValue:this.easeFunc, begin:0, change:1});
			this.component.addEventListener(Event.ENTER_FRAME, this.waitAFrame, false, 0, true);
		}

		protected function motionFinish() : void
		{
			remove();
			if(this.target != null)
			{
				this.target.visible = this.isShow;
			}
			this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_END));
		}
	}
}
