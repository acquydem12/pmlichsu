package AppUI.Views
{
	import AppUI.Views.LessionView.LessionMenuItem;
	
	import CFramework.CComponent.CImage;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSLessionMenuView extends LSBaseView
	{
		private var _bg:CImage;
		private var _dragon:CImage;
		private var _footer:CImage;
		
		private var _cloud1:MovieClip;
		private var _cloud2:MovieClip;
		private var _cloud3:MovieClip;
		private var _cloud4:MovieClip;
		
		private var _listItem:Vector.<LessionMenuItem>;
		
		public function LSLessionMenuView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSLessionMenuView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DETAIL ) as LSLessionMenuView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_DETAIL );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_DETAIL );
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg		=	new CImage;
			addChild( _bg );
			
			_footer	=	new CImage;
			_footer.move( 0, 576 - 62 );
			addChild( _footer );
			
			_dragon	=	new CImage;
			_dragon.move( 25, 90 );
			addChild( _dragon );
			
			var bgClass:Class		=	_core.resourceManager.getClass( "default_bg" );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer" );
			var dragonClass:Class	=	_core.resourceManager.getClass( "sl5_dragon" );
			
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			if( dragonClass )
				_dragon.source	=	new dragonClass;
			
			_listItem	=	new Vector.<LessionMenuItem>;
			createButton();
			
			createButtonBar();
		}
		
		public function parse( index:uint ):void
		{
			for( var i:uint = 0; i < _listItem.length; ++i )
			{
				_listItem[i].parse( index );
			}
		}
		
		protected function createButton():void
		{
			var counterX:uint	=	170;
			var counterY:uint	=	90;
			
			var cl1:Class	=	_core.resourceManager.getClass( "cloud_1" );
			if( cl1 )
			{
				_cloud1		=	new cl1;
				_cloud1.x	=	650;
				_cloud1.y	=	320;
				addChild( _cloud1 );
			}
			var item3:LessionMenuItem	=	new LessionMenuItem( CShareMacros.LESSION_DOCTHEM );
			item3.move( counterX + 400, counterY + 150 );
			addChild( item3 );
			_listItem.push( item3 );
			
			var cl4:Class	=	_core.resourceManager.getClass( "cloud_4" );
			if( cl4 )
			{
				_cloud4		=	new cl4;
				_cloud4.x	=	470;
				_cloud4.y	=	340;
				addChild( _cloud4 );
			}
			var item2:LessionMenuItem	=	new LessionMenuItem( CShareMacros.LESSION_BAITAP );
			item2.move( counterX + 210, counterY + 150 );
			addChild( item2 );
			_listItem.push( item2 );
			
			var cl3:Class	=	_core.resourceManager.getClass( "cloud_3" );
			if( cl3 )
			{
				_cloud3		=	new cl3;
				_cloud3.x	=	290;
				_cloud3.y	=	320;
				addChild( _cloud3 );
			}
			var cl2:Class	=	_core.resourceManager.getClass( "cloud_2" );
			if( cl2 )
			{
				_cloud2		=	new cl2;
				_cloud2.x	=	100;
				_cloud2.y	=	320;
				addChild( _cloud2 );
			}
			var item1:LessionMenuItem	=	new LessionMenuItem( CShareMacros.LESSION_BAIHOC );
			item1.move( counterX + 20, counterY + 150 );
			addChild( item1 );	
			_listItem.push( item1 );
		}
	
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSION_DETAIL, CShareMacros.LS_LESSIONS, true, false );
		}
		
		protected override function getHelpMessage():String
		{
			return "Bài Học: cung cấp kiến thức cơ bản về các cuộc chiến\n" +
				"Bài Tập: kiểm tra kiến thức của bạn thông qua các câu hỏi\n" +
				"Đọc Thêm: cung cấp những kiến thức ngoài lề liên quan đến cuộc chiến tranh lựa chọn";
		}
	}
}