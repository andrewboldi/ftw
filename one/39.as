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
package com.jumpeye.flashEff2.text
{
	import flash.utils.*;

	dynamic public class FeGroup extends FeTable
	{
		private var _type:String = "FeGroup";
		private var _id:Number;
		private var _text:String;
		private var _properties:Object;

		public function FeGroup(param1:Number, param2:Number, param3:Object)
		{
			super();
			init();
			this.x = param1 || 0;
			this.y = param2 || 0;
			this.text = param3.text;
			this.id = param3.id;
			this.properties = param3;
		}

		public function set properties(param1:Object) : void
		{
			this._properties = param1;
		}

		public function set text(param1:String) : void
		{
			this._text = param1;
		}

		public function get text() : String
		{
			return this._text;
		}

		override public function set childs(param1:Array) : void
		{
			var className:String = null;
			var classInstance:Class = null;
			var child:* = undefined;
			var arg:Array = param1;
			var len:uint = arg.length;
			var i:uint = 0;
			while(i < len)
			{
				className = arg[i].type;
				try
				{
					classInstance = getDefinitionByName("com.jumpeye.flashEff2.text." + className);
					child = new classInstance(arg[i].x, arg[i].y, arg[i]);
					addChild(child);
					this._childs.push(arg);
				}
				catch(e:*)
				{
					throw e;
				}
				i = i + 1;
			}
		}

		private function init()
		{
		}

		public function get properties() : Object
		{
			return this._properties;
		}

		public function set id(param1:Number) : void
		{
			this._id = param1;
		}

		override public function get childs() : Array
		{
			return super.childs;
		}

		override public function get type() : String
		{
			return this._type;
		}

		public function get id() : Number
		{
			return this._id;
		}
	}
}
package com.jumpeye.flashEff2.text
{
	import flash.display.*;
	import flash.utils.*;

	public class FeTable extends Sprite
	{
		private var tempChar:FeChar;
		private var tempGroup:FeGroup;
		private var _type:String = "FeTable";
		protected var _childs:Array;

		public function FeTable()
		{
			super();
			init();
			_childs = [];
		}

		public function cleanMe() : void
		{
			var _loc_2:* = undefined;
			var _loc_1:* = 0;
			while(_loc_1 < this._childs.length)
			{
				_loc_2 = this._childs[_loc_1];
				if(_loc_2.type != "FeChar")
				{
					_loc_2.cleanMe();
				}
				if(_loc_2.numChildren == 0)
				{
					removeChildAtIndex(_loc_1);
					break;
				}
				_loc_1 = _loc_1 + 1;
			}
		}

		public function pushChild(param1:Object) : Object
		{
			var classInstance:Class = null;
			var child:* = undefined;
			var arg:Object = param1;
			var className:String = arg.type;
			try
			{
				classInstance = getDefinitionByName("com.jumpeye.flashEff2.text." + className);
				child = new classInstance(arg.x, arg.y, arg);
				addChild(child);
				this._childs.push(child);
			}
			catch(e:*)
			{
				throw e;
			}
			return child;
		}

		public function removeChildAtIndex(param1:uint) : Object
		{
			removeChildAt(param1);
			return this._childs.splice(param1, 1)[0];
		}

		public function set childs(param1:Array) : void
		{
			var _loc_2:uint = param1.length;
			this._childs = [];
			var _loc_3:uint = 0;
			while(_loc_3 < _loc_2)
			{
				pushChild(param1[_loc_3]);
				_loc_3 = _loc_3 + 1;
			}
		}

		private function init()
		{
		}

		public function get childs() : Array
		{
			return _childs;
		}

		public function get type() : String
		{
			return this._type;
		}

		public function removeChilds() : void
		{
			var _loc_1:uint = this._childs.length;
			var _loc_2:uint = 0;
			while(_loc_2 < _loc_1)
			{
				if(this._childs[_loc_2].type == "FeGroup")
				{
					this._childs[_loc_2].removeChilds();
				}
				removeChild(this._childs[_loc_2]);
				_loc_2 = _loc_2 + 1;
			}
			this._childs = [];
		}
	}
}
