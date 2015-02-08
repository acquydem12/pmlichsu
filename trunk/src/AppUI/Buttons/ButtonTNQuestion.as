package AppUI.Buttons
{
	import CFramework.CComponent.CLabelButton;
	import CFramework.CRendererUltility.FilterEffect;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	public class ButtonTNQuestion extends CLabelButton
	{
		private var _index:uint;
		
		public function ButtonTNQuestion(index:uint)
		{
			super(true);
			
			_index		=	index;
			
			var upSkinClass:Class	=	Global.CoreGame.resourceManager.getClass( "question_bg" );
			if( upSkinClass )
				upSkin	=	new Bitmap( new upSkinClass );
			
			title	=	String( index );
//			setLblDown( 2, 2 );
//			setLblNormal( -77.5, -24 );
			labelPtr.size	=	22;
			labelPtr.color	=	0x0;
			
			addEvent();
		}
		
		public function getIndex():uint
		{
			return _index;
		}
		
		protected function addEvent():void
		{
			addEventListener( MouseEvent.ROLL_OVER, onMouseHandler );
			addEventListener( MouseEvent.ROLL_OUT, onMouseHandler );
		}
		
		public function dispose():void
		{
			removeEventListener( MouseEvent.ROLL_OVER, onMouseHandler );
			removeEventListener( MouseEvent.ROLL_OUT, onMouseHandler );
		}
		
		public function highLight():void
		{
			labelPtr.color	=	0x0083ce;
			
			dispose();
		}
		
		public function unHighLight():void
		{
			labelPtr.color	=	0x0;
			
			addEvent();
		}
		
		protected function onMouseHandler( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.ROLL_OVER:
					filters		=	FilterEffect.createStrokeFilter( 0xffffff, 4, 4, 4 );
					labelPtr.color	=	0x0083ce;
					break;
				
				case MouseEvent.ROLL_OUT:
					filters		=	null;
					labelPtr.color	=	0x0;
					break;
			}
		}
	}
}