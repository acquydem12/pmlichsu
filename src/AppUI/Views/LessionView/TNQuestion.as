package AppUI.Views.LessionView
{
	import CFramework.CComponent.CLabel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class TNQuestion extends Sprite
	{
		private var _selected:Vector.<Object>;
		
		private var _question:CLabel;
		
		private var _a:CLabel;
		private var _b:CLabel;
		private var _c:CLabel;
		private var _d:CLabel;
		
		private var _correct:uint;
		
		private var _index:uint;
		
		public function TNQuestion()
		{
			super();
			
			_question	=	new CLabel;
			_question.size	=	18;
			_question.setSize( 630, 100 );
			_question.color	=	0x0;
			_question.wrapWord	=	true;
			_question.bold		=	true;
			_question.setFont( "UVN Bach Dang", true );
			addChild( _question );
			
			_a	=	new CLabel;
			_a.size	=	16;
			_a.color	=	0x0;
			_a.setSize( 630, 30 );
			_a.wrapWord	=	true;
			_a.bold		=	true;
			_a.setFont( "UVN Bach Dang", true );
			addChild( _a );
			addEvent( _a, onAClicked );
			
			_b	=	new CLabel;
			_b.size	=	16;
			_b.color	=	0x0;
			_b.setSize( 630, 30 );
			_b.wrapWord	=	true;
			_b.bold		=	true;
			_b.setFont( "UVN Bach Dang", true );
			addChild( _b );
			addEvent( _b, onBClicked );
			
			_c	=	new CLabel;
			_c.size	=	16;
			_c.color	=	0x0;
			_c.setSize( 630, 30 );
			_c.wrapWord	=	true;
			_c.bold		=	true;
			_c.setFont( "UVN Bach Dang", true );
			addChild( _c );
			addEvent( _c, onCClicked );
			
			_d	=	new CLabel;
			_d.size	=	16;
			_d.color	=	0x0;
			_d.setSize( 630, 30 );
			_d.bold		=	true;
			_d.wrapWord	=	true;
			_d.setFont( "UVN Bach Dang", true );
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
			
			disable();
			
			var found:Boolean = false;
			for( var i:uint = 0; i < _selected.length; ++i )
			{
				if( _selected[i].index == _index )
					found = true;
					
			}
			if( !found )
				_selected.push( { index:_index, ans:index, correct:result } );
			
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
			changeColor( _a );
			onButtonClicked();
			removeEvent( _a, onAClicked );
			checkAnswer( _a, 1 );
			
			if( event )
				event.stopImmediatePropagation();
		}
		
		protected function onBClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( _b );
			onButtonClicked();
			removeEvent( _b, onBClicked );
			checkAnswer( _b, 2 );
			
			if( event )
				event.stopImmediatePropagation();
		}
		
		protected function onCClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( _c );
			onButtonClicked();
			removeEvent( _c, onCClicked );
			checkAnswer( _c, 3 );
			
			if( event )
				event.stopImmediatePropagation();
		}
		
		protected function onDClicked( event:MouseEvent ):void
		{
			resetColor();
			changeColor( _d );
			onButtonClicked();
			removeEvent( _d, onDClicked );
			checkAnswer( _d, 4 );
			
			if( event )
				event.stopImmediatePropagation();
		}
		
		public function parse( index:uint, data:Object ):void
		{
			resetColor();
			
			_index	=	index;
			var found:String	=	null;
			for( var str:String in _selected )
			{
				if( _selected[str].index == _index )
				{
					found	=	str;
					break;
				}
			}
			
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
			
			if( found )
			{
				autoSelect( found );
				disable();
			} else 
				enable();
			
			reposition();
		}
		
		protected function autoSelect( quest:String ):void
		{
			var i:uint	=	_selected[quest].ans;
			switch( i )
			{
				case 1:
					onAClicked( null );
					break;
				
				case 2:
					onBClicked( null );
					break;
				
				case 3:
					onCClicked( null );
					break;
				
				case 4:
					onDClicked( null );
					break;
			}
		}
		
		public function getScore():uint
		{
			var count:uint	=	0;
			for( var i:String in _selected )
			{
				if( _selected[i].correct )
					count++;
			}
			return count;
		}
		
		public function getMax():uint
		{
			return _selected.length;
		}
		
		public function clear():void
		{
			resetColor();
			
			_selected	=	new Vector.<Object>;
			enable();
		}
		
		protected function disable():void
		{
			removeEvent( _a, onAClicked );
			removeEvent( _b, onBClicked );
			removeEvent( _c, onCClicked );
			removeEvent( _d, onDClicked );
		}
		
		protected function enable():void
		{
			addEvent( _a, onAClicked );
			addEvent( _b, onBClicked );
			addEvent( _c, onCClicked );
			addEvent( _d, onDClicked );
		}
		
		protected function reposition():void
		{
			_a.move( _question.x, _question.y + _question.height - 10 );
			_b.move( _a.x, _a.y + _a.height + 10 );
			_c.move( _a.x, _b.y + _b.height + 10 );
			_d.move( _a.x, _c.y + _c.height + 10 );
		}
	}
}