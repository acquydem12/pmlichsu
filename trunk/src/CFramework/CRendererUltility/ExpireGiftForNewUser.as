package CFramework.CRendererUltility
{
	import GTweener.TweenLite;
	
	import CFramework.CComponent.CLabel;
	
	import XMFramework.Interface.IFramework;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	
	public class ExpireGiftForNewUser extends ExpireIconSprite
	{
		
		protected var perGetAward:Boolean			=	false;
		protected var _obdis:DisplayObject;
		protected var _curIndex:int =	-1;
		protected var _lastReceive:int 	=	-1;		
		protected var _time:int 	=	0;
		protected var lbldesc:CLabel;
		public function ExpireGiftForNewUser( _coreSNSFramework:IFramework )
		{
			super(_coreSNSFramework);
			
			coreSNSFramework	=	_coreSNSFramework;
			
			lblTimeLeft			=	new CLabel();
			lblTimeLeft.size	=	9;
			lblTimeLeft.color	=	0xffffff;
			lblTimeLeft.textField.filters	=	FilterEffect.createStrokeFilter( 0x880000 );
			lblTimeLeft.y		=	27;
			lblTimeLeft.x		=	-60;
			lblTimeLeft.width	=	75;
			lblTimeLeft.height	=	50;
			lblTimeLeft.align	=	TextFormatAlign.RIGHT;
			lblTimeLeft.textField.wordWrap	=	true;
			lblTimeLeft.mouseEnabled		=	false;
			lblTimeLeft.mouseChildren		=	false;
			addChild( lblTimeLeft );
			
			
			lbldesc		=	new CLabel();
			lbldesc.size	=	10;
			lbldesc.color	=	0xffffff;
			lbldesc.textField.filters	=	FilterEffect.createStrokeFilter( 0x880000 );
			lbldesc.y		=	10;
			lbldesc.x		=	-43;
			lbldesc.width	=	75;
			lbldesc.height	=	50;
			lbldesc.align	=	TextFormatAlign.RIGHT;
			lbldesc.textField.wordWrap	=	true;
			lbldesc.mouseEnabled		=	false;
			lbldesc.mouseChildren		=	false;
			addChild( lbldesc );
			lbldesc.text = coreSNSFramework.localizer.getString("@ui#1167");
			
		}
		
		protected function checkGiftExpire():Boolean
		{
			
			if(_lastReceive>=0)
			{
				if( expireTime == -1 )
				{
					expireTime	=	coreSNSFramework.timer.serverTime*1000 + 5000000;
				}
				////////////////////
				if( expireTime >= 0 )
				{
					if(_time ==0)
					{
						var conf:Object = coreSNSFramework.configData.getMetadata(ShareMacros.CONF_EXPIRE_GIFT_FOR_NEW_USER);
						timeLeft = conf[_curIndex.toString()].time;
					}
					else
						timeLeft = _time;
					
					timeLeftInSecond	=	int(timeLeft);
					
					if( timeLeft >= 0 )
						coreSNSFramework.runtimeUpdater.addFunction( onFrameUpdateType2 );
						
					else
						return false;
				}
			}
			return true;
		}
	
		protected function onFrameUpdateType2( deltaTime:Number, totalTime:Number ):void
		{
			if( timeLeft > 0 )
			{
			
				lblTimeLeft.x		=	-60;
				timeLeft	-=	deltaTime;
				_time 				= 	timeLeft;
				lblTimeLeft.text	=	StringFormatter.formatExpireTime( coreSNSFramework, timeLeft );
			}
			else
			{
			
				lblTimeLeft.x		=	-43;
				lblTimeLeft.text =coreSNSFramework.localizer.getString("@ui#1163");
				if(perGetAward==false)
					ObjectAnimater.applySharkEffect(_obdis);
				perGetAward = true;
				complete();
				
			}
		}
		
		protected function complete():void
		{
			
		}
		
		override protected function onFrameUpdate(deltaTime:Number, totalTime:Number):void
		{
			_time 		= 	timeLeft;
			
			super.onFrameUpdate(deltaTime, totalTime );
		}

	}
}
