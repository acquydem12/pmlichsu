package AppUI.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.CRendererUltility.FilterEffect;
	import CFramework.core.CView;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class LSDTView extends LSBaseView
	{
		private var _bg:CImage;
		private var _footer:CImage;
		private var _title:CImage;
		private var _lblTitle:CLabel;
		
		private var _lbls:Vector.<CLabel>	=	new Vector.<CLabel>;
		
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
			_title.move( 40, 50 );
			addChild( _title );
			var titleClass:Class	=	_core.resourceManager.getClass( "DT_subBg" );
			if( titleClass )
				_title.source	=	new Bitmap( new titleClass );
			
			createButtonBar();
		}
		
		protected function dispose():void
		{
			for( var i:uint = 0; i < _lbls.length; ++i )
			{
				if( _lbls[i].parent )
					_lbls[i].parent.removeChild( _lbls[i] );
				_lbls[i].removeEventListener( MouseEvent.CLICK, onClicked );
				_lbls[i].removeEventListener( MouseEvent.ROLL_OVER, onHandler );
				_lbls[i].removeEventListener( MouseEvent.ROLL_OUT, onHandler );
			}
			if( _lbls.length > 0 )
				_lbls.splice( 0, _lbls.length );
		}
		
		private var _index:uint;
		public function parse( index:uint ):void
		{
			dispose();
			
			_index	=	index;
			
			var config:Object	=	JSONData.DTData[index];
			var count:uint		=	0;
			for( var i:String in config )
			{
				var lbl:CLabel	=	new CLabel( config[i] );
				lbl.color		=	0x0;
				lbl.size		=	23;
				lbl.setSize( 540, 40 );
				lbl.align		=	AlignMode.CENTER;
				lbl.setFont( "UVN Bach Dang", true );
				lbl.x	=	160;
				lbl.y	=	170 + count * 40;
				lbl.buttonMode	=	true;
				count++;
				lbl.addEventListener( MouseEvent.CLICK, onClicked );
				lbl.addEventListener( MouseEvent.ROLL_OVER, onHandler );
				lbl.addEventListener( MouseEvent.ROLL_OUT, onHandler );
				addChild( lbl );
				
				_lbls.push( lbl );
			}
		}
		
		protected function onClicked( event:MouseEvent ):void
		{
			LSDTSubView.show( _index, _lbls.indexOf( event.currentTarget ) + 1);
		}
		
		protected function onHandler( event:MouseEvent ):void
		{
			if( event.type == MouseEvent.ROLL_OVER )
			{
				(event.currentTarget as CLabel).color	=	0xff0000;
			} 
			else if( event.type == MouseEvent.ROLL_OUT ) 
			{
				(event.currentTarget as CLabel).color	=	0x000000;
			}
		}
		
		protected override function getHelpMessage():String
		{
			return "\n\n\n                       Phần này cung cấp những thông tin ngoài lề có liên quan đến nội dung bài học của chương này.";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_LESSION_DETAIL );
		}
	}
}