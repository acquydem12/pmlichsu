package CFramework.core
{
	public class CRuntimeUpdater
	{
		private var rtObjectList : Array	=	new Array();
		
		public function onFrameUpdate( deltaTime : Number, totalTime : Number ) : void
		{
			for( var index:String in rtObjectList )
			{
				if( rtObjectList[index].type == "Object" )
				{
					var rtPbj : Object	=	rtObjectList[index].target as Object;
					rtPbj.onFrameUpdate( deltaTime, totalTime );
				}
				else if( rtObjectList[index].type == "Function" )
				{
					var rtFunc : Function	=	rtObjectList[index].target as Function;
					rtFunc.call( rtObjectList[index].thisObj, deltaTime, totalTime );
				}
			}
		}
		
		/**
		 * 
		 * @param obj
		 * 
		 */		
		public function addObject( obj : Object ) : void
		{
			if( obj )
			{
				var param : Object	=	new Object();
				param.type			=	"Object";
				param.target		=	obj;
				
				//rtObjectList.push( param );
				
				var has : Boolean	=	false;
				for( var exist:String in rtObjectList )
				{
					if( rtObjectList[exist].target == obj )
					{
						has	=	true;
						break;
					}
				}
				
				if( ! has )
					rtObjectList.push( param );
			}
		}
		
		/**
		 * 
		 * @param obj
		 * 
		 */		
		public function removeObject( obj : Object ) : void
		{
			if( obj )
			{
				for( var i:int=0; i<rtObjectList.length; i++ )
				{
					var param : Object	=	rtObjectList[i];
					if( param.type == "Object" && param.target == obj )
						rtObjectList.splice( i, 1 );
				}				
			}
		}
		
		/**
		 * 
		 * @param func
		 * 
		 */		
		public function addFunction( func : Function, thisObj : * = null ) : void
		{
			if( func != null )
			{
				var param : Object	=	new Object();
				param.type			=	"Function";
				param.target		=	func;
				param.thisObj		=	thisObj;
				
				var has : Boolean	=	false;				
				for( var exist:String in rtObjectList )
				{
					if( rtObjectList[exist].target == func && rtObjectList[exist].thisObj == thisObj )
					{
						has	=	true;
						break;
					}
				}
				
				if( ! has )
					rtObjectList.push( param );
			}
		}
		
		/**
		 * 
		 * @param obj
		 * 
		 */		
		public function removeFunction( func : Function, thisObj : * = null ) : void
		{
			if( func != null )
			{
				for( var i:int=0; i<rtObjectList.length; i++ )
				{
					var param : Object	=	rtObjectList[i];
					if( param.type == "Function" && param.target == func && param.thisObj == thisObj )
						rtObjectList.splice( i, 1 );
				}				
			}
		}
		
		public function cleanAll():void
		{
			rtObjectList.splice(0);
		}
		
		public function getTotalNode() : int
		{
			return rtObjectList.length;
		}
	}
}