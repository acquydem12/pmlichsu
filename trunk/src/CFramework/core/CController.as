package CFramework.core
{
	public class CController
	{
		protected var _core:CCore;
		
		private var _viewLayer:CView;
		private var _modelLayer:CModel;
		
		public function CController()
		{
		}
		
		public function get modelLayer():CModel
		{
			return _modelLayer;
		}
		
		public function get viewLayer():CView
		{
			return _viewLayer;
		}
		
		public function onInitArchitecture( view:CView, model:CModel ):void
		{
			_modelLayer			=	model;
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