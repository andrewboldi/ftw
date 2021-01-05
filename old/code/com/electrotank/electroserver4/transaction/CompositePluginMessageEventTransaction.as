package com.electrotank.electroserver4.transaction
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;

	public class CompositePluginMessageEventTransaction extends TransactionImpl
	{
		public function CompositePluginMessageEventTransaction()
		{
			super();
		}

		override public function execute(param1:Message, param2:ElectroServer) : void
		{
			var _loc_7:PluginMessageEvent = null;
			var _loc_3:CompositePluginMessageEvent = CompositePluginMessageEvent(param1);
			var _loc_4:Array = new Array();
			var _loc_5:Array = _loc_3.getParameters();
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_5.length)
			{
				_loc_7 = new PluginMessageEvent();
				_loc_7.setPluginName(_loc_3.getPluginName());
				_loc_7.setOriginRoomId(_loc_3.getOriginRoomId());
				_loc_7.setOriginZoneId(_loc_3.getOriginZoneId());
				_loc_7.setEsObject(_loc_5[_loc_6]);
				_loc_4.push(_loc_7);
				_loc_6 = _loc_6 + 1;
			}
			param2.processCompositeMessages(_loc_4);
			param2.dispatchEvent(_loc_3);
		}
	}
}
