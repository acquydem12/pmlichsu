package AppUI.Views.LessionView
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
	
	import flashx.textLayout.elements.BreakElement;
	
	public class LessionMenuItem extends Sprite
	{
		private var _bg:CImage;
		
		private var _lblText:CLabel;
		
		private var _index:uint;
		private var _text:String;
		
		public function LessionMenuItem( text:String )
		{
			super();
			
			this._text	=	text;
			
			_bg	=	new CImage;
			addChild( _bg );
			
			_lblText	=	new CLabel;
			_lblText.size	=	20;
			_lblText.setSize( 165, 150 );
			_lblText.text	=	text;
			_lblText.bold	=	true;
			_lblText.color	=	0xffffff;
			_lblText.align	=	AlignMode.CENTER;
			_lblText.move( -5, 50 );
			_lblText.buttonMode		=	true;
			addChild( _lblText );
			
			var bgClass:Class	=	Global.CoreGame.resourceManager.getClass( "sl5_circle" );
			if( bgClass )
				_bg.source	=	new bgClass;
			
			addEventListener( MouseEvent.CLICK, onClicked );
			_lblText.addEventListener( MouseEvent.ROLL_OVER, onTextHandler );
			_lblText.addEventListener( MouseEvent.ROLL_OUT, onTextHandler );
		}
		
		public function parse( index:uint ):void
		{
			this._index	=	index;
		}
		
		public function move( x:Number, y:Number ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		protected function onClicked( event:MouseEvent ):void
		{
			switch( _text )
			{
				case CShareMacros.LESSION_BAIHOC:
//					Global.CoreGame.showView( CShareMacros.LS_LESSIONS );
//					(Global.CoreGame.holder.getView( CShareMacros.LS_LESSIONS )
//						as LSMenuView).changeView( CShareMacros.LS_LESSIONS, CShareMacros.LS_LESSIONS, false, true );
					break;
				
				case CShareMacros.LESSION_BAITAP:
//					Global.CoreGame.showView( CShareMacros.LS_LESSIONS );
//					(Global.CoreGame.holder.getView( CShareMacros.LS_LESSIONS )
//						as LSMenuView).changeView( CShareMacros.LS_LESSIONS, CShareMacros.LS_LESSIONS, false, true );
					break;
				
				case CShareMacros.LESSION_DOCTHEM:
//					Global.CoreGame.showView( CShareMacros.LS_LESSIONS );
//					(Global.CoreGame.holder.getView( CShareMacros.LS_LESSIONS )
//						as LSMenuView).changeView( CShareMacros.LS_LESSIONS, CShareMacros.LS_LESSIONS, false, true );
					break;
			}
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