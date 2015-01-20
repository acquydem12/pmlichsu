package CFramework.CComponent
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CStaticImageButton extends Sprite
	{
		private var _img:CImage;
		private var _btn:CImageButton;
		
		private var _isShowImage:Boolean;
		
		public function CStaticImageButton()
		{
			super();
			
			_img	=	new CImage();
			_img.visible	=	false;
			addChild( _img );
			
			_btn	=	new CImageButton();
			addChild( _btn );
		}
		
		public function move( x:Number, y:Number ):void
		{
			this.x	=	x;
			this.y	=	y;
		}
		
		public function rePosition():void
		{
			_btn.move( 0, 0 );
			if( _img.source )
				_img.move( -_img.source.width/2, -_img.source.height/2 );
			else 
				_img.move( 0, 0 );
		}
		
		public function down():void
		{
			_btn.visible	=	false;
			_img.visible	=	true;
		}
		
		public function up():void
		{
			_btn.visible	=	true;
			_img.visible	=	false;
		}
		
		public function get button():CImageButton
		{
			return _btn;
		}
		
		public function get image():CImage
		{
			return _img;
		}
	}
}