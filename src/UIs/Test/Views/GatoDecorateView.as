package UIs.Test.Views
{
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CLabelButton;
	
	import Share.CShareMacros;
	
	import UIs.Test.ColorItems.BaseColorItem;
	import UIs.Test.ColorItems.IColor;
	import UIs.Test.ColorItems.IReceiveColor;
	import UIs.Test.ContainedObject;
	import UIs.Test.IReceivePlate;
	import UIs.Test.Items.BaseItem;
	import UIs.Test.Items.ToppingItem;
	import UIs.Test.PlateItem;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.events.SelectionEvent;

	public class GatoDecorateView extends BaseView implements IReceiveIndex, IReceiveColor, IReceivePlate
	{
		private var _indexSelected:uint = 2;
		private var _currentColor:int;
		private var _currentStr:String;
		
		// Select view
		private var _selectPatternView:Sprite;
		private var _selectItems:Vector.<SelectItem>;
		
		// Decorate gato view
		private static const defaultBrush:Point	=	new Point( 10, 10 );
		private var _lastPoint:Point;
		
		private var _gato:CImage;
		private var _mask:Sprite;
		private var _isMouseDown:Boolean = 	false;
		
		private var _toppingItems:Vector.<BaseItem>;
		private var _dynamicToppings:Vector.<BaseItem>;
		
		private var _frostingItems:Vector.<BaseColorItem>;
		private var _plateItems:Vector.<PlateItem>;
		
		private var _plate:DisplayObject;
		
		private var _decorateView:Sprite;
		
		private var _btnFrost:CLabelButton;
		private var _btnTopping:CLabelButton;
		private var _btnPlate:CLabelButton;
		
		// End gato view
		private var _endView:Sprite;
		
		private var _counter:Number	=	0.0;
		
		public function GatoDecorateView( thisScreen:String = null )
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
			
			selectPattern();
		}
		
		public override function onShow():void
		{
			selectPattern();
			Global.CoreGame.runtimeUpdater.addFunction( onRuntimeUpdate );
		}
		
		public override function onHide():void
		{
			clear( true );
			Global.CoreGame.runtimeUpdater.removeFunction( onRuntimeUpdate );
		}
		
		protected function onRuntimeUpdate( delta:Number, total:Number ):void
		{
			if( _counter != 0 )
				_counter	+=	delta;
		}
		
		protected function clear( removeEndView:Boolean = true ):void
		{
			clearItem();
			
			var i:uint = 0;
			if( _selectPatternView )
			{
				_selectPatternView.removeChildren();
				removeChild( _selectPatternView );
				_selectPatternView	=	null;
			}
			
			if( _decorateView )
			{
				_btnFrost.removeEventListener( MouseEvent.CLICK, onFrostingClicked );
				_decorateView.removeChild( _btnFrost );
				
				_btnTopping.removeEventListener( MouseEvent.CLICK, onToppingClicked );
				_decorateView.removeChild( _btnTopping );
				
				_btnPlate.removeEventListener( MouseEvent.CLICK, onPlatesClicked );
				_decorateView.removeChild( _btnPlate );
				
				_decorateView.removeChildren();
				removeChild( _decorateView );
				_decorateView	=	null;
				
				if( _mask )
					_mask.graphics.clear();
			}
			
			if( removeEndView && _endView )
			{
				_endView.removeChildren();
				removeChild( _endView );
				_endView	=	null;
			}
			
			onUnDecorate();
		}
		
		protected function selectPattern():void
		{
			clear();
			
			_selectPatternView	=	new Sprite;
			addChild( _selectPatternView );
			
			_selectItems	=	new Vector.<SelectItem>;
			
			var bg:CImage	=	new CImage;
			bg.move( 100, 150 );
			_selectPatternView.addChild( bg );
			
			var clsBg:Class	=	_core.resourceManager.getClass( "select_gato_bg" );
			bg.source	=	new Bitmap( new clsBg );
			
			for( var i:uint = 0; i < 3; ++i )
			{
				var selectItem:SelectItem	=	new SelectItem( i + 1, this );
				selectItem.x	=	130 + (i != 0 ? 1 : 0)*10 + i * 190;
				selectItem.y	=	380 - selectItem.height;
				_selectPatternView.addChild( selectItem );
			}
		}
		
		protected function decorate():void
		{
			clear();
			
			_decorateView	=	new Sprite;
			addChild( _decorateView );
			
			// Load bg
			var bg:CImage	=	new CImage;
			bg.move( 60, 100 );
			_decorateView.addChild( bg );
			
			var clsBg:Class	=	_core.resourceManager.getClass( "decor_gato_bg" );
			bg.source	=	new Bitmap( new clsBg );
			
			// Load gato
			_gato	=	new CImage;
			_decorateView.addChild( _gato );
			
			var clsGato:Class	=	_core.resourceManager.getClass( JSONFake.CAKE[_indexSelected] );
			_gato.source	=	new clsGato;
			_gato.x		=	565 - _gato.width/2;
			_gato.y		=	500 - _gato.height;
			
			_mask	=	new Sprite;
			_decorateView.addChild( _mask );
			
			// Load button
			_btnFrost	=	new CLabelButton( false );
			_btnFrost.title	=	"Frostings";
			_btnFrost.setLblDown( 2, 2 );
			_btnFrost.setLblNormal( -46.5, -15 );
			_btnFrost.labelPtr.size	=	18;
			_btnFrost.labelPtr.bold	=	true;
			_btnFrost.labelPtr.color	=	0xffffff;
			_btnFrost.labelPtr.setFont( "UVN Banh Mi", true );
			_btnFrost.move( 110, 153 );
			_btnFrost.addEventListener( MouseEvent.CLICK, onFrostingClicked );
			_decorateView.addChild( _btnFrost );
			
			_btnTopping	=	new CLabelButton( false );
			_btnTopping.title	=	"Toppings";
			_btnTopping.setLblDown( 2, 2 );
			_btnTopping.setLblNormal( -46.5, -15 );
			_btnTopping.labelPtr.size	=	18;
			_btnTopping.labelPtr.bold	=	true;
			_btnTopping.labelPtr.color	=	0xffffff;
			_btnTopping.labelPtr.setFont( "UVN Banh Mi", true );
			_btnTopping.move( 210, 153 );
			_btnTopping.addEventListener( MouseEvent.CLICK, onToppingClicked );
			_decorateView.addChild( _btnTopping );
			
			_btnPlate	=	new CLabelButton( false );
			_btnPlate.title	=	"Plates";
			_btnPlate.setLblDown( 2, 2 );
			_btnPlate.setLblNormal( -48.5, -15 );
			_btnPlate.labelPtr.size	=	18;
			_btnPlate.labelPtr.bold	=	true;
			_btnPlate.labelPtr.color	=	0xffffff;
			_btnPlate.labelPtr.setFont( "UVN Banh Mi", true );
			_btnPlate.move( 310, 153 );
			_btnPlate.addEventListener( MouseEvent.CLICK, onPlatesClicked );
			_decorateView.addChild( _btnPlate );
			
			var btnComplete:CLabelButton	=	new CLabelButton( false );
			btnComplete.title	=	"Hoàn Thành";
			btnComplete.setLblDown( 2, 2 );
			btnComplete.setLblNormal( -35.5, -12 );
			btnComplete.labelPtr.size	=	12;
			btnComplete.labelPtr.setSize( 100, 20 );
			btnComplete.labelPtr.bold	=	true;
			btnComplete.labelPtr.color	=	0xffffff;
			btnComplete.labelPtr.setFont( "UVN Banh Mi", true );
			btnComplete.move( 720, 558 );
			btnComplete.scaleX	=	1.3;
			btnComplete.addEventListener( MouseEvent.CLICK, onCompleteClicked );
			_decorateView.addChild( btnComplete );
			
			var clsUp:Class	=	_core.resourceManager.getClass( "tab_button_up" );
			var clsDown:Class	=	_core.resourceManager.getClass( "tab_button_down" );
			
			_btnFrost.upSkin	=	new Bitmap( new clsUp );
			_btnFrost.overSkin	=	new Bitmap( new clsUp );
			
			_btnTopping.upSkin	=	new Bitmap( new clsUp );
			_btnTopping.overSkin=	new Bitmap( new clsUp );
			
			_btnPlate.upSkin	=	new Bitmap( new clsUp );
			_btnPlate.overSkin	=	new Bitmap( new clsUp );
			
			_btnFrost.downSkin	=	new Bitmap( new clsDown );
			_btnTopping.downSkin=	new Bitmap( new clsDown );
			_btnPlate.downSkin	=	new Bitmap( new clsDown );
			
			_dynamicToppings	=	new Vector.<BaseItem>;
			
			var clsNUp:Class		=	_core.resourceManager.getClass( "normal_button_up" );
			var clsNDown:Class	=	_core.resourceManager.getClass( "normal_button_down" );
			btnComplete.upSkin	=	new clsNUp;
			btnComplete.overSkin=	new clsNUp;
			btnComplete.downSkin=	new clsNDown;
			
			onDecorate();
		}
		
		protected function onDecorate():void
		{
			if( stage )
			{
				stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
		}
		
		protected function onUnDecorate():void
		{
			if( stage )
			{
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				
				stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
		}
		
		protected function complete():void
		{
			_endView	=	new Sprite;
			addChild( _endView );
			
			var bg:CImage	=	new CImage;
			bg.move( 80, 80 );
			_endView.addChild( bg );
			
			var clsBg:Class	=	_core.resourceManager.getClass( "congras_bg" );
			bg.source	=	new Bitmap( new clsBg );
			
			copyFromDecorateToEnd();
			clear( false );
			
		}
		
		protected function copyFromDecorateToEnd():void
		{
			var tempX:Number	=	120;
			var tempY:Number	=	60;
			
			if( !_endView )
				return;
			
			// copy gato
			if( _plate )
			{
				_endView.addChild( _plate );
				_plate.x	-=	tempX;
				_plate.y	-=	tempY;
			}
			
			if( _gato )
			{
				_endView.addChild( _gato );
				_gato.x		-=	tempX;
				_gato.y		-=	tempY;
			}
			
			if( _mask )
			{
				_endView.addChild( _mask );
				_mask.x		-=	tempX;
				_mask.y		-=	tempY;
			}
			
			if( _dynamicToppings && _dynamicToppings.length > 0 )
			{
				for( var i:uint = 0; i < _dynamicToppings.length; ++i )
				{
					_dynamicToppings[i].x	-=	tempX;
					_dynamicToppings[i].y	-=	tempY;
					_endView.addChild( _dynamicToppings[i] );
				}
			}
		}
		
		public function changeIndex( index:uint ):void
		{
			_indexSelected	=	index;
		}
		
		public function changeColor( colorItem:String ):void
		{
			_currentStr	=	colorItem;
		}
		
		public function changePlate( cls:Class ):void
		{
			if( !_decorateView )
				return;
			
			if( _plate && _plate.parent )
			{
				_plate.parent.removeChild( _plate );
				_plate	=	null;
			}
			
			_plate	=	new cls;
			_plate.x	=	_gato.x - 60;
			_plate.y	=	_gato.y + _gato.height + 50 - _plate.height;
			_decorateView.addChildAt( _plate, _decorateView.getChildIndex( _gato ));
		}
		
		//===================================================================================
		protected function clearItem():void
		{
			var i:uint = 0;
			if( _frostingItems )
			{
				for( i = 0; i < _frostingItems.length; ++i )
				{
					_frostingItems[i].dispose();
				}
				if( _frostingItems.length > 0 )
					_frostingItems.splice( 0, _frostingItems.length );
				_frostingItems	=	null;
			}
			
			if( _toppingItems )
			{
				for( i = 0; i < _toppingItems.length; ++i )
				{
					_toppingItems[i].dispose();
				}
				if( _toppingItems.length > 0 )
					_toppingItems.splice( 0, _toppingItems.length );
				_toppingItems	=	null;
			}
			
			if( _plateItems )
			{
				for( i = 0; i < _plateItems.length; ++i )
				{
					_plateItems[i].dispose();
				}
				if( _plateItems.length > 0 )
					_plateItems.splice( 0, _plateItems.length );
				_plateItems	=	null;
			}
		}
		
		protected function onFrostingClicked( event:MouseEvent ):void
		{
			if( _frostingItems )
				return;
			
			clearItem();
			
			_frostingItems	=	new Vector.<BaseColorItem>;
			var counter:uint=	0;
			for( var i:String in JSONFake.FROST )
			{
				var item:BaseColorItem = new BaseColorItem( i, JSONFake.FROST[i], this );
				item.x	=	95 + int(counter % 3) * 94;
				item.y	=	242 + int(counter / 3) * 100;
				_decorateView.addChild( item );
				
				_frostingItems.push( item );
				counter++;
			}
		}
		
		protected function onToppingClicked( event:MouseEvent ):void
		{
			if( _toppingItems )
				return;
			
			clearItem();
			
			_toppingItems	=	new Vector.<BaseItem>;
			var counter:uint=	0;
			for( var i:String in JSONFake.TOPPING )
			{
				var item:BaseItem	=	new ToppingItem( JSONFake.TOPPING[i], true, _dynamicToppings );
				item.x	=	68 + int(counter % 3) * 94;
				item.y	=	212 + int(counter / 3) * 100;
				_toppingItems.push( item );
				_decorateView.addChild( item );
				counter++;
			}
		}
		
		protected function onPlatesClicked( event:MouseEvent ):void
		{
			if( _plateItems )
				return;
			
			clearItem();
			
			_plateItems	=	new Vector.<PlateItem>;
			var counter:uint=	0;
			for( var i:String in JSONFake.PLATES )
			{
				var item:PlateItem	=	new PlateItem( JSONFake.PLATES[i], this, true );
				item.x	=	98 + int(counter % 1) * 94;
				item.y	=	212 + int(counter / 1) * 100;
				_plateItems.push( item );
				_decorateView.addChild( item );
				counter++;
			}
		}
		
		//===================================================================================
		protected function onCompleteClicked( event:MouseEvent ):void
		{
			complete();
		}
		
		protected override function onNextClicked( event:MouseEvent ):void
		{
			super.onNextClicked( event );
			
			if( _selectPatternView )
				decorate();
			else if( _decorateView )
				complete();
			else if( _endView )
			{
				Global.CoreGame.showView( CShareMacros.HLB_TN );
				Global.CoreGame.hideView( CShareMacros.HLB_VIEW );
			}
		}
		
		protected override function onPrevClicked( event:MouseEvent ):void
		{
			super.onPrevClicked( event );
			
			if( _decorateView )
				selectPattern();
			else if( _endView )
				decorate();
			else if( _selectPatternView )
				onMenuClicked( event );
		}
	
		//===================================================================================
		protected function onKeyDown( evt:KeyboardEvent ):void
		{
			if( evt.keyCode == Keyboard.DELETE )
			{
				for( var i:uint = 0; i < _dynamicToppings.length; ++i )
				{
					var result:Boolean	=	_dynamicToppings[i].hitTest();
					if( result )
					{
						_dynamicToppings[i].dispose();
						if( _dynamicToppings[i].parent )
							_dynamicToppings[i].parent.removeChild( _dynamicToppings[i] );
						_dynamicToppings.splice( i, 1 );
						i--;
					}
				}
			}
		}

		protected function onMouseDown( evt:MouseEvent ):void
		{
			_isMouseDown	=	true;
			_lastPoint		=	new Point( evt.stageX, evt.stageY );
		}
		
		protected function onMouseUp( evt:MouseEvent ):void
		{
			_isMouseDown	=	false;
			_lastPoint		=	null;
		}
		
		protected function onMouseMove( evt:MouseEvent ):void
		{
			if( _counter != 0 && _counter < 0.3 )
				return;
			
			_counter	=	0.1;
			
			if( !_isMouseDown )
				return;
			
			if( !_mask )
				return;
			
			if( !_gato.hitTestPoint( evt.stageX, evt.stageY ))
				return;
			
			if( _currentStr )
			{
				var cls:Class	=	_core.resourceManager.getClass( _currentStr );
				if( cls )
				{
					var img:DisplayObject	=	new Bitmap( new cls );
					img.x	=	evt.stageX - img.width/2;
					img.y	=	evt.stageY - img.height/2;
					_mask.addChild( img );
				}
			}
//			var g:Graphics	=	_mask.graphics;
//			g.beginFill( _currentColor );
//			if( _lastPoint ) {
//				g.lineStyle( defaultBrush.x, _currentColor );
//				g.moveTo( _lastPoint.x, _lastPoint.y );
//				
//				_lastPoint.x	=	evt.stageX;
//				_lastPoint.y	=	evt.stageY;
//				
//				g.lineTo( _lastPoint.x, _lastPoint.y );
//				
//			} else {
//				g.drawCircle( evt.stageX, evt.stageY, defaultBrush.x );
//			}
//			g.endFill();
		}
	}
}