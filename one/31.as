package com.electrotank.electroserver4.zone
{
	import com.electrotank.electroserver4.room.*;

	public class Zone extends Object
	{
		private var zoneId:Number;
		private var zoneName:String;
		private var rooms:Array;
		private var roomsById:Object;
		private var roomsByName:Object;
		private var joinedRooms:Array;

		public function Zone()
		{
			super();
			rooms = new Array();
			roomsById = new Object();
			roomsByName = new Object();
			joinedRooms = new Array();
		}

		public function getJoinedRooms() : Array
		{
			return joinedRooms;
		}

		public function addJoinedRoom(param1:Room) : void
		{
			joinedRooms.push(param1);
		}

		public function removeJoinedRoom(param1:Room) : void
		{
			var _loc_2:Number = 0;
			while(_loc_2 < joinedRooms.length)
			{
				if(joinedRooms[_loc_2] == param1)
				{
					joinedRooms.splice(_loc_2, 1);
					break;
				}
				_loc_2 = _loc_2 + 1;
			}
		}

		public function addRoom(param1:Room) : void
		{
			if(roomsById[param1.getRoomId()] == null)
			{
				getRooms().push(param1);
				roomsById[param1.getRoomId()] = param1;
				roomsByName[param1.getRoomName()] = param1;
			}
			else
			{
				trace("Error: tried to add a room with an id that already exists. roomId: " + param1.getRoomId() + " roomName: " + param1.getRoomName());
			}
		}

		public function doesRoomExist(param1:Number) : Boolean
		{
			return !(getRoomById(param1) == null);
		}

		public function getRoomByName(param1:String) : Room
		{
			return roomsByName[param1];
		}

		public function getRoomById(param1:Number) : Room
		{
			return roomsById[param1];
		}

		public function removeRoom(param1:Number) : void
		{
			var _loc_3:int = NaN;
			var _loc_2:Room = getRoomById(param1);
			if(_loc_2 == null)
			{
				trace("Error: tried to remove a room and the roomId was not found. roomId: " + param1);
			}
			else
			{
				roomsById[param1] = null;
				roomsByName[_loc_2.getRoomName()] = null;
				_loc_3 = 0;
				while(_loc_3 < getRooms().length)
				{
					if(getRooms()[_loc_3] == _loc_2)
					{
						getRooms().splice(_loc_3, 1);
						break;
					}
					_loc_3 = _loc_3 + 1;
				}
			}
		}

		public function getRooms() : Array
		{
			return rooms;
		}

		public function setZoneId(param1:Number) : void
		{
			zoneId = param1;
		}

		public function getZoneId() : Number
		{
			return zoneId;
		}

		public function setZoneName(param1:String) : void
		{
			zoneName = param1;
		}

		public function getZoneName() : String
		{
			return zoneName;
		}
	}
}
package com.electrotank.electroserver4.zone
{
	public class ZoneManager extends Object
	{
		private var zones:Array;
		private var zonesById:Object;
		private var zonesByName:Object;

		public function ZoneManager()
		{
			super();
			zones = new Array();
			zonesById = new Object();
			zonesByName = new Object();
		}

		public function getZones() : Array
		{
			return zones;
		}

		public function removeZone(param1:Number) : void
		{
			var _loc_3:int = NaN;
			var _loc_4:Zone = null;
			var _loc_2:Zone = getZoneById(param1);
			if(_loc_2 != null)
			{
				zonesById[param1.toString()] = null;
				zonesByName[_loc_2.getZoneName()] = null;
				_loc_3 = 0;
				while(_loc_3 < zones.length)
				{
					_loc_4 = zones[_loc_3];
					if(_loc_4.getZoneId() == param1)
					{
						zones.splice(_loc_3, 1);
						break;
					}
					_loc_3 = _loc_3 + 1;
				}
			}
			else
			{
				trace("Error: Tried removing zone that wasn't being managed by the ZoneManager.");
			}
		}

		public function addZone(param1:Zone) : void
		{
			if(zonesById[param1.getZoneId().toString()] == null)
			{
				getZones().push(param1);
				zonesByName[param1.getZoneName()] = param1;
				zonesById[param1.getZoneId().toString()] = param1;
			}
			else
			{
				trace("Error: this zone has already been added. zoneId: " + param1.getZoneId().toString());
			}
		}

		public function getZoneById(param1:Number) : Zone
		{
			var _loc_2:Zone = zonesById[param1.toString()];
			if(_loc_2 == null)
			{
				trace("Error: getZoneById() could not find a zone with this id: " + param1);
			}
			return _loc_2;
		}

		public function getZoneByName(param1:String) : Zone
		{
			var _loc_2:Zone = zonesByName[param1];
			if(_loc_2 == null)
			{
				trace("Error: getZoneByName() could not find a zone with this name: " + param1);
			}
			return _loc_2;
		}
	}
}
