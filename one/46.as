package fl.containers
{
	import fl.controls.*;
	import fl.core.*;
	import fl.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class BaseScrollPane extends UIComponent
	{
		public static const SCROLL_BAR_STYLES:Object = {upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		private static var defaultStyles:Object = {repeatDelay:500, repeatInterval:35, skin:"ScrollPane_upSkin", contentPadding:0, disabledAlpha:0.50};
		protected var defaultLineScrollSize:Number = 4;
		protected var _maxHorizontalScrollPosition:Number = 0;
		protected var vScrollBar:Boolean;
		protected var disabledOverlay:Shape;
		protected var hScrollBar:Boolean;
		protected var availableWidth:Number;
		protected var _verticalPageScrollSize:Number = 0;
		protected var vOffset:Number = 0;
		protected var _verticalScrollBar:ScrollBar;
		protected var useFixedHorizontalScrolling:Boolean = false;
		protected var contentWidth:Number = 0;
		protected var contentHeight:Number = 0;
		protected var _horizontalPageScrollSize:Number = 0;
		protected var background:DisplayObject;
		protected var _useBitmpScrolling:Boolean = false;
		protected var contentPadding:Number = 0;
		protected var availableHeight:Number;
		protected var _horizontalScrollBar:ScrollBar;
		protected var contentScrollRect:Rectangle;
		protected var _horizontalScrollPolicy:String;
		protected var _verticalScrollPolicy:String;

		final public static function getStyleDefinition() : Object
		{
			return BaseScrollPane.mergeStyles(defaultStyles, ScrollBar.getStyleDefinition());
		}

		public function BaseScrollPane()
		{
			contentWidth = 0;
			contentHeight = 0;
			contentPadding = 0;
			vOffset = 0;
			_maxHorizontalScrollPosition = 0;
			_horizontalPageScrollSize = 0;
			_verticalPageScrollSize = 0;
			defaultLineScrollSize = 4;
			useFixedHorizontalScrolling = false;
			_useBitmpScrolling = false;
			super();
		}

		protected function handleWheel(param1:MouseEvent) : void
		{
			if(!enabled || !_verticalScrollBar.visible || contentHeight <= availableHeight)
			{
				return;
			}
			_verticalScrollBar.scrollPosition = _verticalScrollBar.scrollPosition - (param1.delta * verticalLineScrollSize);
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition);
			dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, param1.delta, horizontalScrollPosition));
		}

		public function get verticalScrollPosition() : Number
		{
			return _verticalScrollBar.scrollPosition;
		}

		protected function drawDisabledOverlay() : void
		{
			if(enabled)
			{
				if(contains(disabledOverlay))
				{
					removeChild(disabledOverlay);
				}
			}
			else
			{
				var _loc_1:contentPadding = contentPadding;
				disabledOverlay.y = _loc_1;
				disabledOverlay.x = _loc_1;
				disabledOverlay.width = availableWidth;
				disabledOverlay.height = availableHeight;
				disabledOverlay.alpha = getStyleValue("disabledAlpha");
				addChild(disabledOverlay);
			}
		}

		public function set verticalScrollPosition(param1:Number) : void
		{
			drawNow();
			_verticalScrollBar.scrollPosition = param1;
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition, false);
		}

		protected function setContentSize(param1:Number, param2:Number) : void
		{
			if(contentWidth == param1 || useFixedHorizontalScrolling && contentHeight == param2)
			{
				return;
			}
			contentWidth = param1;
			contentHeight = param2;
			invalidate(InvalidationType.SIZE);
		}

		public function get horizontalScrollPosition() : Number
		{
			return _horizontalScrollBar.scrollPosition;
		}

		public function get horizontalScrollBar() : ScrollBar
		{
			return _horizontalScrollBar;
		}

		override public function set enabled(param1:Boolean) : void
		{
			if(enabled == param1)
			{
				return;
			}
			_verticalScrollBar.enabled = param1;
			_horizontalScrollBar.enabled = param1;
		}

		public function get verticalLineScrollSize() : Number
		{
			return _verticalScrollBar.lineScrollSize;
		}

		public function get horizontalScrollPolicy() : String
		{
			return _horizontalScrollPolicy;
		}

		protected function calculateAvailableSize() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			var _loc_4:int = NaN;
			var _loc_5:int = NaN;
			_loc_1 = ScrollBar.WIDTH;
			var _loc_6:Number = Number(getStyleValue("contentPadding"));
			contentPadding = _loc_6;
			_loc_2 = _loc_6;
			_loc_3 = (height - (2 * _loc_2)) - vOffset;
			vScrollBar = _verticalScrollPolicy == ScrollPolicy.ON || _verticalScrollPolicy == ScrollPolicy.AUTO && contentHeight > _loc_3;
			_loc_4 = (width - (vScrollBar ? _loc_1 : 0)) - (2 * _loc_2);
			_loc_5 = useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - _loc_4;
			hScrollBar = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _loc_5 > 0;
			if(hScrollBar)
			{
				_loc_3 = _loc_3 - _loc_1;
			}
			if(hScrollBar && !vScrollBar && _verticalScrollPolicy == ScrollPolicy.AUTO && contentHeight > _loc_3)
			{
				vScrollBar = true;
				_loc_4 = _loc_4 - _loc_1;
			}
			availableHeight = _loc_3 + vOffset;
			availableWidth = _loc_4;
		}

		public function get maxVerticalScrollPosition() : Number
		{
			drawNow();
			return Math.max(0, contentHeight - availableHeight);
		}

		public function set horizontalScrollPosition(param1:Number) : void
		{
			drawNow();
			_horizontalScrollBar.scrollPosition = param1;
			setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition, false);
		}

		public function get horizontalLineScrollSize() : Number
		{
			return _horizontalScrollBar.lineScrollSize;
		}

		public function set verticalPageScrollSize(param1:Number) : void
		{
			_verticalPageScrollSize = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function get verticalScrollPolicy() : String
		{
			return _verticalScrollPolicy;
		}

		protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
		}

		public function get useBitmapScrolling() : Boolean
		{
			return _useBitmpScrolling;
		}

		protected function handleScroll(param1:ScrollEvent) : void
		{
			if(param1.target == _verticalScrollBar)
			{
				setVerticalScrollPosition(param1.position);
			}
			else
			{
				setHorizontalScrollPosition(param1.position);
			}
		}

		public function set verticalLineScrollSize(param1:Number) : void
		{
			_verticalScrollBar.lineScrollSize = param1;
		}

		public function get verticalScrollBar() : ScrollBar
		{
			return _verticalScrollBar;
		}

		protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
		{
		}

		public function set horizontalPageScrollSize(param1:Number) : void
		{
			_horizontalPageScrollSize = param1;
			invalidate(InvalidationType.SIZE);
		}

		override protected function draw() : void
		{
			if(isInvalid(InvalidationType.STYLES))
			{
				setStyles();
				drawBackground();
				if(contentPadding != getStyleValue("contentPadding"))
				{
					invalidate(InvalidationType.SIZE, false);
				}
			}
			if(isInvalid(InvalidationType.SIZE, InvalidationType.STATE))
			{
				drawLayout();
			}
			updateChildren();
			super.draw();
		}

		public function set horizontalScrollPolicy(param1:String) : void
		{
			_horizontalScrollPolicy = param1;
			invalidate(InvalidationType.SIZE);
		}

		override protected function configUI() : void
		{
			var _loc_1:Graphics = null;
			super.configUI();
			contentScrollRect = new Rectangle(0, 0, 85, 85);
			_verticalScrollBar = new ScrollBar();
			_verticalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
			_verticalScrollBar.visible = false;
			_verticalScrollBar.lineScrollSize = defaultLineScrollSize;
			addChild(_verticalScrollBar);
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			_horizontalScrollBar = new ScrollBar();
			_horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
			_horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
			_horizontalScrollBar.visible = false;
			_horizontalScrollBar.lineScrollSize = defaultLineScrollSize;
			addChild(_horizontalScrollBar);
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
			disabledOverlay = new Shape();
			_loc_1 = disabledOverlay.graphics;
			_loc_1.beginFill(16777215);
			_loc_1.drawRect(0, 0, width, height);
			_loc_1.endFill();
			addEventListener(MouseEvent.MOUSE_WHEEL, handleWheel, false, 0, true);
		}

		protected function calculateContentWidth() : void
		{
		}

		public function get verticalPageScrollSize() : Number
		{
			if(isNaN(availableHeight))
			{
				drawNow();
			}
			return _verticalPageScrollSize == 0 && !isNaN(availableHeight) ? availableHeight : _verticalPageScrollSize;
		}

		protected function drawLayout() : void
		{
			calculateAvailableSize();
			calculateContentWidth();
			background.width = width;
			background.height = height;
			if(vScrollBar)
			{
				_verticalScrollBar.visible = true;
				_verticalScrollBar.x = (width - ScrollBar.WIDTH) - contentPadding;
				_verticalScrollBar.y = contentPadding;
				_verticalScrollBar.height = availableHeight;
			}
			else
			{
				_verticalScrollBar.visible = false;
			}
			_verticalScrollBar.setScrollProperties(availableHeight, 0, contentHeight - availableHeight, verticalPageScrollSize);
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition, false);
			if(hScrollBar)
			{
				_horizontalScrollBar.visible = true;
				_horizontalScrollBar.x = contentPadding;
				_horizontalScrollBar.y = (height - ScrollBar.WIDTH) - contentPadding;
				_horizontalScrollBar.width = availableWidth;
			}
			else
			{
				_horizontalScrollBar.visible = false;
			}
			_horizontalScrollBar.setScrollProperties(availableWidth, 0, useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - availableWidth, horizontalPageScrollSize);
			setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition, false);
			drawDisabledOverlay();
		}

		protected function drawBackground() : void
		{
			var _loc_1:DisplayObject = null;
			_loc_1 = background;
			background = getDisplayObjectInstance(getStyleValue("skin"));
			background.width = width;
			background.height = height;
			addChildAt(background, 0);
			if((_loc_1 == null) && _loc_1 == background)
			{
				removeChild(_loc_1);
			}
		}

		public function set horizontalLineScrollSize(param1:Number) : void
		{
			_horizontalScrollBar.lineScrollSize = param1;
		}

		public function get horizontalPageScrollSize() : Number
		{
			if(isNaN(availableWidth))
			{
				drawNow();
			}
			return _horizontalPageScrollSize == 0 && !isNaN(availableWidth) ? availableWidth : _horizontalPageScrollSize;
		}

		public function get maxHorizontalScrollPosition() : Number
		{
			drawNow();
			return Math.max(0, contentWidth - availableWidth);
		}

		protected function setStyles() : void
		{
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
		}

		protected function updateChildren() : void
		{
			var _loc_1:enabled = enabled;
			_horizontalScrollBar.enabled = _loc_1;
			_verticalScrollBar.enabled = _loc_1;
			_verticalScrollBar.drawNow();
			_horizontalScrollBar.drawNow();
		}

		public function set verticalScrollPolicy(param1:String) : void
		{
			_verticalScrollPolicy = param1;
			invalidate(InvalidationType.SIZE);
		}

		public function set useBitmapScrolling(param1:Boolean) : void
		{
			_useBitmpScrolling = param1;
			invalidate(InvalidationType.STATE);
		}
	}
}
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
