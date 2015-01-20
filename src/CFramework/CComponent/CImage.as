package CFramework.CComponent
{
	import CFramework.CRendererUltility.FilterEffect;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class CImage extends Sprite
	{
		private var _asset : DisplayObject			=	null;
		private var _loadingIcon : DisplayObject;
		private var _enabled : Boolean				=	true;

		private var tooltipTime:Number				=	0;
		public var isTooltipEnabled:Boolean		=	false;
		private var toolTip:Sprite					=	null;
		private var isHighlight:Boolean				=	false;
		
		public function CImage() {
			
			_loadingIcon	=	new CLoadingIcon;
			
			updateLoadingIcon();
		}
		
		public function set source( val : DisplayObject ) : void
		{
			if( val == null || _asset == val )
				return;
				
			if( _asset != null )
			{
				try
				{
					removeChild( _asset );
				}
				catch( ex : * ){}
			}
				
			addChild( val );
			
			_asset	=	val;
			
			//
			updateLoadingIcon();
		}
		
		public function drawSize( w : Number, h : Number, color : uint = 0x000088, alpha : Number = 0.5 ) : void
		{
			var g : Graphics	=	this.graphics;
			g.beginFill( color, alpha );
			g.drawRect( 0, 0, w, h );
			g.endFill();
			
			_loadingIcon.x	=	w * 0.5;
			_loadingIcon.y	=	h * 0.5;
		}
		
		public function get source() : DisplayObject
		{
			return _asset;
		}
		
		private function updateLoadingIcon() : void
		{
			// Remove loading icon
			if( _asset != null )
			{
				try
				{
					removeChild( _loadingIcon );
					_loadingIcon = null;
					
				}
				catch( ex : * ){}
			}
				
			else
				addChild( _loadingIcon );
		}
		
		public function set enabled( val : Boolean ) : void
		{
			_enabled	=	val;
			
			this.mouseChildren	=	_enabled;
			this.mouseEnabled	=	_enabled;
		}
		
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		public function move( x:int, y:int ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		public function set highlight( isHighlight:Boolean ):void
		{
			this.isHighlight	=	isHighlight;
		}
		
		public function setTooltip( text:String, alignX:String, alignY:String = null ):void
		{
			toolTip				=	new Sprite();
			toolTip.visible		=	false;
			addChildAt( toolTip, numChildren );
			
			var lblText:TextField	=	new TextField();
			lblText.mouseEnabled=	false;
			lblText.text		=	text;
			lblText.textColor	=	0x000000;
			lblText.width		=	lblText.textWidth + 15;
			lblText.height		=	lblText.textHeight + 6;
			toolTip.addChild( lblText );
			
			var lblWidth:int 	= 	lblText.width;
			var lblHeight:int 	= 	lblText.height;
			
			var g:Graphics = toolTip.graphics;
			g.beginFill( 0xffffff, 1.0 );
			g.drawRoundRect(-5, -2, lblWidth, lblHeight, 10, 10);
			g.endFill();
			
			switch( alignX )
			{
				case "CENTER":
					toolTip.x		=	width/2 - lblWidth/2;
					break;
				case "LEFT":
					toolTip.x		=	- lblWidth;
					break;
				case "RIGHT":
					toolTip.x		=	width + lblWidth;
					break;
			}
			if( alignY != null )
			{
				switch( alignY )
				{
					case "CENTER":
						toolTip.y	=	height/2 - lblHeight/2;
						break;
					case "TOP":
						toolTip.y	=	-lblHeight;
						break;
					case "BOTTOM":
						toolTip.y	=	height + lblHeight;
						break;
				}
			}
			
			addEventListener( MouseEvent.ROLL_OVER, onMouseHandler );
		}
		
		protected function onMouseHandler(event:MouseEvent):void
		{
			switch( event.type )
			{
				case MouseEvent.ROLL_OVER:
					addEventListener( MouseEvent.ROLL_OUT, onMouseHandler );
					toolTip.visible	=	true;
					
					if ( isHighlight )
						filters		=	FilterEffect.createStrokeFilter( 0xffffff, 5.0, 5.0, 5.0 );
					break;
				
				case MouseEvent.ROLL_OUT:
					removeEventListener( MouseEvent.ROLL_OUT, onMouseHandler );
					toolTip.visible	=	false;
					filters		=	null;
					break;
			}
		}
	}
}
