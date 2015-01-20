package CFramework.CRendererUltility
{
	public class TextReduce
	{
		public function TextReduce()
		{
		}
		
		public static function reduce( text:String, MAXCHAR:Number ):String
		{
			if( text == null || text == "")
				return text;
			
			if( text.length <= MAXCHAR )
				return text;
			
			var localName:String=	"";
			var words:Array		=	text.split( " " );
			var needThreeDot:Boolean	=	false;
			if( words.length > 1 )
				needThreeDot	=	true;
			if( words.length > 0 ) 
			{
				var count:int		=	0;
				var firstWord:String	=	words[count];
				while( count < words.length && (localName.length + firstWord.length) < MAXCHAR )
				{
					localName		+=	firstWord + " ";
					count++;
					firstWord		=	words[count];
				}
				
				if( localName.length < MAXCHAR )
				{
					needThreeDot	=	true;
					for( var i:int = localName.length; i < MAXCHAR - 3; ++i )
					{
						localName	+=	text.charAt( i );
					}
				}
				
			}
			if( needThreeDot )
				localName	+=	"...";
			
			return localName;
		}
	}
}