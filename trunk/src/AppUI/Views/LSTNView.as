package AppUI.Views
{
	import AppUI.Buttons.ButtonTNQuestion;
	import AppUI.Views.LessionView.TNQuestion;
	
	import CFramework.CComponent.CImage;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSTNView extends LSBaseView
	{
		private var _bg:CImage;
		private var _question_bg:CImage;
		
		private var _footer:CImage;
		
		private var _flagTN:MovieClip;
		
		private var _buttons:Vector.<ButtonTNQuestion>;
		
		private var _data:Object;
		
		private var _tnQuestion:TNQuestion;
		
		public function LSTNView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSTNView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_TN ) as LSTNView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_TN );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_TN );
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
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_2" );
			var questionClass:Class	=	_core.resourceManager.getClass( "tluan_bg" );
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			var flagTNClass:Class	=	_core.resourceManager.getClass( "flag_tracno" );
			if( flagTNClass )
			{
				_flagTN		=	new flagTNClass;
				_flagTN.x	=	560;
				_flagTN.y	=	5;
				_flagTN.scaleX	=	0.7;
				_flagTN.scaleY	=	0.7;
				addChild( _flagTN );
			}
			
			_question_bg	=	new CImage;
			_question_bg.move( 60, 100 );
			addChild( _question_bg );
			
			if( questionClass )
				_question_bg.source	=	new Bitmap( new questionClass );
			
			_buttons		=	new Vector.<ButtonTNQuestion>;
			
			_tnQuestion		=	new TNQuestion;
			_tnQuestion.x	=	100;
			_tnQuestion.y	=	140;
			addChild( _tnQuestion );
			
			createButtonBar();
		}
		
		public function parse( index:uint ):void
		{
			removeAllButton();
			
			var data:Object	=	JSONData.TNQuestions;
			if( data.hasOwnProperty( index ))
			{
				_data	=	data[index];
				var counter:uint = 0;
				for( var qStr:String in _data )
				{
					var btn:ButtonTNQuestion	=	new ButtonTNQuestion( uint( qStr ) );
					btn.move( 220 + int( counter % 6 ) * 63, 440 + int( counter / 6) * 31 );
					addChild( btn );
					btn.addEventListener( MouseEvent.CLICK, onQuestionClicked );
					
					if( counter == 0 )
						_tnQuestion.parse( _data[qStr] );
					counter++;
					
					_buttons.push( btn );
				}
			}
		}
		
		protected function removeAllButton():void
		{
			for( var i:uint = 0; i < _buttons.length; ++i )
			{
				_buttons[i].removeEventListener( MouseEvent.CLICK, onQuestionClicked );
				_buttons[i].dispose();
				removeChild( _buttons[i] );
			}
			if( _buttons.length > 0 )
				_buttons.splice( 0, _buttons.length );
		}
		
		protected function onQuestionClicked( event:MouseEvent ):void
		{
			for( var i:uint = 0; i < _buttons.length; ++i )
				_buttons[i].unHighLight();
			
			( event.currentTarget as ButtonTNQuestion).highLight();
			
			_tnQuestion.parse( _data[( event.currentTarget as ButtonTNQuestion).getIndex()] );
			
			event.stopImmediatePropagation();
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSION_TL, CShareMacros.LS_LESSION_BT_MENU, true, false );
		}
	}
}