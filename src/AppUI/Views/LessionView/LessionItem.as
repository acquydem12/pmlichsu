package AppUI.Views.LessionView
{
	import AppUI.Views.LSLessionMenuView;
	
	import CFramework.CComponent.CLabel;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LessionItem extends Sprite
	{
		private var _lblIndex:CLabel;
		private var _lblText:CLabel;
		
		private var _color:int;
		private var _index:uint;
		private var _listener:ILessionListener;
		
		public function LessionItem( index:uint, indexStr:String, text:String, color:int, listener:ILessionListener )
		{
			super();
			
			this._listener	=	listener;
			this._index		=	index;
			this._color		=	color;
			
			_lblIndex	=	new CLabel;
			_lblIndex.size	=	35;
			_lblIndex.setSize( 45, 80 );
			_lblIndex.text	=	indexStr;
			_lblIndex.bold	=	true;
			_lblIndex.color	=	color;
			_lblIndex.align	=	AlignMode.CENTER;
			_lblIndex.buttonMode		=	true;
			addChild( _lblIndex );
			
			_lblText	=	new CLabel;
			_lblText.size	=	16;
			_lblText.setSize( 150, 150 );
			_lblText.bold	=	true;
			_lblText.color	=	color;
			_lblText.wrapWord	=	true;
			_lblText.text	=	text;
			_lblText.move( 50, 0 );
			_lblText.setFont( "Myriad Pro Cond", true );
			_lblText.buttonMode		=	true;
			addChild( _lblText );
			
			addEventListener( MouseEvent.CLICK, onClicked );
		}
		
		public function normalize():void
		{
			_lblIndex.color	=	_color;
			_lblText.color	=	_color;
		}
		
		public function highLight():void
		{
			_lblIndex.color	=	0x0;
			_lblText.color	=	0x0;
		}
		
		public function dispose():void
		{
			removeEventListener( MouseEvent.CLICK, onClicked );
		}
		
		protected function onClicked( event:MouseEvent ):void
		{
			if( _listener )
			{
				_listener.onClicked( _index );
				highLight();
			}
		}
	}
}