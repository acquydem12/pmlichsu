package AppUI.Views.LessionView
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DemoTextEditor extends Sprite
	{
		[Embed(source="AS3TextEditorLite.swf")]
		private static const loadingIconClass:Class;
		
		private var _textField:TextField;
		
		public function DemoTextEditor()
		{
			var content:DisplayObject	=	new loadingIconClass();
			content.scaleX	=	0.97;
			content.x		=	200;
			content.y		=	233;
			addChild( content );
			
			_textField		=	new TextField;
			var format:TextFormat	=	new TextFormat("Arial");
			
			addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		public function getTextTyped():String
		{
			return _textField.text;
		}
		
		protected function onKeyUp( event:KeyboardEvent ):void
		{
			_textField.text	=	(event.target as TextField).text;
		}
	}
}