package CFramework.CRendererUltility
{
	import flash.display.DisplayObject;

	public class ScreenAlignment
	{
		public static var screenWidth : int		=	ShareConstant.APP_SCREEN_WIDTH;
		public static var screenHeight : int	=	ShareConstant.APP_SCREEN_HEIGHT;
		
		public static var formViewWidth : int	=	ShareConstant.APP_FORMVIEW_WIDTH;
		public static var formViewHeight : int	=	ShareConstant.APP_FORMVIEW_HEIGHT;
		
		/**
		 * 
		 * @param obj
		 * 
		 */		
		public static function centerScreen( obj : DisplayObject, mWidth : int = 0, mHeight : int = 0 ) : void
		{
			var localHeight : int = mHeight == 0 ? obj.height: mHeight;
			var localWidth : int  = mWidth == 0 ? obj.width: mWidth;
			obj.x	=	(screenWidth - localWidth) / 2;
			obj.y	=	(screenHeight - localHeight) / 2;
		}
		
		/**
		 * 
		 * @param obj
		 * 
		 */		
		public static function centerFormView( obj : DisplayObject ) : void
		{
			var offX : int	=	(formViewWidth - obj.width) / 2;
			var offY : int	=	(formViewHeight - obj.height) / 2;
			
			obj.x	=	offX;
			obj.y	=	offY;
		}
	}
}