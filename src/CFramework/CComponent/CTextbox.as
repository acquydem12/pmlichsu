package CFramework.CComponent
{	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldType;

	public class CTextbox extends Sprite
	{
		private var _color : int			=	0x888888;
		private var _textSize : int			=	13;
		private var _textFont : String		=	(new Embedded_Font1).fontName;		
		private var _embedFont : Boolean	=	false;
		private var _bold : Boolean			=	false;
		private var _italic : Boolean		=	false;
		private var _underline : Boolean	=	false;
		private var _textAlign : String		=	TextFormatAlign.LEFT;
		private var _tf : TextField;
		
		public function CTextbox( text : String = "" )
		{
			super();
			
			_tf	=	new TextField();
			
			_tf.border 			= 	true;
			_tf.text			=	text;
			_tf.type			=	TextFieldType.INPUT;
			
			setFont_default();
			
			addChild( _tf );
		}
		
		public function set border( val : Boolean ) : void
		{
			_tf.border 			= 	val;
		}
		
		public function get border() : Boolean
		{
			return _tf.border;
		}
		
		public function move( x: Number, y:Number ) : void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		public function setFont_default() : void
		{
			_textFont	=	(new Embedded_Font1).fontName;
			_embedFont	=	false;			
			updateTextformat();
		}
		
		public function setFont_Tahoma() : void
		{
			_textFont	=	"Tahoma";
			_embedFont	=	true;
			updateTextformat();
		}
		
		public function setFont( value : String, embedFont : Boolean ) : void
		{
			_textFont	=	value;
			_embedFont	=	embedFont;
			updateTextformat();
		}
		
		public function getFont() : String
		{
			return _textFont;
		}
		
		public function set color( value : int ) : void
		{
			_color	=	value;
			updateTextformat();
		}
		
		public function set size( value : int ) : void
		{
			_textSize	=	value;
			updateTextformat();
		}
		
		public function set text( value : String ) : void
		{
			if( value == null )
				value = "";
			_tf.text	=	value;
		}
		
		public function get text() : String
		{
			return _tf.text;
		}
		
		public function set htmlText( value : String ) : void
		{
			_tf.htmlText	=	value;
		}
		
		public function get htmlText() : String
		{
			return _tf.htmlText;
		}

		/**
		* Align macros:
		*	TextFormatAlign.LEFT
		*	TextFormatAlign.RIGHT
		*	TextFormatAlign.CENTER
		*	TextFormatAlign.JUSTIFY
		*/
		public function set align( value : String ) : void
		{
			_textAlign	=	value;
			updateTextformat();
		}
		
		public function set bold( value : Boolean ) : void
		{
			_bold	=	value;
			updateTextformat();
		}
		
		public function set italic( value : Boolean ) : void
		{
			_italic	=	value;
			updateTextformat();
		}
		
		public function set underline( value : Boolean ) : void
		{
			_underline	=	value;
			updateTextformat();
		}
		
		public function get textField() : TextField
		{
			return _tf;
		}
		
		override public function set width( value : Number ) : void
		{
			_tf.autoSize	=	TextFieldAutoSize.NONE;
			_tf.width		=	value;
			super.width		=	value;
		}
		
		override public function set height( value : Number ) : void
		{
			_tf.autoSize	=	TextFieldAutoSize.NONE;
			_tf.height		=	value;
			super.height	=	value;
		}
		
		public function setSize(w:Number, h:Number):void
		{
			this.width	=	w;
			this.height	=	h;
		}
				
		/////////////////////////////////////////////
		
		private function updateTextformat() : void
		{
			var tFormat : TextFormat	=	new TextFormat( _textFont, _textSize, _color, _bold, _italic, _underline, "", "", _textAlign );
			_tf.embedFonts				=	_embedFont;
			_tf.antiAliasType			=	AntiAliasType.ADVANCED;
			_tf.gridFitType				=	GridFitType.SUBPIXEL;
			_tf.defaultTextFormat		=	tFormat;
			_tf.setTextFormat( tFormat );
		}
		
		public static function DeclEmbedFont()
		{
			Embedded_Font1;
		}
	}
}
