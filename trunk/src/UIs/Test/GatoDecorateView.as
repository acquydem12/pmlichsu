package UIs.Test
{
	import CFramework.CComponent.CLabel;
	import CFramework.CComponent.CLabelButton;
	import CFramework.CRendererUltility.FilterEffect;
	import CFramework.core.CView;
	
	import Share.CShareMacros;
	
	import UIs.Test.ColorItems.BaseColorItem;
	import UIs.Test.ColorItems.IColor;
	import UIs.Test.ColorItems.IReceiveColor;
	import UIs.Test.Items.BaseItem;
	import UIs.Test.Items.BigCherryItem;
	import UIs.Test.Items.CandleItem;
	import UIs.Test.Items.CandyItem;
	import UIs.Test.Items.CreamItem;
	import UIs.Test.Items.DecorItem;
	import UIs.Test.Items.FruitItem;
	import UIs.Test.Items.SmallCherryItem;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	public class GatoDecorateView extends CView implements IReceiveColor
	{
		private static const defaultBrush:Point	=	new Point( 10, 10 );
		
		private static const colorMap:Object	=	{
			"0x0000ff":0x0000ff,
			"0x00ffff":0x00ffff,
			"0x00ff00":0x00ff00,
			"0xff00ff":0xff00ff,
			"0xff0000":0xff0000,
			"0xffff00":0xffff00
		};
		
		private var _currentColor:int	=	0x0;
		
		private var _bg:ContainedObject;
		private var _shelf1:ContainedObject;
		private var _shelf2:ContainedObject;
		private var _shelf3:ContainedObject;
		
		private var _btnClear:CLabelButton;
		
		private var _gato:MovieClip;
		private var _mask:Sprite;
		private var _isMouseDown:Boolean = 	false;
		
		private var _staticItems:Vector.<BaseItem>;
		private var _dynamicItems:Vector.<BaseItem>;
		
		private var _colorBoard:Vector.<BaseColorItem>;
		
		private var _lastPoint:Point;
		
		public function GatoDecorateView()
		{
			super();
		}
		
		public override function onRegisterComplete():void
		{
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			loadBG();
			loadShelf();
			loadGATO();
			loadDecorator();
			
			loadColorBoard();
			createButtonClear();
		}
		
		public function changeColor( colorItem:IColor ):void
		{
			_currentColor	=	colorItem.color;
			for( var i:uint = 0; i < _colorBoard.length; ++i )
			{
				if( _colorBoard[i] != colorItem )
					_colorBoard[i].up();
			}
		}
		
		private function createButtonClear():void
		{
			_btnClear	=	new CLabelButton( false );
			_btnClear.title	=	"Xóa";
			_btnClear.setLblDown( 2, 2 );
			_btnClear.setLblNormal( -42.5, -15 );
			var tfEvent:CLabel	=	_btnClear.labelPtr;
			tfEvent.size		=	18;
			tfEvent.bold		=	true;
			tfEvent.color		=	0xffffff;
			addChild( _btnClear );
			
			Global.CTTController.addTooltip( _btnClear, "Xóa chiếc bánh hiện tại" );
			
			_btnClear.addEventListener( MouseEvent.CLICK, onButtonHandler );
			_btnClear.addEventListener( MouseEvent.ROLL_OVER, onButtonHandler );
			
			// Init image
			var cls:Class;
			cls		=	_core.resourceManager.getClass( "button_circle_up" );
			_btnClear.upSkin	=	new Bitmap( new cls );
			_btnClear.overSkin	=	new Bitmap( new cls );
			_btnClear.move( Global.APP_WIDTH - _btnClear.upSkin.width/2 - 10, 50 );
			
			cls		=	_core.resourceManager.getClass( "button_circle_down" );
			_btnClear.downSkin	=	new Bitmap( new cls );
		}
		
		private function loadBG():void
		{
			var cls:Class	=	_core.resourceManager.getClass( "bg" );
			if( cls )
			{
				_bg		=	new ContainedObject;
				addChild( _bg );
				
				_bg.source	=	new Bitmap( new cls );
				_bg.x	=	0;
				_bg.y	=	-100;
			}
		}
		
		private function loadShelf():void
		{
			var cls:Class	=	_core.resourceManager.getClass( "shelf" );
			if( cls )
			{
				_shelf1		=	new ContainedObject;
				_shelf1.x	=	10;
				_shelf1.y	=	50;
				addChild( _shelf1 );
				
				_shelf2		=	new ContainedObject;
				addChild( _shelf2 );
				
				_shelf3		=	new ContainedObject;
				_shelf3.x	=	10;
				_shelf3.y	=	200;
				addChild( _shelf3 );
				
				_shelf1.source	=	new Bitmap( new cls );
				_shelf2.source	=	new Bitmap( new cls );
				_shelf3.source	=	new Bitmap( new cls );
				_shelf2.x	=	Global.APP_WIDTH - _shelf2.source.width - 30;
				_shelf2.y	=	100;
			}
		}
		
		private function loadGATO():void
		{
			var cls:Class	=	_core.resourceManager.getClass( "default_cake" );
			if( cls )
			{
				_gato	=	new cls;
				_gato.x	=	Global.HAFT_APP_WIDTH - _gato.width / 2;
				_gato.y	=	Global.HAFT_APP_HEIGHT - _gato.height / 2;
				addChild( _gato );
				_gato.buttonMode	=	true;
				
				_mask	=	new Sprite;
				addChild( _mask );
			}
		}
		
		private function loadDecorator():void
		{
			var i:uint	=	0;
			_staticItems	=	new Vector.<BaseItem>();
			_dynamicItems	=	new Vector.<BaseItem>();

			// Load candles
			for( i = 1; i < 7; ++i )
			{
				var lcandle:BaseItem	=	new CandleItem( String( i ), true, _dynamicItems );
				lcandle.x	=	_shelf2.x +  i * 20 + 50;
				lcandle.y	=	100;
				_staticItems.push( lcandle );
				addChild( lcandle );
			}
			
			// Load big cherry
			var cherry:BaseItem	=	new BigCherryItem( true, _dynamicItems );
			cherry.x	=	_shelf2.x +  i * 20 + 70;
			cherry.y	=	95;
			_staticItems.push( cherry );
			addChild( cherry );
			
			// Load big cherry
			var fruit:BaseItem	=	new FruitItem( true, _dynamicItems );
			fruit.x	=	_shelf2.x +  i * 20 + 140;
			fruit.y	=	125;
			_staticItems.push( fruit );
			addChild( fruit );
			
			// Load Candy
			for( i = 0; i < 6; ++i )
			{
				var candy:BaseItem	=	new CandyItem( String( i + 1 ), true, _dynamicItems );
				candy.x	=	_shelf1.x + 50 + int(i%3) * 110 ;
				candy.y	=	45 + int(i/3) * 160;
				_staticItems.push( candy );
				addChild( candy );
			}
			
			// Load decors
			for( i = 0; i < 5; ++i )
			{
				var decor:BaseItem	=	new DecorItem( String( i + 1 ), true, _dynamicItems );
				decor.x	=	_shelf1.x + 50 + int(i % 3) * 100 ;
				decor.y	=	325 + int(i/3) * 100;
				_staticItems.push( decor );
				addChild( decor );
			}
			
			// Load small cherry
			var scherry:BaseItem	=	new SmallCherryItem( true, _dynamicItems );
			scherry.x	=	_shelf2.x +  i * 20 + 170;
			scherry.y	=	80;
			_staticItems.push( scherry );
			addChild( scherry );
			
			// Load cream
			var cream:BaseItem	=	new CreamItem( true, _dynamicItems );
			cream.x	=	_shelf2.x +  i * 20 + 230;
			cream.y	=	145;
			_staticItems.push( cream );
			addChild( cream );
		}
		
		private function loadColorBoard():void
		{
			_colorBoard	=	new Vector.<BaseColorItem>();
			var counter:uint	=	0;
			for( var i:String in colorMap )
			{
				var item:BaseColorItem	=	new BaseColorItem( i, colorMap[i], this );
				addChild( item );
				
				_colorBoard.push( item );
				item.x	=	int(counter % 3) * 126 + 870;
				item.y	=	int(counter / 3) * 98 + 300;
				
				++counter;
			}
		}
		
		private function drawBackgroud( color:int ):void
		{
			var g:Graphics	=	graphics;
			g.beginFill( color );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
		}
		
		private function clearBackground():void
		{
			graphics.clear();
		}
		
		public override function onShow():void
		{
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			drawBackgroud( 0x00fa00 );
		}
		
		public override function onHide():void
		{
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			clearBackground();
		}
		
		protected function clear():void
		{
			for( var i:uint = 0; i < _dynamicItems.length; ++i )
			{
				_dynamicItems[i].dispose();
				removeChild( _dynamicItems[i] );
			}
			if( _dynamicItems.length > 0 )
				_dynamicItems.splice( 0, _dynamicItems.length );
			
			if( _mask )
				_mask.graphics.clear();
		}
		
		protected function onKeyDown( evt:KeyboardEvent ):void
		{
			if( evt.keyCode == Keyboard.DELETE )
			{
				for( var i:uint = 0; i < _dynamicItems.length; ++i )
				{
					var result:Boolean	=	_dynamicItems[i].hitTest();
					if( result )
					{
						_dynamicItems[i].dispose();
						removeChild( _dynamicItems[i] );
						_dynamicItems.splice( i, 1 );
						i--;
					}
				}
			}
		}
		
		protected function onButtonHandler( evt:MouseEvent ):void
		{
			switch( evt.type )
			{
				case MouseEvent.CLICK:
					clear();
					break;
				
				case MouseEvent.ROLL_OVER:
					_btnClear.addEventListener( MouseEvent.ROLL_OUT, onButtonHandler );
					_btnClear.filters	=	FilterEffect.createStrokeFilter( 0xffff00, 4, 4, 4 );
					break;
				
				case MouseEvent.ROLL_OUT:
					_btnClear.removeEventListener( MouseEvent.ROLL_OUT, onButtonHandler );
					_btnClear.filters	=	null;
					break;
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
			if( !_isMouseDown )
				return;
			
			if( !_mask || !_gato )
				return;
			
			if( !_gato.hitTestPoint( evt.stageX, evt.stageY ))
				return;
			
			var g:Graphics	=	_mask.graphics;
			g.beginFill( _currentColor );
			if( _lastPoint ) {
				g.lineStyle( defaultBrush.x, _currentColor );
				g.moveTo( _lastPoint.x, _lastPoint.y );
				
				_lastPoint.x	=	evt.stageX;
				_lastPoint.y	=	evt.stageY;
				
				g.lineTo( _lastPoint.x, _lastPoint.y );
				
			} else {
				g.drawCircle( evt.stageX, evt.stageY, defaultBrush.x );
			}
			g.endFill();
		}
	}
}