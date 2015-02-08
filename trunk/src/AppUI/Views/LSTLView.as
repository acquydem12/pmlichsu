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
		private var _lblTitle:CLabel;
		
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
			
			_lblTitle	=	new CLabel;
			_lblTitle.size	=	22;
			_lblTitle.color	=	0x0;
			_lblTitle.text	=	"ĐỀ BÀI";
			_lblTitle.move( 452, 3 );
			addChild( _lblTitle );
			
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
			_workingSpace.move( 185, 400 );
			addChild( _workingSpace );
			
			_lblQuestion	=	new CLabel;
			_lblQuestion.size	=	20;
			_lblQuestion.color	=	0x0;
			_lblQuestion.wrapWord	=	true;
			_lblQuestion.setSize( 500, 100 );
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
			
//			var flagClass:Class	=	_core.resourceManager.getClass( "flag_tluan" );
//			if( flagClass )
//			{
//				_flag_tl	=	new flagClass;
//				addChild( _flag_tl );
//			}
			
			_questions	=	new Vector.<ButtonTLQuestion>;
			
			createButtonBar();
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
						_lblQuestion.text	=	_data[index].q;
					
					_questions[i].visible	=	true;
				} else {
					_questions[i].visible	=	false;
				}
			}
		}
		
		protected function removeAllButton():void
		{
			for( var i:uint = 0; i < _questions.length; ++i )
			{
				_questions[i].removeEventListener( MouseEvent.CLICK, onQuestionClicked );
				_questions[i].dispose();
				removeChild( _questions[i] );
			}
			if( _questions.length > 0 )
				_questions.splice( 0, _questions.length );
		}
		
		protected function onQuestionClicked( event:MouseEvent ):void
		{
			for( var i:uint = 0; i < _questions.length; ++i )
				_questions[i].unHighLight();
			
			( event.currentTarget as ButtonTLQuestion).highLight();
			
			_lblQuestion.text	=	_data[( event.currentTarget as ButtonTLQuestion).getIndex()].q;
			
			event.stopImmediatePropagation();
		}
		
		protected override function getHelpMessage():String
		{
			return "Chọn câu hỏi và trả lời vào ô bên dưới";
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			_core.showView( CShareMacros.LS_LESSION_BT_MENU );
		}
	}
}