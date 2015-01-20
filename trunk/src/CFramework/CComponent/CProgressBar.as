package CFramework.CComponent
{
	import CFramework.CRendererUltility.FilterEffect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class CProgressBar extends Sprite
	{
		protected var _bitData : BitmapData;
		protected var _bitmap : Bitmap;
		protected var _shape : Shape;
		
		protected var _asset : DisplayObject;
		private var _loadingIcon : DisplayObject;
		
		protected var _value : Number		=	0;
		protected var _max : Number			=	1;
		protected var _min : Number			=	0;
		protected var _assetWidth : Number	=	1;
		protected var _assetHeight : Number	=	1;
		
		protected var _isSquare : Boolean	=	true;
		protected var _roundX : int			=	15;
		protected var _roundY : int			=	15;
		
		protected var _isShowPercent : Boolean	=	false;
		protected var _isShowNumber	: Boolean	=	false;
		protected var _lblPercent : CLabel	=	null;
		
		public function CProgressBar( width : Number, height : Number )
		{
			super();
			
			_assetWidth		=	width;
			_assetHeight	=	height;
			
			_bitmap			=	new Bitmap();
			addChild( _bitmap );
			
			_shape			=	new Shape();
			addChild( _shape );
			
			_lblPercent		=	new CLabel();
			_lblPercent.size=	10;
			
			_loadingIcon	=	new CLoadingIcon;
			
			updateLoadingIcon();
			
			draw();
		}
		
		public function showPercent():void
		{
			_isShowPercent		=	true;
			_lblPercent.color	=	0xffffff;
			_lblPercent.text	=	"%%%%%%";
			_lblPercent.filters	=	FilterEffect.createStrokeFilter( 0x0, 3, 3, 3 );
			addChild( _lblPercent );
		}
		
		public function showNumber():void
		{
			_isShowNumber		=	true;
			showPercent();
		}
		
		public function get assetHeight():Number
		{
			return _assetHeight;
		}

		public function set assetHeight(value:Number):void
		{
			_assetHeight = value;
		}

		public function get assetWidth():Number
		{
			return _assetWidth;
		}

		public function set assetWidth(value:Number):void
		{
			_assetWidth = value;
		}

		public function set assetSkin( val : DisplayObject ) : void
		{
			if( _asset == val )
				return;
			
			_asset		=	val;
			if( !_isSquare )
			{
				if( _isShowPercent )
					addChildAt( _asset, getChildIndex( _lblPercent ) - 1 );
				else 
					addChild( _asset );
			}
			
			updateLoadingIcon();
			draw();
		}
		
		public function set changeAssetSkin( val : DisplayObject ) : void
		{
			if( _asset == val || _asset == null )
				return;
			
			if( !_isSquare )
				removeChild( _asset );
			
			_asset	=	val;	
			
			if( _isShowPercent )
				addChildAt( _asset, getChildIndex( _lblPercent ) + 1 );
			else 
				addChild( _asset );
			
			draw();
		}
		
		public function get assetSkin() : DisplayObject
		{
			return _asset;	
		}
		
		public function set squareAngle( isSquare:Boolean ):void
		{
			_isSquare	=	isSquare;
		}
		
		public function set roundX( rX:int ):void
		{
			_roundX		=	rX;
		}
		
		public function set roundY( rY:int ):void
		{
			_roundY		=	rY;
		}
		
		private function draw():void
		{			
			if( _asset == null )
				return;
			
			if( _isShowNumber )
				_lblPercent.text	=	(_value - _min) + "/" + (_max - _min);
			else
				_lblPercent.text	=	Math.round( ((_value - _min) / (_max - _min)) * 100 ) + "%";
			_lblPercent.x		=	_asset.width / 2 - _lblPercent.width / 2;
			_lblPercent.y		=	_asset.height / 2 - _lblPercent.height / 2;
			
			var w : Number		=	((_value - _min) / (_max - _min)) * _assetWidth;
			if( int(w) <= 0)
			{
				_bitmap.bitmapData	=	null;
				// Hide all asset
				_bitmap.visible		=	false;
				_asset.visible		=	false;
				return;
			}
			// Show all asset
			_bitmap.visible		=	true;
			_asset.visible		=	true;
			
			if( _isSquare )
			{
				_bitData			=	new BitmapData( w, _assetHeight, true, 0x00000000 );
				_bitData.draw( _asset );
				
				_bitmap.bitmapData	=	_bitData;
			}
			else
			{
				_shape.graphics.clear();
				_shape.graphics.lineStyle();
				_shape.graphics.beginFill( 0xFFFFFF, 1 );
				_shape.graphics.drawRoundRect( 0, 0, w, _assetHeight, _roundX, _roundY );
				_shape.graphics.endFill();
				_asset.mask	=	_shape;
			}
		}
		
		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set maximum(m:Number):void
		{
			if( m < _min )
				m	=	_min + 1;
				
			_max = m;
			_value = Math.min( _value, _max );
			draw();
		}
		public function get maximum():Number
		{
			return _max;
		}
		
		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set minimum(m:Number):void
		{
			if( m > _max )
				m	=	_max - 1;
				
			_min = m;
			_value = Math.max( _min, _value );
			draw();
		}
		public function get minimum():Number
		{
			return _min;
		}
		
		/**
		 * Gets / sets the current value of the ProgressBar.
		 */
		public function set value(v:Number):void
		{
			if( v < 0 )
				v = 0.0;
			else
			{
				_value	=	Math.max( v, _min );
				_value 	= 	Math.min( v, _max );		
			}
			
			draw();
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function move( x:int, y:int ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		private function updateLoadingIcon() : void
		{
			// Remove loading icon
			if( _asset != null )
			{
				removeChild( _loadingIcon );
				_loadingIcon = null;
			}
			else
			{
				addChild( _loadingIcon );
			}
			
		}
	}
}