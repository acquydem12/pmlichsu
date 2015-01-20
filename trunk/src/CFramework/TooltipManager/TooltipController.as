package CFramework.TooltipManager
{
	import CFramework.core.CController;
	
	import Share.CShareMacros;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class TooltipController extends CController
	{
		private static const MAX_WAIT_TIME : Number	=	0.3;	// Seconds
		
		private var targetsList : Array				=	new Array();
		private var appRoot : DisplayObject; 		
		private var currentTarget : Object			=	null;
		private var waitTime : Number				=	0.0;
		private var showStringData : Object			=	{ updated : false };
		
		public function TooltipController()
		{
			super();
			
			Global.CTTController	=	this;
		}
		
		private function get cViewLayer() : TooltipView
		{
			return (viewLayer as TooltipView);
		}
		
		override public function onRegisterComplete():void
		{
			var appRoot : DisplayObject		=	
				_core.holder.releaseVariable( CShareMacros.VAR_APP_ROOT ) as DisplayObject;
			appRoot.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			_core.runtimeUpdater.addFunction( onFrameUpdate, this );
		}
		
		public function addTooltip(target:DisplayObject, content:*, type:String=""):void
		{
			if( target == null )
				return;
			
			var tarObj : Object		=	new Object();
			tarObj["disObject"]		=	target;
			tarObj["content"]		=	content;
			tarObj["type"]			=	type;
			
			target.addEventListener( MouseEvent.ROLL_OVER, onMouseOverObject );
			target.addEventListener( MouseEvent.ROLL_OUT, onMouseOutObject );
			
			// Try to delete from current list if exist
			removeTooltip( target );
			
			// Add to list
			targetsList.push( tarObj );
		}		
		
		public function removeTooltip(target:DisplayObject):void
		{
			for( var index : String in targetsList )
			{
				if( targetsList[index].disObject == target )
				{
					targetsList.splice( index, 1 );
					break;
				}
			}
		}
		
		public function removeAll() : void
		{
			for each( var tarObj : Object in targetsList )
			{
				var disObj : DisplayObject	=	tarObj.type;
				if( disObj )
				{
					disObj.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseOverObject );
					disObj.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOutObject );
				}
			}
			
			targetsList	=	new Array();
		}
		
		public function showString( content : String ) : void
		{
			showStringData["content"]	=	content;
			showStringData["type"]		=	"showString";
			showStringData["updated"]	=	false;
			
			waitTime	=	0;
		}
		
		public function showStringAt( content : String, screenX : Number, screenY : Number ) : void
		{
			showStringData["content"]	=	content;
			showStringData["screenX"]	=	screenX;	
			showStringData["screenY"]	=	screenY;
			showStringData["type"]		=	"showStringAt";
			showStringData["updated"]	=	false;			
			
			waitTime	=	0;
		}
		
		/////////////////////////////////////////////////////////////
		
		private function onMouseMove( event : MouseEvent ) : void
		{			
			// This line not nescessory call
			// coreSNSFramework.hideView( ShareMacros.MODULE_TOOLTIP );
						
			cViewLayer.hideTooltip();
		}
		public function hidetooltip():void
		{
			cViewLayer.hideTooltip();
		}
		private function onMouseOverObject( event : MouseEvent ) : void
		{
			var target : DisplayObject	=	event.currentTarget as DisplayObject;
			for each( var tarObj : Object in targetsList )
			{
				if( tarObj.disObject == target )
				{
					showTooltip( tarObj );
					break;
				}
			}				
		}	
		
		private function onMouseOutObject( event : MouseEvent ) : void
		{
			currentTarget	=	null;
		}
		
		private function showTooltip( objData : Object ) : void
		{
			if( objData.disObject )
			{				
				currentTarget	=	objData;
				waitTime		=	0.0;
			}
		}
		
		private function onFrameUpdate( deltaTime : Number, totalTime : Number ) : void
		{
			waitTime	+=	0.05;
			if( waitTime >= MAX_WAIT_TIME )
			{
				if( currentTarget )
				{					
					cViewLayer.showStringMessage( currentTarget["content"], currentTarget["type"] );
					cViewLayer.reposition();
				}
				else if( showStringData["updated"] == false )
				{
					if( showStringData["type"] == "showString" )
					{
						cViewLayer.showStringMessage( showStringData.content, "" );
						cViewLayer.reposition();
					}
					else if( showStringData["type"] == "showStringAt" )
					{
						cViewLayer.showStringMessage( showStringData.content, "" );
						cViewLayer.setPosition( showStringData.screenX, showStringData.screenY );
					}
					
					//
					showStringData["updated"] = true;
				}
			}
		}
	}
}