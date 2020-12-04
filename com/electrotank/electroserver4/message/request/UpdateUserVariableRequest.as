package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;

	public class UpdateUserVariableRequest extends RequestImpl
	{
		private var name:String;
		private var value:EsObject;

		public function UpdateUserVariableRequest()
		{
			super();
			setMessageType(MessageType.UpdateUserVariableRequest);
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			if(getValue() == null)
			{
				_loc_2.push("getValue() must not return null.");
			}
			if(getName() == null)
			{
				_loc_2.push("getName() must not return null.");
			}
			_loc_1 = _loc_2.length == 0;
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}

		public function setName(param1:String) : void
		{
			this.name = param1;
		}

		public function getName() : String
		{
			return name;
		}

		public function setValue(param1:EsObject) : void
		{
			this.value = param1;
		}

		public function getValue() : EsObject
		{
			return value;
		}
	}
}
