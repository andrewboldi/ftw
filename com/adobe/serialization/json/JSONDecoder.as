package com.adobe.serialization.json
{
	public class JSONDecoder extends Object
	{
		private var value:*;
		private var tokenizer:JSONTokenizer;
		private var token:JSONToken;

		public function JSONDecoder(param1:String)
		{
			super();
			tokenizer = new JSONTokenizer(param1);
			nextToken();
			value = parseValue();
		}

		public function getValue()
		{
			return value;
		}

		private function nextToken() : JSONToken
		{
			var _loc_1:getNextToken = tokenizer.getNextToken();
			token = _loc_1;
			return _loc_1;
		}

		private function parseArray() : Array
		{
			var _loc_1:Array = new Array();
			nextToken();
			if(token.type == JSONTokenType.RIGHT_BRACKET)
			{
				return _loc_1;
			}
			while(true)
			{
				_loc_1.push(parseValue());
				nextToken();
				if(token.type == JSONTokenType.RIGHT_BRACKET)
				{
					return _loc_1;
				}
				if(token.type == JSONTokenType.COMMA)
				{
					nextToken();
					break;
				}
				tokenizer.parseError("Expecting ] or , but found " + token.value);
			}
			return null;
		}

		private function parseObject() : Object
		{
			var _loc_2:String = null;
			var _loc_1:Object = new Object();
			nextToken();
			if(token.type == JSONTokenType.RIGHT_BRACE)
			{
				return _loc_1;
			}
			while(true)
			{
				if(token.type == JSONTokenType.STRING)
				{
					_loc_2 = String(token.value);
					nextToken();
					if(token.type == JSONTokenType.COLON)
					{
						nextToken();
						_loc_1[_loc_2] = parseValue();
						nextToken();
						if(token.type == JSONTokenType.RIGHT_BRACE)
						{
							return _loc_1;
						}
						if(token.type == JSONTokenType.COMMA)
						{
							nextToken();
						}
						else
						{
							tokenizer.parseError("Expecting } or , but found " + token.value);
						}
					}
					else
					{
						tokenizer.parseError("Expecting : but found " + token.value);
					}
					break;
				}
				tokenizer.parseError("Expecting string but found " + token.value);
			}
			return null;
		}

		private function parseValue() : Object
		{
			switch(token.type)
			{
			case JSONTokenType.LEFT_BRACE:
				return parseObject();
			case JSONTokenType.LEFT_BRACKET:
				return parseArray();
			case JSONTokenType.STRING:
				return token.value;
			case JSONTokenType.NUMBER:
				return token.value;
			case JSONTokenType.TRUE:
				return token.value;
			case JSONTokenType.FALSE:
				return token.value;
			case JSONTokenType.NULL:
				return token.value;
			default:
				tokenizer.parseError("Unexpected " + token.value);
				break;
			}
			return null;
		}
	}
}
