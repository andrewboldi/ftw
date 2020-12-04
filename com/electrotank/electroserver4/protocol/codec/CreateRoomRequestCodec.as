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
