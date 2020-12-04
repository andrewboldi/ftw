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
