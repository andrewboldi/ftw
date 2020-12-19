package net.theyak.ui
{
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import net.theyak.events.*;

	public class YakAlert extends YakDialog
	{
		private var buttons:Sprite;
		private var _button1:Button = null;
		private var _button2:Button = null;
		private var _button3:Button = null;

		public function YakAlert(param1:String, param2:String = "Alert", param3:String = "", param4:String = "", param5:String = "")
		{
			var _loc_9:uint = 0;
			super(param2, 300, 200);
			var _loc_6:Rectangle = getCanvasSize();
			var _loc_7:TextField = new TextField();
			_loc_7.text = param1;
			_loc_7.width = _loc_6.width;
			if(_loc_7.textHeight > 50)
			{
				_loc_7.y = (_loc_7.textHeight - 50) / 2;
			}
			else
			{
				_loc_7.y = 50 - _loc_7.textHeight;
			}
			_loc_7.wordWrap = true;
			var _loc_8:TextFormat = new TextFormat();
			_loc_8.align = "center";
			_loc_8.bold = true;
			_loc_8.font = "_sans";
			_loc_8.size = 16;
			_loc_7.setTextFormat(_loc_8);
			canvas.addChild(_loc_7);
			if(param3.length > 0 || param4.length > 0 || param5.length > 0)
			{
				_loc_9 = 0;
				buttons = new Sprite();
				if(param3.length > 0)
				{
					_button1 = new Button();
					_button1.label = param3;
					_button1.addEventListener(MouseEvent.CLICK, pressed);
					_button1.setSize(70, _button1.height);
					_button1.mouseEnabled;
					buttons.addChild(_button1);
					_loc_9 = _loc_9 + 1;
				}
				if(param4.length > 0)
				{
					_button2 = new Button();
					_button2.label = param4;
					_button2.x = _loc_9 * 75;
					_button2.addEventListener(MouseEvent.CLICK, pressed);
					_button2.setSize(70, _button2.height);
					_button2.mouseEnabled;
					buttons.addChild(_button2);
					_loc_9 = _loc_9 + 1;
				}
				if(param5.length > 0)
				{
					_button3 = new Button();
					_button3.label = param4;
					_button3.x = _loc_9 * 75;
					_button3.addEventListener(MouseEvent.CLICK, pressed);
					_button3.setSize(70, _button3.height);
					_button3.mouseEnabled;
					buttons.addChild(_button3);
					_loc_9 = _loc_9 + 1;
				}
				buttons.y = (_loc_6.height - _button1.height) - 10;
				buttons.x = (_loc_6.width - (75 * _loc_9) - 5) / 2;
				canvas.addChild(buttons);
			}
		}

		public function pressed(param1:MouseEvent) : void
		{
			dispatchEvent(new AlertEvent(Button(param1.target).label));
			super.close();
		}
	}
}
package net.theyak.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import net.theyak.events.*;
	import window.*;

	public class YakDialog extends Sprite
	{
		private var title:String;
		private var w:int;
		private var h:int;
		private var _wndTopLeft:Sprite;
		private var _wndTop:Sprite;
		private var _wndTopRight:Sprite;
		private var _wndLeft:Sprite;
		private var _wndRight:Sprite;
		private var _wndBottomLeft:Sprite;
		private var _wndBottomRight:Sprite;
		private var _wndBottom:Sprite;
		private var _wndClose:Sprite;
		private var _wndTitle:TextField;
		private var _mask:Sprite;
		private var _canvas:Sprite;
		private var moving:Boolean = false;

		public function YakDialog(param1:String = "Window", param2:int = 400, param3:int = 300)
		{
			super();
			w = param2;
			h = param3;
			paintFrame(param1);
			paintBackground();
			addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			addEventListener(MouseEvent.MOUSE_UP, endDrag);
			addEventListener(MouseEvent.ROLL_OUT, mouseOut, true);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
		}

		public function get canvas() : Sprite
		{
			return _canvas;
		}

		public function getCanvasSize() : Rectangle
		{
			return new Rectangle(0, 0, _wndTop.width, _wndLeft.height);
		}

		public function center(param1:DisplayObject) : void
		{
			x = (param1.width - width) / 2;
			y = (param1.height - height) / 2;
		}

		public function setSize(param1:uint, param2:uint) : void
		{
			w = param1;
			h = param2;
			_wndTop.width = (w - _wndTopLeft.width) - _wndTopRight.width;
			_wndTopRight.x = (_wndTopLeft.x + _wndTopLeft.width) + _wndTop.width;
			_wndLeft.height = (h - _wndTopLeft.height) - _wndBottomLeft.height;
			_wndRight.height = (h - _wndTopRight.height) - _wndBottomRight.height;
			_wndRight.x = (_wndLeft.x + _wndLeft.width) + _wndTop.width;
			_wndBottomLeft.y = (_wndTop.y + _wndTopLeft.height) + _wndLeft.height;
			_wndBottom.width = (w - _wndBottomLeft.width) - _wndBottomRight.width;
			_wndBottom.y = (_wndTop.y + _wndTop.height) + _wndLeft.height;
			_wndBottomRight.x = (_wndLeft.x + _wndBottomLeft.width) + _wndBottom.width;
			_wndBottomRight.y = (_wndTop.y + _wndTopRight.height) + _wndRight.height;
			_wndClose.x = (_wndTopLeft.width + _wndTop.width) - _wndClose.width;
			_mask.width = _wndTop.width;
			_mask.height = _wndLeft.height;
			paintBackground();
		}

		private function paintBackground() : void
		{
			graphics.clear();
			var _loc_1:String = GradientType.LINEAR;
			var _loc_2:Array = [16777215, 16772846];
			var _loc_3:Array = [1, 1];
			var _loc_4:Array = [0, 255];
			var _loc_5:Matrix = new Matrix();
			_loc_5.createGradientBox(_wndTop.width, _wndLeft.height, Math.PI / 2, 0, 0);
			var _loc_6:String = SpreadMethod.PAD;
			graphics.beginGradientFill(_loc_1, _loc_2, _loc_3, _loc_4, _loc_5, _loc_6);
			graphics.drawRect(_wndLeft.width, _wndTop.height, _wndTop.width, _wndLeft.height);
		}

		private function paintFrame(param1:String)
		{
			_wndTopLeft = new TopLeft();
			_wndTopRight = new TopRight();
			_wndTop = new Top();
			_wndLeft = new Left();
			_wndRight = new Right();
			_wndBottomLeft = new BottomLeft();
			_wndBottom = new Bottom();
			_wndBottomRight = new BottomRight();
			_wndClose = new Close();
			var _loc_2:* = (w - _wndBottomLeft.width) - _wndBottomRight.width;
			_wndBottom.width = _loc_2;
			_wndTop.width = _loc_2;
			var _loc_2:* = (h - _wndTop.height) - _wndBottom.height;
			_wndRight.height = _loc_2;
			_wndLeft.height = _loc_2;
			var _loc_2:* = _wndTopLeft.width;
			_wndBottom.x = _loc_2;
			_wndTop.x = _loc_2;
			var _loc_2:* = _wndBottom.width + _wndBottomLeft.width;
			_wndBottomRight.x = _loc_2;
			var _loc_2:* = _loc_2;
			_wndTopRight.x = _loc_2;
			_wndRight.x = _loc_2;
			var _loc_2:* = _wndTop.height;
			_wndRight.y = _loc_2;
			_wndLeft.y = _loc_2;
			var _loc_2:* = _wndTop.height + _wndLeft.height;
			_wndBottom.y = _loc_2;
			var _loc_2:* = _loc_2;
			_wndBottomRight.y = _loc_2;
			_wndBottomLeft.y = _loc_2;
			_wndClose.x = (_wndTopLeft.width + _wndTop.width) - _wndClose.width;
			_wndClose.y = (_wndTop.height - _wndClose.height) / 2;
			addChild(_wndTopLeft);
			addChild(_wndTop);
			addChild(_wndTopRight);
			addChild(_wndLeft);
			addChild(_wndRight);
			addChild(_wndBottomLeft);
			addChild(_wndBottom);
			addChild(_wndBottomRight);
			_wndTitle = new TextField();
			_wndTitle.width = _wndTop.width;
			_wndTitle.height = _wndTop.height - 4;
			_wndTitle.x = _wndTopLeft.width + 4;
			_wndTitle.y = 4;
			_wndTitle.selectable = false;
			addChild(_wndTitle);
			addChild(_wndClose);
			_canvas = new Sprite();
			_canvas.x = _wndLeft.width;
			_canvas.y = _wndTop.height;
			_mask = new Sprite();
			_mask.graphics.beginFill(16716049);
			_mask.graphics.drawRect(0, 0, _wndTop.width, _wndLeft.height);
			_mask.graphics.endFill();
			_mask.x = _canvas.x;
			_mask.y = _canvas.y;
			addChild(_mask);
			_canvas.mask = _mask;
			addChild(_canvas);
			setTitle(param1);
		}

		public function setTitle(param1:String)
		{
			this.title = param1;
			var _loc_2:TextFormat = new TextFormat();
			_loc_2.bold = true;
			_loc_2.font = "_sans";
			_loc_2.size = 13;
			_loc_2.color = 16777215;
			_wndTitle.text = param1;
			_wndTitle.setTextFormat(_loc_2);
		}

		private function beginDrag(param1:MouseEvent) : void
		{
			if(param1.target == _wndTitle)
			{
				moving = true;
				startDrag(false, new Rectangle(0, 0, stage.stageWidth - 20, stage.stageHeight - 20));
			}
		}

		private function endDrag(param1:MouseEvent) : void
		{
			stopDrag();
			moving = false;
		}

		private function mouseOut(param1:MouseEvent) : void
		{
			if(stage != null)
			{
				if(param1.stageX <= 0 || param1.stageX >= stage.width || param1.stageY <= 0 || param1.stageY >= stage.height)
				{
					endDrag(param1);
				}
			}
		}

		private function mouseClick(param1:MouseEvent) : void
		{
			if(param1.target == _wndClose)
			{
				endDrag(param1);
				close();
			}
		}

		public function close()
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			removeEventListener(MouseEvent.ROLL_OUT, mouseOut, true);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
			dispatchEvent(new DialogEvent("close"));
			parent.removeChild(this);
		}
	}
}
