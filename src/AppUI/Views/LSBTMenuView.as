package AppUI.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LSBTMenuView extends LSBaseView
	{
		private var _bg:CImage;
		private var _footer:CImage;
		
		private var _flagTL:MovieClip;
		private var _flagTN:MovieClip;
		
		private var _cloud1:MovieClip;
		private var _cloud2:MovieClip;
		private var _cloud3:MovieClip;
		private var _cloud4:MovieClip;
		
		private var _index:uint;
		
		public function LSBTMenuView(identify:String)
		{
			super(identify, true);
		}
		
		public static function show( index:uint ):void
		{
			var view:LSLessionMenuView = 
				(Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_BT_MENU ) as LSLessionMenuView);
			view.parse( index );
			
			Global.CoreGame.showView( CShareMacros.LS_LESSION_BT_MENU );
		}
		
		public static function hide():void
		{
			Global.CoreGame.hideView( CShareMacros.LS_LESSION_BT_MENU );
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
			
			var bgClass:Class		=	_core.resourceManager.getClass( "default_bg" );
			var footerClass:Class	=	_core.resourceManager.getClass( "footer_2" );
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			if( footerClass )
				_footer.source	=	new Bitmap( new footerClass );
			
			var flagTNClass:Class	=	_core.resourceManager.getClass( "flag_tracno" );
			var flagTLClass:Class	=	_core.resourceManager.getClass( "flag_tluan" );
			if( flagTNClass )
			{
				_flagTN		=	new flagTNClass;
				_flagTN.x	=	80;
				_flagTN.y	=	150;
				_flagTN.buttonMode	=	true;
				addChild( _flagTN );
				_flagTN.addEventListener( MouseEvent.CLICK, onTNClicked );
				_flagTN.addEventListener( MouseEvent.ROLL_OVER, onObjectHandler );
				_flagTN.addEventListener( MouseEvent.ROLL_OUT, onObjectHandler );
			}
			if( flagTLClass )
			{
				_flagTL		=	new flagTLClass;
				_flagTL.x	=	430;
				_flagTL.y	=	150;
				_flagTL.buttonMode	=	true;
				addChild( _flagTL );
				_flagTL.addEventListener( MouseEvent.CLICK, onTLClicked );
				_flagTL.addEventListener( MouseEvent.ROLL_OVER, onObjectHandler );
				_flagTL.addEventListener( MouseEvent.ROLL_OUT, onObjectHandler );
			}
			
			createCloud();
			
			createButtonBar();
		}
		
		public function parse( index:uint ):void
		{
			this._index	=	index;
		}
		
		private function createCloud():void
		{
			var cl1:Class	=	_core.resourceManager.getClass( "cloud_1" );
			if( cl1 )
			{
				_cloud1		=	new cl1;
				_cloud1.x	=	370;
				_cloud1.y	=	320;
				addChild( _cloud1 );
			}
			
			var cl4:Class	=	_core.resourceManager.getClass( "cloud_4" );
			if( cl4 )
			{
				_cloud4		=	new cl4;
				_cloud4.x	=	470;
				_cloud4.y	=	340;
				addChild( _cloud4 );
			}
			
			var cl3:Class	=	_core.resourceManager.getClass( "cloud_3" );
			if( cl3 )
			{
				_cloud3		=	new cl3;
				_cloud3.x	=	320;
				_cloud3.y	=	320;
				addChild( _cloud3 );
			}
			
			var cl2:Class	=	_core.resourceManager.getClass( "cloud_2" );
			if( cl2 )
			{
				_cloud2		=	new cl2;
				_cloud2.x	=	250;
				_cloud2.y	=	320;
				addChild( _cloud2 );
			}
		}
		
		protected function onObjectHandler( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.ROLL_OVER:
					( event.currentTarget as DisplayObject ).filters	=	FilterEffect.createStrokeFilter( 0xffff00, 4, 4, 4 );
					break;
				
				case MouseEvent.ROLL_OUT:
					( event.currentTarget as DisplayObject ).filters	=	null;
					break;
			}
		}
		
		protected function onTLClicked( event:MouseEvent ):void
		{
			LSTLView.show( _index );
			
			( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_TL ) as 
				LSTLView ).moveIn( true, 
					function():void
					{
						LSBTMenuView.hide();
					});
		}
		
		protected function onTNClicked( event:MouseEvent ):void
		{
			LSTNView.show( _index );
			
			( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_TN ) as 
				LSTNView ).moveIn( true, 
					function():void
					{
						LSBTMenuView.hide();
					});
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSION_BT_MENU, CShareMacros.LS_LESSION_DETAIL, true, false );
		}
		
		protected override function getHelpMessage():String
		{
			return "Trắc Nghiệm: đưa ra các câu hỏi dưới dạng chọn đáp án đúng. Bạn phải chọn đáp án đúng để trả lời câu hỏi." +
				"\n\nTự Luận: đưa ra các câu hỏi liên quan tới nội dung bài học, bạn nhập câu trả lời vào khung soạn thảo.";
		}
	}
}