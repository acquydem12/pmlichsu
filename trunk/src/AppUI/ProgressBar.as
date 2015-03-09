package AppUI
{
	import CFramework.CComponent.CImage;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ProgressBar extends Sprite
	{
		public static const EVENT_RELEASE:String	=	"EVENT_RELEASE";
		
		private var _bar:CImage;
		
		private var _control:CImage;
		
		public function ProgressBar( w:Number )
		{
			super();
			
			_bar	=	new CImage;
//			_bar.width	=	w;
			addChild( _bar );
			
			_control	=	new CImage;
			_control.buttonMode	=	true;
			_control.addEventListener( MouseEvent.MOUSE_DOWN, ScrollFaceDown );
			_control.addEventListener( MouseEvent.MOUSE_UP, ScrollFaceUp );
			addChild( _control );
			
			var barClass:Class	=	Global.CoreGame.resourceManager.getClass( "bar" );
			var ctClass:Class	=	Global.CoreGame.resourceManager.getClass( "node" );
			
			_bar.source			=	new barClass;
			_control.source		=	new Bitmap( new ctClass );
		}
		
		public function updateControl( current:Number, max:Number ):void
		{
			if( _isDown )
				return;
			
			var percent:Number	=	current / max;
			_control.x	=	percent * _bar.width;
			if( _control.x >= _bar.width - _control.width )
				_control.x	=	_bar.width - _control.width;
		}
		
		public function dispose():void
		{
			_control.removeEventListener( MouseEvent.MOUSE_DOWN, ScrollFaceDown );
			_control.removeEventListener( MouseEvent.MOUSE_UP, ScrollFaceUp );
			
			if( _control.parent && _control.parent.stage )
			{
				_control.parent.stage.removeEventListener(MouseEvent.MOUSE_UP, ScrollFaceUp);
				_control.parent.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePanePosition);
			}
		}
		
		private var _distance:Number	=	0;
		private var _isDown:Boolean	=	false;
		private function ScrollFaceDown(event:MouseEvent):void
		{
			if( !_control.parent || !_control.parent.stage )
				return;
			
			_distance	=	event.stageX;
			
			_isDown	=	true;
				
			_control.parent.stage.addEventListener(MouseEvent.MOUSE_UP, StageMouseUP);
			_control.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, updatePanePosition);
			
			var bounds:Rectangle = new Rectangle( 0, 0, _bar.width - _control.width, 0 );
			
			_control.startDrag(false, bounds);
		}
		
		private function StageMouseUP(event:*):void
		{
			ScrollFaceUp(event);
			_isDown	=	false;
		}
		
		public function getPositionPercent():Number
		{
			return _control.x / _bar.width;			
		}
		
		private function ScrollFaceUp(event:MouseEvent):void
		{
			if( !_control.parent || !_control.parent.stage )
				return;
			
			_control.parent.stage.removeEventListener(MouseEvent.MOUSE_UP, ScrollFaceUp);
			_control.parent.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePanePosition);
			_control.stopDrag();
			
			var d:*	=	event.stageX - _distance;
			if( d > 2 && _isDown )
			{
				_distance	=	0;
				dispatchEvent( new Event( EVENT_RELEASE )); 
			}
		}
		
		private function updatePanePosition( event:MouseEvent ):void
		{
		}
		
	}
}