package AppUI.Views
{
	import AppUI.Buttons.ButtonTNQuestion;
	import AppUI.Views.LessionView.TNQuestion;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CImageButton;
	import CFramework.CComponent.CLabelButton;
	
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
		
		private var _btnScore:CImageButton;
		private var _btnSave:CImageButton;
		private var _btnNextLession:CImageButton;
		
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
			
			_btnScore		=	new CImageButton();
			_btnScore.move( 636, 440 );
			_btnScore.addEventListener( MouseEvent.CLICK, onScoreClicked );
			addChild( _btnScore );
			
			_btnNextLession		=	new CImageButton();
			_btnNextLession.move( 636, 471 );
			_btnNextLession.addEventListener( MouseEvent.CLICK, onNextLessionClicked );
			addChild( _btnNextLession );
			
			var btnChamDiemClass:Class	=	_core.resourceManager.getClass( "btnChamDiem" );
			var btnLamLaiClass:Class	=	_core.resourceManager.getClass( "btnLamLai" );
			_btnScore.upSkin	=	new Bitmap( new btnChamDiemClass );
			_btnNextLession.upSkin	=	new Bitmap( new btnLamLaiClass );
			
			createButtonBar();
		}
		
		protected function onScoreClicked( event:MouseEvent ):void
		{
			if( _tnQuestion.getMax() < _buttons.length )
			{
				LSMessageBox.show( "\n\n   Bạn phải trả lời hết câu hỏi để chấm điểm." );
			} else
				LSMessageBox.show( "\n\n               Bạn đạt được: " + 
					String(_tnQuestion.getScore()) + "/" + String(_tnQuestion.getMax()) + " điểm" );
		}
		
		protected function onNextLessionClicked( event:MouseEvent ):void
		{
			parse( _index );
		}
		
		private var _index:uint;
		public function parse( index:uint ):void
		{
			removeAllButton();
			_tnQuestion.clear();
			
			_index	=	index;
			
			var data:Object	=	JSONData.TNQuestions;
			if( data.hasOwnProperty( index ))
			{
				_data	=	data[index];
				var len:uint	=	0;
				for( var qStr:String in _data )
					len++;
				
				var counter:uint 	=	0;
				var max:uint		=	12;
				
				// Random pos
				max		=	len < max ? len : max;
				var rand:int	=	int( Math.random() * (len-1) ) + 1;
				var qs:Vector.<uint>	=	new Vector.<uint>;
				for( var i:uint = 0; i < max; ++i )
				{
					if( len >= rand + i )
					{
						qs.push( rand + i );
					}
					else if( len <= rand + i )
					{
						qs.push( rand + i - len );
					}
				}
				for( i = 0; i < qs.length; ++ i )
				{
					var btn:ButtonTNQuestion	=	new ButtonTNQuestion( i+1, uint( qs[i] ) );
					btn.move( 220 + int( counter % 6 ) * 63, 440 + int( counter / 6) * 31 );
					addChild( btn );
					btn.addEventListener( MouseEvent.CLICK, onQuestionClicked );
					
					if( counter == 0 )
					{
						btn.highLight();
						_tnQuestion.parse( i+1, _data[qs[i]] );
					}
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
			
			_tnQuestion.parse( ( event.currentTarget as ButtonTNQuestion).getOrder(), 
				_data[( event.currentTarget as ButtonTNQuestion).getIndex()] );
			
			event.stopImmediatePropagation();
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSION_TL, CShareMacros.LS_LESSION_BT_MENU, true, false );
		}
	
		protected override function getHelpMessage():String
		{
			return "Chọn câu hỏi để trả lời:\n\n" +
				"Đáp án xanh lá cây: trả lời đúng\n" +
				"Đáp án đỏ: trả lời sai\n\n" +
				"Chúc bạn trả lời tốt ^^";
		}
	}
}