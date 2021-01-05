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
