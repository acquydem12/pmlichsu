package TooltipManager
{
	import CFramework.CComponent.CLabel;
	
	import CFramework.CRendererUltility.FilterEffect;
	
	import Share.CShareMacros;
	
	import CFramework.core.CView;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.elements.TextFlow;
	
	public class CTooltip extends CView
	{
		// View
		private static const STRING_BACKGROUND_COLOR : uint		=	0xfdffd8;
		private static const STRING_BORDER_COLOR : uint			=	0x00b0f6;
		private static const STRING_BACKGROUND_ALPHA : Number	=	1.0;
		
		private var _container : Sprite;
		private var _imgPanel : Sprite;
		private var _lblStrContent : CLabel;
		
		// Control
		private static const MAX_WAIT_TIME : Number	=	0.3;	// Seconds
		
		private var targetsList : Array				=	new Array();
		private var appRoot : DisplayObject; 		
		private var currentTarget : Object			=	null;
		private var waitTime : Number				=	0.0;
		private var showStringData : Object			=	{ updated : false };
		
		public function CTooltip()
		{
			super();
			
			this.mouseEnabled	=	false;
			this.mouseChildren	=	false;
		}
		
		override public function onRegisterCompleted():void
		{	
			var host : DisplayObjectContainer	=	_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_TOPMOST ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			//
			_imgPanel	=	new Sprite();
			_imgPanel.mouseEnabled	=	false;
			_imgPanel.mouseChildren	=	false;
			
			//
			_lblStrContent				=	new CLabel();
			_lblStrContent.size			=	13;
			_lblStrContent.x			=	5;
			_lblStrContent.y			=	0;
			_lblStrContent.height		=	1;
			_lblStrContent.width		=	1;
			_lblStrContent.color		=	0x9b6740;
			_lblStrContent.textField.multiline 	= 	true;
			_lblStrContent.mouseEnabled			=	false;
			_lblStrContent.mouseChildren		=	false;
			_lblStrContent.textField.autoSize 	= 	TextFieldAutoSize.LEFT;
			addChild( _lblStrContent );
			
			//
			_container	=	new Sprite();
			addChild( _container );			
			_container.addChild( _imgPanel );
			_container.addChild( _lblStrContent );		
			_container.mouseEnabled	=	false;
			_container.mouseChildren	=	false;
			
			//
			_core.showView( CShareMacros.VIEW_TOOLTIP );
			
			_core.runtimeUpdater.addFunction( onFrameUpdate, this );
		}

		// Controller
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
			hideTooltip();
		}
		
		public function hidetooltip():void
		{
			hideTooltip();
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
			waitTime	+=	deltaTime;
			if( waitTime >= MAX_WAIT_TIME )
			{
				if( currentTarget )
				{					
					showStringMessage( currentTarget["content"], currentTarget["type"] );
					reposition();
				}
				else if( showStringData["updated"] == false )
				{
					if( showStringData["type"] == "showString" )
					{
						showStringMessage( showStringData.content, "" );
						reposition();
					}
					else if( showStringData["type"] == "showStringAt" )
					{
						showStringMessage( showStringData.content, "" );
						setPosition( showStringData.screenX, showStringData.screenY );
					}
					
					//
					showStringData["updated"] = true;
				}
			}
		}
		
		// View
		public function hideTooltip() : void
		{
			_container.visible = false;
				
		}
		
		public function showTooltip() : void
		{
			_container.visible = true;
		}
		
		
		public function showStringMessage( content : String, type : String ) : void
		{
			if( type != "" )
			{
				_lblStrContent.setFont( type, true );
			}
			else 
				_lblStrContent.setFont_default();
			
			if(content != null)
			{	
				_lblStrContent.textField.htmlText		=	content;			
				paintStringBackground();	
				showTooltip();
			}
			
		}
		
		public function get panelHeight() : Number
		{
			return _imgPanel.height;			
		}
		
		public function get panelWidth() : Number
		{
			return _imgPanel.width;			
		}
		
		public function reposition() : void
		{			
			var appRoot : DisplayObject		=	_core.holder.releaseVariable( CShareMacros.VAR_APP_ROOT ) as DisplayObject;
			setPosition( appRoot.stage.mouseX, appRoot.stage.mouseY + 20 );
		}
		
		public function setPosition( posX : Number, posY : Number ) : void
		{
			var appRoot : DisplayObject		=	_core.holder.releaseVariable( CShareMacros.VAR_APP_ROOT ) as DisplayObject;
			var appWidth : Number			=	_core.holder.releaseVariable( CShareMacros.VAR_APP_WIDTH ) as Number;
			var appHeight : Number			=	_core.holder.releaseVariable( CShareMacros.VAR_APP_HEIGHT ) as Number;
			
			var posX : Number	=	posX;
			var posY : Number	=	posY;
			
			if( posX + _imgPanel.width > appWidth )
				posX	=	appWidth - _imgPanel.width;
			
			if( posY + 20 + _imgPanel.height > appHeight )
				posY	=	appHeight - _imgPanel.height - 5;
			
			_container.x	=	posX;
			_container.y	=	posY;
		}
		
		private function paintStringBackground() : void
		{
			if( _lblStrContent.text == "" || _lblStrContent.text == null )
				return;
			
			var w : Number		=	_lblStrContent.textField.textWidth + 15;
			var h : Number		=	_lblStrContent.textField.textHeight + 6;
						
			var g : Graphics	=	_imgPanel.graphics;
			g.clear();
			
			g.lineStyle( 1.0, CTooltip.STRING_BORDER_COLOR );
			
			g.beginFill( CTooltip.STRING_BACKGROUND_COLOR, CTooltip.STRING_BACKGROUND_ALPHA );
			g.drawRoundRect( 0, 0, w, h, 7, 7 );
			g.endFill();
			
			_imgPanel.mouseEnabled	=	false;
			_imgPanel.mouseChildren	=	false;
		}
		
		/**
		 * Draw custom background here
		 * 
		 */		
		private function paintCustomBackground() : void
		{
			
		}
	}
}