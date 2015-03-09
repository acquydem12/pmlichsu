package AppUI.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CImageButton;
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CScrollbarComponent;
	
	import Share.CShareMacros;
	
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class LSDAView extends LSBaseView
	{
		private var _bg:CImage;
		
		private var _lblMessage:CLabel;
		
		private var _btn_quit:CImageButton;
		
		private var _scrollbar:CImage;
		private var _scroller:CScrollbarComponent;
		
		public function LSDAView(identify:String)
		{
			super(identify, false);
		}
		
		public static function show( message:String ):void
		{
			Global.CoreGame.showView( CShareMacros.LS_DAVIEW );
			var view:LSDAView	=	Global.CoreGame.holder.getView( CShareMacros.LS_DAVIEW ) as LSDAView;
			view.parse( message );
			
			view.x	=	842;
			view.y	=	0;
			TweenLite.to( view, 0.5, {x:0, y:0} );
		}
		
		public static function hide():void
		{
			var view:LSDAView	=	Global.CoreGame.holder.getView( CShareMacros.LS_DAVIEW ) as LSDAView;
			
			view.x	=	0;
			view.y	=	0;
			TweenLite.to( view, 0.5, {x:-843, y:0, onComplete:function():void
			{
				Global.CoreGame.hideView( CShareMacros.LS_DAVIEW );
			}});
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_TOPMOST ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg	=	new CImage;
			_bg.move( 100, 150 );
			addChild( _bg );
			var bgClass:Class		=	_core.resourceManager.getClass( "danTLbg" );
			if( bgClass )
				_bg.source			=	new Bitmap( new bgClass );
			
			_btn_quit	=	new CImageButton;
			_btn_quit.move( 710, 157 );
			_btn_quit.addEventListener( MouseEvent.CLICK, onStartHandler );
			_btn_quit.addEventListener( MouseEvent.ROLL_OVER, onStartHandler );
			_btn_quit.addEventListener( MouseEvent.ROLL_OUT, onStartHandler );
			addChild( _btn_quit );
			var quitClass:Class	=	_core.resourceManager.getClass( "btn_quit_help" );
			if( quitClass )
				_btn_quit.upSkin	=	new quitClass;			
			
			_lblMessage	=	new CLabel;
			_lblMessage.size	=	18;
			_lblMessage.setSize( 590, 500 );
			_lblMessage.move( 115, 185 );
			_lblMessage.color	=	0x0;
			_lblMessage.bold	=	true;
			_lblMessage.setFont( "UVN Bach Dang", true );
			_lblMessage.wrapWord	=	true;
			addChild( _lblMessage );
			
			_scrollbar		=	new CImage;
			var faceClass:Class	=	Global.CoreGame.resourceManager.getClass( "danTLScroller" );
			_scrollbar.source	=	new Bitmap( new faceClass );
		}
		
		public function parse( message:String ):void
		{
			_lblMessage.text	=	message;
			
			if( _scroller )
			{
				_scroller.dispose();
				_scroller		=	null;
			}
			
			_scroller = new CScrollbarComponent(_lblMessage, _lblMessage.width, 245, _scrollbar, "vertical");
		}
		
		protected function onStartHandler( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.CLICK:
					hide();
					break;
				
				case MouseEvent.ROLL_OVER:
					_btn_quit.scaleX	=	1.02;
					_btn_quit.scaleY	=	1.02;
					break;
				
				case MouseEvent.ROLL_OUT:
					_btn_quit.scaleX	=	1.00;
					_btn_quit.scaleY	=	1.00;
					break;
			}
		}
	}
}