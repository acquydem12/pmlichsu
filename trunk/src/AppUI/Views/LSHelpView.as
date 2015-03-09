package AppUI.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CImageButton;
	import CFramework.CComponent.CLabel;
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class LSHelpView extends LSBaseView
	{
		private var _bg:CImage;
		private var _btnStart:CImageButton;
		
		public function LSHelpView(identify:String)
		{
			super(identify);
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg	=	new CImage;
			_bg.move( 0, -10 );
			addChild( _bg );
			
			_btnStart	=	new CImageButton;
			_btnStart.move( 780, 490 );
			_btnStart.addEventListener( MouseEvent.CLICK, onStartHandler );
			_btnStart.addEventListener( MouseEvent.ROLL_OVER, onStartHandler );
			_btnStart.addEventListener( MouseEvent.ROLL_OUT, onStartHandler );
			addChild( _btnStart );
			
			var bgClass:Class		=	_core.resourceManager.getClass( "help" );
			var startClass:Class	=	_core.resourceManager.getClass( "btn_start_large" );
			if( bgClass )
				_bg.source			=	new Bitmap( new bgClass );
			if( startClass )
				_btnStart.upSkin	=	new Bitmap( new startClass );
		}
		
		protected function onStartHandler( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.CLICK:
					LSLessionMenuView.show( 0 );
					(Global.CoreGame.holder.getView( CShareMacros.LS_HELP )
						as LSHelpView).changeView( CShareMacros.LS_HELP, CShareMacros.LS_LESSION_DETAIL, false, true );
					break;
				
				case MouseEvent.ROLL_OVER:
					_btnStart.filters	=	FilterEffect.createStrokeFilter( 0xffffff, 2, 2, 2 );
					break;
				
				case MouseEvent.ROLL_OUT:
					_btnStart.filters	=	null;
					break;
			}
		}
	}
}