package CFramework.CRendererUltility
{
	public class ScalingObject
	{
		public function ScalingObject()
		{
		}
		
		public static function scaleFromCenter(dis:*, sX:Number, sY:Number):void
		{
			var prevW:Number = dis.width;
			var prevH:Number = dis.height;
			dis.scaleX = sX;
			dis.scaleY = sY;
			dis.x += (prevW - dis.width) / 2;
			dis.y += (prevH - dis.height) / 2;
		}
		
	}
}