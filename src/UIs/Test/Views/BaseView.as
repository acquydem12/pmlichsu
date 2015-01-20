package UIs.Test.Views
{	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CLabelButton;
	import CFramework.core.CView;
	
	import Share.CShareMacros;
	
	import UIs.Test.ContainedObject;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class BaseView extends CView
	{
		protected var _thisScreen:String;
		
		private var _bg:CImage;
		
		protected var _btnMenu:CLabelButton;
		protected var _btnSupport:CLabelButton;
		protected var _btnExit:CLabelButton;
		protected var _btnNext:CLabelButton;
		protected var _btnPrev:CLabelButton;
		
		public function BaseView( thisScreen:String = null )
		{
			super();
			
			_thisScreen	=	thisScreen;
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg		=	new CImage;
			addChild( _bg );
			
			var clsBg:Class	=	_core.resourceManager.getClass( "game_bg" );
			_bg.source	=	new Bitmap( new clsBg );
			
			createButton();
		}
		
		private function createButton():void
		{
			_btnMenu	=	new CLabelButton( false );
			_btnMenu.title	=	"Menu";
			_btnMenu.setLblDown( 2, 2 );
			_btnMenu.setLblNormal( -34.5, -15 );
			_btnMenu.labelPtr.size	=	18;
			_btnMenu.labelPtr.bold	=	true;
			_btnMenu.labelPtr.color	=	0xffffff;
			_btnMenu.labelPtr.setFont( "UVN Banh Mi", true );
			_btnMenu.move( 50, 610 );
			_btnMenu.addEventListener( MouseEvent.CLICK, onMenuClicked );

			_btnSupport	=	new CLabelButton( false );
			_btnSupport.title	=	"Hỗ trợ";
			_btnSupport.setLblDown( 2, 2 );
			_btnSupport.setLblNormal( -34.5, -15 );
			_btnSupport.labelPtr.size	=	18;
			_btnSupport.labelPtr.bold	=	true;
			_btnSupport.labelPtr.color	=	0xffffff;
			_btnSupport.labelPtr.setFont( "UVN Banh Mi", true );
			_btnSupport.move( 130, 610 );
			_btnSupport.addEventListener( MouseEvent.CLICK, onSupportClicked );
			
			_btnExit	=	new CLabelButton( false );
			_btnExit.title	=	"Thoát";
			_btnExit.setLblDown( 2, 2 );
			_btnExit.setLblNormal( -34.5, -15 );
			_btnExit.labelPtr.size	=	18;
			_btnExit.labelPtr.bold	=	true;
			_btnExit.labelPtr.color	=	0xffffff;
			_btnExit.labelPtr.setFont( "UVN Banh Mi", true );
			_btnExit.move( 210, 610 );
			_btnExit.addEventListener( MouseEvent.CLICK, onExitClicked );
			
			_btnNext	=	new CLabelButton( false );
			_btnNext.title	=	"Tới";
			_btnNext.setLblDown( 2, 2 );
			_btnNext.setLblNormal( -36.5, -15 );
			_btnNext.labelPtr.size	=	18;
			_btnNext.labelPtr.bold	=	true;
			_btnNext.labelPtr.color	=	0xffffff;
			_btnNext.labelPtr.setFont( "UVN Banh Mi", true );
			_btnNext.move( 370, 610 );
			_btnNext.addEventListener( MouseEvent.CLICK, onNextClicked );
			
			_btnPrev	=	new CLabelButton( false );
			_btnPrev.title	=	"Lui";
			_btnPrev.setLblDown( 2, 2 );
			_btnPrev.setLblNormal( -36.5, -15 );
			_btnPrev.labelPtr.size	=	18;
			_btnPrev.labelPtr.bold	=	true;
			_btnPrev.labelPtr.color	=	0xffffff;
			_btnPrev.labelPtr.setFont( "UVN Banh Mi", true );
			_btnPrev.move( 290, 610 );
			_btnPrev.addEventListener( MouseEvent.CLICK, onPrevClicked );
			
			var clsUp:Class		=	_core.resourceManager.getClass( "normal_button_up" );
			var clsDown:Class	=	_core.resourceManager.getClass( "normal_button_down" );
			
			_btnMenu.upSkin		=	( new clsUp );
			_btnMenu.overSkin	=	( new clsUp );
			_btnMenu.downSkin	=	( new clsDown );
			
			_btnSupport.upSkin		=	( new clsUp );
			_btnSupport.overSkin	=	( new clsUp );
			_btnSupport.downSkin	=	( new clsDown );
			
			_btnExit.upSkin		=	( new clsUp );
			_btnExit.overSkin	=	( new clsUp );
			_btnExit.downSkin	=	( new clsDown );
			
			_btnNext.upSkin		=	( new clsUp );
			_btnNext.overSkin	=	( new clsUp );
			_btnNext.downSkin	=	( new clsDown );
			
			_btnPrev.upSkin		=	( new clsUp );
			_btnPrev.overSkin	=	( new clsUp );
			_btnPrev.downSkin	=	( new clsDown );
		}
		
		protected function onMenuClicked( event:MouseEvent ):void
		{
			Global.CoreGame.hideView( _thisScreen );
			Global.CoreGame.showView( CShareMacros.HLB_MENU );
		}
		
		protected function onSupportClicked( event:MouseEvent ):void
		{
			
		}
		
		protected function onExitClicked( event:MouseEvent ):void
		{
			
		}
		
		protected function onNextClicked( event:MouseEvent ):void
		{
			
		}
		
		protected function onPrevClicked( event:MouseEvent ):void
		{
			
		}
	}
}