package AppUI.Views.MenuItem
{
	import AppUI.Views.LSLessionMenuView;
	
	import flash.events.MouseEvent;

	public class LMenuItem extends MenuItem
	{
		protected var _view:LSLessionMenuView;
		protected var _index:uint;
		
		public function LMenuItem( view:LSLessionMenuView, text:String, index:uint )
		{
			super(text);
			
			_view	=	view;
			_index	=	index;
		}
		
		public function forceClicked():void
		{
			onClicked( null );
		}
		
		public override function onClicked( event:MouseEvent ):void
		{
			_view.onClicked( _index );
		}
	}
}