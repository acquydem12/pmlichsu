package UIs.Test.Views
{
	import CFramework.CComponent.CImage;
	
	import Share.CShareMacros;
	
	import UIs.Test.IQuestionIndexReceiver;
	import UIs.Test.QuestionItem;
	import UIs.Test.QuestionView;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	public class TNView extends BaseView implements IQuestionIndexReceiver
	{
		private var _questionView:QuestionView;
		
		public function TNView( thisScreen:String = null )
		{
			super(thisScreen);
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			addChild( _btnMenu );
			addChild( _btnSupport );
			addChild( _btnExit );
			addChild( _btnNext );
			addChild( _btnPrev );
			
			var bg:CImage	=	new CImage;
			bg.move( 100, 100 );
			addChild( bg );
			var clsBg:Class	=	_core.resourceManager.getClass( "tn_bg" );
			bg.source		=	new Bitmap( new clsBg );
			
			_questionView	= 	new QuestionView();
			_questionView.x	=	400;
			_questionView.y	=	100;
			addChild( _questionView );
			
			var counter:uint	=	0;
			for( var i:String in JSONFake.QUESTION )
			{
				var index:uint	=	int( i );
				var question:QuestionItem	=	new QuestionItem( index, this );
				question.x		=	151 + int(counter%3) * 98;
				question.y		=	220 + int(counter/3) * 98;
				addChild( question );
				
				counter++;
			}
		}
		
		public function changeQuestionIndex( index:int ):void
		{
			_questionView.parse( JSONFake.QUESTION[index] );
		}
		
		protected override function onNextClicked( event:MouseEvent ):void
		{
			super.onNextClicked( event );
			
			Global.CoreGame.showView( CShareMacros.HLB_VIEW );
			Global.CoreGame.hideView( CShareMacros.HLB_TN );
		}
		
		protected override function onPrevClicked( event:MouseEvent ):void
		{
			super.onPrevClicked( event );
			
			Global.CoreGame.showView( CShareMacros.HLB_VIEW );
			Global.CoreGame.hideView( CShareMacros.HLB_TN );
		}
	}
}