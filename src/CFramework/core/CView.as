package CFramework.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class CView extends Sprite
	{
		protected var _core:CCore;
		
		protected var _container:DisplayObjectContainer;
		
		private var _modelLayer:CModel;
		private var _controllerLayer:CController;
		
		public function CView()
		{
			super();
		}
		
		public function get controllerLayer():CController
		{
			return _controllerLayer;
		}

		public function get modelLayer():CModel
		{
			return _modelLayer;
		}

		public function onInitArchitecture( model:CModel, controller:CController ):void
		{
			_controllerLayer	=	controller;
			_modelLayer			=	model;
		}
		
		public function get parentContainer():DisplayObjectContainer
		{
			return _container;
		}

		public function set parentContainer(value:DisplayObjectContainer):void
		{
			_container = value;
		}

		public function set core(value:CCore):void
		{
			_core = value;
		}
		
		public function onRegisterComplete():void
		{
			
		}
		
		public function onShow():void
		{
			
		}
		
		public function onHide():void
		{
			
		}
	}
}