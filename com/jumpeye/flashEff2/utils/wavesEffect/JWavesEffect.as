package com.jumpeye.flashEff2.utils.wavesEffect
{
	import flash.display.*;
	import flash.filters.*;
	import flash.geom.*;

	public class JWavesEffect extends Sprite
	{
		public var bitmap:BitmapData;
		private var map:Bitmap;
		private var offsetPoints:Array;
		private var target:*;
		public var decrInterval:Number;
		private var blurQuality:Number;
		public var baseX:*;
		public var baseY:*;
		private var bounds:Object;
		private var __value:* = 0;
		public var fractalNoiseVal:*;
		private var hig:Number;
		public var intervalId:*;
		public var blurX:*;
		public var blurY:*;
		private var wid:*;

		public function JWavesEffect(param1:*, param2:Boolean, param3:Number, param4:Number = 0, param5:Number = 0)
		{
			__value = 0;
			super();
			blurQuality = param3;
			this.target = param1;
			this.map = new Bitmap();
			this.map.smoothing = param2;
			addChild(map);
			this.baseX = baseX || 100;
			this.baseY = baseY || 100;
			this.blurX = blurX || 0;
			this.blurY = blurY || 0;
			this.fractalNoiseVal = fractalNoiseVal || true;
			this.offsetPoints = new Array();
			this.offsetPoints[0] = new Point();
			this.wid = param4 == 0 ? param1.width : param4;
			this.hig = param5 == 0 ? param1.height : param5;
			this.wid = this.wid > 2880 ? 2880 : this.wid;
			this.hig = this.hig > 2880 ? 2880 : this.hig;
			this.bitmap = new BitmapData(this.wid + 2, this.hig + 2, true, 0);
		}

		public function get value() : Number
		{
			return __value;
		}

		private function setEffect() : void
		{
			var _loc_1:Array = null;
			initFilters(value);
			_loc_1 = this.target.filters;
			this.offsetPoints[0].x = this.value;
			this.offsetPoints[0].y = this.value;
			this.bitmap.perlinNoise(this.baseX, this.baseY, 2, 100, true, this.fractalNoiseVal, 7, true, this.offsetPoints);
			_loc_1[0].mapBitmap = this.bitmap;
			this.target.filters = _loc_1;
			map.bitmapData = bitmap;
		}

		private function getDisplacement(param1:*) : BitmapFilter
		{
			var _loc_2:Point = null;
			var _loc_3:DisplacementMapFilter = null;
			_loc_2 = new Point(0, 0);
			_loc_3 = new DisplacementMapFilter(this.bitmap, _loc_2, 1, 1, param1 / 3, param1 / 3, "color");
			return _loc_3;
		}

		private function initFilters(param1:*) : void
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			var _loc_4:Array = null;
			_loc_2 = getDisplacement(param1);
			_loc_3 = getBlur(0);
			_loc_4 = [];
			_loc_4.push(_loc_2);
			_loc_4.push(_loc_3);
			target.filters = [_loc_2];
		}

		private function getBlur(param1:*) : BitmapFilter
		{
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			_loc_2 = param1;
			_loc_3 = param1;
			return new BlurFilter(_loc_2, _loc_3, blurQuality);
		}

		public function set value(param1:Number) : void
		{
			__value = param1;
			setEffect();
		}
	}
}
