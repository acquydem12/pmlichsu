package AppUI.Views.LessionView
{
	import AppUI.Views.LSBHView;
	import AppUI.Views.LSBTMenuView;
	import AppUI.Views.LSDTView;
	import AppUI.Views.LSLessionView;
	import AppUI.Views.LSMenuView;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.BreakElement;
	
	public class LessionMenuItem extends Sprite
	{
		private var _bg:CImage;
		
		private var _img:CImage;
		
		private var _index:uint;
		private var _text:String;
		
		private static const map:Object	=	{
			"BÀI TẬP":"BT",
			"BÀI HỌC":"BH",
			"ĐỌC THÊM":"DT"
		};
		
		public function LessionMenuItem( text:String )
		{
			super();
			
			this._text	=	text;
			
			buttonMode	=	true;
			
			_bg	=	new CImage;
			addChild( _bg );
			
			_img	=	new CImage;
			_img.mouseEnabled	=	false;
			addChild( _img );
			
			var bgClass:Class	=	Global.CoreGame.resourceManager.getClass( "sl5_circle" );
			if( bgClass )
			{
				_bg.source	=	new bgClass;
				(_bg.source as MovieClip).stop();
			}
			var cls:Class	=	Global.CoreGame.resourceManager.getClass( map[text] );
			if( cls )
			{
				_img.source	=	new Bitmap( new cls );
				_img.move( 45 + ((61 - _img.width) < 0 ? -10 : 0), 42 );
			}
			
			addEventListener( MouseEvent.CLICK, onClicked );
		}
		
		public function parse( index:uint ):void
		{
			this._index	=	index;
		}
		
		public function move( x:Number, y:Number ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		protected function onClicked( event:MouseEvent ):void
		{
			switch( _text )
			{
				case CShareMacros.LESSION_BAIHOC:
					LSBHView.show( _index );
					
					( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_BH ) as 
						LSBHView ).moveIn( true, 
							function():void
							{
								Global.CoreGame.hideView( CShareMacros.LS_LESSION_DETAIL );
							});
					break;
				
				case CShareMacros.LESSION_BAITAP:
					Global.CoreGame.showView( CShareMacros.LS_LESSION_BT_MENU );
					( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_BT_MENU ) as 
						LSBTMenuView ).parse( _index );
					
					( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_BT_MENU ) as 
						LSBTMenuView ).moveIn( true, 
						function():void
						{
							Global.CoreGame.hideView( CShareMacros.LS_LESSION_DETAIL );
						});
					break;
				
				case CShareMacros.LESSION_DOCTHEM:
					Global.CoreGame.showView( CShareMacros.LS_LESSION_DT );
					( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DT ) as 
						LSDTView ).parse( _index );
					
					( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DT ) as 
						LSDTView ).moveIn( true, 
							function():void
							{
								Global.CoreGame.hideView( CShareMacros.LS_LESSION_DETAIL );
							});
					break;
			}
		}
	}
}