package com.jumpeye.transitions.utils.tween
{
	public class ArrayTweenInfo extends Object
	{
		public var change:Number;
		public var start:Number;
		public var index:uint;

		public function ArrayTweenInfo(param1:uint, param2:Number, param3:Number)
		{
			super();
			this.index = param1;
			this.start = param2;
			this.change = param3;
		}
	}
}
package com.jumpeye.transitions.utils.tween
{
	public class TweenInfo extends Object
	{
		public var start:Number;
		public var name:String;
		public var change:Number;
		public var target:Object;
		public var property:String;
		public var isPlugin:Boolean;

		public function TweenInfo(param1:Object, param2:String, param3:Number, param4:Number, param5:String, param6:Boolean)
		{
			super();
			this.target = param1;
			this.property = param2;
			this.start = param3;
			this.change = param4;
			this.name = param5;
			this.isPlugin = param6;
		}
	}
}
