package com.electrotank.electroserver4.message
{
	public class ValidationResponse extends Object
	{
		private var isValid:Boolean;
		private var problems:Array;

		public function ValidationResponse(param1:Boolean, param2:Array)
		{
			super();
			this.isValid = param1;
			this.problems = param2;
		}

		public function getProblems() : Array
		{
			return problems;
		}

		public function getIsValid() : Boolean
		{
			return isValid;
		}
	}
}
