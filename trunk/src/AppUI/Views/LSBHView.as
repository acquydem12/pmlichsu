package AppUI.Views
{
	import AppUI.Views.LessionView.ILessionListener;
	import AppUI.Views.LessionView.LessionItem;
	
	import CFramework.CComponent.CImage;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class LSBHView extends LSBaseView implements ILessionListener
	{
		private var _bg:CImage;
		private var _bgSub:CImage;
		private var _footer:CImage;
		
		private var _lessions:Vector.<LessionItem>;
		
		public function LSBHView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSBHView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_BH ) as LSBHView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_BH );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LESSION_BAIHOC );
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg			=	new CImage;
			addChild( _bg );
			
			_footer		=	new CImage();
			_footer.move( 0, 576 - 62 );
			addChild( _footer );
			
			_bgSub	=	new CImage;
			_bgSub.move( 15, 15 );
			addChild( _bgSub );
			
			var bgSubClass:Class	=	_core.resourceManager.getClass( "bgBH" );
			var bgClass:Class		=	_core.resourceManager.getClass( "default_bg" );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_4" );
			
			if( bgSubClass )
				_bgSub.source	=	new Bitmap( new bgSubClass );
			
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			_lessions	=	new Vector.<LessionItem>();
			
			checkCreateButtonBar();
		}
		
		public function onClicked(index:uint):void
		{
			for( var i:uint = 0; i < _lessions.length; ++i )
			{
				_lessions[i].normalize();
			}
		}
		
		public function parse( index:uint ):void
		{
			for( var i:uint = 0; i < _lessions.length; ++i )
			{
				_lessions[i].dispose();
				_lessions[i].parent.removeChild( _lessions[i] );
			}
			if( _lessions.length > 0 )
				_lessions.splice( 0, _lessions.length );
			
			var jsdata:Object	=	JSONData.LessionData[index];
			var count:uint	=	0;
			for( var str:String in jsdata )
			{
				var data:Object	=	jsdata[str];
				var lession:LessionItem	=	new LessionItem( count, data.index, data.text, data.color, this );
				lession.x		=	20 + int(count%1) * 400;
				lession.y		=	80 + int(count/1) * 100;
				
				if( count == 0 )
					lession.highLight();
				count++;
				
				addChild( lession );
				_lessions.push( lession );
			}
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