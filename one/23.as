package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class AddBuddyRequestCodec extends MessageCodecImpl
	{
		public function AddBuddyRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:AddBuddyRequest = AddBuddyRequest(param2);
			param1.writePrefixedString(_loc_3.getBuddyName(), MessageConstants.USER_NAME_PREFIX_LENGTH);
			var _loc_4:EsObject = _loc_3.getEsObject();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class AddRoomOperatorRequestCodec extends MessageCodecImpl
	{
		public function AddRoomOperatorRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:AddRoomOperatorRequest = AddRoomOperatorRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeLong(_loc_3.getUserId(), MessageConstants.USER_ID_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class BuddyStatusUpdatedEventCodec extends MessageCodecImpl
	{
		public function BuddyStatusUpdatedEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:EsObject = null;
			var _loc_2:BuddyStatusUpdatedEvent = new BuddyStatusUpdatedEvent();
			var _loc_3:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_3);
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			_loc_2.setHasEsObject(param1.nextBoolean());
			if(_loc_2.getHasEsObject())
			{
				_loc_4 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_4);
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ClientIdleEventCodec extends MessageCodecImpl
	{
		public function ClientIdleEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:ClientIdleEvent = new ClientIdleEvent();
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CompositePluginMessageEventCodec extends MessageCodecImpl
	{
		public function CompositePluginMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:CompositePluginMessageEvent = new CompositePluginMessageEvent();
			_loc_2.setPluginName(param1.nextPrefixedString(MessageConstants.PLUGIN_PARM_NAME_PREFIX_LENGTH));
			_loc_2.setOriginZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setOriginRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			var _loc_3:Number = param1.nextInteger(MessageConstants.COMPOSITE_ESOBJECT_ARRAY_PREFIX_LENGTH);
			var _loc_4:Array = new Array();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3)
			{
				_loc_4.push(EsObjectCodec.decode(param1));
				_loc_5 = _loc_5 + 1;
			}
			_loc_2.setParameters(_loc_4);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ConnectionEventCodec extends MessageCodecImpl
	{
		public function ConnectionEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:int = NaN;
			var _loc_2:ConnectionEvent = new ConnectionEvent();
			var _loc_3:Boolean = param1.nextBoolean();
			_loc_2.setAccepted(_loc_3);
			if(_loc_2.getAccepted())
			{
				_loc_2.setHashId(param1.nextInteger(MessageConstants.HASH_ID_LENGTH));
				_loc_2.setPrime(param1.nextString());
				_loc_2.setBase(param1.nextString());
			}
			else
			{
				_loc_4 = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
				_loc_2.setEsError(Errors.getErrorById(_loc_4));
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateOrJoinGameRequestCodec extends MessageCodecImpl
	{
		public function CreateOrJoinGameRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:CreateOrJoinGameRequest = CreateOrJoinGameRequest(param2);
			param1.writeString(_loc_3.getGameType());
			param1.writeString(_loc_3.getZoneName());
			if(_loc_3.getPassword() == null || _loc_3.getPassword().length == 0)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				param1.writeString(_loc_3.getPassword());
			}
			var _loc_4:EsObject = _loc_3.getGameDetails();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
			param1.writeBoolean(_loc_3.getIsLocked());
			param1.writeBoolean(_loc_3.getIsHidden());
			SearchCriteriaCodec.encode(param1, _loc_3.getSearchCriteria());
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateOrJoinGameResponseCodec extends MessageCodecImpl
	{
		public function CreateOrJoinGameResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_3:CreateOrJoinGameResponse = new CreateOrJoinGameResponse();
			_loc_3.setSuccessful(param1.nextBoolean());
			if(_loc_3.getSuccessful())
			{
				_loc_3.setGameId(param1.nextInteger());
				_loc_3.setZoneId(param1.nextInteger());
				_loc_3.setRoomId(param1.nextInteger());
				_loc_3.setGameDetails(EsObjectCodec.decode(param1));
			}
			else
			{
				_loc_3.setEsError(Errors.getErrorById(param1.nextInteger()));
			}
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.plugin.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateRoomRequestCodec extends MessageCodecImpl
	{
		public function CreateRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:CreateRoomRequest = CreateRoomRequest(param2);
			if(_loc_3.getZoneId() == -1)
			{
				param1.writeBoolean(false);
				param1.writePrefixedString(_loc_3.getZoneName(), MessageConstants.ZONE_NAME_PREFIX_LENGTH);
			}
			else
			{
				param1.writeBoolean(true);
				param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			}
			param1.writePrefixedString(_loc_3.getRoomName(), MessageConstants.ROOM_NAME_PREFIX_LENGTH);
			if((_loc_3.getRoomDescription() == null) && _loc_3.getRoomDescription().length == 0)
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_3.getRoomDescription(), MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
			}
			if((_loc_3.getPassword() == null) && _loc_3.getPassword().length == 0)
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_3.getPassword(), MessageConstants.ROOM_PASSWORD_PREFIX_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
			}
			param1.writeInteger(_loc_3.getCapacity(), MessageConstants.ROOM_CAPACITY_LENGTH);
			param1.writeBoolean(_loc_3.getIsPersistent());
			param1.writeBoolean(_loc_3.getIsHidden());
			param1.writeBoolean(_loc_3.getIsReceivingRoomListUpdates());
			param1.writeBoolean(_loc_3.getIsReceivingRoomDetailUpdates());
			param1.writeBoolean(_loc_3.getIsReceivingUserListUpdates());
			param1.writeBoolean(_loc_3.getIsReceivingRoomVariableUpdates());
			param1.writeBoolean(_loc_3.getIsReceivingUserVariableUpdates());
			param1.writeBoolean(_loc_3.getIsReceivingVideoEvents());
			param1.writeBoolean(_loc_3.getIsNonOperatorUpdateAllowed());
			param1.writeBoolean(_loc_3.getIsNonOperatorVariableUpdateAllowed());
			param1.writeBoolean(_loc_3.getIsCreateOrJoinRoom());
			RoomVariableCodec.encode(param1, _loc_3.getRoomVariables());
			encodePlugins(param1, _loc_3.getPlugins());
			param1.writeBoolean(_loc_3.getIsUsingLanguageFilter());
			if(_loc_3.getIsUsingLanguageFilter())
			{
				param1.writeBoolean(_loc_3.getIsLanguageFilterSpecified());
				if(_loc_3.getIsLanguageFilterSpecified())
				{
					param1.writePrefixedString(_loc_3.getLanguageFilterName(), MessageConstants.FILTER_NAME_PREFIX_LENGTH);
					param1.writeBoolean(_loc_3.getIsDeliverMessageOnFailure());
					param1.writeInteger(_loc_3.getFailuresBeforeKick(), MessageConstants.FILTER_FAILURES_BEFORE_KICK_LENGTH);
					param1.writeInteger(_loc_3.getKicksBeforeBan(), MessageConstants.FILTER_KICKS_BEFORE_BAN_LENGTH);
					param1.writeInteger(_loc_3.getBanDuration(), MessageConstants.ROOM_BAN_DURATION_LENGTH);
					param1.writeBoolean(_loc_3.getIsResetAfterKick());
				}
			}
			param1.writeBoolean(_loc_3.getIsUsingFloodingFilter());
			if(_loc_3.getIsUsingFloodingFilter())
			{
				param1.writeBoolean(_loc_3.getIsFloodingFilterSpecified());
				if(_loc_3.getIsFloodingFilterSpecified())
				{
					param1.writePrefixedString(_loc_3.getFloodingFilterName(), MessageConstants.FILTER_NAME_PREFIX_LENGTH);
					param1.writeInteger(_loc_3.getFloodingFilterFailuresBeforeKick(), MessageConstants.FILTER_FAILURES_BEFORE_KICK_LENGTH);
					param1.writeInteger(_loc_3.getFloodingFilterKicksBeforeBan(), MessageConstants.FILTER_KICKS_BEFORE_BAN_LENGTH);
					param1.writeInteger(_loc_3.getFloodingFilterBanDuration(), MessageConstants.ROOM_BAN_DURATION_LENGTH);
					param1.writeBoolean(_loc_3.getIsFloodingFilterResetAfterKick());
				}
			}
		}

		private function encodePlugins(param1:MessageWriter, param2:Array) : void
		{
			var _loc_4:Plugin = null;
			var _loc_5:EsObject = null;
			param1.writeInteger(param2.length, MessageConstants.PLUGIN_COUNT_LENGTH);
			var _loc_3:Number = 0;
			while(_loc_3 < param2.length)
			{
				_loc_4 = param2[_loc_3];
				param1.writePrefixedString(_loc_4.getExtensionName(), MessageConstants.EXTENSION_NAME_PREFIX_LENGTH);
				param1.writePrefixedString(_loc_4.getPluginHandle(), MessageConstants.PLUGIN_HANDLE_PREFIX_LENGTH);
				param1.writePrefixedString(_loc_4.getPluginName(), MessageConstants.PLUGIN_NAME_PREFIX_LENGTH);
				_loc_5 = _loc_4.getData();
				EsObjectCodec.encode(param1, _loc_5);
				_loc_3 = _loc_3 + 1;
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class CreateRoomVariableRequestCodec extends MessageCodecImpl
	{
		public function CreateRoomVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:CreateRoomVariableRequest = CreateRoomVariableRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
			EsObjectCodec.encode(param1, _loc_3.getValue());
			param1.writeBoolean(_loc_3.getLocked());
			param1.writeBoolean(_loc_3.getPersistent());
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class DeleteRoomVariableRequestCodec extends MessageCodecImpl
	{
		public function DeleteRoomVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:DeleteRoomVariableRequest = DeleteRoomVariableRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class DeleteUserVariableRequestCodec extends MessageCodecImpl
	{
		public function DeleteUserVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:DeleteUserVariableRequest = DeleteUserVariableRequest(param2);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
		}
	}
}
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
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class EvictUserFromRoomRequestCodec extends MessageCodecImpl
	{
		public function EvictUserFromRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:EvictUserFromRoomRequest = EvictUserFromRoomRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeLong(_loc_3.getUserId(), MessageConstants.USER_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getReason(), MessageConstants.ROOM_EVICTION_REASON_PREFIX_LENGTH);
			param1.writeBoolean(_loc_3.isBan());
			if(_loc_3.isBan())
			{
				param1.writeInteger(_loc_3.getDuration(), MessageConstants.ROOM_BAN_DURATION_LENGTH);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindGamesRequestCodec extends MessageCodecImpl
	{
		public function FindGamesRequestCodec()
		{
			super();
		}

		public function getDefaultMessageSize() : Number
		{
			return 1024;
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:FindGamesRequest = FindGamesRequest(param2);
			var _loc_4:SearchCriteria = _loc_3.getSearchCriteria();
			SearchCriteriaCodec.encode(param1, _loc_4);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindGamesResponseCodec extends MessageCodecImpl
	{
		public function FindGamesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:int = NaN;
			var _loc_8:Boolean = false;
			var _loc_9:Boolean = false;
			var _loc_10:EsObject = null;
			var _loc_11:ServerGame = null;
			var _loc_2:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_3:FindGamesResponse = new FindGamesResponse();
			var _loc_4:Number = param1.nextInteger();
			var _loc_5:Array = new Array();
			_loc_3.setGames(_loc_5);
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_4)
			{
				_loc_7 = param1.nextInteger();
				_loc_8 = param1.nextBoolean();
				_loc_9 = param1.nextBoolean();
				_loc_10 = null;
				if(param1.nextBoolean())
				{
					_loc_10 = EsObjectCodec.decode(param1);
				}
				_loc_11 = new ServerGame();
				_loc_11.setGameId(_loc_7);
				_loc_11.setLocked(_loc_8);
				_loc_11.setPasswordProtected(_loc_9);
				_loc_11.setGameDetails(_loc_10);
				_loc_5.push(_loc_11);
				_loc_6 = _loc_6 + 1;
			}
			return _loc_3;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindZoneAndRoomByNameRequestCodec extends MessageCodecImpl
	{
		public function FindZoneAndRoomByNameRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:FindZoneAndRoomByNameRequest = FindZoneAndRoomByNameRequest(param2);
			param1.writePrefixedString(_loc_3.getZoneName(), MessageConstants.ZONE_NAME_PREFIX_LENGTH);
			param1.writePrefixedString(_loc_3.getRoomName(), MessageConstants.ROOM_NAME_PREFIX_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class FindZoneAndRoomByNameResponseCodec extends MessageCodecImpl
	{
		public function FindZoneAndRoomByNameResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:Array = null;
			var _loc_2:FindZoneAndRoomByNameResponse = new FindZoneAndRoomByNameResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Number = param1.nextInteger(MessageConstants.ZONE_AND_ROOM_ID_LIST_LENGTH);
			var _loc_5:Array = new Array();
			var _loc_6:Number = 0;
			while(_loc_6 < _loc_4)
			{
				_loc_7 = new Array();
				_loc_7[0] = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
				_loc_7[1] = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
				_loc_5.push(_loc_7);
				_loc_6 = _loc_6 + 1;
			}
			_loc_2.setRoomAndZoneList(_loc_5);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GateWayKickUserRequestCodec extends MessageCodecImpl
	{
		public function GateWayKickUserRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GateWayKickUserRequest = GateWayKickUserRequest(param2);
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:GateWayKickUserRequest = new GateWayKickUserRequest();
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GenericErrorResponseCodec extends MessageCodecImpl
	{
		public function GenericErrorResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_9:EsObject = null;
			var _loc_2:GenericErrorResponse = new GenericErrorResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:String = param1.nextCharacter();
			var _loc_5:Number = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
			var _loc_6:MessageType = MessageType.findTypeById(_loc_4);
			var _loc_7:EsError = Errors.getErrorById(_loc_5);
			_loc_2.setRequestMessageType(_loc_6);
			_loc_2.setErrorType(_loc_7);
			var _loc_8:Boolean = param1.nextBoolean();
			if(_loc_8)
			{
				_loc_9 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_9);
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetRoomsInZoneRequestCodec extends MessageCodecImpl
	{
		public function GetRoomsInZoneRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetRoomsInZoneRequest = GetRoomsInZoneRequest(param2);
			if(_loc_3.getZoneId() != -1)
			{
				param1.writeBoolean(true);
				param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
				param1.writePrefixedString(_loc_3.getZoneName(), MessageConstants.ZONE_NAME_PREFIX_LENGTH);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.room.*;

	public class GetRoomsInZoneResponseCodec extends MessageCodecImpl
	{
		public function GetRoomsInZoneResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Room = null;
			var _loc_2:GetRoomsInZoneResponse = new GetRoomsInZoneResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			if(param1.nextBoolean())
			{
				_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			}
			else
			{
				_loc_2.setZoneName(param1.nextPrefixedString(MessageConstants.ZONE_NAME_PREFIX_LENGTH));
			}
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_COUNT_LENGTH);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = new Room();
				_loc_6.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
				_loc_6.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
				_loc_6.setUserCount(param1.nextInteger(MessageConstants.USER_COUNT_LENGTH));
				_loc_6.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
				_loc_6.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
				_loc_6.setHasPassword(param1.nextBoolean());
				_loc_2.addRoom(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserCountRequestCodec extends MessageCodecImpl
	{
		public function GetUserCountRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetUserCountRequest = GetUserCountRequest(param2);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserCountResponseCodec extends MessageCodecImpl
	{
		public function GetUserCountResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:GetUserCountResponse = new GetUserCountResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			_loc_2.setCount(param1.nextInteger(MessageConstants.FULL_USER_COUNT_LENGTH));
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUsersInRoomRequestCodec extends MessageCodecImpl
	{
		public function GetUsersInRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetUsersInRoomRequest = GetUsersInRoomRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUsersInRoomResponseCodec extends MessageCodecImpl
	{
		public function GetUsersInRoomResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:GetUsersInRoomResponse = new GetUsersInRoomResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUsers(UserListCodec.decode(param1));
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserVariablesRequestCodec extends MessageCodecImpl
	{
		public function GetUserVariablesRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetUserVariablesRequest = GetUserVariablesRequest(param2);
			param1.writeString(_loc_3.getUserName());
			var _loc_4:Array = _loc_3.getUserVariableNames();
			trace(param1);
			param1.writeInteger(_loc_4.length);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4.length)
			{
				param1.writeString(_loc_4[_loc_5]);
				_loc_5 = _loc_5 + 1;
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetUserVariablesResponseCodec extends MessageCodecImpl
	{
		public function GetUserVariablesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:String = null;
			var _loc_7:EsObject = null;
			var _loc_2:GetUserVariablesResponse = new GetUserVariablesResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			_loc_2.setUserName(param1.nextString());
			var _loc_4:Number = param1.nextInteger();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = param1.nextString();
				_loc_7 = EsObjectCodec.decode(param1);
				_loc_2.addVariable(_loc_6, _loc_7);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class GetZonesRequestCodec extends MessageCodecImpl
	{
		public function GetZonesRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:GetZonesRequest = GetZonesRequest(param2);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.zone.*;

	public class GetZonesResponseCodec extends MessageCodecImpl
	{
		public function GetZonesResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Zone = null;
			var _loc_2:GetZonesResponse = new GetZonesResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Number = param1.nextInteger(MessageConstants.ZONE_COUNT_LENGTH);
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_4)
			{
				_loc_6 = new Zone();
				_loc_6.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_6.setZoneName(param1.nextPrefixedString(MessageConstants.ZONE_NAME_PREFIX_LENGTH));
				_loc_2.addZone(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class JoinRoomEventCodec extends MessageCodecImpl
	{
		public function JoinRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:JoinRoomEvent = new JoinRoomEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
			_loc_2.setRoomDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
			_loc_2.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
			_loc_2.setIsHidden(param1.nextBoolean());
			_loc_2.setHasPassword(param1.nextBoolean());
			_loc_2.setUsers(UserListCodec.decode(param1));
			var _loc_3:Array = new Array();
			_loc_3 = RoomVariableCodec.decode(param1);
			_loc_2.setRoomVariables(_loc_3);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class JoinRoomRequestCodec extends MessageCodecImpl
	{
		public function JoinRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:JoinRoomRequest = JoinRoomRequest(param2);
			var _loc_4:Number = _loc_3.getZoneId();
			var _loc_5:Number = _loc_3.getRoomId();
			var _loc_6:String = _loc_3.getPassword();
			var _loc_7:Boolean = _loc_3.getIsReceivingRoomListUpdates();
			var _loc_8:Boolean = _loc_3.getIsReceivingRoomDetailUpdates();
			var _loc_9:Boolean = _loc_3.getIsReceivingUserListUpdates();
			var _loc_10:Boolean = _loc_3.getIsReceivingRoomVariableUpdates();
			var _loc_11:Boolean = _loc_3.getIsReceivingUserVariableUpdates();
			var _loc_12:Boolean = _loc_3.getIsReceivingVideoEvents();
			param1.writeInteger(_loc_4, MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_5, MessageConstants.ROOM_ID_LENGTH);
			if((_loc_6 == null) && _loc_6 == "")
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_6, MessageConstants.ROOM_PASSWORD_PREFIX_LENGTH);
			}
			else
			{
				param1.writeBoolean(false);
			}
			param1.writeBoolean(_loc_7);
			param1.writeBoolean(_loc_8);
			param1.writeBoolean(_loc_9);
			param1.writeBoolean(_loc_10);
			param1.writeBoolean(_loc_11);
			param1.writeBoolean(_loc_12);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.room.*;

	public class JoinZoneEventCodec extends MessageCodecImpl
	{
		public function JoinZoneEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Room = null;
			var _loc_2:JoinZoneEvent = new JoinZoneEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setZoneName(param1.nextPrefixedString(MessageConstants.ZONE_NAME_PREFIX_LENGTH));
			var _loc_3:Number = param1.nextInteger(MessageConstants.ROOM_COUNT_LENGTH);
			var _loc_4:Array = new Array();
			var _loc_5:Number = 0;
			while(_loc_5 < _loc_3)
			{
				_loc_6 = new Room();
				_loc_6.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_6.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
				_loc_6.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
				_loc_6.setUserCount(param1.nextInteger(MessageConstants.USER_COUNT_LENGTH));
				_loc_6.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
				_loc_6.setHasPassword(param1.nextBoolean());
				_loc_6.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
				_loc_4.push(_loc_6);
				_loc_5 = _loc_5 + 1;
			}
			_loc_2.setRooms(_loc_4);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LeaveRoomEventCodec extends MessageCodecImpl
	{
		public function LeaveRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:LeaveRoomEvent = new LeaveRoomEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_4);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LeaveRoomRequestCodec extends MessageCodecImpl
	{
		public function LeaveRoomRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:LeaveRoomRequest = LeaveRoomRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LeaveZoneEventCodec extends MessageCodecImpl
	{
		public function LeaveZoneEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:LeaveZoneEvent = new LeaveZoneEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LoginRequestCodec extends MessageCodecImpl
	{
		public function LoginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:Protocol = null;
			var _loc_3:LoginRequest = LoginRequest(param2);
			var _loc_4:String = _loc_3.getUserName();
			var _loc_5:String = _loc_3.getPassword();
			if((_loc_4 == null) && _loc_4.length == 0)
			{
				param1.writeBoolean(true);
				param1.writePrefixedString(_loc_4, MessageConstants.USER_NAME_PREFIX_LENGTH);
				if((_loc_5 == null) && _loc_5.length == 0)
				{
					param1.writeBoolean(true);
					param1.writePrefixedString(_loc_5, MessageConstants.PASSWORD_PREFIX_LENGTH);
				}
				else
				{
					param1.writeBoolean(false);
				}
			}
			else
			{
				param1.writeBoolean(false);
			}
			var _loc_6:EsObject = _loc_3.getEsObject();
			if(_loc_6 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_6);
			}
			var _loc_7:Array = _loc_3.getUserVariables();
			if(_loc_7 == null || _loc_7.length == 0)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encodeMap(param1, _loc_7);
			}
			var _loc_8:Boolean = !(_loc_3.getSharedSecret() == null);
			if(_loc_8)
			{
				param1.writePrefixedString(_loc_3.getSharedSecret(), MessageConstants.SHARED_SECRET_LENGTH);
			}
			else
			{
				param1.writeBoolean(_loc_3.getIsAutoDiscoverProtocol());
				if(!_loc_3.getIsAutoDiscoverProtocol())
				{
					_loc_9 = _loc_3.getProtocols();
					param1.writeInteger(_loc_9.length, MessageConstants.PROTOCOL_COUNT_LENGTH);
					_loc_10 = 0;
					while(_loc_10 < _loc_9.length)
					{
						_loc_11 = _loc_9[_loc_10];
						param1.writeInteger(_loc_11.getProtocolId(), MessageConstants.PROTOCOL_LENGTH);
						_loc_10 = _loc_10 + 1;
					}
				}
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.errors.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LoginResponseCodec extends MessageCodecImpl
	{
		public function LoginResponseCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_10:int = NaN;
			var _loc_11:String = null;
			var _loc_12:EsObject = null;
			var _loc_15:int = NaN;
			var _loc_16:EsObject = null;
			var _loc_17:UserVariable = null;
			var _loc_2:LoginResponse = new LoginResponse();
			var _loc_3:String = param1.nextInteger(MessageConstants.MESSAGE_ID_SIZE).toString();
			var _loc_4:Boolean = param1.nextBoolean();
			_loc_2.setAccepted(_loc_4);
			if(!_loc_2.getAccepted())
			{
				_loc_15 = param1.nextInteger(MessageConstants.ERROR_ID_LENGTH);
				_loc_2.setEsError(Errors.getErrorById(_loc_15));
			}
			var _loc_5:Boolean = param1.nextBoolean();
			if(_loc_5)
			{
				_loc_16 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_16);
			}
			var _loc_6:Boolean = param1.nextBoolean();
			if(_loc_6)
			{
				_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			}
			var _loc_7:Boolean = param1.nextBoolean();
			if(_loc_7)
			{
				_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			}
			var _loc_8:Number = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
			var _loc_9:Array = new Array();
			_loc_10 = 0;
			while(_loc_10 < _loc_8)
			{
				_loc_11 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
				_loc_12 = EsObjectCodec.decode(param1);
				_loc_17 = new UserVariable(_loc_11, _loc_12);
				_loc_9.push(_loc_17);
				_loc_10 = _loc_10 + 1;
			}
			_loc_2.setUserVariables(_loc_9);
			var _loc_13:Number = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
			var _loc_14:Object = new Object();
			_loc_10 = 0;
			while(_loc_10 < _loc_13)
			{
				_loc_11 = param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_12 = EsObjectCodec.decode(param1);
				_loc_14[_loc_11] = _loc_12;
				_loc_10 = _loc_10 + 1;
			}
			_loc_2.setBuddies(_loc_14);
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class LogoutRequestCodec extends MessageCodecImpl
	{
		public function LogoutRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:LogoutRequest = LogoutRequest(param2);
			param1.writeBoolean(_loc_3.getDropAllConnections());
			if(!_loc_3.getDropAllConnections())
			{
				param1.writeBoolean(_loc_3.getDropConnection());
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.protocol.*;

	public interface MessageCodec
	{
		function encode(param1:MessageWriter, param2:Message) : void;

		function decode(param1:MessageReader) : Message;
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.protocol.*;

	public class MessageCodecImpl extends Object implements MessageCodec
	{
		public function MessageCodecImpl()
		{
			super();
		}

		public function encode(param1:MessageWriter, param2:Message) : void
		{
			trace("Error: 'encode' method not over-written in a codec for " + param2.getMessageType().getMessageTypeName());
		}

		public function decode(param1:MessageReader) : Message
		{
			var _loc_2:Message = null;
			trace("Error: 'decode' method not over-written in a codec for this message");
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PluginMessageEventCodec extends MessageCodecImpl
	{
		public function PluginMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_3:EsObject = null;
			var _loc_2:PluginMessageEvent = new PluginMessageEvent();
			_loc_2.setPluginName(param1.nextPrefixedString(MessageConstants.PLUGIN_PARM_NAME_PREFIX_LENGTH));
			_loc_2.setSentToRoom(param1.nextBoolean());
			if(_loc_2.wasSentToRoom())
			{
				_loc_2.setDestinationZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_2.setDestinationRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			}
			_loc_2.setIsRoomLevelPlugin(param1.nextBoolean());
			if(_loc_2.getIsRoomLevelPlugin())
			{
				_loc_2.setOriginZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
				_loc_2.setOriginRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			}
			if(param1.nextBoolean())
			{
				_loc_3 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_3);
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PluginRequestCodec extends MessageCodecImpl
	{
		public function PluginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:PluginRequest = PluginRequest(param2);
			param1.writePrefixedString(_loc_3.getPluginName(), MessageConstants.PLUGIN_NAME_PREFIX_LENGTH);
			param1.writeBoolean(_loc_3.wasSentToRoom());
			if(_loc_3.wasSentToRoom())
			{
				param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
				param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			}
			var _loc_4:EsObject = _loc_3.getEsObject();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PrivateMessageEventCodec extends MessageCodecImpl
	{
		public function PrivateMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:EsObject = null;
			var _loc_2:PrivateMessageEvent = new PrivateMessageEvent();
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			_loc_2.setMessage(param1.nextPrefixedString(MessageConstants.PRIVATE_MESSAGE_PREFIX_LENGTH));
			var _loc_3:Boolean = param1.nextBoolean();
			if(_loc_3)
			{
				_loc_4 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_4);
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PrivateMessageRequestCodec extends MessageCodecImpl
	{
		public function PrivateMessageRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_5:int = NaN;
			var _loc_8:String = null;
			var _loc_3:PrivateMessageRequest = PrivateMessageRequest(param2);
			var _loc_4:Array = _loc_3.getUsers();
			param1.writeInteger(_loc_4.length, MessageConstants.USER_COUNT_LENGTH);
			_loc_5 = 0;
			while(_loc_5 < _loc_4.length)
			{
				param1.writeLong(_loc_4[_loc_5].getUserId(), MessageConstants.USER_ID_LENGTH);
				_loc_5 = _loc_5 + 1;
			}
			var _loc_6:Array = _loc_3.getUserNames();
			param1.writeInteger(_loc_6.length, MessageConstants.USER_COUNT_LENGTH);
			_loc_5 = 0;
			while(_loc_5 < _loc_6.length)
			{
				_loc_8 = _loc_6[_loc_5];
				param1.writePrefixedString(_loc_8, MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_5 = _loc_5 + 1;
			}
			param1.writePrefixedString(_loc_3.getMessage(), MessageConstants.PRIVATE_MESSAGE_PREFIX_LENGTH);
			var _loc_7:EsObject = _loc_3.getEsObject();
			if(_loc_7 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_7);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PublicMessageEventCodec extends MessageCodecImpl
	{
		public function PublicMessageEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_4:EsObject = null;
			var _loc_2:PublicMessageEvent = new PublicMessageEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setUserNameIncluded(param1.nextBoolean());
			if(_loc_2.isUserNameIncluded())
			{
				_loc_2.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
			}
			_loc_2.setMessage(param1.nextPrefixedString(MessageConstants.PUBLIC_MESSAGE_PREFIX_LENGTH));
			var _loc_3:Boolean = param1.nextBoolean();
			if(_loc_3)
			{
				_loc_4 = EsObjectCodec.decode(param1);
				_loc_2.setEsObject(_loc_4);
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class PublicMessageRequestCodec extends MessageCodecImpl
	{
		public function PublicMessageRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:PublicMessageRequest = PublicMessageRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getMessage(), MessageConstants.PUBLIC_MESSAGE_PREFIX_LENGTH);
			var _loc_4:EsObject = _loc_3.getEsObject();
			if(_loc_4 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				EsObjectCodec.encode(param1, _loc_4);
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RemoveBuddyRequestCodec extends MessageCodecImpl
	{
		public function RemoveBuddyRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:RemoveBuddyRequest = RemoveBuddyRequest(param2);
			param1.writePrefixedString(_loc_3.getBuddyName(), MessageConstants.USER_NAME_PREFIX_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RemoveRoomOperatorRequestCodec extends MessageCodecImpl
	{
		public function RemoveRoomOperatorRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:RemoveRoomOperatorRequest = RemoveRoomOperatorRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeLong(_loc_3.getUserId(), MessageConstants.USER_ID_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RoomVariableCodec extends Object
	{
		final public static function encode(param1:MessageWriter, param2:Array) : void
		{
			var _loc_4:RoomVariable = null;
			param1.writeInteger(param2.length, MessageConstants.ROOM_VARIABLE_COUNT_LENGTH);
			var _loc_3:Number = 0;
			while(_loc_3 < param2.length)
			{
				_loc_4 = param2[_loc_3];
				param1.writePrefixedString(_loc_4.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
				EsObjectCodec.encode(param1, _loc_4.getValue());
				param1.writeBoolean(_loc_4.getLocked());
				param1.writeBoolean(_loc_4.getPersistent());
				_loc_3 = _loc_3 + 1;
			}
		}

		final public static function decode(param1:MessageReader) : Array
		{
			var _loc_5:String = null;
			var _loc_6:EsObject = null;
			var _loc_7:Boolean = false;
			var _loc_8:Boolean = false;
			var _loc_9:RoomVariable = null;
			var _loc_2:Array = new Array();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ROOM_VARIABLE_COUNT_LENGTH);
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = param1.nextPrefixedString(MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
				_loc_6 = EsObjectCodec.decode(param1);
				_loc_7 = param1.nextBoolean();
				_loc_8 = param1.nextBoolean();
				_loc_9 = new RoomVariable(_loc_5, _loc_6, _loc_7, _loc_8);
				_loc_2.push(_loc_9);
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		public function RoomVariableCodec()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class RoomVariableUpdateEventCodec extends MessageCodecImpl
	{
		public function RoomVariableUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:RoomVariableUpdateEvent = new RoomVariableUpdateEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUpdateAction(param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH));
			_loc_2.setName(param1.nextPrefixedString(MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH));
			if(_loc_2.getUpdateAction() != RoomVariableUpdateEvent.VariableDeleted)
			{
				_loc_2.setValueChanged(param1.nextBoolean());
				if(_loc_2.getValueChanged())
				{
					_loc_2.setValue(EsObjectCodec.decode(param1));
				}
				_loc_2.setLockChanged(param1.nextBoolean());
				if(_loc_2.getLockChanged())
				{
					_loc_2.setLocked(param1.nextBoolean());
				}
				if(_loc_2.getUpdateAction() == RoomVariableUpdateEvent.VariableCreated)
				{
					_loc_2.setPersistent(param1.nextBoolean());
				}
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;

	public class SearchCriteriaCodec extends MessageCodecImpl
	{
		final public static function encode(param1:MessageWriter, param2:SearchCriteria) : void
		{
			var _loc_3:EsObject = null;
			if(param2 == null)
			{
				param1.writeBoolean(false);
			}
			else
			{
				param1.writeBoolean(true);
				if(param2.getGameId() == -1)
				{
					param1.writeBoolean(false);
				}
				else
				{
					param1.writeBoolean(true);
					param1.writeInteger(param2.getGameId());
				}
				param1.writeString(param2.getGameType());
				param1.writeBoolean(param2.getLockedSet());
				if(param2.getLockedSet())
				{
					param1.writeBoolean(param2.getLocked());
				}
				_loc_3 = param2.getGameDetails();
				if(_loc_3 == null)
				{
					param1.writeBoolean(false);
				}
				else
				{
					param1.writeBoolean(true);
					EsObjectCodec.encode(param1, _loc_3);
				}
			}
		}

		public function SearchCriteriaCodec()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateRoomDetailsEventCodec extends MessageCodecImpl
	{
		public function UpdateRoomDetailsEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:UpdateRoomDetailsEvent = new UpdateRoomDetailsEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setRoomNameUpdate(param1.nextBoolean());
			if(_loc_2.isRoomNameUpdate())
			{
				_loc_2.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
			}
			_loc_2.setCapacityUpdate(param1.nextBoolean());
			if(_loc_2.isCapacityUpdate())
			{
				_loc_2.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
			}
			_loc_2.setDescriptionUpdate(param1.nextBoolean());
			if(_loc_2.isDescriptionUpdate())
			{
				_loc_2.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
			}
			_loc_2.setPasswordUpdate(param1.nextBoolean());
			_loc_2.setHiddenUpdate(param1.nextBoolean());
			if(_loc_2.isHiddenUpdate())
			{
				_loc_2.setHidden(param1.nextBoolean());
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateRoomDetailsRequestCodec extends MessageCodecImpl
	{
		public function UpdateRoomDetailsRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:UpdateRoomDetailsRequest = UpdateRoomDetailsRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writeBoolean(_loc_3.isRoomNameUpdate());
			if(_loc_3.isRoomNameUpdate())
			{
				param1.writePrefixedString(_loc_3.getRoomName(), MessageConstants.ROOM_NAME_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isCapacityUpdate());
			if(_loc_3.isCapacityUpdate())
			{
				param1.writeInteger(_loc_3.getCapacity(), MessageConstants.ROOM_CAPACITY_LENGTH);
			}
			param1.writeBoolean(_loc_3.isDescriptionUpdate());
			if(_loc_3.isDescriptionUpdate())
			{
				param1.writePrefixedString(_loc_3.getDescription(), MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isPasswordUpdate());
			if(_loc_3.isPasswordUpdate())
			{
				param1.writePrefixedString(_loc_3.getPassword(), MessageConstants.ROOM_PASSWORD_PREFIX_LENGTH);
			}
			param1.writeBoolean(_loc_3.isHiddenUpdate());
			if(_loc_3.isHiddenUpdate())
			{
				param1.writeBoolean(_loc_3.getHidden());
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateRoomVariableRequestCodec extends MessageCodecImpl
	{
		public function UpdateRoomVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:UpdateRoomVariableRequest = UpdateRoomVariableRequest(param2);
			param1.writeInteger(_loc_3.getZoneId(), MessageConstants.ZONE_ID_LENGTH);
			param1.writeInteger(_loc_3.getRoomId(), MessageConstants.ROOM_ID_LENGTH);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.ROOM_VARIABLE_NAME_PREFIX_LENGTH);
			param1.writeBoolean(_loc_3.hasValueChanged());
			if(_loc_3.hasValueChanged())
			{
				EsObjectCodec.encode(param1, _loc_3.getValue());
			}
			param1.writeBoolean(_loc_3.hasLockStatusChanged());
			if(_loc_3.hasLockStatusChanged())
			{
				param1.writeBoolean(_loc_3.getLocked());
			}
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UpdateUserVariableRequestCodec extends MessageCodecImpl
	{
		public function UpdateUserVariableRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:UpdateUserVariableRequest = UpdateUserVariableRequest(param2);
			param1.writePrefixedString(_loc_3.getName(), MessageConstants.USER_VARIABLE_NAME_PREFIX_LENGTH);
			EsObjectCodec.encode(param1, _loc_3.getValue());
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserEvictedFromRoomEventCodec extends MessageCodecImpl
	{
		public function UserEvictedFromRoomEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:UserEvictedFromRoomEvent = new UserEvictedFromRoomEvent();
			_loc_2.setZoneId(param1.nextInteger(MessageConstants.ZONE_ID_LENGTH));
			_loc_2.setRoomId(param1.nextInteger(MessageConstants.ROOM_ID_LENGTH));
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			_loc_2.setReason(param1.nextPrefixedString(MessageConstants.ROOM_EVICTION_REASON_PREFIX_LENGTH));
			_loc_2.setBan(param1.nextBoolean());
			if(_loc_2.isBan())
			{
				_loc_2.setDuration(param1.nextInteger(MessageConstants.ROOM_BAN_DURATION_LENGTH));
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.user.*;

	public class UserListCodec extends Object
	{
		final public static function decode(param1:MessageReader) : Array
		{
			var _loc_5:User = null;
			var _loc_6:String = null;
			var _loc_7:int = NaN;
			var _loc_8:int = NaN;
			var _loc_9:String = null;
			var _loc_10:EsObject = null;
			var _loc_2:Array = new Array();
			var _loc_3:Number = param1.nextInteger(MessageConstants.USER_COUNT_LENGTH);
			var _loc_4:Number = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = new User();
				_loc_6 = param1.nextLong(MessageConstants.USER_ID_LENGTH);
				_loc_5.setUserId(_loc_6);
				_loc_5.setUserName(param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH));
				_loc_7 = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
				_loc_8 = 0;
				while(_loc_8 < _loc_7)
				{
					_loc_9 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
					_loc_10 = EsObjectCodec.decode(param1);
					_loc_5.addUserVariable(new UserVariable(_loc_9, _loc_10));
					_loc_8 = _loc_8 + 1;
				}
				_loc_5.setIsSendingVideo(param1.nextBoolean());
				if(_loc_5.getIsSendingVideo())
				{
					_loc_5.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
				_loc_2.push(_loc_5);
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		public function UserListCodec()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserListUpdateEventCodec extends MessageCodecImpl
	{
		public function UserListUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_7:String = null;
			var _loc_8:int = NaN;
			var _loc_9:Array = null;
			var _loc_10:int = NaN;
			var _loc_11:String = null;
			var _loc_12:EsObject = null;
			var _loc_2:UserListUpdateEvent = new UserListUpdateEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_4);
			var _loc_5:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_5);
			var _loc_6:String = param1.nextLong(MessageConstants.USER_ID_LENGTH);
			_loc_2.setUserId(_loc_6);
			if(_loc_5 == UserListUpdateEvent.AddUser)
			{
				_loc_7 = param1.nextPrefixedString(MessageConstants.USER_NAME_PREFIX_LENGTH);
				_loc_2.setUserName(_loc_7);
				_loc_8 = param1.nextInteger(MessageConstants.VARIABLE_COUNT_LENGTH);
				_loc_9 = new Array();
				_loc_10 = 0;
				while(_loc_10 < _loc_8)
				{
					_loc_11 = param1.nextPrefixedString(MessageConstants.VARIABLE_NAME_PREFIX_LENGTH);
					_loc_12 = EsObjectCodec.decode(param1);
					_loc_9.push(new UserVariable(_loc_11, _loc_12));
					_loc_10 = _loc_10 + 1;
				}
				_loc_2.setUserVariables(_loc_9);
				_loc_2.setIsSendingVideo(param1.nextBoolean());
				if(_loc_2.getIsSendingVideo())
				{
					_loc_2.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
			}
			else
			{
				if(_loc_5 == UserListUpdateEvent.SendingVideoStream)
				{
					_loc_2.setIsSendingVideo(true);
					_loc_2.setVideoStreamName(param1.nextPrefixedString(MessageConstants.VIDEO_STREAM_NAME_PREFIX_LENGTH));
				}
				else
				{
					if(_loc_5 == UserListUpdateEvent.StoppingVideoStream)
					{
						_loc_2.setIsSendingVideo(false);
						_loc_2.setVideoStreamName("");
					}
				}
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.entities.*;
	import com.electrotank.electroserver4.esobject.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;

	public class UserVariableUpdateEventCodec extends MessageCodecImpl
	{
		public function UserVariableUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_5:EsObject = null;
			var _loc_2:UserVariableUpdateEvent = new UserVariableUpdateEvent();
			_loc_2.setUserId(param1.nextLong(MessageConstants.USER_ID_LENGTH));
			var _loc_3:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_3);
			var _loc_4:String = param1.nextPrefixedString(MessageConstants.USER_VARIABLE_NAME_PREFIX_LENGTH);
			_loc_2.setVariableName(_loc_4);
			if(_loc_2.getActionId() != UserVariableUpdateEvent.VariableDeleted)
			{
				_loc_5 = EsObjectCodec.decode(param1);
				_loc_2.setVariable(new UserVariable(_loc_4, _loc_5));
			}
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.request.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ValidateAdditionalLoginRequestCodec extends MessageCodecImpl
	{
		public function ValidateAdditionalLoginRequestCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:ValidateAdditionalLoginRequest = ValidateAdditionalLoginRequest(param2);
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_2:ValidateAdditionalLoginRequest = new ValidateAdditionalLoginRequest();
			_loc_2.setSecret(param1.nextPrefixedString(MessageConstants.SHARED_SECRET_LENGTH));
			return _loc_2;
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.response.*;
	import com.electrotank.electroserver4.protocol.*;

	public class ValidateAdditionalLoginResponseCodec extends MessageCodecImpl
	{
		public function ValidateAdditionalLoginResponseCodec()
		{
			super();
		}

		override public function encode(param1:MessageWriter, param2:Message) : void
		{
			var _loc_3:ValidateAdditionalLoginResponse = ValidateAdditionalLoginResponse(param2);
			param1.writeBoolean(_loc_3.getApproved());
			param1.writePrefixedString(_loc_3.getSecret(), MessageConstants.SHARED_SECRET_LENGTH);
		}
	}
}
package com.electrotank.electroserver4.protocol.codec
{
	import com.electrotank.electroserver4.*;
	import com.electrotank.electroserver4.message.*;
	import com.electrotank.electroserver4.message.event.*;
	import com.electrotank.electroserver4.protocol.*;
	import com.electrotank.electroserver4.room.*;

	public class ZoneUpdateEventCodec extends MessageCodecImpl
	{
		public function ZoneUpdateEventCodec()
		{
			super();
		}

		override public function decode(param1:MessageReader) : Message
		{
			var _loc_6:Room = null;
			var _loc_7:int = NaN;
			var _loc_2:ZoneUpdateEvent = new ZoneUpdateEvent();
			var _loc_3:Number = param1.nextInteger(MessageConstants.ZONE_ID_LENGTH);
			_loc_2.setZoneId(_loc_3);
			var _loc_4:Number = param1.nextShort(MessageConstants.UPDATE_ACTION_LENGTH);
			_loc_2.setActionId(_loc_4);
			var _loc_5:Number = param1.nextInteger(MessageConstants.ROOM_ID_LENGTH);
			_loc_2.setRoomId(_loc_5);
			if(_loc_4 == ZoneUpdateEvent.AddRoom)
			{
				_loc_6 = new Room();
				_loc_6.setZoneId(_loc_3);
				_loc_6.setRoomId(_loc_5);
				_loc_6.setRoomName(param1.nextPrefixedString(MessageConstants.ROOM_NAME_PREFIX_LENGTH));
				_loc_6.setUserCount(param1.nextInteger(MessageConstants.USER_COUNT_LENGTH));
				_loc_6.setCapacity(param1.nextInteger(MessageConstants.ROOM_CAPACITY_LENGTH));
				_loc_6.setHasPassword(param1.nextBoolean());
				_loc_6.setDescription(param1.nextPrefixedString(MessageConstants.ROOM_DESCRIPTION_PREFIX_LENGTH));
				_loc_2.setRoom(_loc_6);
			}
			if(_loc_4 != ZoneUpdateEvent.DeleteRoom)
			{
				_loc_7 = param1.nextInteger(MessageConstants.ROOM_COUNT_LENGTH);
				_loc_2.setRoomCount(_loc_7);
			}
			return _loc_2;
		}
	}
}
