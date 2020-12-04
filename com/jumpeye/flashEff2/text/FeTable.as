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
