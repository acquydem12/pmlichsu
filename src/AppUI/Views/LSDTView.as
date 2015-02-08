package AppUI.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.core.CView;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class LSDTView extends LSBaseView
	{
		private var _bg:CImage;
		private var _footer:CImage;
		private var _subBg:CImage;
		private var _title:CImage;
		private var _lblTitle:CLabel;
		
		public function LSDTView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSDTView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DT ) as LSDTView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_DT );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_DT );
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_footer		=	new CImage;
			_footer.move( 0, -20 );
			addChild( _footer );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_3" );
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			_subBg		=	new CImage;
			_subBg.move( 30, 60 );
			addChild( _subBg );
			var subClass:Class	=	_core.resourceManager.getClass( "default_bg_sub1" );
			if( subClass )
				_subBg.source	=	new Bitmap( new subClass );
			
			_title	=	new CImage;
			_title.move( 170, 140 );
			addChild( _title );
			var titleClass:Class	=	_core.resourceManager.getClass( "docthem_bg" );
			if( titleClass )
				_title.source	=	new Bitmap( new titleClass );
			
			_lblTitle	=	new CLabel;
			_lblTitle.size	=	50;
			_lblTitle.color	=	0x0;
			_lblTitle.text	=	"ĐỌC THÊM";
			_lblTitle.move( 280, 240 );
			addChild( _lblTitle );
			
			createButtonBar();
		}
		
		public function parse( index:uint ):void
		{
			
		}
		
		protected override function getHelpMessage():String
		{
			return "Phần này cung cấp những thông tin ngoài lề có liên quan đến nội dung bài học của chương này.";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_LESSION_DETAIL );
		}
	}
}