// QuocPT
 
package CFramework.CComponent
{	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.TextAlign;

	public class CLabelButton extends CImageButton
	{
		protected var xfLabel : CLabel;
		protected var xfLabelResize:Object;
		protected var isAutoPos:Boolean	=	false;
		
		public function CLabelButton( autoPos:Boolean ) : void
		{
			super();
			
			isAutoPos				=	autoPos;
			
			xfLabel					=	new CLabel();
			xfLabel.align			=	TextAlign.CENTER;
			xfLabel.wrapWord		=	true;
			xfLabel.autoSize		=	TextFieldAutoSize.CENTER;
			xfLabel.mouseChildren	=	true;
			xfLabel.mouseEnabled	=	true;
			addChild( xfLabel );		
			
			xfLabelResize	=	new Object;
			xfLabelResize.normal=	new Point( 0, 0 );
			xfLabelResize.over	=	new Point( 0, 0 );
			xfLabelResize.down	=	new Point( 0, 0 );
		}
		
		protected override function onMouseClick(event:MouseEvent):void
		{
			super.onMouseClick( event );
		}
		
		protected override function onMouseGoDown(event:MouseEvent):void
		{
			super.onMouseGoDown( event );
			
			changeToDown();
		}
		
		protected override function onMouseGoUp(event:MouseEvent):void
		{
			super.onMouseGoUp( event );
			
			changeToOver();
		}
		
		protected override function onMouseOut(event:MouseEvent):void
		{
			super.onMouseOut( event );
		}
		
		protected override function onMouseOver(event:MouseEvent):void
		{
			super.onMouseOver( event );
			
			changeToOver();
		}
		
		private function changeToNormal():void
		{
			xfLabel.move( xfLabelResize.normal.x, xfLabelResize.normal.y );
		}
		
		private function changeToOver():void
		{
			if( _enabled )
				xfLabel.move( xfLabelResize.normal.x + xfLabelResize.over.x, 
					xfLabelResize.normal.y + xfLabelResize.over.y );
		}
		
		private function changeToDown():void
		{
			if( _enabled )
				xfLabel.move( xfLabelResize.normal.x + xfLabelResize.down.x, 
					xfLabelResize.normal.y + xfLabelResize.down.y );
		}
		
		public function get labelPtr() : CLabel
		{
			return xfLabel;
		}
		
		public function setLblNormal( lX:Number, lY:Number ):void
		{
			xfLabel.move( lX, lY );
			xfLabelResize.normal.x	=	lX;
			xfLabelResize.normal.y	=	lY;
		}
		
		public function setLblOver( mX:Number, mY:Number ):void
		{
			xfLabelResize.over.x	=	mX;
			xfLabelResize.over.y	=	mY;
		}
		
		public function setLblDown( mX:Number, mY:Number ):void
		{
			xfLabelResize.down.x	=	mX;
			xfLabelResize.down.y	=	mY;
		}
		
		public override function set upSkin(val:DisplayObject):void
		{
			super.upSkin	=	val;
			xfLabel.setSize( val.width - 5, val.height - 5 );
			validatePos();
		}
		
		public function validatePos():void
		{
			if( isAutoPos )
				setLblNormal( - xfLabel.width / 2, - xfLabel.height / 2 );
		}
		
		public function set title( content : String ) : void
		{
			xfLabel.text	=	content;
		}
		
		public function get title() : String
		{
			return xfLabel.text;
		}
	}
}