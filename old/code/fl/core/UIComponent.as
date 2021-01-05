package fl.core
{
	import fl.events.*;
	import fl.managers.*;
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;

	public class UIComponent extends Sprite
	{
		public static var inCallLaterPhase:Boolean = false;
		private static var defaultStyles:Object = {focusRectSkin:"focusRectSkin", focusRectPadding:2, textFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), disabledTextFormat:new TextFormat("_sans", 11, 10066329, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), defaultTextFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), defaultDisabledTextFormat:new TextFormat("_sans", 11, 10066329, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0)};
		public static var createAccessibilityImplementation:Function;
		private static var focusManagers:Dictionary = new Dictionary(false);
		protected var _enabled:Boolean = true;
		private var _mouseFocusEnabled:Boolean = true;
		protected var startHeight:Number;
		protected var _height:Number;
		protected var _oldIMEMode:String = null;
		protected var startWidth:Number;
		public var focusTarget:IFocusManagerComponent;
		protected var errorCaught:Boolean = false;
		protected var uiFocusRect:DisplayObject;
		protected var _width:Number;
		public var version:String = "3.0.0.15";
		protected var isFocused:Boolean = false;
		protected var callLaterMethods:Dictionary;
		private var _focusEnabled:Boolean = true;
		private var tempText:TextField;
		protected var invalidateFlag:Boolean = false;
		protected var _inspector:Boolean = false;
		protected var sharedStyles:Object;
		protected var invalidHash:Object;
		protected var isLivePreview:Boolean = false;
		protected var _imeMode:String = null;
		protected var instanceStyles:Object;
		protected var _x:Number;
		protected var _y:Number;

		final public static function getStyleDefinition() : Object
		{
			return defaultStyles;
		}

		final public static function mergeStyles(...restArguments) : Object
		{
			var _loc_2:Object = null;
			var _loc_3:uint = 0;
			var _loc_4:uint = 0;
			var _loc_5:Object = null;
			var _loc_6:String = null;
			_loc_2 = {};
			_loc_3 = restArguments.length;
			_loc_4 = 0;
			while(_loc_4 < _loc_3)
			{
				_loc_5 = restArguments[_loc_4];
				var _loc_7:int = 0;
				var _loc_8:* = _loc_5;
				for each(_loc_6 in _loc_8)
				{
					if(_loc_2[_loc_6] != null)
					{
						continue;
					}
					_loc_2[_loc_6] = restArguments[_loc_4][_loc_6];
				}
				_loc_4 = _loc_4 + 1;
			}
			return _loc_2;
		}

		public function UIComponent()
		{
			version = "3.0.0.15";
			isLivePreview = false;
			invalidateFlag = false;
			_enabled = true;
			isFocused = false;
			_focusEnabled = true;
			_mouseFocusEnabled = true;
			_imeMode = null;
			_oldIMEMode = null;
			errorCaught = false;
			_inspector = false;
			super();
			instanceStyles = {};
			sharedStyles = {};
			invalidHash = {};
			callLaterMethods = new Dictionary();
			StyleManager.registerInstance(this);
			configUI();
			invalidate(InvalidationType.ALL);
			tabEnabled = this is IFocusManagerComponent;
			focusRect = false;
			if(tabEnabled)
			{
				addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
				addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
				addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
			initializeFocusManager();
			addEventListener(Event.ENTER_FRAME, hookAccessibility, false, 0, true);
		}

		public function drawFocus(param1:Boolean) : void
		{
			var _loc_2:int = NaN;
			isFocused = param1;
			if(!(uiFocusRect == null) && contains(uiFocusRect))
			{
				removeChild(uiFocusRect);
				uiFocusRect = null;
			}
			if(param1)
			{
				uiFocusRect = getDisplayObjectInstance(getStyleValue("focusRectSkin"));
				if(uiFocusRect == null)
				{
					return;
				}
				_loc_2 = Number(getStyleValue("focusRectPadding"));
				uiFocusRect.x = -_loc_2;
				uiFocusRect.y = -_loc_2;
				uiFocusRect.width = width + (_loc_2 * 2);
				uiFocusRect.height = height + (_loc_2 * 2);
				addChildAt(uiFocusRect, 0);
			}
		}

		private function callLaterDispatcher(param1:Event) : void
		{
			var _loc_2:Dictionary = null;
			var _loc_3:Object = null;
			if(param1.type == Event.ADDED_TO_STAGE)
			{
				removeEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher);
				stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
				return;
			}
			param1.target.removeEventListener(Event.RENDER, callLaterDispatcher);
			if(stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
				return;
			}
			inCallLaterPhase = true;
			_loc_2 = callLaterMethods;
			var _loc_4:int = 0;
			var _loc_5:* = _loc_2;
			for each(_loc_3 in _loc_5)
			{
				_loc_3();
			}
			inCallLaterPhase = false;
		}

		private function addedHandler(param1:Event) : void
		{
			removeEventListener("addedToStage", addedHandler);
			initializeFocusManager();
		}

		protected function getStyleValue(param1:String) : Object
		{
			return instanceStyles[param1] == null ? sharedStyles[param1] : instanceStyles[param1];
		}

		protected function isOurFocus(param1:DisplayObject) : Boolean
		{
			return param1 == this;
		}

		override public function get scaleX() : Number
		{
			return width / startWidth;
		}

		override public function get scaleY() : Number
		{
			return height / startHeight;
		}

		override public function set height(param1:Number) : void
		{
			if(_height == param1)
			{
				return;
			}
			setSize(width, param1);
		}

		protected function keyDownHandler(param1:KeyboardEvent) : void
		{
		}

		protected function focusInHandler(param1:FocusEvent) : void
		{
			var _loc_2:IFocusManager = null;
			if(isOurFocus(param1.target))
			{
				_loc_2 = focusManager;
				if(_loc_2 && _loc_2.showFocusIndicator)
				{
					drawFocus(true);
					isFocused = true;
				}
			}
		}

		public function setStyle(param1:String, param2:Object) : void
		{
			if(!(instanceStyles[param1] === param2 && param2 is TextFormat))
			{
				return;
			}
			instanceStyles[param1] = param2;
			invalidate(InvalidationType.STYLES);
		}

		override public function get visible() : Boolean
		{
			return super.visible;
		}

		public function get componentInspectorSetting() : Boolean
		{
			return _inspector;
		}

		override public function get x() : Number
		{
			return isNaN(_x) ? super.x : _x;
		}

		override public function get y() : Number
		{
			return isNaN(_y) ? super.y : _y;
		}

		protected function setIMEMode(param1:Boolean)
		{
			var enabled:Boolean = param1;
			if(_imeMode != null)
			{
				if(enabled)
				{
					IME.enabled = true;
					_oldIMEMode = IME.conversionMode;
					try
					{
						if(errorCaught && IME.conversionMode == IMEConversionMode.UNKNOWN)
						{
							IME.conversionMode = _imeMode;
						}
						errorCaught = false;
					}
					catch(e:Error)
					{
						errorCaught = true;
						throw new Error("IME mode not supported: " + _imeMode);
					}
				}
				else
				{
					if((IME.conversionMode == IMEConversionMode.UNKNOWN) && _oldIMEMode == IMEConversionMode.UNKNOWN)
					{
						IME.conversionMode = _oldIMEMode;
					}
					IME.enabled = false;
				}
			}
		}

		public function set enabled(param1:Boolean) : void
		{
			if(param1 == _enabled)
			{
				return;
			}
			_enabled = param1;
			invalidate(InvalidationType.STATE);
		}

		public function setSharedStyle(param1:String, param2:Object) : void
		{
			if(!(sharedStyles[param1] === param2 && param2 is TextFormat))
			{
				return;
			}
			sharedStyles[param1] = param2;
			if(instanceStyles[param1] == null)
			{
				invalidate(InvalidationType.STYLES);
			}
		}

		protected function keyUpHandler(param1:KeyboardEvent) : void
		{
		}

		public function set focusEnabled(param1:Boolean) : void
		{
			_focusEnabled = param1;
		}

		override public function set scaleX(param1:Number) : void
		{
			setSize(startWidth * param1, height);
		}

		public function get mouseFocusEnabled() : Boolean
		{
			return _mouseFocusEnabled;
		}

		override public function set scaleY(param1:Number) : void
		{
			setSize(width, startHeight * param1);
		}

		protected function getDisplayObjectInstance(param1:Object) : DisplayObject
		{
			var classDef:Object = null;
			var skin:Object = param1;
			classDef = null;
			if(skin is Class)
			{
				return new skin();
			}
			if(skin is DisplayObject)
			{
				skin.x = 0;
				skin.y = 0;
				return skin;
			}
			try
			{
				classDef = getDefinitionByName(skin.toString());
			}
			catch(e:Error)
			{
				try
				{
					classDef = loaderInfo.applicationDomain.getDefinition(e.toString());
				}
				catch(e:Error)
				{
				}
			}
			if(classDef == null)
			{
				return null;
			}
			return new classDef();
		}

		protected function copyStylesToChild(param1:UIComponent, param2:Object) : void
		{
			var _loc_3:String = null;
			var _loc_4:int = 0;
			var _loc_5:* = param2;
			for each(_loc_3 in _loc_5)
			{
				param1.setStyle(_loc_3, getStyleValue(_loc_5[_loc_3]));
			}
		}

		protected function beforeComponentParameters() : void
		{
		}

		protected function callLater(param1:Function) : void
		{
			if(inCallLaterPhase)
			{
				return;
			}
			callLaterMethods[param1] = true;
			if(stage != null)
			{
				stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
			}
		}

		protected function createFocusManager() : void
		{
			if(focusManagers[stage] == null)
			{
				focusManagers[stage] = new FocusManager(stage);
			}
		}

		override public function set visible(param1:Boolean) : void
		{
			var _loc_2:String = null;
			if(super.visible == param1)
			{
				return;
			}
			_loc_2 = param1 ? ComponentEvent.SHOW : ComponentEvent.HIDE;
			dispatchEvent(new ComponentEvent(_loc_2, true));
		}

		protected function hookAccessibility(param1:Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, hookAccessibility);
			initializeAccessibility();
		}

		public function set componentInspectorSetting(param1:Boolean) : void
		{
			_inspector = param1;
			if(_inspector)
			{
				beforeComponentParameters();
			}
			else
			{
				afterComponentParameters();
			}
		}

		override public function set x(param1:Number) : void
		{
			move(param1, _y);
		}

		public function drawNow() : void
		{
			draw();
		}

		override public function set y(param1:Number) : void
		{
			move(_x, param1);
		}

		protected function checkLivePreview() : Boolean
		{
			var className:String = null;
			if(parent == null)
			{
				return false;
			}
			try
			{
				className = getQualifiedClassName(parent);
			}
			catch(e:Error)
			{
			}
			return className == "fl.livepreview::LivePreviewParent";
		}

		protected function focusOutHandler(param1:FocusEvent) : void
		{
			if(isOurFocus(param1.target))
			{
				drawFocus(false);
				isFocused = false;
			}
		}

		public function set mouseFocusEnabled(param1:Boolean) : void
		{
			_mouseFocusEnabled = param1;
		}

		public function getFocus() : InteractiveObject
		{
			if(stage)
			{
				return stage.focus;
			}
			return null;
		}

		protected function validate() : void
		{
			invalidHash = {};
		}

		override public function get height() : Number
		{
			return _height;
		}

		public function invalidate(param1:String = "all", param2:Boolean = true) : void
		{
			invalidHash[param1] = true;
			if(param2)
			{
				callLater(draw);
			}
		}

		public function get enabled() : Boolean
		{
			return _enabled;
		}

		protected function getScaleX() : Number
		{
			return super.scaleX;
		}

		protected function getScaleY() : Number
		{
			return super.scaleY;
		}

		public function get focusEnabled() : Boolean
		{
			return _focusEnabled;
		}

		protected function afterComponentParameters() : void
		{
		}

		protected function draw() : void
		{
			if(isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
			{
				if(isFocused && focusManager.showFocusIndicator)
				{
					drawFocus(true);
				}
			}
			validate();
		}

		protected function configUI() : void
		{
			var _loc_1:int = NaN;
			var _loc_2:int = NaN;
			var _loc_3:int = NaN;
			isLivePreview = checkLivePreview();
			_loc_1 = rotation;
			rotation = 0;
			_loc_2 = super.width;
			_loc_3 = super.height;
			var _loc_4:int = 1;
			setSize(_loc_2, _loc_3);
			move(super.x, super.y);
			rotation = _loc_1;
			startWidth = _loc_2;
			startHeight = _loc_3;
			if(numChildren > 0)
			{
				removeChildAt(0);
			}
		}

		protected function setScaleX(param1:Number) : void
		{
		}

		protected function setScaleY(param1:Number) : void
		{
		}

		private function initializeFocusManager() : void
		{
			if(stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
			}
			else
			{
				createFocusManager();
			}
		}

		public function set focusManager(param1:IFocusManager) : void
		{
			UIComponent.focusManagers[this] = param1;
		}

		public function clearStyle(param1:String) : void
		{
			setStyle(param1, null);
		}

		protected function isInvalid(param1:String, ...restArguments) : Boolean
		{
			invalidHash[param1];
			if(invalidHash[param1] || invalidHash[InvalidationType.ALL])
			{
				return true;
			}
			while(restArguments.length > 0)
			{
				if(invalidHash[restArguments.pop()])
				{
					return true;
				}
			}
			return false;
		}

		public function setSize(param1:Number, param2:Number) : void
		{
			_width = param1;
			_height = param2;
			invalidate(InvalidationType.SIZE);
			dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE, false));
		}

		override public function set width(param1:Number) : void
		{
			if(_width == param1)
			{
				return;
			}
			setSize(param1, height);
		}

		public function setFocus() : void
		{
			if(stage)
			{
				stage.focus = this;
			}
		}

		protected function initializeAccessibility() : void
		{
			if(UIComponent.createAccessibilityImplementation != null)
			{
				UIComponent.createAccessibilityImplementation(this);
			}
		}

		public function get focusManager() : IFocusManager
		{
			var _loc_1:DisplayObject = null;
			while(_loc_1)
			{
				if(UIComponent.focusManagers[_loc_1] != null)
				{
					return _loc_1.IFocusManager(UIComponent.focusManagers[_loc_1]);
				}
				_loc_1 = _loc_1.parent;
			}
			return null;
		}

		override public function get width() : Number
		{
			return _width;
		}

		public function move(param1:Number, param2:Number) : void
		{
			_x = param1;
			_y = param2;
			dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
		}

		public function validateNow() : void
		{
			invalidate(InvalidationType.ALL, false);
			draw();
		}

		public function getStyle(param1:String) : Object
		{
			return instanceStyles[param1];
		}
	}
}
