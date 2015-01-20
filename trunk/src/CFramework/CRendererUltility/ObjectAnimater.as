package CFramework.CRendererUltility
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * Utility class generate exp, gold, ... object on screen 
	 * @author quocpt
	 * 
	 */	
	public class ObjectAnimater
	{			
		private static var _params : Object = { targetX : 0, targetY : 0, color : 0xffffff, leftSide : 1, index : 1 };
		//asset : Class, host : DisplayObjectContainer, text : String, posX : Number, posY : Number, targetX : Number = 0, targetY : Number = 0,color : uint = 0xffffff, delay : Number = -1, leftSide : Boolean = false
		public static function createAssetIcon( params : Object ) : void		
		{
			var Dis : Class	=	params.asset;
			var icon : *	=	new Dis;
			var newParams: Object = new Object();
			newParams.icon = icon;
			newParams.host = params.host;
			newParams.posX = params.posX;
			newParams.posY = params.posY;
			newParams.targetX = params.hasOwnProperty("targetX") ? params.targetX : _params.targetX;
			newParams.targetY = params.hasOwnProperty("targetY") ? params.targetY : _params.targetY;
			newParams.leftSide = params.hasOwnProperty("leftSide") ? params.leftSide : _params.leftSide;
			newParams.index = params.hasOwnProperty("index") ? params.index : _params.index;
			newParams.onComplete  = params.onComplete;

			var obj : IconFallObject	=	null;
			obj = new IconFallObject( newParams );
			
			newParams = new Object();
			newParams.text = params.text;
			newParams.color = params.hasOwnProperty("color") ? params.color : _params.color;
			obj.applyAnimationEffect( newParams );
		}
		/**
		 * 
		 * @param params[""]
		 * @param icon : DisplayObject
		 * @param host : DisplayObjectContainer
		 * @param posX : Number
		 * @param posY : Number
		 * @param targetX : Number
		 * @param targetY : Number
		 * @param leftSide : Boolean
		 * @param index : int
		 * 
		 */	
		
		public static function createTextAnimateEffect_Flash( host : DisplayObjectContainer, text : String, posX : Number, posY : Number, color : uint = 0xffffff, fontSize : Number = 15.0, filter : Array = null) : void		
		{
			var obj : TextFlashObject	=	new TextFlashObject(  host, posX, posY, text, color, fontSize, filter );			
			obj.applyAnimationEffect();
		}
		
		public static function createTextAnimateEffect( host : DisplayObjectContainer, text : String, posX : Number, posY : Number, color : uint = 0xffffff, fontSize : Number = 16.0) : void		
		{
			var obj : TextFlyObject	=	new TextFlyObject(  host, posX, posY, text, color, fontSize );			
			obj.applyAnimationEffect();
		}
		
		public static function applySharkEffect( disObj : DisplayObject, delay : Number = 0 ) : void		
		{
			var obj : EffectShaking	=	new EffectShaking();
			obj.applyAnimationEffect( disObj, delay );
		}
	}
}