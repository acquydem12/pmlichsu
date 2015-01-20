package CFramework.CComponent
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class CNodeProgressbar extends Sprite
	{
		private var _emptySkin : Class		=	null;
		private var _hasSkin : Class		=	null;
		
		private var _numberOfItem:int		=	0;
		private var _items:Vector.<DisplayObject>	=	null;
		
		private var _isCreate:Boolean		=	false;
		
		private var _loadingIcon : DisplayObject;
		
		protected var _value : Number		=	0;
		protected var _max : Number			=	1;
		protected var _min : Number			=	0;
		
		protected var _lblValue : CLabel	=	null;
		protected var _lblMax : CLabel		=	null;
		
		public static const HORIZONTAL:String	=	"Horizontal";
		public static const VERTICAL:String		=	"Vertical";
		protected var _isOpposite:Boolean		=	true;
		protected var _direction:String			=	HORIZONTAL;
		protected var _distance:Number			=	-1;
		
		public function CNodeProgressbar( numberOfItem:int )
		{
			super();
			
			_numberOfItem			=	numberOfItem;
			
			_loadingIcon			=	new CLoadingIcon;
			_items					=	new Vector.<DisplayObject>();
			
			_lblValue				=	new CLabel();
			_lblValue.x				=	0;
			_lblValue.y				=	0;
			addChild( _lblValue );
			
			_lblMax					=	new CLabel();
			_lblMax.x				=	0;
			_lblMax.y				=	0;
			addChild( _lblMax );
			
			updateLoadingIcon();
		}
		
		public function showLabel( isShow:Boolean ):void
		{
			if( isShow ) {
				_lblValue.visible	=	true;
				_lblMax.visible		=	true;
			}
			else {
				_lblValue.visible	=	false;
				_lblMax.visible		=	false;
			}
		}
		
		public function set distance( dist:Number ):void
		{
			_distance				=	dist;
			updateView();
		}
		
		public function set opposite( isOps:Boolean ):void
		{
			_isOpposite				=	isOps;
			updateView();
		}
		
		/**
		 * 
		 * @param dir "Horizontal" or "Vertical"
		 * 
		 */		
		public function set direction( dir:String ):void
		{
			_direction	=	dir;
			updateView();
		}
		
		public function get labelValue() : CLabel
		{
			return _lblValue;
		}
		
		public function get labelMax() : CLabel
		{
			return _lblMax;
		}
		
		public function set emptySkin( val : Class ):void
		{
			_emptySkin		=	val;
			updateLoadingIcon();
			updateView();
		}
		
		public function set hasSkin( val : Class ):void
		{
			_hasSkin		=	val;
			updateView();
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
			
			_lblMax.text	=	"/ " + String( _max );
			
			updateView();
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
			
			_min 		=	m;
			_value 		=	Math.max( _min, _value );
			
			updateView();
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
				_value		=	Math.max( v, _min );
				_value 		= 	Math.min( v, _max );
			}
			
			_lblValue.text	=	String( value );
			
			updateView();
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
		
		private function updateView() : void
		{
			if( !_hasSkin || !_emptySkin )
				return;
			
			var percentPerItem:Number	=	100 / _numberOfItem;
			var numberOfHasItem:int		=	int( ( _value / _max ) * 100 / percentPerItem );
			for( var i:int = 0; i < _numberOfItem; ++i )
			{
				if( _items.length > i )
					removeChild( _items[i]);
				
				if( i < numberOfHasItem )
					_items[i]			=	new Bitmap( new _hasSkin );
				else
					_items[i]			=	new Bitmap( new _emptySkin );
				
				var l:Number		=	((_items[i] as DisplayObject).width + 5);
				if( _distance == -1 )
					_distance	=	l;
				
				if( _direction == HORIZONTAL )
				{
					_items[i].x			=	((!_isOpposite) ? (i * _distance) : (_numberOfItem-i)*_distance);
					_items[i].y			=	0;
				}
				else
				{
					_items[i].x			=	0;
					_items[i].y			=	((!_isOpposite) ? (i * _distance) : (_numberOfItem-i)*_distance);
				}
				addChild( _items[i]);
			}
			
			// Update label text
			_lblValue.text	=	String( value );
			_lblMax.text	=	"/ " + String( _max );
			
			
			// Update label position
			_lblValue.x		=	_items[0].x +_items[0].width / 2 - (_lblValue.width + _lblMax.width)/2;
			_lblValue.y		=	-_lblValue.height;
			
			_lblMax.x		=	_lblValue.x + _lblValue.width;
			_lblMax.y		=	-_lblMax.height;
		}
		
		private function updateLoadingIcon() : void
		{
			if( _emptySkin != null )
			{
				if( _loadingIcon )
				{
					removeChild( _loadingIcon );
					_loadingIcon = null;
				}
			}
			else
			{
				addChild( _loadingIcon );
			}
		}
	}
}