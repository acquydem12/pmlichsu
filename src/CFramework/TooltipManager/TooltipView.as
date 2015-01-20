package CFramework.TooltipManager
{
	import CFramework.CComponent.CLabel;
	import CFramework.core.CView;
	
	import Share.CShareMacros;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.elements.TextFlow;
	
	public class TooltipView extends CView
	{
		private static const STRING_BACKGROUND_COLOR : uint		=	0xfdffd8;
		private static const STRING_BORDER_COLOR : uint			=	0x00b0f6;
		private static const STRING_BACKGROUND_ALPHA : Number	=	1.0;
		
		private var _containerObject : Sprite;
		private var _imgPanel : Sprite;
		private var _lblStrContent : CLabel;
		
		public function TooltipView()
		{
			super();
			
			this.mouseEnabled	=	false;
			this.mouseChildren	=	false;
		}
		
		override public function onRegisterComplete():void
		{	
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_TOPMOST ) as DisplayObjectContainer;
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
			_containerObject	=	new Sprite();
			addChild( _containerObject );			
			_containerObject.addChild( _imgPanel );
			_containerObject.addChild( _lblStrContent );		
			_containerObject.mouseEnabled	=	false;
			_containerObject.mouseChildren	=	false;
			
			//
			_core.showView( CShareMacros.VIEW_TOOLTIP );
		}
		
		public function hideTooltip() : void
		{
			_containerObject.visible = false;
		}
		
		public function showTooltip() : void
		{
			_containerObject.visible = true;
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
			var appWidth : Number			=	Global.APP_WIDTH;
			var appHeight : Number			=	Global.APP_HEIGHT;
			
			var posX : Number	=	posX;
			var posY : Number	=	posY;
			
			if( posX + _imgPanel.width > appWidth )
				posX	=	appWidth - _imgPanel.width;
			
			if( posY + 20 + _imgPanel.height > appHeight )
				posY	=	appHeight - _imgPanel.height - 5;
			
			_containerObject.x	=	posX;
			_containerObject.y	=	posY;
		}
		
		private function paintStringBackground() : void
		{
			if( _lblStrContent.text == "" || _lblStrContent.text == null )
				return;
			
			var w : Number		=	_lblStrContent.textField.textWidth + 15;
			var h : Number		=	_lblStrContent.textField.textHeight + 6;
						
			var g : Graphics	=	_imgPanel.graphics;
			g.clear();
			
			g.lineStyle( 1.0, TooltipView.STRING_BORDER_COLOR );
			
			g.beginFill( TooltipView.STRING_BACKGROUND_COLOR, TooltipView.STRING_BACKGROUND_ALPHA );
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