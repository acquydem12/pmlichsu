package AppUI.Views.LessionView
{
	import AppUI.Views.LSLessionMenuView;
	
	import CFramework.CComponent.CLabel;
	
	import Share.CShareMacros;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LessionItem extends Sprite
	{
		private var _lblIndex:CLabel;
		private var _lblText:CLabel;
		
		private var _color:int;
		private var _index:uint;
		private var _listener:ILessionListener;
		
		public function LessionItem( index:uint, text:String, color:int, listener:ILessionListener )
		{
			super();
			
			this._listener	=	listener;
			this._index		=	index;
			this._color		=	color;
			
			_lblIndex	=	new CLabel;
			_lblIndex.size	=	100;
			_lblIndex.setSize( 165, 150 );
			_lblIndex.text	=	String( _index );
			_lblIndex.bold	=	true;
			_lblIndex.color	=	color;
			_lblIndex.buttonMode		=	true;
			addChild( _lblIndex );
				
			_lblText	=	new CLabel;
			_lblText.size	=	18;
			_lblText.setSize( 200, 300 );
			_lblText.bold	=	true;
			_lblText.color	=	color;
			_lblText.wrapWord		=	true;
			_lblText.text	=	text;
			_lblText.move( 60, 30 );
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
		
		protected function onClicked( event:MouseEvent ):void
		{
			if( _listener )
			{
				_listener.onClicked( _index );
				highLight();
				
				Global.CoreGame.showView( CShareMacros.LS_LESSION_DETAIL );
				( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DETAIL ) as LSLessionMenuView ).parse( _index );
				( Global.CoreGame.holder.getView( CShareMacros.LS_LESSION_DETAIL ) as LSLessionMenuView ).moveIn( true, 
					function():void
					{
						Global.CoreGame.hideView( CShareMacros.LS_LESSIONS );
					});
			}
		}
	}
}