package AppUI.Views
{
	import AppUI.ProgressBar;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.core.CView;
	
	import Share.CShareConstant;
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import org.osmf.events.MetadataEvent;
	
	public class LSDTSubView extends LSBaseView
	{
		private var _bg:CImage;
		private var _footer:CImage;
		private var _title:CImage;
		private var _lblTitle:CLabel;
		
		private var _video:Video;
		
		private var _lession:uint;
		private var _index:uint;
		private var _duration:Number;
		
		private var nc:NetConnection;
		private var _netStream:NetStream;
		
		private var _prgBar:ProgressBar;
		
		private var mapTime:Object	=	{
			"171":398,
			"172":1434,
			"181":305,
			"182":1350,
			"191":332,
			"192":420,
			"193":420,
			"201":993,
			"202":797,
			"203":538,
			"204":662
		};
		
		public function LSDTSubView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( lession:uint, index:uint ):void
		{
			var view:LSDTSubView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DT_DETAIL ) as LSDTSubView);
			view.parse( lession, index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_DT_DETAIL );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_DT_DETAIL );
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg			=	new CImage;
			addChild( _bg );
			
			_footer		=	new CImage;
			_footer.move( 0, 576 - 62 );
			addChild( _footer );
			var bgClass:Class		=	_core.resourceManager.getClass( "default_bg" );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_5" );
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			_title	=	new CImage;
			_title.move( 15, 5 );
			addChild( _title );
			var titleClass:Class	=	_core.resourceManager.getClass( "DTbg" );
			if( titleClass )
				_title.source	=	new Bitmap( new titleClass );
			
			createButtonBar();
			
			nc	= new NetConnection(); 
			nc.connect(null);
		}
		
		public override function onHide():void
		{
			dispose();
		}
		
		protected function dispose():void
		{
			if( _video )
			{
				removeChild( _video )
				_video	=	null;
			}
			if( _netStream )
			{
				_netStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				_netStream.close();
				_netStream	=	null;
			}
			if( _prgBar )
			{
				if( _prgBar.parent )
					_prgBar.parent.removeChild( _prgBar );
				_prgBar.dispose();
				_prgBar = null;
			}
			
			removeEventListener( Event.ENTER_FRAME, onUpdate );
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void 
		{
		}
		
		public function parse( lession:uint, index:uint ):void
		{
			try {
				_index	=	index;
				_lession	=	lession;
				
				dispose();
				
				if( _netStream )
				{
					_netStream.close();
					_netStream	=	null;
				}
				
				_netStream = new NetStream(nc);
				_netStream.addEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler );
				_netStream.play( "debug/media/swf/" + String( lession ) + String ( index ) + ".flv"); 
				var client:Object = new Object;
				client.onMetaData = onMetaData;
				_netStream.client = client;                                        
				function onMetaData( metaData:* ):void  {
				}
				
				_video = new Video(); 
				_video.width	=	640;
				_video.height	=	480;
				_video.x	=	_core.holder.releaseVariable(CShareMacros.VAR_APP_WIDTH) / 2 - _video.width / 2;
				_video.y	=	_core.holder.releaseVariable(CShareMacros.VAR_APP_HEIGHT) / 2 - _video.height / 2 - 30;
				_video.attachNetStream(_netStream);
				addChild( _video );
				
				_prgBar	=	new ProgressBar( 640 );
				_prgBar.x	=	_video.x;
				_prgBar.addEventListener( ProgressBar.EVENT_RELEASE, onMoveBar );
				_prgBar.y	=	_video.y + _video.height - _prgBar.height;
				addChild( _prgBar );
				
				addEventListener( Event.ENTER_FRAME, onUpdate );
			}
			catch( e:Error ) {}
		}
		
		protected function onUpdate( event:Event ):void
		{
			if( !_netStream || !_prgBar )
				return;
			
			var timeMax:Number		=	mapTime[String( _lession ) + String ( _index )];
			_prgBar.updateControl( _netStream.time, timeMax );
		}
		
		protected function onMoveBar( event:Event ):void
		{
			if( _netStream )
			{
				var percent:Number	=	_prgBar.getPositionPercent();
				var time:uint		=	uint( percent * mapTime[String( _lession ) + String ( _index )] );
				_netStream.seek( time );
			}
		}
		
		protected override function getHelpMessage():String
		{
			return "\n\n\n               Phần này cung cấp những thông tin ngoài lề có liên quan đến nội dung bài học của chương này.";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_LESSION_DT );
			_core.hideView( CShareMacros.LS_LESSION_DT_DETAIL );
		}
	}
}