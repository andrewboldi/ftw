package Scene
{
	import Misc.*;
	import com.adobe.utils.*;
	import fl.controls.*;
	import fl.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	import net.theyak.util.*;

	public class BaseChat extends Sprite
	{
		public static var class_name:* = "Scene.BaseChat";
		public static var instance_number_counter:int = 0;
		private var instance_number:int = 0;
		protected var _tOutput:TextArea;
		public var _tInput:TextInput;
		protected var _tAlert:TextArea;
		protected var _cbPhrases:ComboBox;
		protected var _btnPhrases:Button;
		protected var _muted:Boolean;
		protected var _lastMessage:int;

		public function BaseChat()
		{
			super();
			var _loc_3:* = this.instance_number_counter + 1;
			this.instance_number_counter = _loc_3;
			instance_number = instance_number_counter;
			var _loc_1:TextFormat = new TextFormat();
			_loc_1.size = g.user.font_size;
			_loc_1.font = g.user.font;
			_loc_1.leading = g.user.leading;
			_tOutput = new TextArea();
			_tOutput.setSize(501, 129);
			_tOutput.x = 10;
			_tOutput.y = 379;
			_tOutput.editable = false;
			_tOutput.setStyle("textFormat", _loc_1);
			addChild(_tOutput);
			_tInput = new TextInput();
			_tInput.setSize(501, 22);
			_tInput.x = 10;
			_tInput.y = 507.90;
			_tInput.maxChars = 256;
			addChild(_tInput);
			_cbPhrases = new ComboBox();
			_cbPhrases.x = 10;
			_cbPhrases.y = 507.90;
			_cbPhrases.setSize(451, 22);
			_cbPhrases.restrict = "";
			_cbPhrases.addItem({label:"", data:0});
			_cbPhrases.addItem({label:"Hello", data:1});
			_cbPhrases.addItem({label:"Game anyone?", data:2});
			_cbPhrases.addItem({label:"Countdown anyone?", data:3});
			_cbPhrases.addItem({label:"Yes", data:4});
			_cbPhrases.addItem({label:"No", data:5});
			_cbPhrases.addItem({label:"I'll play", data:6});
			_cbPhrases.addItem({label:"Bye", data:7});
			_cbPhrases.addItem({label:"Good game", data:8});
			_cbPhrases.addItem({label:"Sorry, I'm muted", data:9});
			_cbPhrases.addItem({label:"/version", data:10});
			_cbPhrases.addItem({label:"/history", data:11});
			_cbPhrases.addItem({label:"/clearchat", data:12});
			addChild(_cbPhrases);
			_cbPhrases.visible = false;
			_cbPhrases.enabled = false;
			_btnPhrases = new Button();
			_btnPhrases.emphasized = true;
			_btnPhrases.label = "Send";
			_btnPhrases.visible = false;
			_btnPhrases.enabled = false;
			_btnPhrases.setSize(50, 20);
			_btnPhrases.x = 461;
			_btnPhrases.y = 508.90;
			EventManager.add(_btnPhrases, MouseEvent.CLICK, sendText, "BaseChat._btnPhrases");
			addChild(_btnPhrases);
			_tAlert = new TextArea();
			_tAlert.setSize(190, 132);
			_tAlert.x = 520;
			_tAlert.y = 398;
			_tAlert.editable = false;
			_tAlert.setStyle("textFormat", _loc_1);
			addChild(_tAlert);
		}

		public function refresh_userlist() : void
		{
		}

		protected function do_private_message(param1:String) : void
		{
		}

		private function sendText(param1:MouseEvent) : void
		{
			var _loc_2:String = null;
			if(_muted)
			{
				if(_lastMessage < (getTimer() - 20000))
				{
					_loc_2 = StringUtil.trim(_cbPhrases.text);
				}
				else
				{
					return;
				}
				_lastMessage = getTimer();
				_cbPhrases.selectedIndex = 0;
				_cbPhrases.text = "";
			}
			else
			{
				_loc_2 = StringUtil.trim(_tInput.text);
				_tInput.text = "";
			}
			if(_loc_2.length > 1)
			{
				g.chat.forceSend(_loc_2);
			}
		}

		private function on_chat_key(param1:KeyboardEvent) : void
		{
			var _loc_2:String = null;
			var _loc_3:Array = null;
			var _loc_4:uint = 0;
			if(_muted == false)
			{
				if(param1.ctrlKey)
				{
					if(param1.charCode == Keyboard.ENTER)
					{
						_loc_2 = StringEx.remove_duplicates(StringEx.toAscii(StringUtil.trim(_tInput.text)), 5);
						if(_loc_2.length > 0)
						{
							do_private_message(_loc_2);
						}
						_tInput.text = "";
					}
					else
					{
						if(param1.keyCode == Keyboard.HOME)
						{
							_tOutput.verticalScrollPosition = 0;
							_tOutput.invalidate();
						}
						else
						{
							if(param1.keyCode == Keyboard.END)
							{
								_tOutput.verticalScrollPosition = _tOutput.maxVerticalScrollPosition;
								_tOutput.invalidate();
							}
							else
							{
								if(param1.keyCode == Keyboard.UP)
								{
									_tInput.text = g.chat.getPrevious();
									_tInput.setSelection(_tInput.text.length, _tInput.text.length);
								}
								else
								{
									if(param1.keyCode == Keyboard.DOWN)
									{
										_tInput.text = g.chat.getNext();
										_tInput.setSelection(_tInput.text.length, _tInput.text.length);
									}
									else
									{
										if(param1.keyCode == Keyboard.PAGE_DOWN)
										{
											_tInput.text = "";
										}
										else
										{
											if(param1.keyCode == Keyboard.RIGHT)
											{
												_tInput.text = g.chat.completeName(_tInput.text, g.activeZoneName, g.activeRoomName);
												_tInput.setSelection(_tInput.text.length, _tInput.text.length);
											}
											else
											{
											}
										}
									}
								}
							}
						}
					}
				}
				else
				{
					if(param1.charCode == Keyboard.ENTER)
					{
						_loc_2 = param1.keyCode == Keyboard.LEFT && g.user.access >= 255 && StringEx.remove_duplicates(StringEx.toAscii(StringUtil.trim(_tInput.text)), 5);
						g.chat.send(_loc_2);
						_tInput.text = "";
					}
				}
			}
		}

		public function on_private_message_event(param1:Object) : void
		{
			g.chat.privateMessageEvent(param1.from, param1.message);
		}

		public function on_public_message_event(param1:Object) : void
		{
			g.chat.publicMessageEvent(param1.name, param1.message, param1.zonename, param1.roomname);
		}

		public function onZoneList(param1:Object) : void
		{
			g.chat.noticeEvent(param1.zones);
		}

		public function onMute(param1:Boolean = true) : void
		{
			_muted = param1;
			_tInput.enabled = !param1;
			_tInput.visible = !param1;
			_cbPhrases.visible = param1;
			_cbPhrases.enabled = param1;
			_btnPhrases.visible = param1;
			_btnPhrases.enabled = param1;
			_lastMessage = getTimer() - 60000;
		}

		public function onUnmute() : void
		{
			_muted = false;
			_tInput.visible = true;
			_tInput.enabled = true;
			_tInput.setFocus();
			_cbPhrases.visible = false;
			_cbPhrases.enabled = false;
			_btnPhrases.visible = false;
			_btnPhrases.enabled = false;
		}

		public function onRoomsInZone(param1:Object) : void
		{
			g.chat.noticeEvent("Rooms in zone " + param1.zonename);
			g.chat.noticeEvent(param1.rooms);
		}

		public function on_plugin_message(param1:Object) : void
		{
			switch(param1.response.Action)
			{
			case "pm":
				g.chat.privateMessageEvent(param1.response.n, param1.response.m);
				break;
			case "Notice":
				g.chat.noticeEvent(param1.response.message);
				break;
			case "Alert":
				if(_tAlert.text.length > 2)
				{
					_tAlert.text = _tAlert.text + "\n" + param1.response.m;
				}
				else
				{
					_tAlert.text = param1.response.m;
				}
				_tAlert.validateNow();
				_tAlert.verticalScrollPosition = _tAlert.maxVerticalScrollPosition;
				break;
			case "Broadcast":
				if(_tAlert.text.length > 2)
				{
					_tAlert.text = _tAlert.text + "\n" + param1.response.m;
				}
				else
				{
					_tAlert.text = param1.response.m;
				}
				_tAlert.validateNow();
				_tAlert.verticalScrollPosition = _tAlert.maxVerticalScrollPosition;
				break;
			case "error":
				if(g.scene.activeScene == "FTW" || g.scene.activeScene == "Countdown")
				{
					if(param1.response.number == 1)
					{
						g.chat.noticeEvent("Sorry, an error occured creating the game. Please try again in a few minutes.");
					}
					else
					{
						g.chat.noticeEvent("Sorry, an error occured");
					}
					g.scene.lobby();
				}
				break;
			default:
				break;
			}
		}

		protected function on_enter(param1:ComponentEvent) : void
		{
			g.chat.send(StringUtil.trim(_tInput.text));
			_tInput.text = "";
		}

		protected function on_added(param1:Event) : void
		{
		}

		protected function on_added_to_stage(param1:Event) : void
		{
			g.server.addEventListener("privateMessage", "on_private_message_event", this);
			g.server.addEventListener("publicMessage", "on_public_message_event", this);
			g.server.addEventListener("zoneList", "onZoneList", this);
			g.server.addEventListener("roomsInZone", "onRoomsInZone", this);
			if(g.user.access > 0)
			{
				_tInput.setFocus();
				EventManager.add(_tInput, KeyboardEvent.KEY_DOWN, on_chat_key);
			}
			g.chat.setOutput(_tOutput);
			if(g.user.muted)
			{
				onMute();
			}
		}

		protected function on_removed(param1:Event) : void
		{
		}

		protected function on_removed_from_stage(param1:Event) : void
		{
			EventManager.remove(_btnPhrases, MouseEvent.CLICK, sendText);
			EventManager.remove(_tInput, KeyboardEvent.KEY_DOWN, on_chat_key);
			g.server.removeEventListener("privateMessage", "on_private_message_event", this);
			g.server.removeEventListener("publicMessage", "on_public_message_event", this);
			g.server.removeEventListener("zoneList", "onZoneList", this);
			g.server.removeEventListener("roomsInZone", "onRoomsInZone", this);
		}
	}
}
