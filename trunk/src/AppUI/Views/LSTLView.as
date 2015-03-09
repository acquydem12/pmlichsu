package AppUI.Views
{
	import AppUI.Buttons.ButtonTLQuestion;
	import AppUI.Views.LessionView.DemoTextEditor;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CImageButton;
	import CFramework.CComponent.CLabel;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSTLView extends LSBaseView
	{
		private var _bg:CImage;
		private var _title:CImage;
		private var _titleName:CImage;
		
		private var _footer:CImage;
		private var _subBg:CImage;
		
		private var _workingSpace:CLabel;
		
		private var _questions:Vector.<ButtonTLQuestion>;
		private var _lblQuestion:CLabel;
		
		private var _flag_tl:MovieClip;
		
		private var _btnNext:CImageButton;
		private var _btnPrev:CImageButton;
		
		private var _data:Object;
		
		private var _editor:DemoTextEditor;
		
		private var _btnDapAn:CImageButton;
		
		public function LSTLView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSTLView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_TL ) as LSTLView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_TL );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_TL );
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg		=	new CImage;
			addChild( _bg );
			var bgClass:Class	=	_core.resourceManager.getClass( "default_bg" );
			if( bgClass )
				_bg.source	=	new Bitmap( new bgClass );
			
			_title	=	new CImage;
			_title.move( 400, 0 );
			addChild( _title );
			var titleClass:Class	=	_core.resourceManager.getClass( "tluan_debai" );
			if( titleClass )
				_title.source	=	new Bitmap( new titleClass );
			
			_titleName	=	new CImage;
			_titleName.move( 445, 2 );
			_titleName.scaleX	=	0.9;
			_titleName.scaleY	=	0.9;
			addChild( _titleName );
			var titleNameClass:Class	=	_core.resourceManager.getClass( "DB" );
			if( titleNameClass )
				_titleName.source		=	new Bitmap( new titleNameClass );
			
			_footer		=	new CImage;
			_footer.move( 0, 576 - 62 );
			addChild( _footer );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_2" );
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			_subBg		=	new CImage;
			_subBg.move( 180, 30 );
			addChild( _subBg );
			var subClass:Class	=	_core.resourceManager.getClass( "tluan_bg_type" );
			if( subClass )
				_subBg.source	=	new Bitmap( new subClass );
			
			_workingSpace	=	new CLabel;
			_workingSpace.size	=	22;
			_workingSpace.color	=	0xffffff;
			_workingSpace.text	=	"BÀI LÀM";
			_workingSpace.rotationZ	=	-90;
			_workingSpace.setFont( "Myriad Pro Cond", true );
			_workingSpace.move( 185, 400 );
			addChild( _workingSpace );
			
			_lblQuestion	=	new CLabel;
			_lblQuestion.size	=	18;
			_lblQuestion.color	=	0x0;
			_lblQuestion.wrapWord	=	true;
			_lblQuestion.setFont( "UVN Bach Dang", true );
			_lblQuestion.setSize( 480, 100 );
			_lblQuestion.move( 248, 50 );
			addChild( _lblQuestion );
			
			_btnNext	=	new CImageButton;
			_btnNext.scaleX	=	-1;
			_btnNext.move( 760, 195 );
			_btnNext.addEventListener( MouseEvent.CLICK, onNext );
			addChild( _btnNext );
			
			_btnPrev	=	new CImageButton;
			addChild( _btnPrev );
			_btnPrev.move( 170, 195 );
			_btnPrev.addEventListener( MouseEvent.CLICK, onPrev );
			var btnClass:Class	=	_core.resourceManager.getClass( "tluan_btn_back" );
			if( btnClass )
			{
				_btnNext.upSkin	=	new Bitmap( new btnClass );
				_btnPrev.upSkin	=	new Bitmap( new btnClass );
			}
			
			_editor		=	new DemoTextEditor();
			addChild( _editor );
			
			_btnDapAn	=	new CImageButton;
			_btnDapAn.move( 785, 270 );
			addChild( _btnDapAn );
			_btnDapAn.addEventListener( MouseEvent.CLICK, onDapanClicked );
			var btnDAClass:Class	=	_core.resourceManager.getClass( "btnDapAn" );
			if( btnDAClass )
			{
				_btnDapAn.upSkin	=	new Bitmap( new btnDAClass );
			}
			
			var flagClass:Class	=	_core.resourceManager.getClass( "flagTL" );
			if( flagClass )
			{
				_flag_tl	=	new flagClass;
				_flag_tl.x	=	0;
				_flag_tl.y	=	40;
				addChild( _flag_tl );
			}
			
			_questions	=	new Vector.<ButtonTLQuestion>;
			
			createButtonBar();
		}
		
		protected function onDapanClicked( event:MouseEvent ):void
		{
			if( _editor.getTextTyped() == "" )
			{
				LSMessageBox.show( "\n\nBạn phải trả lời câu hỏi mới có thể xem đáp án !" );
			}
			else 
			{
				LSDAView.show( _data[_current.getIndex()].ans );
			}
		}
		
		protected function onNext( event:MouseEvent ):void
		{
			if( _data && _data.hasOwnProperty( (_currentPage + 1) * MAX_VIEW + 1 ) )
			{
				++_currentPage;
				nextPage();
			}
		}
		
		protected function onPrev( event:MouseEvent ):void
		{
			if( _currentPage <= 0 )
				return;
			
			--_currentPage;
			nextPage();
		}
		
		private static const MAX_VIEW:uint	=	7;
		public function parse( index:uint ):void
		{
			removeAllButton();
			
			var data:Object	=	JSONData.TLQuestions;
			if( data.hasOwnProperty( index ))
			{
				_data	=	data[index];
				_currentPage	=	0;
			}
			
			var counter:uint = 0;
			for( var i:uint = 0; i < MAX_VIEW; ++i )
			{
				var btn:ButtonTLQuestion	=	new ButtonTLQuestion();
				btn.x	=	220 + int( counter % MAX_VIEW ) * 82;
				btn.y	=	196;
				btn.visible	=	false;
				addChild( btn );
				btn.addEventListener( MouseEvent.CLICK, onQuestionClicked );
				
				counter++;
				
				_questions.push( btn );
			}
			
			nextPage();
		}
		
		private var _currentPage:uint = 0;
		protected function nextPage():void
		{
			for( var i:uint = 0; i < MAX_VIEW; ++i )
			{
				var index:uint	=	_currentPage * MAX_VIEW + i + 1;
				if( _data.hasOwnProperty( index ))
				{
					_questions[i].parse( index );
					if( i == 0 )
					{
						_current	=	_questions[i];
						_lblQuestion.text	=	_data[index].q;
						_questions[i].highLight();
					}
					else _questions[i].unHighLight();
					
					_questions[i].visible	=	true;
				} else {
					_questions[i].visible	=	false;
				}
			}
		}
		
		protected function removeAllButton():void
		{
			_current	=	null;
			for( var i:uint = 0; i < _questions.length; ++i )
			{
				_questions[i].removeEventListener( MouseEvent.CLICK, onQuestionClicked );
				_questions[i].dispose();
				removeChild( _questions[i] );
			}
			if( _questions.length > 0 )
				_questions.splice( 0, _questions.length );
		}
		
		private var _current:ButtonTLQuestion;
		protected function onQuestionClicked( event:MouseEvent ):void
		{
			for( var i:uint = 0; i < _questions.length; ++i )
				_questions[i].unHighLight();
			
			( event.currentTarget as ButtonTLQuestion).highLight();
			
			_current	=	( event.currentTarget as ButtonTLQuestion);
			_lblQuestion.text	=	_data[( event.currentTarget as ButtonTLQuestion).getIndex()].q;
			
			event.stopImmediatePropagation();
		}
		
		protected override function getHelpMessage():String
		{
			return "Chọn câu hỏi và trả lời vào ô bên dưới\n\nBạn phải trả lời câu hỏi mới có thể xem đáp án";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_LESSION_BT_MENU );
		}
	}
}