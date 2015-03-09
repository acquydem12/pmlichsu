package AppUI.Views
{
	import AppUI.Views.LessionView.LessionMenuItem;
	import AppUI.Views.MenuItem.LMenuItem;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSLessionMenuView extends LSBaseView
	{
		private var _bg:CImage;
		private var _dragon:CImage;
		private var _footer:CImage;
		
		private var _bgSub:CImage;
		
		private var _lblTitle:CLabel;
		private var _lblLessionTitle:CLabel;
		
		private var _cloud1:MovieClip;
		private var _cloud2:MovieClip;
		private var _cloud3:MovieClip;
		private var _cloud4:MovieClip;
		
		private var _items:Vector.<LMenuItem>;
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
			
			_lblTitle	=	new CLabel;
			_lblTitle.size	=	28;
			_lblTitle.text	=	"CHƯƠNG II: VIỆT NAM TỪ THẾ KỈ X ĐẾN THẾ KỈ XV";
			_lblTitle.move( 210, 20 );
			_lblTitle.color	=	0x0;
			_lblTitle.setFont( "Myriad Pro Cond", true );
			_lblTitle.bold	=	true;
			addChild( _lblTitle );
			
			_bgSub	=	new CImage;
			_bgSub.move( 120, 110 );
			addChild( _bgSub );
			
			var bgSubClass:Class	=	_core.resourceManager.getClass( "title_1_cyan" );
			
			if( bgSubClass )
				_bgSub.source	=	new Bitmap( new bgSubClass );
			
			_lblLessionTitle	=	new CLabel;
			_lblLessionTitle.size	=	16;
			_lblLessionTitle.move( 130, 120 );
			_lblLessionTitle.setSize( 560, 60 );
			_lblLessionTitle.color	=	0x147b73;
			_lblLessionTitle.setFont( "Myriad Pro Cond", true );
			_lblLessionTitle.align	=	AlignMode.CENTER;
			_lblLessionTitle.bold	=	true;
			addChild( _lblLessionTitle );
			
			_items		=	new Vector.<LMenuItem>;
			loadItems();
			
			_dragon	=	new CImage;
			_dragon.move( 42, 150 );
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
		
		private function loadItems():void
		{	
			for( var i:uint = 0; i < 4; ++i )
			{
				var item:LMenuItem	=	new LMenuItem( this, String( 17 + i ), i );
				item.move( 217 + i * 131, 130 - 36 );
				addChild( item );
				_items.push( item );
			}
		}
		
		public function parse( index:uint ):void
		{
			_items[index].forceClicked();
		}
		
		public function onClicked( index:uint ):void
		{
			_lblLessionTitle.text	=	JSONData.LessionTitle[17 + index].text;
			for( var i:uint = 0; i < _items.length; ++i )
				_items[i].enable( _items[i].onClicked );
			_items[index].disable( _items[index].onClicked );
			
			for( var j:uint = 0; j < _listItem.length; ++j )
			{
				_listItem[j].parse( 17 + index );
			}
		}
		
		protected function createButton():void
		{
			var counterX:uint	=	170;
			var counterY:uint	=	140;
			
			var cl1:Class	=	_core.resourceManager.getClass( "cloud_1" );
			if( cl1 )
			{
				_cloud1		=	new cl1;
				_cloud1.x	=	650;
				_cloud1.y	=	360;
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
				_cloud4.y	=	380;
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
				_cloud3.y	=	360;
				addChild( _cloud3 );
			}
			var cl2:Class	=	_core.resourceManager.getClass( "cloud_2" );
			if( cl2 )
			{
				_cloud2		=	new cl2;
				_cloud2.x	=	100;
				_cloud2.y	=	360;
				addChild( _cloud2 );
			}
			var item1:LessionMenuItem	=	new LessionMenuItem( CShareMacros.LESSION_BAIHOC );
			item1.move( counterX + 20, counterY + 150 );
			addChild( item1 );	
			_listItem.push( item1 );
		}
		
		protected override function createButtonBar():void
		{
			super.createButtonBar();
			disableButtonHome();
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSION_DETAIL, CShareMacros.LS_HELP, true, false );
		}
		
		protected override function getHelpMessage():String
		{
			return "Bài Học: cung cấp kiến thức cơ bản về các cuộc chiến\n" +
				"Bài Tập: kiểm tra kiến thức của bạn thông qua các câu hỏi\n" +
				"Đọc Thêm: cung cấp những kiến thức ngoài lề liên quan đến cuộc chiến tranh lựa chọn";
		}
	}
}