package fl.containers
{
	import fl.controls.*;
	import fl.core.*;
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.ui.*;

	public class ScrollPane extends BaseScrollPane implements IFocusManagerComponent
	{
		private static var defaultStyles:Object = {upSkin:"ScrollPane_upSkin", disabledSkin:"ScrollPane_disabledSkin", focusRectSkin:null, focusRectPadding:null, contentPadding:0};
		protected var scrollDragHPos:Number;
		protected var loader:Loader;
		protected var yOffset:Number;
		protected var currentContent:Object;
		protected var xOffset:Number;
		protected var _source:Object = "";
		protected var scrollDragVPos:Number;
		protected var _scrollDrag:Boolean = false;
		protected var contentClip:Sprite;

		final public static function getStyleDefinition() : Object
		{
			return ScrollPane.mergeStyles(defaultStyles, BaseScrollPane.getStyleDefinition());
		}

		public function ScrollPane()
		{
			_source = "";
			_scrollDrag = false;
			super();
		}

		public function get source() : Object
		{
			return _source;
		}

		public function set source(param1:Object) : void
		{
			var _loc_2:* = undefined;
			clearContent();
			if(isLivePreview)
			{
				return;
			}
			_source = param1;
			if(_source == "" || _source == null)
			{
				return;
			}
			currentContent = getDisplayObjectInstance(param1);
			if(currentContent != null)
			{
				_loc_2 = contentClip.addChild(currentContent);
				dispatchEvent(new Event(Event.INIT));
				update();
			}
			else
			{
				load(new URLRequest(_source.toString()));
			}
		}

		public function get bytesLoaded() : Number
		{
			return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesLoaded;
		}

		protected function doDrag(param1:MouseEvent) : void
		{
			var _loc_2:* = undefined;
			var _loc_3:* = undefined;
			_loc_2 = scrollDragVPos - (mouseY - yOffset);
			_verticalScrollBar.setScrollPosition(_loc_2);
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition, true);
			_loc_3 = scrollDragHPos - (mouseX - xOffset);
			_horizontalScrollBar.setScrollPosition(_loc_3);
			setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition, true);
		}

		override protected function keyDownHandler(param1:KeyboardEvent) : void
		{
			var _loc_2:int = 0;
			_loc_2 = calculateAvailableHeight();
			switch(param1.keyCode)
			{
			case Keyboard.DOWN:
				var _loc_4:* = this.verticalScrollPosition + 1;
				this.verticalScrollPosition = _loc_4;
				break;
			case Keyboard.UP:
				var _loc_4:* = this.verticalScrollPosition - 1;
				this.verticalScrollPosition = _loc_4;
				break;
			case Keyboard.RIGHT:
				var _loc_4:* = this.horizontalScrollPosition + 1;
				this.horizontalScrollPosition = _loc_4;
				break;
			case Keyboard.LEFT:
				var _loc_4:* = this.horizontalScrollPosition - 1;
				this.horizontalScrollPosition = _loc_4;
				break;
			case Keyboard.END:
				verticalScrollPosition = maxVerticalScrollPosition;
				break;
			case Keyboard.HOME:
				verticalScrollPosition = 0;
				break;
			case Keyboard.PAGE_UP:
				verticalScrollPosition = verticalScrollPosition - _loc_2;
				break;
			case Keyboard.PAGE_DOWN:
				verticalScrollPosition = verticalScrollPosition + _loc_2;
				break;
			default:
				break;
			}
		}

		protected function doStartDrag(param1:MouseEvent) : void
		{
			if(!enabled)
			{
				return;
			}
			xOffset = mouseX;
			yOffset = mouseY;
			scrollDragHPos = horizontalScrollPosition;
			scrollDragVPos = verticalScrollPosition;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doDrag, false, 0, true);
		}

		public function get content() : DisplayObject
		{
			var _loc_1:Object = null;
			_loc_1 = currentContent;
			if(_loc_1 is URLRequest)
			{
				_loc_1 = loader.content;
			}
			return _loc_1;
		}

		public function get percentLoaded() : Number
		{
			if(loader != null)
			{
				return Math.round((bytesLoaded / bytesTotal) * 100);
			}
			return 0;
		}

		protected function endDrag(param1:MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
		}

		public function update() : void
		{
			var _loc_1:DisplayObject = null;
			_loc_1 = contentClip.getChildAt(0);
			setContentSize(_loc_1.width, _loc_1.height);
		}

		override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			var _loc_3:* = undefined;
			_loc_3 = contentClip.scrollRect;
			_loc_3.x = param1;
			contentClip.scrollRect = _loc_3;
		}

		public function refreshPane() : void
		{
			if(_source is URLRequest)
			{
				_source = _source.url;
			}
			source = _source;
		}

		protected function passEvent(param1:Event) : void
		{
			dispatchEvent(param1);
		}

		protected function calculateAvailableHeight() : Number
		{
			var _loc_1:int = NaN;
			_loc_1 = Number(getStyleValue("contentPadding"));
			return (height - (_loc_1 * 2)) - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0);
		}

		public function load(param1:URLRequest, param2:LoaderContext = null) : void
		{
			if(param2 == null)
			{
				param2 = new LoaderContext(false, ApplicationDomain.currentDomain);
			}
			clearContent();
			initLoader();
			var _loc_3:URLRequest = param1;
			_source = _loc_3;
			currentContent = _loc_3;
			loader.load(_loc_3, param2);
		}

		override protected function handleScroll(param1:ScrollEvent) : void
		{
			passEvent(param1);
			super.handleScroll(param1);
		}

		override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
			var _loc_3:* = undefined;
			_loc_3 = contentClip.scrollRect;
			_loc_3.y = param1;
			contentClip.scrollRect = _loc_3;
		}

		protected function initLoader() : void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, passEvent, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onContentLoad, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.INIT, passEvent, false, 0, true);
			contentClip.addChild(loader);
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STYLES))
			{
				drawBackground();
			}
			if(isInvalid(InvalidationType.STATE))
			{
				setScrollDrag();
			}
			super.draw();
		}

		override protected function configUI() : void
		{
			super.configUI();
			contentClip = new Sprite();
			addChild(contentClip);
			contentClip.scrollRect = contentScrollRect;
			_horizontalScrollPolicy = ScrollPolicy.AUTO;
			_verticalScrollPolicy = ScrollPolicy.AUTO;
		}

		public function set scrollDrag(param1:Boolean) : void
		{
			_scrollDrag = param1;
			invalidate(InvalidationType.STATE);
		}

		protected function clearContent() : void
		{
			if(contentClip.numChildren == 0)
			{
				return;
			}
			contentClip.removeChildAt(0);
			currentContent = null;
			if(loader != null)
			{
				try
				{
					loader.close();
				}
				catch(e:*)
				{
				}
				try
				{
					loader.unload();
				}
				catch(e:*)
				{
				}
				loader = null;
			}
		}

		override protected function drawLayout() : void
		{
			super.drawLayout();
			contentScrollRect = contentClip.scrollRect;
			contentScrollRect.width = availableWidth;
			contentScrollRect.height = availableHeight;
			contentClip.cacheAsBitmap = useBitmapScrolling;
			contentClip.scrollRect = contentScrollRect;
			var _loc_1:contentPadding = contentPadding;
			contentClip.y = _loc_1;
			contentClip.x = _loc_1;
		}

		override protected function drawBackground() : void
		{
			var _loc_1:DisplayObject = null;
			_loc_1 = background;
			background = getDisplayObjectInstance(getStyleValue(enabled ? "upSkin" : "disabledSkin"));
			background.width = width;
			background.height = height;
			addChildAt(background, 0);
			if((_loc_1 == null) && _loc_1 == background)
			{
				removeChild(_loc_1);
			}
		}

		public function get bytesTotal() : Number
		{
			return loader == null || loader.contentLoaderInfo == null ? 0 : loader.contentLoaderInfo.bytesTotal;
		}

		protected function onContentLoad(param1:Event) : void
		{
			var _loc_2:* = undefined;
			update();
			_loc_2 = calculateAvailableHeight();
			calculateAvailableSize();
			horizontalScrollBar.setScrollProperties(availableWidth, 0, useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - availableWidth, availableWidth);
			verticalScrollBar.setScrollProperties(_loc_2, 0, contentHeight - _loc_2, _loc_2);
			passEvent(param1);
		}

		public function get scrollDrag() : Boolean
		{
			return _scrollDrag;
		}

		protected function setScrollDrag() : void
		{
			if(_scrollDrag)
			{
				contentClip.addEventListener(MouseEvent.MOUSE_DOWN, doStartDrag, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_UP, endDrag, false, 0, true);
			}
			else
			{
				contentClip.removeEventListener(MouseEvent.MOUSE_DOWN, doStartDrag);
				stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
				removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			}
			contentClip.buttonMode = _scrollDrag;
		}
	}
}
