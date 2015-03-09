package CFramework.CComponent
{	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class CLabel extends Sprite
	{
		private var _color : int			=	0x888888;
		private var _textSize : int			=	13;
		private var _textFont : String		=	"Times New Roman";
		private var _embedFont : Boolean	=	false;
		private var _bold : Boolean			=	false;
		private var _italic : Boolean		=	false;
		private var _underline : Boolean	=	false;
		private var _textAlign : String		=	TextFormatAlign.LEFT;
		private var _tf : TextField;
		private var _type : String			=	TextFieldType.DYNAMIC;
		private var _isAutosize:Boolean		=	false;
		
		public function CLabel( text : String = "" )
		{
			super();
			
			_tf	=	new TextField();
			
			this.mouseEnabled	=	true;
			this.mouseChildren 	= 	false;
			_tf.mouseEnabled	=	false;			
			_tf.text			=	text;
			
			setFont_default();
			_tf.autoSize		=	TextFieldAutoSize.LEFT;
			addChild( _tf );
		}
		
		public function move( x: Number, y:Number ) : void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		public function setFont_default() : void
		{
			_textFont	=	"Times New Roman";
			_embedFont	=	false;
			updateTextformat();
		}
		
		public function setFont_Tahoma() : void
		{
			_textFont	=	"Tahoma";
			_embedFont	=	false;
			updateTextformat();
		}
		
		public static function getFont( fontName:String, callBack:Function ):void
		{
//			Global.CoreGame.resourceManager.getResourceFunc( ShareConstant.SWF_CommonAsset, fontName, onLoaded );
//			function onLoaded( bucket:String, className:String, cls:Class ):void
//			{
//				Font.registerFont( cls );
//				var arr:Array	=	Font.enumerateFonts( true );
//				callBack();
//			}
		}
		
		public function setFont( value : String, embedFont : Boolean ) : void
		{
			_textFont	=	value;
			_embedFont	=	true;
			updateTextformat();
//			Global.CoreGame.resourceManager.getResourceFunc( ShareConstant.SWF_CommonAsset, value, onFontLoaded );
		}
		
		private function onFontLoaded( bucket:String, className:String, cls:Class ):void
		{
			Font.registerFont( cls );
			_textFont	=	className;
			_embedFont	=	true;
			updateTextformat();
		}
		
		public function getFont() : String
		{
			return _textFont;
		}
		
		public function set autoSize( size:String ):void
		{
			if (size == TextFieldAutoSize.NONE)
				_isAutosize = false;
			else
				_isAutosize = true;
			_tf.autoSize = size;
		}
		
		public function set type( val : String ):void
		{
			_type	=	val;
			updateTextformat();
		}
		
		public function set color( value : int ) : void
		{
			_color	=	value;
			updateTextformat();
		}
		
		public function set wrapWord( value:Boolean ):void
		{
			_tf.wordWrap=	value;
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
			
			if (_isAutosize)
			{
				this.width = _tf.width;
				this.height = _tf.height;
			}
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
			_tf.type					=	_type;
			_tf.defaultTextFormat		=	tFormat;
			_tf.setTextFormat( tFormat );
		}
		
		public static function DeclEmbedFont():void
		{
		}
		
		override public function set filters(value:Array):void
		{
			_tf.filters = value;
		}
	}
}
