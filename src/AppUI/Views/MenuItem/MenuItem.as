package AppUI.Views.MenuItem
{
	import AppUI.Views.LSLessionMenuView;
	import AppUI.Views.LSLessionView;
	import AppUI.Views.LSMenuView;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CImageButton;
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CLabelButton;
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuItem extends CLabelButton
	{
		private var _img:CImage;
		
		private var _lblText:CLabel;
		private var _index:uint;
		
		public function MenuItem( text:String )
		{
			super( true );
			
			_index		=	uint( text );
			
			var bgClass:Class	=	Global.CoreGame.resourceManager.getClass( "lession_1_bg" );
			var bgOverClass:Class	=	Global.CoreGame.resourceManager.getClass( "lession_1_bg_cyan" );
			if( bgClass )
				upSkin	=	new Bitmap( new bgClass );
			if( bgOverClass )
			{
				overSkin	=	new Bitmap( new bgOverClass );
				downSkin	=	new Bitmap( new bgOverClass );
				disableSkin	=	new Bitmap( new bgOverClass );
			}
			
			_img	=	new CImage;
			_img.move( -30, -12 );
			_img.mouseEnabled	=	false;
			addChild( _img );
			
			var cls:Class	=	Global.CoreGame.resourceManager.getClass( text );
			_img.source		=	new Bitmap( new cls );
			
			addEventListener( MouseEvent.CLICK, onClicked );
		}
		
		public function onClicked( event:MouseEvent ):void
		{
			LSLessionMenuView.show( _index-17 );
			(Global.CoreGame.holder.getView( CShareMacros.LS_MENU )
				as LSMenuView).changeView( CShareMacros.LS_MENU, CShareMacros.LS_LESSION_DETAIL, false, true );
		}
	}
}