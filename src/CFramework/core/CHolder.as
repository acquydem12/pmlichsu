package CFramework.core
{
	public class CHolder
	{
		private var _bankView:Object	=	new Object;
		private var _bankModel:Object	=	new Object;
		private var _bankController:Object	=	new Object;
		
		private var _holder:Object		=	new Object;
		
		public function CHolder()
		{
		}
		
		public function holdVariable(identity:String, value:*):void
		{
			_holder[identity]	=	value;
		}
		
		public function releaseVariable(identity:String):*
		{
			if( _holder.hasOwnProperty( identity ))
				return _holder[identity];
			return null;
		}
		
		public function add(identity:String, view:CView = null, model:CModel = null, controller:CController = null):void
		{
			if( view )
			{
				view.onInitArchitecture( model, controller );
				_bankView[identity]		=	view;
				view.onRegisterComplete();
			}
			if( model )
			{
				model.onInitArchitecture( view, controller );
				_bankModel[identity]	=	model;
				model.onRegisterComplete();
			}
			if( controller )
			{
				controller.onInitArchitecture( view, model );
				_bankController[identity]	=	controller;
				controller.onRegisterComplete();
			}
		}
		
		public function remove(identity:String):void
		{
			if( _bankView.hasOwnProperty( identity ))
				delete _bankView[identity];
			
			if( _bankModel.hasOwnProperty( identity ))
				delete _bankModel[identity];
			
			if( _bankController.hasOwnProperty( identity ))
				delete _bankController[identity];
		}
		
		public function getAllView():Vector.<CView>
		{
			var vector:Vector.<CView> = new Vector.<CView>();
			for( var str:String in _bankView )
			{
				vector.push( _bankView[str] );
			}
			return vector;
		}
		
		public function getController(identity:String):CController
		{
			if( _bankController.hasOwnProperty(identity))
				return _bankController[identity];
			return null;
		}
		
		public function getModel(identity:String):CModel
		{
			if( _bankModel.hasOwnProperty(identity))
				return _bankModel[identity];
			return null;
		}
		
		public function getView(identity:String):CView
		{
			if(_bankView.hasOwnProperty(identity))
				return _bankView[identity];
			return null;
		}
	}
}