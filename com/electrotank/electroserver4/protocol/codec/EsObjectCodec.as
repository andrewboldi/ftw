package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;

	public class EsObjectCodec extends MessageCodecImpl
	{
		final public static function getDefaultMessageSize() : Number
		{
			return 1024;
		}

		final public static function encode(param1:MessageWriter, param2:EsObject) : void
		{
			var _loc_6:EsObjectDataHolder = null;
			var _loc_3:Number = param2.getSize();
			param1.writeInteger(param2.getSize());
			var _loc_4:Array = param2.getEntries();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3)
			{
				_loc_6 = _loc_4[_loc_5];
				EsObjectCodec.encodeObjectEntry(param1, _loc_6);
				_loc_5 = _loc_5 + 1;
			}
		}

		final public static function encodeMap(param1:MessageWriter, param2:Array) : void
		{
			var _loc_4:EsObjectMap = null;
			param1.writeInteger(param2.length);
			var _loc_3:Number = 0;
			while(_loc_3 < param2.length)
			{
				_loc_4 = param2[_loc_3];
				param1.writeString(_loc_4.getName());
				EsObjectCodec.encode(param1, _loc_4.getValue());
				_loc_3 = _loc_3 + 1;
			}
		}

		final private static function encodeObjectEntry(param1:MessageWriter, param2:EsObjectDataHolder) : void
		{
			var _loc_4:Array = null;
			var _loc_5:Array = null;
			var _loc_6:int = NaN;
			var _loc_7:int = NaN;
			var _loc_3:DataType = param2.getDataType();
			param1.writeCharacter(_loc_3.getIndicator());
			param1.writeString(param2.getName());
			switch(_loc_3)
			{
			case DataType.Integer:
				param1.writeInteger(param2.getIntValue());
				break;
			case DataType.EsString:
				param1.writeString(param2.getStringValue());
				break;
			case DataType.Double:
				param1.writeDouble(param2.getDoubleValue());
				break;
			case DataType.Float:
				param1.writeFloat(param2.getFloatValue());
				break;
			case DataType.EsBoolean:
				param1.writeBoolean(param2.getBooleanValue());
				break;
			case DataType.Byte:
				param1.writeByte(param2.getByteValue());
				break;
			case DataType.Character:
				param1.writeCharacter(param2.getCharValue());
				break;
			case DataType.Long:
				param1.writeLong(param2.getLongValue());
				break;
			case DataType.Short:
				param1.writeShort(param2.getShortValue());
				break;
			case DataType.EsNumber:
				param1.writeDouble(param2.getNumberValue());
				break;
			case DataType.EsObject:
				EsObjectCodec.encode(param1, param2.getEsObjectValue());
				break;
			case DataType.EsObjectArray:
				_loc_4 = param2.getEsObjectArrayValue();
				param1.writeInteger(_loc_4.length);
				_loc_6 = 0;
				while(_loc_6 < _loc_4.length)
				{
					EsObjectCodec.encode(param1, _loc_4[_loc_6]);
					_loc_6 = _loc_6 + 1;
				}
				break;
			case DataType.IntegerArray:
				param1.writeIntegerArray(param2.getIntArrayValue());
				break;
			case DataType.StringArray:
				param1.writeStringArray(param2.getStringArrayValue());
				break;
			case DataType.DoubleArray:
				param1.writeDoubleArray(param2.getDoubleArrayValue());
				break;
			case DataType.FloatArray:
				param1.writeFloatArray(param2.getFloatArrayValue());
				break;
			case DataType.BooleanArray:
				param1.writeBooleanArray(param2.getBooleanArrayValue());
				break;
			case DataType.EsByteArray:
				param1.writeByteArray(param2.getByteArrayValue());
				break;
			case DataType.CharacterArray:
				param1.writeCharacterArray(param2.getCharArrayValue());
				break;
			case DataType.LongArray:
				param1.writeLongArray(param2.getLongArrayValue());
				break;
			case DataType.ShortArray:
				param1.writeShortArray(param2.getShortArrayValue());
				break;
			case DataType.NumberArray:
				_loc_5 = param2.getNumberArrayValue();
				param1.writeInteger(_loc_5.length);
				_loc_7 = 0;
				while(_loc_7 < _loc_5.length)
				{
					param1.writeDouble(_loc_5[_loc_7]);
					_loc_7 = _loc_7 + 1;
				}
				break;
			default:
				EsObjectCodec.trace("Unable to encode data type " + _loc_3);
				break;
			}
		}

		final public static function decode(param1:MessageReader) : EsObject
		{
			var _loc_5:String = null;
			var _loc_6:DataType = null;
			var _loc_7:String = null;
			var _loc_8:int = NaN;
			var _loc_9:Array = null;
			var _loc_10:Array = null;
			var _loc_11:Array = null;
			var _loc_12:int = NaN;
			var _loc_13:int = NaN;
			var _loc_2:Number = param1.nextInteger();
			var _loc_3:EsObject = new EsObject();
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_2)
			{
				_loc_5 = param1.nextCharacter();
				_loc_6 = DataType.findTypeByIndicator(_loc_5);
				_loc_7 = param1.nextString();
				switch(_loc_6)
				{
				case DataType.Integer:
					_loc_3.setInteger(_loc_7, param1.nextInteger());
					break;
				case DataType.EsString:
					_loc_3.setString(_loc_7, param1.nextString());
					break;
				case DataType.Double:
					_loc_3.setDouble(_loc_7, param1.nextDouble());
					break;
				case DataType.Float:
					_loc_3.setFloat(_loc_7, param1.nextFloat());
					break;
				case DataType.EsBoolean:
					_loc_3.setBoolean(_loc_7, param1.nextBoolean());
					break;
				case DataType.Byte:
					_loc_3.setByte(_loc_7, param1.nextByte());
					break;
				case DataType.Character:
					_loc_3.setChar(_loc_7, param1.nextCharacter());
					break;
				case DataType.Long:
					_loc_3.setLong(_loc_7, param1.nextLong());
					break;
				case DataType.Short:
					_loc_3.setShort(_loc_7, param1.nextShort());
					break;
				case DataType.EsNumber:
					_loc_3.setNumber(_loc_7, new Number(param1.nextDouble()));
					break;
				case DataType.EsObject:
					_loc_3.setEsObject(_loc_7, EsObjectCodec.decode(param1));
					break;
				case DataType.EsObjectArray:
					_loc_8 = param1.nextInteger();
					_loc_9 = new Array();
					_loc_12 = 0;
					while(_loc_12 < _loc_8)
					{
						_loc_9[_loc_12] = EsObjectCodec.decode(param1);
						_loc_12 = _loc_12 + 1;
					}
					_loc_3.setEsObjectArray(_loc_7, _loc_9);
					break;
				case DataType.IntegerArray:
					_loc_3.setIntegerArray(_loc_7, param1.nextIntegerArray());
					break;
				case DataType.StringArray:
					_loc_3.setStringArray(_loc_7, param1.nextStringArray());
					break;
				case DataType.DoubleArray:
					_loc_3.setDoubleArray(_loc_7, param1.nextDoubleArray());
					break;
				case DataType.FloatArray:
					_loc_3.setFloatArray(_loc_7, param1.nextFloatArray());
					break;
				case DataType.BooleanArray:
					_loc_3.setBooleanArray(_loc_7, param1.nextBooleanArray());
					break;
				case DataType.EsByteArray:
					_loc_3.setByteArray(_loc_7, param1.nextByteArray());
					break;
				case DataType.CharacterArray:
					_loc_3.setCharArray(_loc_7, param1.nextCharacterArray());
					break;
				case DataType.LongArray:
					_loc_3.setLongArray(_loc_7, param1.nextLongArray());
					break;
				case DataType.ShortArray:
					_loc_3.setShortArray(_loc_7, param1.nextShortArray());
					break;
				case DataType.NumberArray:
					_loc_10 = param1.nextDoubleArray();
					_loc_11 = new Array();
					_loc_13 = 0;
					while(_loc_13 < _loc_10.length)
					{
						_loc_11[_loc_13] = EsObjectCodec.Number(_loc_10[_loc_13]);
						_loc_13 = _loc_13 + 1;
					}
					_loc_3.setNumberArray(_loc_7, _loc_11);
					break;
				default:
					EsObjectCodec.trace("Unable to decode data type " + _loc_6);
					break;
				}
				_loc_4 = _loc_4 + 1;
			}
			return _loc_3;
		}

		public function EsObjectCodec()
		{
			super();
		}
	}
}
