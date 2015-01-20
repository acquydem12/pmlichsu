package CFramework.CRendererUltility
{
	import GTweener.TweenLite;
	
	import XMFramework.Core.SCore;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class ParticleEffect extends Sprite
	{
		private var timeFactor:Number;
		private var coreGame:SCore;
		
		public function ParticleEffect( coreGame:SCore )
		{
			super();
			
			this.coreGame	=	coreGame;
			
			var ctn:DisplayObject	=	coreGame.globalHolder.getVariable( ShareMacros.VAR_CONTAINER_TOPMOST );
			(ctn as Sprite).addChild( this );
			
			coreGame.runtimeUpdater.addFunction( runtimeUpdater );
			
			timeFactor	=	1.0;
		}
		
		public function runtimeUpdater( deltaTime : Number, totalTime : Number ):void
		{
			timeFactor	+=	deltaTime;
			
			if( isCompleteTween() )
			{
				dispose();
			}
		}
		
		public function isCompleteTween():Boolean
		{
			return ( timeFactor <= 0 );
		}
		
		public function tween( bucket:String, className:String ):void
		{
			for (var i:int = 0; i < 10; i++) {
				tweenDot(getNewDot(), getRandom(0, 3)); 
			}
		}
		
		public function dispose():void
		{
			if( parent )
				parent.removeChild( this );
			coreGame.runtimeUpdater.removeFunction( runtimeUpdater );
		}
		
		
		private function tweenDot(dot:Shape, delay:Number):void {
			dot.x = 172;
			dot.y = 160;
			TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(80, 380), angle:getRandom(245, 295), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
		}
		
		private function getNewDot():Shape {
			var s:Shape = new Shape();
			var green:uint = 0 | int(getRandom(80, 256)) << 8 | 0;
			s.graphics.beginFill(green, 1);
			s.graphics.drawCircle(0, 0, Math.random() * 8 + 5);
			s.graphics.endFill();
			this.addChild(s);
			return s;
		}
		
		protected function getRandom(min:Number, max:Number):Number {
			return min + (Math.random() * (max - min));
		}
	}
}