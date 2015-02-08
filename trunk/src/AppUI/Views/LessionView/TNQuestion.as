package AppUI.Views.LessionView
{
	import CFramework.CComponent.CLabel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class TNQuestion extends Sprite
	{
		private var _question:CLabel;
		
		private var _a:CLabel;
		private var _b:CLabel;
		private var _c:CLabel;
		private var _d:CLabel;
		
		private var _correct:uint;
		
		public function TNQuestion()
		{
			super();
			
			_question	=	new CLabel;
			_question.size	=	18;
			_question.setSize( 630, 100 );
//			_question.move( 150, 430 );
			_question.color	=	0x0;
			_question.wrapWord	=	true;
			addChild( _question );
			
			_a	=	new CLabel;
			_a.size	=	18;
			_a.color	=	0x0;
			_a.wrapWord	=	true;
			addChild( _a );
			addEvent( _a, onAClicked );
			
			_b	=	new CLabel;
			_b.size	=	18;
			_b.color	=	0x0;
			_b.wrapWord	=	true;
			addChild( _b );
			addEvent( _b, onBClicked );
			
			_c	=	new CLabel;
			_c.size	=	18;
			_c.color	=	0x0;
			_c.wrapWord	=	true;
			addChild( _c );
			addEvent( _c, onCClicked );
			
			_d	=	new CLabel;
			_d.size	=	18;
			_d.color	=	0x0;
			_d.wrapWord	=	true;
			addChild( _d );
			addEvent( _d, onDClicked );
		}
		
		protected function removeEvent( label:CLabel, clickFunc:Function ):void
		{
			label.removeEventListener( MouseEvent.CLICK, clickFunc );
			label.removeEventListener( MouseEvent.ROLL_OVER, onAnswerHandler );
			label.removeEventListener( MouseEvent.ROLL_OUT, onAnswerHandler );
		}
		
		protected function addEvent( label:CLabel, clickFunc:Function ):void
		{
			label.addEventListener( MouseEvent.CLICK, clickFunc );
			label.addEventListener( MouseEvent.ROLL_OVER, onAnswerHandler );
			label.addEventListener( MouseEvent.ROLL_OUT, onAnswerHandler );
		}
		
		protected function onAnswerHandler( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.ROLL_OVER:
					( event.currentTarget as CLabel ).color	=	0xffff00;
					break;
				
				case MouseEvent.ROLL_OUT:
					( event.currentTarget as CLabel ).color	=	0x0;
					break;
			}
		}
		
		protected function resetColor():void
		{
			_a.color	=	0x0;
			_b.color	=	0x0;
			_c.color	=	0x0;
			_d.color	=	0x0;
		}
		
		protected function changeColor( answer:CLabel ):void
		{
			answer.color	=	0xffff00;
		}
		
		protected function checkAnswer( label:CLabel, index:uint ):Boolean
		{
			var result:Boolean	=	false;
			if( index == 1 && _correct == 1 )
			{
				result	=	true;
			} else if( index == 2 && _correct == 2 )
			{
				result	=	true;
			} else if( index == 3 && _correct == 3 ) 
			{
				result	=	true;
			} else if( index == 4 && _correct == 4 )
			{
				result	=	true;
			} else 
				result	=	false;
			
			if( result )
				label.color	=	0x00ff00;
			else label.color	=	0xff0000;
			
			return result;
		}
		
		protected function onButtonClicked():void
		{
			addEvent( _a, onAClicked );
			addEvent( _b, onBClicked );
			addEvent( _c, onCClicked );
			addEvent( _d, onDClicked );
		}
		
		protected function onAClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( event.currentTarget as CLabel );
			onButtonClicked();
			removeEvent( _a, onAClicked );
			checkAnswer( _a, 1 );
			
			event.stopImmediatePropagation();
		}
		
		protected function onBClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( event.currentTarget as CLabel );
			onButtonClicked();
			removeEvent( _b, onBClicked );
			checkAnswer( _b, 2 );
			
			event.stopImmediatePropagation();
		}
		
		protected function onCClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( event.currentTarget as CLabel );
			onButtonClicked();
			removeEvent( _c, onCClicked );
			checkAnswer( _c, 3 );
			
			event.stopImmediatePropagation();
		}
		
		protected function onDClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( event.currentTarget as CLabel );
			onButtonClicked();
			removeEvent( _d, onDClicked );
			checkAnswer( _d, 4 );
			
			event.stopImmediatePropagation();
		}
		
		public function parse( data:Object ):void
		{
			_question.text	=	data.q;
			_a.text			=	"A:" + data.a;
			_b.text			=	"B:" + data.b;
			_c.text			=	"C:" + data.c;
			_d.text			=	"D:" + data.d;
			
			_a.autoSize		=	TextFieldAutoSize.LEFT;
			_b.autoSize		=	TextFieldAutoSize.LEFT;
			_c.autoSize		=	TextFieldAutoSize.LEFT;
			_d.autoSize		=	TextFieldAutoSize.LEFT;
			
			_correct		=	data.correct;
			
			reposition();
		}
		
		protected function reposition():void
		{
			_a.move( _question.x, _question.y + _question.height );
			_b.move( _a.x, _a.y + _a.height + 10 );
			_c.move( _a.x, _b.y + _b.height + 10 );
			_d.move( _a.x, _c.y + _c.height + 10 );
		}
	}
}