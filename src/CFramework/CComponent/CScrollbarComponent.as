package CFramework.CComponent
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author Ady Levy
	 */
	public class CScrollbarComponent extends MovieClip
	{
		// const values :
		private const MIN_FACE_SIZE:int = 25; // minimum scroller face size
		private const MOUSE_WHEEL_PRECENTAGE:Number = 0.15; // when scrolling with wheel
		private const gap:int = 1; // gap from pane
		
		private var ScrollerPane:Sprite; // the pane
		private var PaneMask:Sprite; // our mask
		private var ScrollerFace:Sprite; // our scroller
		
		/*
		* scroller constructor :
		* pane - your pane to add a scroller to
		* w,h - width and height of scrolling area
		* facemc - movieclip to attach as a scroller face
		* align - in the future i'll add a vertical scroller to the class (too lazy)
		* */
		public function CScrollbarComponent(pane:Sprite, w:int, h:int, FaceMC:Sprite, align:String):void
		{
			ScrollerPane = pane;
			ScrollerFace = FaceMC;
			
			PaneMask = createMask(ScrollerPane, w, h);
			PaneMask.x = ScrollerPane.x;
			PaneMask.y = ScrollerPane.y;
			
			if( pane.parent )
				pane.parent.addChild(PaneMask);
			pane.mask = PaneMask;
			
			// adds the mouse wheel handler to the pane :
			ScrollerPane.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
			createScroller(ScrollerPane, w, h, FaceMC, align);
		}
		
		public function dispose():void
		{
			if( ScrollerPane && ScrollerPane.parent )
			{
				ScrollerPane.parent.removeChild( PaneMask );
				ScrollerPane.parent.removeChild( ScrollerFace );
			}
		}
		
		/*
		* attach the scroller face and defines its behaviour.
		* */
		private function createScroller(ScrollerPane:*, w:int, h:int, FaceMC:Sprite, align:String):void
		{
			if( ScrollerPane.parent )
				ScrollerPane.parent.addChild(FaceMC);
			
			FaceMC.x = ScrollerPane.x + w + gap;
			FaceMC.y = ScrollerPane.y;
			var FaceSize:* = (PaneMask.height / ScrollerPane.height) * PaneMask.height ;
			
			(FaceMC as Sprite).buttonMode = true;
			FaceMC.addEventListener(MouseEvent.MOUSE_DOWN,ScrollFaceDown)
			FaceMC.addEventListener(MouseEvent.MOUSE_UP,ScrollFaceUp)
		}
		
		/*
		* i am using the stage for mouse up event and mouse move, 
		* because it behaves better.
		* */
		private function StageMouseUP(event:*):void
		{
			ScrollFaceUp(event);
		}
		
		/*
		* mouse down handler
		* */
		private function ScrollFaceDown(event:*):void
		{
			if( ScrollerPane.stage )
			{
				ScrollerPane.stage.addEventListener(MouseEvent.MOUSE_UP, StageMouseUP);
				ScrollerPane.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
			var bounds:Rectangle = new Rectangle(PaneMask.x+PaneMask.width+gap, PaneMask.y, 0 , PaneMask.height-ScrollerFace.height);
			
			ScrollerFace.startDrag(false,bounds);
			
		}
		
		/*
		* mouse up handler
		* */
		private function ScrollFaceUp(event:*):void
		{
			if( ScrollerPane.stage )
			{
				ScrollerPane.stage.removeEventListener(MouseEvent.MOUSE_UP, ScrollFaceUp);
				ScrollerPane.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
			ScrollerFace.stopDrag();
		}
		
		/*
		* this function updates the pane position according to the scroller position
		* */
		private function updatePanePosition():void
		{
			var precentage:* = (ScrollerFace.y- PaneMask.y)/ ( PaneMask.height - ScrollerFace.height);
			var myMovingArea:* = ScrollerPane.height - PaneMask.height;
			var moveTo:* = myMovingArea * precentage;
			
			TweenLite.to(ScrollerPane,.6, { y:PaneMask.y-moveTo});
		}
		
		private function mouseMoveHandler(event:*):void
		{
			updatePanePosition();
		}
		
		/*
		* mouse wheel rolled on the pane
		* here delta can be -6,-3,3,6 ..
		* according to the scrolling speed
		* i just scroll up and down, you can use the -6/-3 behaviour if you like
		* 
		* */
		private function mouseWheelHandler(event:*):void
		{
			var moveMent:* = MOUSE_WHEEL_PRECENTAGE * (PaneMask.y + PaneMask.height - ScrollerFace.height);
			var newPos:int;
			if (event.delta > 0) 
				newPos = Math.max(ScrollerFace.y - moveMent,PaneMask.y);
			else
				newPos = Math.min (ScrollerFace.y + moveMent,PaneMask.y + PaneMask.height - ScrollerFace.height);	
			
			TweenLite.to(ScrollerFace, .6, { y:newPos} );
			
			var precentage:* = (newPos- PaneMask.y) / ( PaneMask.height - ScrollerFace.height);
			var myMovingArea:* = ScrollerPane.height - PaneMask.height;
			var moveTo:* = myMovingArea * precentage;
			TweenLite.to(ScrollerPane,.2, { y:PaneMask.y-moveTo});
		}
		
		/*
		* create the pane mask
		* */
		private function createMask(Pane:*,panelW:int, panelH:int):Sprite
		{
			var cont:Sprite = new Sprite();
			var color:int = Math.round(Math.random()*0xFFFFFF);
			cont.graphics.beginFill(color,0.5);
			cont.graphics.drawRect(0,0,panelW,panelH);
			cont.graphics.endFill();
			return cont;
		}
		
	}
}