package CFramework.CRendererUltility
{
	import GTweener.TweenLite;
	
	import CFramework.CComponent.CLabel;
	
	import XMFramework.Interface.IFramework;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	
	public class ExpireIconSprite extends Sprite
	{
		protected var coreSNSFramework:IFramework;
		
		protected var lblTimeLeft:CLabel		=	null;
		protected var expireTime:Number			=	-1;		
		protected var timeLeft:Number			=	0;
		protected var timeLeftInSecond:Number	=	0;	
		public function ExpireIconSprite( _coreSNSFramework:IFramework )
		{
			super();
			
			coreSNSFramework	=	_coreSNSFramework;
			
			lblTimeLeft			=	new CLabel();
			lblTimeLeft.size	=	11;
			lblTimeLeft.color	=	0xffffff;
			lblTimeLeft.textField.filters	=	FilterEffect.createStrokeFilter( 0x880000 );
			lblTimeLeft.y		=	10;
			lblTimeLeft.x		=	-50;
			lblTimeLeft.width	=	75;
			lblTimeLeft.height	=	50;
			lblTimeLeft.align	=	TextFormatAlign.RIGHT;
			lblTimeLeft.textField.wordWrap	=	true;
			lblTimeLeft.mouseEnabled		=	false;
			lblTimeLeft.mouseChildren		=	false;
			addChild( lblTimeLeft );
		}
		protected function getConfExpire():String
		{
			return null;
		}
		
		public function checkEventExpire():Boolean
		{
			if( expireTime == -1 )
			{
				var conf:String	=	getConfExpire();
				if( conf )
					expireTime	=	Date.parse(	conf );
			}
			
			////////////////////
			if( expireTime > 0 )
			{
				timeLeft			=	(expireTime / 1000) - coreSNSFramework.timer.serverTime;
				timeLeftInSecond	=	int(timeLeft);
				
				if( timeLeft > 0 )
					coreSNSFramework.runtimeUpdater.addFunction( onFrameUpdate );
					
				else
					return false;
			}
			
			return true;
		}
		
		protected function hideIcon():void
		{
			coreSNSFramework.runtimeUpdater.removeFunction( onFrameUpdate );
		}
	
		protected function getString():String
		{
			return lblTimeLeft.text;
		}
		protected function onFrameUpdate( deltaTime:Number, totalTime:Number ):void
		{
			timeLeft			-=	deltaTime;		
			
			if( timeLeft <= timeLeftInSecond )
			{
				timeLeftInSecond	=	int(timeLeft);				
				lblTimeLeft.text	=	StringFormatter.formatExpireTime( coreSNSFramework, timeLeft );
			}
			
			if( timeLeft < 0 )
				hideIcon();
		}
	}
}
