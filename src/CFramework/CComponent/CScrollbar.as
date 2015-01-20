package CFramework.CComponent
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class CScrollbar extends Sprite
	{
		private var _itemContainer:Sprite;
		private var _itemList:Vector.<DisplayObject>;
		private var _totalLength:Number	=	0;
		
		private var _scrollbar:DisplayObject;
		private var _scrollbarControl:CImage;
		
		private var _btnUp:CImageButton;
		private var _btnDown:CImageButton;
		
		private var _size:Rectangle;
		
		private var _scrollItem:Boolean;
		
		private var _yOffset:Number;
		private var _ymin:Number = 0;
		private var _ymax:Number;
		
		private var _step:Number = 1;
		private var _currentPos:Number;
		
		private var _autoHideScroll:Boolean	=	true;
		
		public function CScrollbar()
		{
			super();
			
			_itemList	=	new Vector.<DisplayObject>();
			
			_itemContainer	=	new Sprite();
			addChild( _itemContainer );
			
			_scrollbarControl	=	new CImage();
			_scrollbarControl.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
			_size	=	new Rectangle(0, 0, 100, 100);
			
			Global.CoreSNSFramework.getStage().addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		public function set autoHideScroll(value:Boolean):void
		{
			_autoHideScroll = value;
		}
		
		protected function onMouseDown( e:MouseEvent ):void
		{
			Global.CoreSNSFramework.getStage().addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_yOffset	=	mouseY - _scrollbarControl.y;
		}
		
		protected function onMouseUp( e:MouseEvent ):void
		{
			Global.CoreSNSFramework.getStage().removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		protected function onMouseMove( e:MouseEvent ):void
		{
			slide( mouseY - _yOffset );
			
			e.updateAfterEvent();
		}
		
		private function slide( dis:Number ):void
		{
			var lastY:Number		=	_scrollbarControl.y;
			_scrollbarControl.y		=	dis;
			if( _scrollbarControl.y <= _ymin )
				_scrollbarControl.y	=	_ymin;
			if( _scrollbarControl.y >= _ymax )
				_scrollbarControl.y	=	_ymax;
			
			var distance:Number		=	_totalLength * (lastY - _scrollbarControl.y) / _scrollbar.height;
			for( var i:int; i < _itemList.length; ++i )
			{
				_itemList[i].y	+=	distance;
			}
		}
		
		private function createMask():Shape
		{
			var m:Shape	=	 new Shape();
			_itemContainer.addChild( m );
			
			m.graphics.lineStyle();
			m.graphics.beginFill( 0xFFFFFF, 1 );
			m.graphics.drawRect( _size.x, _size.y, _size.width, _size.height );
			m.graphics.endFill();
			
			return m;
		}
		
		public function set scrollItem( typeScroll:Boolean ):void
		{
			_scrollItem	=	typeScroll;
			updateView();
		}
		
		public function get scrollbarRect():Rectangle
		{
			return _size;
		}
		
		public function set scrollbarRect( val:Rectangle ):void
		{
			_size		=	val;
			updateView();
		}
		
		public function addItem( item:DisplayObject ):void
		{
			var m:Shape		=	createMask();
			item.mask		=	m;
			_itemList.push( item );
			_itemContainer.addChild( m );
			_itemContainer.addChild( item );
			_totalLength	+=	item.height;
			
			updateView();
		}
		
		public function clear():void
		{
			if( _itemContainer.numChildren > 0 )
				_itemContainer.removeChildren( 0, _itemContainer.numChildren - 1 );
			if( _itemList.length > 0 )
				_itemList.splice( 0, _itemList.length );
			_totalLength	=	0;
		}
		
		private function showScrollbar():void
		{
			if( _scrollbarControl )
				_scrollbarControl.visible	=	true;
			if( _scrollbar )
				_scrollbar.visible	=	true;
			if( _btnUp )
				_btnUp.visible		=	true;
			if( _btnDown )
				_btnDown.visible	=	true;
		}
		
		private function hideScrollbar():void
		{
			if( _scrollbarControl )
				_scrollbarControl.visible	=	false;
			if( _scrollbar )
				_scrollbar.visible	=	false;
			if( _btnUp )
				_btnUp.visible		=	false;
			if( _btnDown )
				_btnDown.visible	=	false;
		}
		
		public function set scrollbarSkin( val : DisplayObject ):void
		{
			if( _scrollbar )
				_scrollbar.parent.removeChild( _scrollbar );
			
			_scrollbar	=	val;
			addChild( _scrollbar );
			
			updateView();
		}
		
		public function get scrollbarSkin():DisplayObject
		{
			return _scrollbar;
		}
		
		public function set scrollbarControlSkin( val : DisplayObject ):void
		{
			if( _scrollbarControl.parent )
			{
				_scrollbarControl.removeChildAt(0);
				_scrollbarControl.parent.removeChild( _scrollbarControl );
			}
			
			_scrollbarControl.source	=	val;
			addChild( _scrollbarControl );
			
			updateView();
		}
		
		public function get scrollbarControlSkin():DisplayObject
		{
			return _scrollbarControl;
		}
		
		public function setScrollbarControlRangeMove( min:Number, max:Number ):void
		{
			_ymin	=	min;
			_ymax	=	max;
		}
		
		public function get btnUp():CImageButton
		{
			if( !_btnUp )
			{
				_btnUp	=	new CImageButton();
				_btnUp.visible	=	false;
				addChild( _btnUp );
				_btnUp.addEventListener( MouseEvent.CLICK, onUp );
			}
			return _btnUp;
		}
		
		public function get btnDown():CImageButton
		{
			if( !_btnDown )
			{
				_btnDown	=	new CImageButton();
				_btnDown.visible	=	false;
				addChild( _btnDown );
				_btnDown.addEventListener( MouseEvent.CLICK, onDown );
			}
			return _btnDown;
		}
		
		protected function onUp( e:MouseEvent ):void
		{
			slide( _scrollbarControl.y - _step );
		}
		
		protected function onDown( e:MouseEvent ):void
		{
			slide( _scrollbarControl.y + _step );
		}
		
		public function setStep( step:Number ):void
		{
			_step	=	step;
		}
		
		public function scrollbarControlSkinMove( x:Number, y:Number ):void
		{
			_scrollbarControl.move( x, y );
		}
		
		private function updateView():void
		{
			if( _itemContainer.numChildren > 0 )
				_itemContainer.removeChildren( 0, _itemContainer.numChildren-1 );
			
			for( var i:int = 0; i < _itemList.length; ++i )
			{
				_itemList[i].mask	=	createMask();
				_itemContainer.addChild( _itemList[i] );
			}
			
			if( _totalLength > _size.height )
				showScrollbar();
			else 
				hideScrollbar();
			
			if( !_autoHideScroll )
				showScrollbar();
		}
	}
}