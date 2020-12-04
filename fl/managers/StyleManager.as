package fl.managers
{
	import fl.core.*;
	import flash.text.*;
	import flash.utils.*;

	public class StyleManager extends Object
	{
		private static var _instance:StyleManager;
		private var globalStyles:Object;
		private var classToDefaultStylesDict:Dictionary;
		private var styleToClassesHash:Object;
		private var classToStylesDict:Dictionary;
		private var classToInstancesDict:Dictionary;

		final public static function clearComponentStyle(param1:Object, param2:String) : void
		{
			var _loc_3:Class = null;
			var _loc_4:Object = null;
			_loc_3 = StyleManager.getClassDef(param1);
			_loc_4 = StyleManager.getInstance().classToStylesDict[_loc_3];
			if((_loc_4 == null) && _loc_4[param2] == null)
			{
				StyleManager.invalidateComponentStyle(_loc_3, param2);
			}
		}

		final private static function getClassDef(param1:Object) : Class
		{
			var component:Object = param1;
			if(component is Class)
			{
				return component;
			}
			try
			{
				return StyleManager.getDefinitionByName(StyleManager.getQualifiedClassName(component));
			}
			catch(e:Error)
			{
				if(e is UIComponent)
				{
					try
					{
						return e.loaderInfo.applicationDomain.getDefinition(StyleManager.getQualifiedClassName(e));
					}
					catch(e:Error)
					{
					}
				}
			}
			return null;
		}

		final public static function clearStyle(param1:String) : void
		{
			StyleManager.setStyle(param1, null);
		}

		final public static function setComponentStyle(param1:Object, param2:String, param3:Object) : void
		{
			var _loc_4:Class = null;
			var _loc_5:Object = null;
			_loc_4 = StyleManager.getClassDef(param1);
			_loc_5 = StyleManager.getInstance().classToStylesDict[_loc_4];
			if(_loc_5 == null)
			{
				var _loc_6:Object = {};
				StyleManager.getInstance().classToStylesDict[_loc_4] = _loc_6;
				_loc_5 = _loc_6;
			}
			if(_loc_5 == param3)
			{
				return;
			}
			_loc_5[param2] = param3;
			StyleManager.invalidateComponentStyle(_loc_4, param2);
		}

		final private static function setSharedStyles(param1:UIComponent) : void
		{
			var _loc_2:StyleManager = null;
			var _loc_3:Class = null;
			var _loc_4:Object = null;
			var _loc_5:String = null;
			_loc_2 = StyleManager.getInstance();
			_loc_3 = StyleManager.getClassDef(param1);
			_loc_4 = _loc_2.classToDefaultStylesDict[_loc_3];
			var _loc_6:int = 0;
			var _loc_7:* = _loc_4;
			for each(_loc_5 in _loc_7)
			{
				param1.setSharedStyle(_loc_5, StyleManager.getSharedStyle(param1, _loc_5));
			}
		}

		final public static function getComponentStyle(param1:Object, param2:String) : Object
		{
			var _loc_3:Class = null;
			var _loc_4:Object = null;
			_loc_3 = StyleManager.getClassDef(param1);
			_loc_4 = StyleManager.getInstance().classToStylesDict[_loc_3];
			return _loc_4 == null ? null : _loc_4[param2];
		}

		final private static function getInstance()
		{
			if(_instance == null)
			{
				_instance = new StyleManager();
			}
			return _instance;
		}

		final private static function invalidateComponentStyle(param1:Class, param2:String) : void
		{
			var _loc_3:Dictionary = null;
			var _loc_4:Object = null;
			var _loc_5:UIComponent = null;
			_loc_3 = StyleManager.getInstance().classToInstancesDict[param1];
			if(_loc_3 == null)
			{
				return;
			}
			var _loc_6:int = 0;
			var _loc_7:* = _loc_3;
			for each(_loc_4 in _loc_7)
			{
				_loc_5 = _loc_4;
				if(_loc_5 == null)
				{
					continue;
				}
				_loc_5.setSharedStyle(param2, StyleManager.getSharedStyle(_loc_5, param2));
			}
		}

		final private static function invalidateStyle(param1:String) : void
		{
			var _loc_2:Dictionary = null;
			var _loc_3:Object = null;
			_loc_2 = StyleManager.getInstance().styleToClassesHash[param1];
			if(_loc_2 == null)
			{
				return;
			}
			var _loc_4:int = 0;
			var _loc_5:* = _loc_2;
			for each(_loc_3 in _loc_5)
			{
				StyleManager.invalidateComponentStyle(StyleManager.Class(_loc_3), param1);
			}
		}

		final public static function registerInstance(param1:UIComponent) : void
		{
			var inst:StyleManager = null;
			var classDef:Class = null;
			var target:Class = null;
			var defaultStyles:Object = null;
			var styleToClasses:Object = null;
			var n:String = null;
			var instance:UIComponent = param1;
			inst = StyleManager.getInstance();
			classDef = StyleManager.getClassDef(instance);
			if(classDef == null)
			{
				return;
			}
			if(inst.classToInstancesDict[classDef] == null)
			{
				inst.classToInstancesDict[classDef] = new Dictionary(true);
				target = classDef;
				while(defaultStyles == null)
				{
					if(target["getStyleDefinition"] != null)
					{
						var _loc_3:Class = target;
						defaultStyles = _loc_3["getStyleDefinition"]();
						break;
					}
					try
					{
						target = instance.loaderInfo.applicationDomain.getDefinition(StyleManager.getQualifiedSuperclassName(target));
					}
					catch(err:Error)
					{
						try
						{
							target = StyleManager.getDefinitionByName(StyleManager.getQualifiedSuperclassName(target));
						}
						catch(e:Error)
						{
							defaultStyles = UIComponent.getStyleDefinition();
							break;
						}
					}
				}
				styleToClasses = inst.styleToClassesHash;
				var _loc_3:int = 0;
				var _loc_4:* = defaultStyles;
				for each(n in _loc_4)
				{
					if(styleToClasses[n] == null)
					{
						styleToClasses[n] = new Dictionary(true);
					}
					styleToClasses[n][classDef] = true;
				}
				inst.classToDefaultStylesDict[classDef] = defaultStyles;
				inst.classToStylesDict[classDef] = {};
			}
			inst.classToInstancesDict[classDef][instance] = true;
			StyleManager.setSharedStyles(instance);
		}

		final public static function getStyle(param1:String) : Object
		{
			return StyleManager.getInstance().globalStyles[param1];
		}

		final private static function getSharedStyle(param1:UIComponent, param2:String) : Object
		{
			var _loc_3:Class = null;
			var _loc_4:StyleManager = null;
			var _loc_5:Object = null;
			_loc_3 = StyleManager.getClassDef(param1);
			_loc_4 = StyleManager.getInstance();
			_loc_5 = _loc_4.classToStylesDict[_loc_3][param2];
			if(_loc_5 != null)
			{
				return _loc_5;
			}
			_loc_5 = _loc_4.globalStyles[param2];
			if(_loc_5 != null)
			{
				return _loc_5;
			}
			return _loc_4.classToDefaultStylesDict[_loc_3][param2];
		}

		final public static function setStyle(param1:String, param2:Object) : void
		{
			var _loc_3:Object = null;
			_loc_3 = StyleManager.getInstance().globalStyles;
			if(!(_loc_3[param1] === param2 && param2 is TextFormat))
			{
				return;
			}
			_loc_3[param1] = param2;
			StyleManager.invalidateStyle(param1);
		}

		public function StyleManager()
		{
			super();
			styleToClassesHash = {};
			classToInstancesDict = new Dictionary(true);
			classToStylesDict = new Dictionary(true);
			classToDefaultStylesDict = new Dictionary(true);
			globalStyles = UIComponent.getStyleDefinition();
		}
	}
}
