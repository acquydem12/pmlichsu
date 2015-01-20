package CFramework.CRendererUltility
{
	import GTweener.TweenLite;
	import CFramework.CComponent.CLabel;
	import flash.display.DisplayObjectContainer;
	import flash.filters.GlowFilter;

	public class TextFlyObject
	{
		private var _host : DisplayObjectContainer;
		private var _posX : Number;
		private var _posY : Number;
		private var _lblMessage : CLabel		=	null;		
		private static var DeltaX : Number	=	20.0;
		private static var DeltaY : Number	=	5.0;
		
		public function TextFlyObject( host : DisplayObjectContainer, posX : Number, posY : Number, text : String, color : uint = 0xffffff, fontSize : Number = 16.0 )
		{
			_host		=	host;
			_posX		=	posX;
			_posY		=	posY;			
			
			///////////////////
			if( text )
			{
				_lblMessage	=	new CLabel();
				_lblMessage.textField.selectable	=	false;
				_lblMessage.color		=	color;
				_lblMessage.mouseEnabled	=	false;
				_lblMessage.tabEnabled		=	false;
				_lblMessage.filters			=	[new GlowFilter(0, 1, 3, 3, 6)];
				_lblMessage.text			=	text;
				_lblMessage.size			= 	fontSize;
				_lblMessage.cacheAsBitmap = true;
			}
		}
		
		public function applyAnimationEffect() : void
		{
			if( _lblMessage )
			{
				_host.addChild( _lblMessage );
				_lblMessage.x		=	_posX;
				_lblMessage.y		=	_posY;
				TweenLite.to( _lblMessage, 2, { y : _lblMessage.y - 100, alpha : 0.1,onComplete	:removeLabel  } );
	
			}
		}
		
		private function removeLabel() : void
		{	
			if( _lblMessage && _host.contains(_lblMessage) )
				_host.removeChild( _lblMessage );
			_lblMessage		=	null;
		}
	}
}