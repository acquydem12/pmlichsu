package AppUI.Views
{
	import AppUI.Views.MenuItem.MenuItem;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSMenuView extends LSBaseView
	{
		private var _bg:CImage;
		private var _bgSub:CImage;
		
		private var _lblTitle:CLabel;
		
		private var _title:CImage;
		
		public function LSMenuView(identify:String)
		{
			super(identify, true);
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg	=	new CImage;
			addChild( _bg );
			
			_lblTitle	=	new CLabel;
			_lblTitle.size	=	28;
			_lblTitle.text	=	"CHƯƠNG II: VIỆT NAM TỪ THẾ KỈ X ĐẾN THẾ KỈ XV";
			_lblTitle.move( 50, 20 );
			_lblTitle.color	=	0x0;
			_lblTitle.setFont_default();
			_lblTitle.bold	=	true;
			addChild( _lblTitle );
			
			_bgSub	=	new CImage;
			_bgSub.move( 120, 140 );
			addChild( _bgSub );
			
			_title	=	new CImage;
			_title.move( 250, 240 );
			addChild( _title );
			
			var bgClass:Class		=	_core.resourceManager.getClass( "sl4_bg" );
			var bgSubClass:Class	=	_core.resourceManager.getClass( "title_1" );
			var titleClass:Class	=	_core.resourceManager.getClass( "icon_select" );
			
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			
			if( bgSubClass )
				_bgSub.source	=	new Bitmap( new bgSubClass );
			
			if( titleClass )
				_title.source	=	new Bitmap( new titleClass );
			
			loadItems();
			
			checkCreateButtonBar();
		}
		
		protected override function createButtonBar():void
		{
			super.createButtonBar();
			disableButtonHome();
		}
		
		private function loadItems():void
		{	
			for( var i:uint = 0; i < 4; ++i )
			{
				var item:MenuItem	=	new MenuItem( String( 17 + i ) );
				item.move( 217 + i * 131, 160 - 36 );
				addChild( item );
			}
		}
		
		protected override function getHelpMessage():String
		{
			return "Click chọn thế kỉ để bắt đầu bài học";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_HELP );
		}
	}
}