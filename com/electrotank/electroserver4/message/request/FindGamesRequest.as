package com.electrotank.electroserver4.message.request
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;

	public class FindGamesRequest extends RequestImpl
	{
		private var searchCriteria:SearchCriteria;

		public function FindGamesRequest()
		{
			super();
			setMessageType(MessageType.FindGamesRequest);
		}

		public function setSearchCriteria(param1:SearchCriteria) : void
		{
			this.searchCriteria = param1;
		}

		public function getSearchCriteria() : SearchCriteria
		{
			return searchCriteria;
		}

		override public function validate() : ValidationResponse
		{
			var _loc_1:Boolean = true;
			var _loc_2:Array = new Array();
			var _loc_3:ValidationResponse = new ValidationResponse(_loc_1, _loc_2);
			return _loc_3;
		}
	}
}
