package fl.data
{
	dynamic public class SimpleCollectionItem extends Object
	{
		public var label:String;
		public var data:String;

		public function SimpleCollectionItem()
		{
			super();
		}

		public function toString() : String
		{
			return "[SimpleCollectionItem: " + label + "," + data + "]";
		}
	}
}
