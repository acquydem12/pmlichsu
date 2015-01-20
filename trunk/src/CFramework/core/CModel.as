package CFramework.core
{
	public class CModel
	{
		private var _core:CCore;
		
		private var _viewLayer:CView;
		private var _controllerLayer:CController;
		
		public function CModel()
		{
		}
		
		public function get controllerLayer():CController
		{
			return _controllerLayer;
		}
		
		public function get viewLayer():CView
		{
			return _viewLayer;
		}
		
		public function onInitArchitecture( view:CView, controller:CController ):void
		{
			_controllerLayer	=	controller;
			_viewLayer			=	view;
		}
		
		public function set core(value:CCore):void
		{
			_core = value;
		}
		
		public function onRegisterComplete():void
		{
			
		}
	}
}