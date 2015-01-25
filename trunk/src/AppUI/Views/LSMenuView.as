package AppUI.Views
{
	import AppUI.Views.MenuItem.MenuItem;
	
	import CFramework.CComponent.CImage;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSMenuView extends LSBaseView
	{
		private var _bg:CImage;
		private var _bgSub:CImage;
		
		private var _title:CImage;
		
		private var _cloud1:MovieClip;
		private var _cloud2:MovieClip;
		private var _cloud3:MovieClip;
		private var _cloud4:MovieClip;
		
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
			
			_bgSub	=	new CImage;
			_bgSub.move( 30, 60 );
			addChild( _bgSub );
			
			_title	=	new CImage;
			_title.move( 140, 100 );
			addChild( _title );
			
			var bgClass:Class		=	_core.resourceManager.getClass( "default_bg" );
			var bgSubClass:Class	=	_core.resourceManager.getClass( "default_bg_sub1" );
			var titleClass:Class	=	_core.resourceManager.getClass( "sl3_title" );
			
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
			var counterX:uint	=	120;
			var counterY:uint	=	90;
			
			var cl1:Class	=	_core.resourceManager.getClass( "cloud_1" );
			if( cl1 )
			{
				_cloud1		=	new cl1;
				_cloud1.x	=	600;
				_cloud1.y	=	320;
				addChild( _cloud1 );
			}
			var item3:MenuItem	=	new MenuItem( "THẾ KỈ\nXVI - XIX", 0 );
			item3.move( counterX + 400, counterY + 150 );
			addChild( item3 );
			
			var cl4:Class	=	_core.resourceManager.getClass( "cloud_4" );
			if( cl4 )
			{
				_cloud4		=	new cl4;
				_cloud4.x	=	420;
				_cloud4.y	=	340;
				addChild( _cloud4 );
			}
			var item2:MenuItem	=	new MenuItem( "THẾ KỈ\nX - XV", 1 );
			item2.move( counterX + 210, counterY + 150 );
			addChild( item2 );
			
			var cl3:Class	=	_core.resourceManager.getClass( "cloud_3" );
			if( cl3 )
			{
				_cloud3		=	new cl3;
				_cloud3.x	=	240;
				_cloud3.y	=	340;
				addChild( _cloud3 );
			}
			var cl2:Class	=	_core.resourceManager.getClass( "cloud_2" );
			if( cl2 )
			{
				_cloud2		=	new cl2;
				_cloud2.x	=	50;
				_cloud2.y	=	320;
				addChild( _cloud2 );
			}
			var item1:MenuItem	=	new MenuItem( "THẾ KỈ\nI - X", 0 );
			item1.move( counterX + 20, counterY + 150 );
			addChild( item1 );	
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