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
