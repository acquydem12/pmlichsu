package CFramework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class CCore extends EventDispatcher
	{
		private var _resourceManager:CResourceManager;
		private var _holder:CHolder;
		private var _runtimeUpdater:CRuntimeUpdater;
		private var _timer:CTimer;
		
		private var _hostObject:DisplayObject;
		
		public function CCore(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function setHost( host:DisplayObject ):void
		{
			_hostObject	=	host;
		}
		
		public function onInit( host:DisplayObject, data:Object, resources:String ):void
		{
			_holder				=	new CHolder;
			
			_runtimeUpdater		=	new CRuntimeUpdater;
			
			_timer				=	new CTimer();
			_timer.initTimer();
			
			_hostObject			=	host;
			if( _hostObject )
				_hostObject.stage.addEventListener( Event.ENTER_FRAME, onUpdateFrame );
			
			_resourceManager	=	new CResourceManager(resources);
		}
		
		public function start(callback:Function):void
		{
			_resourceManager.addEventListener( CResourceManager.LOADING_COMPLETED, onResultLoadResource );
			
			function onResultLoadResource( event:Event ):void
			{
				_resourceManager.removeEventListener( 
					CResourceManager.LOADING_COMPLETED, onLoadingComplete );
				
				callback( event );
			}
		}
		
		private function onUpdateFrame( event : Event ) : void
		{
			if( _timer )
				_timer.updateTimer();
			
			if( runtimeUpdater )
				runtimeUpdater.onFrameUpdate( _timer.deltaTime, _timer.totalTime );
		}
		
		public function register(identity:String, view:CView = null, model:CModel = null, controller:CController = null):void
		{	
			if( view )
				view.core	=	this;
			if( model )
				model.core	=	this;
			if( controller )
				controller.core = this;
			
			_holder.add(identity, view, model, controller);
		}

		public function showView(identity:String):void
		{
			var view:CView = _holder.getView(identity);
			var pContainer:DisplayObjectContainer = view.parentContainer;
			if( pContainer )
			{
				view.parentContainer.addChild(view);
				view.onShow();
			}
		}
		
		public function hideView(identity:String):void
		{
			var view:CView = _holder.getView(identity);
			var pContainer:DisplayObjectContainer = view.parentContainer;
			if( pContainer )
			{
				view.parentContainer.removeChild(view);
				view.onHide();
			}
		}
		
		public function hideAllView(identity:String):void
		{
			var allView:Vector.<CView> = _holder.getAllView();
			for( var i:uint = 0; i < allView.length; ++i )
			{
				var view:CView = allView[i];
				var pContainer:DisplayObjectContainer = view.parentContainer;
				if( pContainer )
				{
					view.parentContainer.removeChild(view);
					view.onHide();
				}
			}
		}
		
		public function get resourceManager():CResourceManager
		{
			return _resourceManager;
		}
		
		public function get holder():CHolder
		{
			return _holder;
		}
		
		public function get runtimeUpdater():CRuntimeUpdater
		{
			return _runtimeUpdater;
		}

		private function onLoadingComplete( event:Event ):void
		{
		}
	}
}