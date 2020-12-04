package Misc
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;

	public class SmallAd extends Sprite
	{
		private var interval:uint = 0;
		private var ad:int;
		private var ads:Array;
		private var _text:TextField;

		public function SmallAd()
		{
			super();
			ads = new Array();
			var _loc_1:Object = new Object();
			_loc_1.name = "Art of Problem Solving, Volume 1: The Basics";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=100";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Art of Problem Solving, Volume 1: and Beyond";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=102";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Algebra by Richard Rusczyk";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=200";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Counting and Probability by David Patrick";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=202";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Geometry by Richard Rusczyk";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=204";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "Introduction to Number Theory by Mathew Crawford";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_Item.php?item_id=206";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "MATHCOUNTS books";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_CP_MC.php";
			ads.push(_loc_1);
			_loc_1 = new Object();
			_loc_1.name = "AMC Preparation books";
			_loc_1.url = "http://www.artofproblemsolving.com/Books/AoPS_B_CP_AMC.php";
			ads.push(_loc_1);
			addEventListener(MouseEvent.CLICK, onAdClick);
			addEventListener(Event.ADDED, startTimer);
			addEventListener(Event.REMOVED, destroy);
		}

		private function updateAd() : void
		{
			ad = Math.floor(Math.random() * ads.length);
			_text.text = ads[ad].name;
		}

		private function onAdClick(param1:Event) : void
		{
			navigateToURL(new URLRequest(ads[ad].url), "_blank");
		}

		private function startTimer(param1:Event) : void
		{
			trace("Start timer");
			updateAd();
			interval = setInterval(updateAd, 60000);
		}

		private function destroy(param1:Event) : void
		{
			trace("Destroy");
			if(interval != 0)
			{
				clearInterval(interval);
			}
			removeEventListener(MouseEvent.CLICK, onAdClick);
			removeEventListener(Event.ADDED, startTimer);
			removeEventListener(Event.REMOVED, destroy);
		}
	}
}
