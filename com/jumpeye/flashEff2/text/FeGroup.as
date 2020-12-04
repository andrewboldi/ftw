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
