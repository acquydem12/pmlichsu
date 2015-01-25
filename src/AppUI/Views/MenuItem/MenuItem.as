package AppUI.Views.MenuItem
{
	import AppUI.Views.LSLessionView;
	import AppUI.Views.LSMenuView;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuItem extends Sprite
	{
		private var _bg:CImage;
		
		private var _lblText:CLabel;
		
		public function MenuItem( text:String, state:uint )
		{
			super();
			
			_bg	=	new CImage;
			addChild( _bg );
			
			_lblText	=	new CLabel;
			_lblText.size	=	18;
			_lblText.setSize( 165, 150 );
			_lblText.text	=	text;
			_lblText.bold	=	true;
			_lblText.color	=	0xffffff;
			_lblText.align	=	AlignMode.CENTER;
			_lblText.move( 0, 60 );
			_lblText.buttonMode		=	true;
			addChild( _lblText );
			
			var bgClass:Class	=	Global.CoreGame.resourceManager.getClass( "sl3_circle" );
			if( bgClass )
				_bg.source	=	new bgClass;
			
			if( state == 1 )
			{
				addEventListener( MouseEvent.CLICK, onClicked );
				_lblText.addEventListener( MouseEvent.ROLL_OVER, onTextHandler );
				_lblText.addEventListener( MouseEvent.ROLL_OUT, onTextHandler );
			}
			else 
			{
				filters	=	FilterEffect.createBackWhiteImage();
			}
		}
		
		public function move( x:Number, y:Number ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		protected function onClicked( event:MouseEvent ):void
		{
			Global.CoreGame.showView( CShareMacros.LS_LESSIONS );
			(Global.CoreGame.holder.getView( CShareMacros.LS_MENU )
				as LSMenuView).changeView( CShareMacros.LS_MENU, CShareMacros.LS_LESSIONS, false, true );
		}
		
		protected function onTextHandler( event:MouseEvent ):void
		{	
			switch( event.type )
			{
				case MouseEvent.ROLL_OVER:
					_lblText.underline	=	true;
					break;
				
				case MouseEvent.ROLL_OUT:
					_lblText.underline	=	false;
					break;
			}
		}
	}
}