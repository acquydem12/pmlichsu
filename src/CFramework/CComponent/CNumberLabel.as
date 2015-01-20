package CFramework.CComponent
{
	import flash.display.Bitmap;

	public class CNumberLabel extends CLabel
	{
		private var numbering:CImage;
		
		public function CNumberLabel( text:String="" )
		{
			super(text);
			
			numbering		=	new CImage();
			addChild( numbering );
		}
		
		public function image( bucket:String, className:String ):void
		{
			Global.CoreSNSFramework.resourceManager.getResourceFunc( bucket, className, onLoadingComplete );
		}
		
		protected function onLoadingComplete( bucket:String, className:String, clazz:Class ):void
		{
			numbering.source		=	new Bitmap( new clazz );
			numbering.move( -numbering.source.width, numbering.source.height );
		}
	}
}