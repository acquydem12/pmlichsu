package UIs.Test.Views
{
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CLabelButton;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	public class MenuView extends BaseView
	{
		public function MenuView( thisScreen:String = null )
		{
			super(thisScreen);
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			addChild( _btnMenu );
			addChild( _btnSupport );
			addChild( _btnExit );
			addChild( _btnNext );
			addChild( _btnPrev );
			
			var btnExercise:CLabelButton	=	new CLabelButton( false );
			btnExercise.title	=	"Bài\nTập";
			btnExercise.setLblDown( 2, 2 );
			btnExercise.setLblNormal( -70.5, -45 );
			btnExercise.labelPtr.size	=	30;
			btnExercise.labelPtr.bold	=	true;
			btnExercise.labelPtr.color	=	0xffffff;
			btnExercise.labelPtr.setFont( "UVN Banh Mi", true );
			btnExercise.move( 210, 353 );
			btnExercise.addEventListener( MouseEvent.CLICK, onExerciseClicked );
			addChild( btnExercise );
			
			var btnTH:CLabelButton	=	new CLabelButton( false );
			btnTH.title	=	"Thực\nHành";
			btnTH.setLblDown( 2, 2 );
			btnTH.setLblNormal( -76.5, -45 );
			btnTH.labelPtr.size	=	30;
			btnTH.labelPtr.bold	=	true;
			btnTH.labelPtr.color	=	0xffffff;
			btnTH.labelPtr.setFont( "UVN Banh Mi", true );
			btnTH.move( 410, 353 );
			btnTH.addEventListener( MouseEvent.CLICK, onTHClicked );
			addChild( btnTH );
			
			var btnTN:CLabelButton	=	new CLabelButton( false );
			btnTN.title	=	"Trắc\nNghiệm";
			btnTN.setLblDown( 2, 2 );
			btnTN.setLblNormal( -72.5, -45 );
			btnTN.labelPtr.size	=	30;
			btnTN.labelPtr.bold	=	true;
			btnTN.labelPtr.color	=	0xffffff;
			btnTN.labelPtr.setFont( "UVN Banh Mi", true );
			btnTN.move( 610, 353 );
			btnTN.addEventListener( MouseEvent.CLICK, onTNClicked );
			addChild( btnTN );
			
			var clsUp:Class	=	_core.resourceManager.getClass( "item_up" );
			var clsDown:Class	=	_core.resourceManager.getClass( "item_down" );
			
			btnExercise.upSkin	=	new Bitmap( new clsUp );
			btnTH.upSkin	=	new Bitmap( new clsUp );
			btnTN.upSkin	=	new Bitmap( new clsUp );
			
			btnExercise.overSkin	=	new Bitmap( new clsUp );
			btnTH.overSkin	=	new Bitmap( new clsUp );
			btnTN.overSkin	=	new Bitmap( new clsUp );
			
			btnExercise.downSkin	=	new Bitmap( new clsDown );
			btnTH.downSkin	=	new Bitmap( new clsDown );
			btnTN.downSkin	=	new Bitmap( new clsDown );
		}
		
		protected function onExerciseClicked( e:MouseEvent ):void
		{
		}
		
		protected function onTHClicked( e:MouseEvent ):void
		{
			Global.CoreGame.showView( CShareMacros.HLB_VIEW );
			Global.CoreGame.hideView( CShareMacros.HLB_MENU );
		}
		
		protected function onTNClicked( e:MouseEvent ):void
		{
			Global.CoreGame.showView( CShareMacros.HLB_TN );
			Global.CoreGame.hideView( CShareMacros.HLB_MENU );
		}
	}
}