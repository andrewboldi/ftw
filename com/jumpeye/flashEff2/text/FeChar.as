package com.jumpeye.flashEff2.text
{
	import flash.display.*;
	import flash.text.*;

	dynamic public class FeChar extends Sprite
	{
		private var _id:Number;
		private var _textField:TextField;
		private var _properties:Object;
		private var _bottomPosition:Number;
		private var _htmlText:String = "";
		private var _type:String = "FeChar";

		public function FeChar(param1:Number, param2:Number, param3:Object)
		{
			super();
			init();
			param3.text;
			this.text = param3.text || "";
			this.id = param3.id;
			this.x = param1;
			this.y = param2;
			this.properties = param3;
			this.textField.embedFonts = true;
		}

		public function get textField() : TextField
		{
			return _textField;
		}

		private function init()
		{
			this.textField = new TextField();
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			this.textField.selectable = false;
			addChild(this.textField);
		}

		public function set text(param1:String) : void
		{
			this.textField.text = param1;
			_htmlText = param1;
		}

		public function get id() : Number
		{
			return this._id;
		}

		private function renewPositions()
		{
			this.y = (this.y + this.bottomPosition) - this.textField.getLineMetrics(0).ascent;
		}

		public function set textField(param1:TextField) : void
		{
			_textField = param1;
		}

		public function set bottomPosition(param1:Number) : void
		{
			_bottomPosition = param1;
		}

		public function applyTextFormat(param1:TextFormat) : void
		{
			param1.leading = 0;
			param1.leftMargin = 0;
			param1.rightMargin = 0;
			param1.letterSpacing = 0;
			param1.indent = 0;
			param1.blockIndent = 0;
			param1.align = "left";
			this.textField.setTextFormat(param1);
			if(this.textField.getTextFormat().italic == true)
			{
				this.textField.autoSize = TextFieldAutoSize.LEFT;
				this.textField.width = this.textField.width + (this.textField.height * 0.21);
				this.textField.autoSize = TextFieldAutoSize.NONE;
			}
			renewPositions();
		}

		public function get text() : String
		{
			return this.textField.text;
		}

		public function set htmlText(param1:String) : void
		{
			trace(param1);
			this.textField.htmlText = param1;
			_htmlText = param1;
		}

		public function get properties() : Object
		{
			return this._properties;
		}

		public function get bottomPosition() : Number
		{
			return _bottomPosition;
		}

		public function set properties(param1:Object) : void
		{
			this._properties = param1;
		}

		public function set id(param1:Number) : void
		{
			this._id = param1;
		}

		public function get htmlText() : String
		{
			return _htmlText;
		}

		public function get type() : String
		{
			return this._type;
		}
	}
}
