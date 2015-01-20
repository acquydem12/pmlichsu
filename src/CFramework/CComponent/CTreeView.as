package CFramework.CComponent
{
	import GTweener.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CTreeView extends Sprite
	{
		private static const ON_EXPAND_LEVEL:String	=	"ON_EXPAND_LEVEL_";
		private static const ON_COLAPSE_LEVEL:String=	"ON_COLAPSE_LEVEL_";
		
		private var _level:uint		=	0;
		
		private var _align:Number	=	0;
		private var _nodeHeight:Number	=	0;
		private var _order:uint		=	0;
		
		private var _head:CTreeView	=	null;
		private var _pNode:CTreeView	=	null;
		private var _imgNode:DisplayObject	=	null;
		private var _view:ITreeNodeView	=	null;
		private var _isExpand:Boolean	=	false;
		
		private var _nodes:Vector.<CTreeView>	=	new Vector.<CTreeView>();
		private var _tail:CTreeView	=	null;
		
		public function CTreeView( align:Number, pNode:CTreeView = null, order:uint = 0, height:Number = 0 )
		{
			super();
			
			_align	=	align;
			_pNode	=	pNode;
			_nodeHeight	=	height;
			_order	=	order;
			_head	=	head;
			_tail	=	this;
			
			if( _pNode )
			{
				_head	=	_pNode.tail;
				_level	=	_pNode._level + 1;
				_pNode.addEventListener( ON_EXPAND_LEVEL, onExpand );
				_pNode.addEventListener( ON_COLAPSE_LEVEL, onColapse );
				_pNode.addNode( this );
				
				_head.addEventListener( ON_EXPAND_LEVEL, onExpand );
				_head.addEventListener( ON_COLAPSE_LEVEL, onColapse );
			}
			addEventListener( MouseEvent.CLICK, onMouseClick );
		}

		public function totalSize():Number
		{
			var size:Number	=	0;
			for( var i:uint = 0; i < _nodes.length; ++i )
				size	+=	_nodes[i].nodeHeight();
			
			if( _nodes.length <= 0 )
				size	=	_nodeHeight;
			
			return size;
		}
		
		public function get head():CTreeView
		{
			return _head;
		}

		public function get tail():CTreeView
		{
			return _tail;
		}

		public function addNode( node:CTreeView ):void
		{
			_tail	=	node;
			_nodes.push( node );
			addChild( node );
		}
		
		public function set view(value:ITreeNodeView):void
		{
			_view = value;
		}

		private function onMouseClick( e:MouseEvent ):void
		{
			if( !_isExpand )
			{
				_isExpand	=	true;
				// Expand or show view
				if( _view )
					_view.show();
				dispatchEvent( new Event( ON_EXPAND_LEVEL ));
			}
			else
			{
				_isExpand	=	false;
				// Colapse or hide view
				if( _view )
					_view.hide();
				dispatchEvent( new Event( ON_COLAPSE_LEVEL ));
			}
			e.stopImmediatePropagation();
		}
		
		private function onExpand( e:Event ):void
		{
			// Expand or show vie
			TweenLite.to( this, 0.5, { x:x+_align, y:y+_pNode.nodeHeight()+(_order*_nodeHeight), 
				onComplete:function(target:*):void
				{
					target.visible	=	true;
				}, onCompleteParams:[this] });
		}
		
		private function onColapse( e:Event ):void
		{
			// Colapse or hide view
			TweenLite.to( this, 0.5, { x:x-_align, y:y-_pNode.nodeHeight()-(_order*_nodeHeight), 
				onComplete:function(target:*):void
				{
					target.visible	=	false;
				}, onCompleteParams:[this] });
		}
		
		public function move( x:Number, y:Number ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		public function set imgNode(value:DisplayObject):void
		{
			_imgNode = value;
			addChild( _imgNode );
			if( !_nodeHeight && _imgNode )
				_nodeHeight	=	_imgNode.height;
		}

		public function nodeHeight():Number
		{
			return _nodeHeight;
		}

		public function get align():Number
		{
			return _align;
		}

		public function set align(value:Number):void
		{
			_align = value;
		}

		public function get level():uint
		{
			return _level;
		}
	}
}