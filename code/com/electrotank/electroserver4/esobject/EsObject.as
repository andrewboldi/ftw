package com.electrotank.electroserver4.esobject
{
	import flash.utils.*;
	import flash.xml.*;

	public class EsObject extends Object
	{
		private var data:Object;
		private var list:Array;

		public function EsObject()
		{
			super();
			data = new Object();
			list = new Array();
		}

		public function toString(param1:String = null) : String
		{
			var _loc_4:EsObjectDataHolder = null;
			var _loc_5:String = null;
			var _loc_6:String = null;
			var _loc_7:Array = null;
			var _loc_8:Array = null;
			var _loc_9:int = NaN;
			var _loc_10:int = NaN;
			var _loc_11:EsObject = null;
			var _loc_2:String = "{EsObject:\n";
			if(param1 == null)
			{
				param1 = "";
			}
			param1 = param1 + "\t";
			var _loc_3:Number = 0;
			while(_loc_3 < getEntries().length)
			{
				_loc_4 = getEntries()[_loc_3];
				_loc_5 = _loc_4.getName();
				_loc_2 = _loc_2 + (param1 + _loc_5) + ":" + _loc_4.getDataType().getName() + " = ";
				_loc_6 = param1 + "\t";
				switch(_loc_4.getDataType())
				{
				case DataType.EsObject:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString(param1);
					break;
				case DataType.Byte:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Character:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Double:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsBoolean:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsNumber:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsString:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Float:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Integer:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Long:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Short:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.BooleanArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.CharacterArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.DoubleArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.EsByteArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.FloatArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.IntegerArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.LongArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.NumberArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.ShortArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.StringArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_7 = _loc_4.getRawValue();
					_loc_9 = 0;
					while(_loc_9 < _loc_7.length)
					{
						_loc_2 = _loc_2 + (_loc_6 + _loc_7[_loc_9]);
						if(_loc_9 != (_loc_7.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_9 = _loc_9 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				case DataType.EsObjectArray:
					_loc_2 = _loc_2 + "\n" + _loc_6 + "[\n";
					_loc_8 = _loc_4.getRawValue();
					_loc_10 = 0;
					while(_loc_10 < _loc_8.length)
					{
						_loc_11 = _loc_8[_loc_10];
						_loc_2 = _loc_2 + (_loc_6 + _loc_11.toString(param1));
						if(_loc_10 != (_loc_8.length - 1))
						{
							_loc_2 = _loc_2 + ",\n";
						}
						_loc_10 = _loc_10 + 1;
					}
					_loc_2 = _loc_2 + "\n" + _loc_6 + "]";
					break;
				default:
					trace("EsObject.toString() data type not supported: " + _loc_4.getDataType().getName());
					break;
				}
				if(_loc_3 != (getEntries().length - 1))
				{
					_loc_2 = _loc_2 + "\n";
				}
				_loc_3 = _loc_3 + 1;
			}
			_loc_2 = _loc_2 + "\n" + param1 + "}";
			return _loc_2;
		}

		public function toXML(param1:String = null) : String
		{
			var _loc_4:EsObjectDataHolder = null;
			var _loc_5:String = null;
			var _loc_6:String = null;
			var _loc_7:Array = null;
			var _loc_8:int = NaN;
			var _loc_9:String = null;
			var _loc_10:* = undefined;
			var _loc_11:int = NaN;
			var _loc_12:int = NaN;
			var _loc_13:EsObject = null;
			if(param1 == null)
			{
				param1 = "";
			}
			param1 = param1 + "\t";
			var _loc_2:String = "";
			if(param1 == "\t")
			{
				_loc_2 = _loc_2 + "<Variable>";
			}
			_loc_2 = _loc_2 + "\n";
			var _loc_3:Number = 0;
			while(_loc_3 < getEntries().length)
			{
				_loc_4 = getEntries()[_loc_3];
				_loc_5 = _loc_4.getName();
				_loc_2 = _loc_2 + (param1 + "<Variable name='") + _loc_5 + "' type='" + _loc_4.getDataType().getName() + "' >";
				_loc_6 = param1 + "\t";
				switch(_loc_4.getDataType())
				{
				case DataType.EsObject:
					_loc_2 = _loc_2 + _loc_4.getEsObjectValue().toXML(param1);
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.Character:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Double:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsBoolean:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsNumber:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.EsString:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Float:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Integer:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Long:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Short:
					_loc_2 = _loc_2 + _loc_4.getRawValue().toString();
					break;
				case DataType.Byte:
					_loc_8 = Number(_loc_4.getRawValue());
					_loc_9 = _loc_8.toString(16);
					if(_loc_9.length < 2)
					{
						_loc_9 = "0" + _loc_9;
					}
					_loc_2 = _loc_2 + _loc_9;
					break;
				case DataType.BooleanArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.CharacterArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.DoubleArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.EsByteArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.FloatArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.IntegerArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.LongArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.NumberArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.ShortArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.StringArray:
					_loc_7 = _loc_4.getRawValue();
					_loc_11 = 0;
					while(_loc_11 < _loc_7.length)
					{
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + _loc_7[_loc_11].toString() + "</Entry>";
						_loc_11 = _loc_11 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				case DataType.EsObjectArray:
					_loc_10 = _loc_4.getRawValue();
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_13 = _loc_10[_loc_12];
						_loc_2 = _loc_2 + "\n" + _loc_6 + "<Entry>" + (_loc_13.toXML(param1 + "\t")) + "\n" + _loc_6 + "</Entry>";
						_loc_12 = _loc_12 + 1;
					}
					_loc_2 = _loc_2 + "\n" + param1;
					break;
				default:
					trace("EsObject.toString() data type not supported: " + _loc_4.getDataType().getName());
					break;
				}
				_loc_2 = _loc_2 + "</Variable>";
				if(_loc_3 != (getEntries().length - 1))
				{
					_loc_2 = _loc_2 + "\n";
				}
				_loc_3 = _loc_3 + 1;
			}
			if(param1 == "\t")
			{
				_loc_2 = _loc_2 + "\n</Variable>";
			}
			return _loc_2;
		}

		public function fromXML(param1:XMLNode) : void
		{
			var _loc_4:XMLNode = null;
			var _loc_5:Object = null;
			var _loc_6:String = null;
			var _loc_7:DataType = null;
			var _loc_8:String = null;
			var _loc_9:Array = null;
			var _loc_10:Array = null;
			var _loc_11:XMLNode = null;
			var _loc_12:int = NaN;
			var _loc_13:EsObject = null;
			var _loc_2:Array = param1.childNodes;
			var _loc_3:Number = 0;
			while(_loc_3 < _loc_2.length)
			{
				_loc_4 = _loc_2[_loc_3];
				_loc_5 = _loc_4.attributes;
				_loc_6 = _loc_5.name;
				_loc_7 = DataType.findTypeByName(_loc_5.type);
				_loc_9 = new Array();
				switch(_loc_7)
				{
				case DataType.EsObject:
					_loc_13 = new EsObject();
					_loc_13.fromXML(_loc_4);
					setEsObject(_loc_6, _loc_13);
					break;
				case DataType.Byte:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setByte(_loc_6, int(_loc_8));
					break;
				case DataType.Character:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setChar(_loc_6, _loc_8);
					break;
				case DataType.Double:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setDouble(_loc_6, Number(_loc_8));
					break;
				case DataType.EsBoolean:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setBoolean(_loc_6, _loc_8.toLowerCase() == "true" ? true : false);
					break;
				case DataType.EsNumber:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setNumber(_loc_6, Number(_loc_8));
					break;
				case DataType.EsString:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setString(_loc_6, _loc_8);
					break;
				case DataType.Float:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setFloat(_loc_6, Number(_loc_8));
					break;
				case DataType.Integer:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setInteger(_loc_6, Number(_loc_8));
					break;
				case DataType.Long:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setLong(_loc_6, _loc_8);
					break;
				case DataType.Short:
					_loc_8 = _loc_4.firstChild.nodeValue;
					setShort(_loc_6, Number(_loc_8));
					break;
				case DataType.StringArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = _loc_11.firstChild.nodeValue;
						_loc_12 = _loc_12 + 1;
					}
					setStringArray(_loc_6, _loc_9);
					break;
				case DataType.CharacterArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = _loc_11.firstChild.nodeValue;
						_loc_12 = _loc_12 + 1;
					}
					setCharArray(_loc_6, _loc_9);
					break;
				case DataType.LongArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = _loc_11.firstChild.nodeValue;
						_loc_12 = _loc_12 + 1;
					}
					setLongArray(_loc_6, _loc_9);
					break;
				case DataType.DoubleArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = Number(_loc_11.firstChild.nodeValue);
						_loc_12 = _loc_12 + 1;
					}
					setDoubleArray(_loc_6, _loc_9);
					break;
				case DataType.FloatArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = Number(_loc_11.firstChild.nodeValue);
						_loc_12 = _loc_12 + 1;
					}
					setFloatArray(_loc_6, _loc_9);
					break;
				case DataType.IntegerArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = int(_loc_11.firstChild.nodeValue);
						_loc_12 = _loc_12 + 1;
					}
					setIntegerArray(_loc_6, _loc_9);
					break;
				case DataType.NumberArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = Number(_loc_11.firstChild.nodeValue);
						_loc_12 = _loc_12 + 1;
					}
					setNumberArray(_loc_6, _loc_9);
					break;
				case DataType.ShortArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = Number(_loc_11.firstChild.nodeValue);
						_loc_12 = _loc_12 + 1;
					}
					setShortArray(_loc_6, _loc_9);
					break;
				case DataType.BooleanArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_9[_loc_12] = _loc_11.firstChild.nodeValue.toLowerCase() == "true" ? true : false;
						_loc_12 = _loc_12 + 1;
					}
					setBooleanArray(_loc_6, _loc_9);
					break;
				case DataType.EsByteArray:
					break;
				case DataType.EsObjectArray:
					_loc_10 = _loc_4.childNodes;
					_loc_12 = 0;
					while(_loc_12 < _loc_10.length)
					{
						_loc_11 = _loc_10[_loc_12];
						_loc_13 = new EsObject();
						_loc_13.fromXML(_loc_11);
						_loc_9[_loc_12] = _loc_13;
						_loc_12 = _loc_12 + 1;
					}
					setEsObjectArray(_loc_6, _loc_9);
					break;
				default:
					trace("EsObject.toString() data type not supported: " + _loc_7.getName());
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
		}

		public function doesPropertyExist(param1:String) : Boolean
		{
			return !(data[param1] == null);
		}

		public function getSize() : Number
		{
			return list.length;
		}

		public function getEntries() : Array
		{
			return list;
		}

		private function put(param1:String, param2:EsObjectDataHolder) : void
		{
			var _loc_3:EsObjectDataHolder = null;
			var _loc_4:int = NaN;
			param2.setName(param1);
			if(data[param1] != null)
			{
				_loc_3 = data[param1];
				_loc_4 = 0;
				while(_loc_4 < list.length)
				{
					if(list[_loc_4] == _loc_3)
					{
						list.splice(_loc_4, 1);
						break;
					}
					_loc_4 = _loc_4 + 1;
				}
				data[param1] = null;
			}
			data[param1] = param2;
			list.push(param2);
		}

		public function getDataType(param1:String) : DataType
		{
			return getHolderForName(param1).getDataType();
		}

		public function setInteger(param1:String, param2:Number) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Integer);
			_loc_3.setIntValue(param2);
			put(param1, _loc_3);
		}

		public function setString(param1:String, param2:String) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsString);
			_loc_3.setStringValue(param2);
			put(param1, _loc_3);
		}

		public function setDouble(param1:String, param2:Number) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Double);
			_loc_3.setDoubleValue(param2);
			put(param1, _loc_3);
		}

		public function setFloat(param1:String, param2:Number) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Float);
			_loc_3.setFloatValue(param2);
			put(param1, _loc_3);
		}

		public function setBoolean(param1:String, param2:Boolean) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsBoolean);
			_loc_3.setBooleanValue(param2);
			put(param1, _loc_3);
		}

		public function setByte(param1:String, param2:int) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Byte);
			_loc_3.setByteValue(param2);
			put(param1, _loc_3);
		}

		public function setChar(param1:String, param2:String) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Character);
			_loc_3.setCharValue(param2);
			put(param1, _loc_3);
		}

		public function setLong(param1:String, param2:String) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Long);
			_loc_3.setLongValue(param2);
			put(param1, _loc_3);
		}

		public function setShort(param1:String, param2:Number) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.Short);
			_loc_3.setShortValue(param2);
			put(param1, _loc_3);
		}

		public function setEsObject(param1:String, param2:EsObject) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsObject);
			_loc_3.setEsObjectValue(param2);
			put(param1, _loc_3);
		}

		public function setNumber(param1:String, param2:Number) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsNumber);
			_loc_3.setNumberValue(param2);
			put(param1, _loc_3);
		}

		public function setIntegerArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.IntegerArray);
			_loc_3.setIntArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setStringArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.StringArray);
			_loc_3.setStringArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setDoubleArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.DoubleArray);
			_loc_3.setDoubleArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setFloatArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.FloatArray);
			_loc_3.setFloatArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setBooleanArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.BooleanArray);
			_loc_3.setBooleanArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setByteArray(param1:String, param2:ByteArray) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsByteArray);
			_loc_3.setByteArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setCharArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.CharacterArray);
			_loc_3.setCharArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setLongArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.LongArray);
			_loc_3.setLongArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setShortArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.ShortArray);
			_loc_3.setShortArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setEsObjectArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.EsObjectArray);
			_loc_3.setEsObjectArrayValue(param2);
			put(param1, _loc_3);
		}

		public function setNumberArray(param1:String, param2:Array) : void
		{
			var _loc_3:EsObjectDataHolder = new EsObjectDataHolder();
			_loc_3.setRawValue(param2);
			_loc_3.setDataType(DataType.NumberArray);
			_loc_3.setNumberArrayValue(param2);
			put(param1, _loc_3);
		}

		private function getHolderForName(param1:String) : EsObjectDataHolder
		{
			var _loc_2:EsObjectDataHolder = data[param1];
			if(_loc_2 == null)
			{
				throw new Error("Unable to locate variable named '" + param1 + "' on EsObject");
			}
			return _loc_2;
		}

		public function getInteger(param1:String) : Number
		{
			return getHolderForName(param1).getIntValue();
		}

		public function getString(param1:String) : String
		{
			return getHolderForName(param1).getStringValue();
		}

		public function getDouble(param1:String) : Number
		{
			return getHolderForName(param1).getDoubleValue();
		}

		public function getFloat(param1:String) : Number
		{
			return getHolderForName(param1).getFloatValue();
		}

		public function getBoolean(param1:String) : Boolean
		{
			return getHolderForName(param1).getBooleanValue();
		}

		public function getByte(param1:String) : int
		{
			return getHolderForName(param1).getByteValue();
		}

		public function getChar(param1:String) : String
		{
			return getHolderForName(param1).getCharValue();
		}

		public function getLong(param1:String) : String
		{
			return getHolderForName(param1).getLongValue();
		}

		public function getShort(param1:String) : Number
		{
			return getHolderForName(param1).getShortValue();
		}

		public function getEsObject(param1:String) : EsObject
		{
			return getHolderForName(param1).getEsObjectValue();
		}

		public function getNumber(param1:String) : Number
		{
			return getHolderForName(param1).getNumberValue();
		}

		public function getIntegerArray(param1:String) : Array
		{
			return getHolderForName(param1).getIntArrayValue();
		}

		public function getStringArray(param1:String) : Array
		{
			return getHolderForName(param1).getStringArrayValue();
		}

		public function getDoubleArray(param1:String) : Array
		{
			return getHolderForName(param1).getDoubleArrayValue();
		}

		public function getFloatArray(param1:String) : Array
		{
			return getHolderForName(param1).getFloatArrayValue();
		}

		public function getBooleanArray(param1:String) : Array
		{
			return getHolderForName(param1).getBooleanArrayValue();
		}

		public function getByteArray(param1:String) : ByteArray
		{
			return getHolderForName(param1).getByteArrayValue();
		}

		public function getCharArray(param1:String) : Array
		{
			return getHolderForName(param1).getCharArrayValue();
		}

		public function getLongArray(param1:String) : Array
		{
			return getHolderForName(param1).getLongArrayValue();
		}

		public function getShortArray(param1:String) : Array
		{
			return getHolderForName(param1).getShortArrayValue();
		}

		public function getEsObjectArray(param1:String) : Array
		{
			return getHolderForName(param1).getEsObjectArrayValue();
		}

		public function getNumberArray(param1:String) : Array
		{
			return getHolderForName(param1).getNumberArrayValue();
		}

		public function removeVariable(param1:String) : void
		{
			var _loc_3:EsObjectDataHolder = null;
			var _loc_2:Number = 0;
			while(_loc_2 < list.length)
			{
				_loc_3 = list[_loc_2];
				if(_loc_3.getName() == param1)
				{
					list.splice(_loc_2, 1);
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function removeAll() : void
		{
			data = new Object();
			list = new Array();
		}

		public function getRawVariable(param1:String) : Object
		{
			return getHolderForName(param1).getRawValue();
		}
	}
}
