package com.electrotank.electroserver4.esobject
{
	public class DataType extends Object
	{
		public static var Integer:DataType = new DataType("0", "integer");
		public static var EsString:DataType = new DataType("1", "string");
		public static var Double:DataType = new DataType("2", "double");
		public static var Float:DataType = new DataType("3", "float");
		public static var EsBoolean:DataType = new DataType("4", "boolean");
		public static var Byte:DataType = new DataType("5", "byte");
		public static var Character:DataType = new DataType("6", "character");
		public static var Long:DataType = new DataType("7", "long");
		public static var Short:DataType = new DataType("8", "short");
		public static var EsObject:DataType = new DataType("9", "esobject");
		public static var EsObjectArray:DataType = new DataType("a", "esobject_array");
		public static var IntegerArray:DataType = new DataType("b", "integer_array");
		public static var StringArray:DataType = new DataType("c", "string_array");
		public static var DoubleArray:DataType = new DataType("d", "double_array");
		public static var FloatArray:DataType = new DataType("e", "float_array");
		public static var BooleanArray:DataType = new DataType("f", "boolean_array");
		public static var EsByteArray:DataType = new DataType("g", "byte_array");
		public static var CharacterArray:DataType = new DataType("h", "character_array");
		public static var LongArray:DataType = new DataType("i", "long_array");
		public static var ShortArray:DataType = new DataType("j", "short_array");
		public static var EsNumber:DataType = new DataType("k", "number");
		public static var NumberArray:DataType = new DataType("l", "number_array");
		private static var typesByIndicator:Object;
		private static var typesByName:Object;
		private var indicator:String;
		private var name:String;

		final public static function register(param1:DataType) : void
		{
			if(typesByIndicator == null)
			{
				typesByIndicator = new Object();
			}
			if(typesByName == null)
			{
				typesByName = new Object();
			}
			typesByIndicator[param1.getIndicator()] = param1;
			typesByName[param1.getName()] = param1;
		}

		final public static function findTypeByIndicator(param1:String) : DataType
		{
			return typesByIndicator[param1];
		}

		final public static function findTypeByName(param1:String) : DataType
		{
			return typesByName[param1];
		}

		public function DataType(param1:String, param2:String)
		{
			super();
			indicator = param1;
			name = param2;
			register(this);
		}

		public function getIndicator() : String
		{
			return indicator;
		}

		public function getName() : String
		{
			return name;
		}
	}
}
