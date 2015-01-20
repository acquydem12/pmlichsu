package CFramework.core
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class CResourceManager extends EventDispatcher
	{
		public static const LOADING_COMPLETED:String	=	"LOADING_COMPLETED";
		
		private var ldr:Loader; 
		public function CResourceManager(resources:String)
		{
			ldr = new Loader(); 
			var req:URLRequest = new URLRequest(resources);
			var ldrContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain); 
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler); 
			ldr.load(req, ldrContext);
		}
		
		private function completeHandler(event:Event):void 
		{ 
			trace( "Resource loading completed" );
			dispatchEvent( new Event( LOADING_COMPLETED ));
		} 
		
		public function getClass( className:String ):Class
		{
			var cls:Class	=	
				ApplicationDomain.currentDomain.getDefinition( className ) as Class;
			return cls;
		}
	}
}