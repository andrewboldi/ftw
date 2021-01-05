package Game
{
	import Misc.*;
	import com.electrotank.electroserver4.esobject.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class Problem extends EventDispatcher
	{
		public var number:uint = 0;
		public var id:uint = 0;
		public var filename:String = "";
		public var answer:String = "";
		public var real_answer:String = "";
		public var answers:Array;
		public var user_answer:String = "";
		public var book:uint = -28;
		public var image:Loader = null;
		public var loaded:Boolean = false;
		public var error:String = "";
		public var reported:Boolean = false;
		public var loadInterval:uint = 0;
		public var loadCount:uint = 0;

		public function Problem(param1:uint)
		{
			super();
			this.number = param1;
			g.server.addEventListener("pluginMessage", "on_plugin_message", this);
			this.answers = new Array();
			loadCount = 0;
			poll();
		}

		override public function toString() : String
		{
			var _loc_1:String = null;
			_loc_1 = "Problem Number: " + number + "\n" + "Problem ID: " + id + "\n" + "Filename: " + filename + "\n" + "Answer: " + answer + "\n" + "User Answer: " + user_answer + "\n" + "Book: " + book + "\n" + "Loaded: " + loaded + "\n" + "Error: " + error + "\n" + "Reported: " + reported + "\n" + "Load Interval: " + loadInterval + "\n" + "Load Count: " + loadCount;
			return _loc_1;
		}

		public function load_image() : void
		{
			if(loadInterval != 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
			var _loc_1:URLRequest = new URLRequest(filename);
			image = new Loader();
			image.load(_loc_1);
			EventManager.add(image.contentLoaderInfo, Event.COMPLETE, setloaded);
			EventManager.add(image.contentLoaderInfo, IOErrorEvent.IO_ERROR, seterror);
			g.debug;
			if(g.debug && 1 == 0)
			{
				EventManager.add(image.contentLoaderInfo, HTTPStatusEvent.HTTP_STATUS, http_status_handler);
				EventManager.add(image.contentLoaderInfo, Event.INIT, init_handler);
				EventManager.add(image.contentLoaderInfo, Event.OPEN, open_handler);
				EventManager.add(image.contentLoaderInfo, Event.UNLOAD, unload_handler);
				EventManager.add(image.contentLoaderInfo, ProgressEvent.PROGRESS, progress_handler);
			}
		}

		public function on_plugin_message(param1:Object) : void
		{
			var _loc_2:int = 0;
			var _loc_3:Array = null;
			var _loc_4:int = 0;
			switch(param1.response.Action)
			{
			case "Problem":
				if(param1.response.number != this.number)
				{
					return;
				}
				if(param1.response.file.length > 10)
				{
					g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
					if(!g.user.s3)
					{
						_loc_2 = 0;
						_loc_2 = this.filename.lastIndexOf("/");
						param1.response.file = "http://www.artofproblemsolving.com/Forum/latexrender/pictures/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 1)) + "/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 2)) + "/";
						param1.response.file = param1.response.file + (this.filename.charAt(_loc_2 + 3)) + "/";
						param1.response.file = param1.response.file + (this.filename.substr(_loc_2 + 1));
					}
					this.id = param1.response.id;
					this.book = param1.response.book;
					this.answer = g.clean_answer(param1.response.answer);
					this.real_answer = param1.response.answer;
					this.filename = param1.response.file;
					load_image();
					this.answers = new Array();
					this.answers.push(this.answer);
					if(param1.response.alt_answers.length > 0)
					{
						_loc_3 = String(param1.response.alt_answers).split("\n");
						if(_loc_3.length > 0)
						{
							_loc_4 = _loc_3.length - 1;
							while(_loc_4 >= 0)
							{
								this.answers.push(g.clean_answer(_loc_3[_loc_4]));
								_loc_4 = _loc_4 - 1;
							}
						}
					}
				}
				else
				{
					if(loadInterval > 0)
					{
						clearInterval(loadInterval);
					}
					g.scene.debug("on-plugin_message: Setting interval");
					loadInterval = setInterval(poll, 1000);
				}
				break;
			default:
				break;
			}
		}

		private function poll() : void
		{
			var _loc_1:EsObject = null;
			if(loadInterval > 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
			if(g.server.isConnected)
			{
				_loc_1 = new EsObject();
				_loc_1.setInteger("n", this.number);
				g.server.esRoomPlugin("Game", g.game.zone_name, g.game.room_name, "Problem", _loc_1);
			}
		}

		private function setloaded(param1:Event) : void
		{
			remove_load_event_listeners();
			this.loaded = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function seterror(param1:IOErrorEvent) : void
		{
			var _loc_2:EsObject = new EsObject();
			_loc_2.setString("message", "I/O Error loading " + number + " " + filename + " " + param1.text);
			g.server.esRoomPlugin("Game", g.game.zone_name, g.game.room_name, "log", _loc_2);
			remove_load_event_listeners();
			var _loc_4:* = this.loadCount + 1;
			this.loadCount = _loc_4;
			if(loadCount >= 3)
			{
				this.error = param1.text;
			}
			else
			{
				loadInterval = setInterval(load_image, 3000);
				var _loc_4:* = this.loadCount + 1;
				this.loadCount = _loc_4;
			}
		}

		private function remove_load_event_listeners() : void
		{
			if(image)
			{
				EventManager.remove(image.contentLoaderInfo, Event.COMPLETE, setloaded);
				EventManager.remove(image.contentLoaderInfo, IOErrorEvent.IO_ERROR, seterror);
				g.debug;
				if(g.debug && 1 == 0)
				{
					EventManager.remove(image.contentLoaderInfo, HTTPStatusEvent.HTTP_STATUS, http_status_handler);
					EventManager.remove(image.contentLoaderInfo, Event.INIT, init_handler);
					EventManager.remove(image.contentLoaderInfo, Event.OPEN, open_handler);
					EventManager.remove(image.contentLoaderInfo, Event.UNLOAD, unload_handler);
					EventManager.remove(image.contentLoaderInfo, ProgressEvent.PROGRESS, progress_handler);
				}
			}
		}

		public function cleanup()
		{
			g.server.removeEventListener("pluginMessage", "on_plugin_message", this);
			remove_load_event_listeners();
			if(loadInterval > 0)
			{
				clearInterval(loadInterval);
				loadInterval = 0;
			}
		}

		private function http_status_handler(param1:HTTPStatusEvent) : void
		{
			g.debuglog("HTTPStatusEvent.HTTP_Status: " + param1.status);
		}

		private function init_handler(param1:Event) : void
		{
			g.debuglog("Event.INIT: " + param1);
		}

		private function open_handler(param1:Event) : void
		{
			g.debuglog("Event.OPEN: " + param1);
		}

		private function unload_handler(param1:Event) : void
		{
			g.debuglog("Event.UNLOAD: " + param1);
		}

		private function progress_handler(param1:ProgressEvent) : void
		{
			g.debuglog("ProgressEvent.PROGRESS: " + param1);
		}
	}
}
