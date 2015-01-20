package CFramework.CRendererUltility
{
	import GTweener.TimelineLite;
	import GTweener.TweenLite;
	import GTweener.easing.Linear;
	
	import CFramework.CComponent.CLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	public class TextFlashObject
	{
		private var _host : DisplayObjectContainer;
		private var _posX : Number;
		private var _posY : Number;
		private var _container : Sprite			=	null;
		private var _lblMessage : CLabel		=	null;		
		private static var DeltaX : Number	=	20.0;
		private static var DeltaY : Number	=	5.0;
		
		public function TextFlashObject( host : DisplayObjectContainer, posX : Number, posY : Number, text : String, color : uint, fontSize : Number, filter : Array )
		{
			_host		=	host;
			_posX		=	posX;
			_posY		=	posY;			
			
			///////////////////
			if( text )
			{				
				_lblMessage	=	new CLabel();
				_lblMessage.textField.selectable		=	false;
				_lblMessage.color		=	color;
				_lblMessage.size		= fontSize;
				_lblMessage.mouseEnabled	=	false;
				_lblMessage.tabEnabled		=	false;
				_lblMessage.filters			=	filter;
				_lblMessage.textField.autoSize		=	TextFieldAutoSize.RIGHT;
				
				
				_lblMessage.text			=	text;
				
				_container		=	new Sprite();
				_lblMessage.x	=	- _lblMessage.width * 0.5;
				_container.addChild( _lblMessage );
			}
		}
		
		public function applyAnimationEffect() : void
		{
			if( _lblMessage )
			{
				_host.addChild( _container );
				
				_container.x		=	_posX;
				_container.y		=	_posY;
				
				_container.scaleX	=	2.5;
				_container.scaleY	=	2.5;
								
				var _timeLine : TimelineLite = new TimelineLite( { onComplete : removeLabel});
				_timeLine.append( TweenLite.to( _container, 0.3, { scaleX : 1, scaleY : 1, ease : Linear.easeNone } ) );
				_timeLine.append( TweenLite.to( _container, 0.7, { alpha : 0.1, y : _container.y - 80, ease : Linear.easeNone } ) );
			}
		}
		

		
		private function removeLabel() : void
		{
			try
			{
				_host.removeChild( _container );
				_container.removeChild( _lblMessage );
				_host	=	null;
			}
			catch( ex : * )
			{}
			
			_container	=	null;
			_lblMessage	=	null;
		}
	}
}