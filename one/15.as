package com.electrotank.electroserver4.errors
{
	public class Errors extends Object
	{
		private static var errorsById:Array;
		public static var UserNameExists:EsError = Errors.register(new EsError(0, "UserNameExists"));
		public static var UserAlreadyLoggedIn:EsError = Errors.register(new EsError(1, "UserAlreadyLoggedIn"));
		public static var InvalidMessageNumber:EsError = Errors.register(new EsError(2, "InvalidMessageNumber"));
		public static var InboundMessageFailedValidation:EsError = Errors.register(new EsError(3, "InboundMessageFailedValidation"));
		public static var MaximumClientConnectionsReached:EsError = Errors.register(new EsError(4, "MaximumClientConnectionsReached"));
		public static var ZoneNotFound:EsError = Errors.register(new EsError(5, "ZoneNotFound"));
		public static var RoomNotFound:EsError = Errors.register(new EsError(6, "RoomNotFound"));
		public static var RoomAtCapacity:EsError = Errors.register(new EsError(7, "RoomAtCapacity"));
		public static var RoomPasswordMismatch:EsError = Errors.register(new EsError(8, "RoomPasswordMismatch"));
		public static var GatewayPaused:EsError = Errors.register(new EsError(9, "GatewayPaused"));
		public static var AccessDenied:EsError = Errors.register(new EsError(10, "AccessDenied"));
		public static var RoomVariableLocked:EsError = Errors.register(new EsError(11, "RoomVariableLocked"));
		public static var RoomVariableAlreadyExists:EsError = Errors.register(new EsError(12, "RoomVariableAlreadyExists"));
		public static var DuplicateRoomName:EsError = Errors.register(new EsError(13, "DuplicateRoomName"));
		public static var DuplicateZoneName:EsError = Errors.register(new EsError(14, "DuplicateZoneName"));
		public static var UserVariableAlreadyExists:EsError = Errors.register(new EsError(15, "UserVariableAlreadyExists"));
		public static var UserVariableDoesNotExist:EsError = Errors.register(new EsError(16, "UserVariableDoesNotExist"));
		public static var ZoneAllocationFailure:EsError = Errors.register(new EsError(17, "ZoneAllocationFailure"));
		public static var RoomAllocationFailure:EsError = Errors.register(new EsError(18, "RoomAllocationFailure"));
		public static var UserBanned:EsError = Errors.register(new EsError(19, "UserBanned"));
		public static var UserAlreadyInRoom:EsError = Errors.register(new EsError(20, "UserAlreadyInRoom"));
		public static var VulgarityCheckFailed:EsError = Errors.register(new EsError(21, "VulgarityCheckFailed"));
		public static var ActionCausedError:EsError = Errors.register(new EsError(22, "ActionCausedError"));
		public static var ActionRequiresLogin:EsError = Errors.register(new EsError(23, "ActionRequiresLogin"));
		public static var GenericError:EsError = Errors.register(new EsError(24, "GenericError"));
		public static var PluginNotFound:EsError = Errors.register(new EsError(25, "PluginNotFound"));
		public static var LoginEventHandlerFailure:EsError = Errors.register(new EsError(26, "LoginEventHandlerFailure"));
		public static var InvalidUserName:EsError = Errors.register(new EsError(27, "InvalidUserName"));
		public static var ExtensionNotFound:EsError = Errors.register(new EsError(28, "ExtensionNotFound"));
		public static var PluginInitializationFailed:EsError = Errors.register(new EsError(29, "PluginInitializationFailed"));
		public static var EventNotFound:EsError = Errors.register(new EsError(30, "EventNotFound"));
		public static var FloodingFilterCheckFailed:EsError = Errors.register(new EsError(31, "FloodingFilterCheckFailed"));
		public static var UserNotJoinedToRoom:EsError = Errors.register(new EsError(32, "UserNotJoinedToRoom"));
		public static var ManagedObjectNotFound:EsError = Errors.register(new EsError(33, "ManagedObjectNotFound"));
		public static var IdleTimeReached:EsError = Errors.register(new EsError(34, "IdleTimeReached"));
		public static var ServerError:EsError = Errors.register(new EsError(35, "ServerError"));
		public static var OperationNotSupported:EsError = Errors.register(new EsError(36, "OperationNotSupported"));
		public static var InvalidLanguageFilterSettings:EsError = Errors.register(new EsError(37, "InvalidLanguageFilterSettings"));
		public static var InvalidFloodingFilterSettings:EsError = Errors.register(new EsError(38, "InvalidFloodingFilterSettings"));
		public static var ExtensionForcedReload:EsError = Errors.register(new EsError(39, "ExtensionForcedReload"));
		public static var UserLogOutRequested:EsError = Errors.register(new EsError(40, "UserLogOutRequested"));
		public static var OnlyRtmpConnectionRemains:EsError = Errors.register(new EsError(41, "OnlyRtmpConnectionRemains"));
		public static var GameDoesntExist:EsError = Errors.register(new EsError(42, "GameDoesntExist"));
		public static var FailedToJoinGameRoom:EsError = Errors.register(new EsError(43, "FailedToJoinGameRoom"));
		public static var GameIsLocked:EsError = Errors.register(new EsError(44, "GameIsLocked"));
		public static var InvalidParameters:EsError = Errors.register(new EsError(45, "InvalidParameters"));
		public static var PublicMessageRejected:EsError = Errors.register(new EsError(46, "PublicMessageRejected"));
		public static var FailedToConnect:EsError = Errors.register(new EsError(1000, "FailedToConnect"));

		final public static function getErrorById(param1:Number) : EsError
		{
			var _loc_2:EsError = errorsById[param1];
			if(_loc_2 == null)
			{
				Errors.trace("Error: tried to 'getErrorById' but error was not found with id: " + param1.toString());
			}
			return _loc_2;
		}

		final public static function register(param1:EsError) : EsError
		{
			if(errorsById == null)
			{
				errorsById = new Array();
			}
			errorsById[param1.getId()] = param1;
			return param1;
		}

		public function Errors()
		{
			super();
		}
	}
}
package com.electrotank.electroserver4.errors
{
	public class EsError extends Object
	{
		private var id:Number;
		private var description:String;

		public function EsError(param1:Number, param2:String)
		{
			super();
			id = param1;
			description = param2;
		}

		public function getDescription() : String
		{
			return description;
		}

		public function getId() : Number
		{
			return id;
		}
	}
}
