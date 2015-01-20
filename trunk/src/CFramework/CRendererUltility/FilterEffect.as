package CFramework.CRendererUltility
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class FilterEffect
	{
		static public function createGlowFilter( color : int = 0, alpha : Number = 1.0, blurX : int = 6.0, blurY : int = 6.0, strengh : int = 2 ) : Array
		{
			return [new GlowFilter( color, alpha, blurX, blurY, strengh )];
		}
		
		static public function createGhostFormFilter( color : int, alpha : Number = 1.0 ) : Array
		{
			var R : Number	=	Number((color & 0xff0000)) / Number(0xff0000);
			var G : Number	=	Number((color & 0x00ff00)) / Number(0x00ff00);
			var B : Number	=	Number((color & 0x0000ff)) / Number(0x0000ff);
			var matrix:Array = new Array();
			matrix = matrix.concat([R, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, G, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, B, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, alpha, 0]); // alpha

			return [new ColorMatrixFilter(matrix)];
		}
		
		static public function createBlinkingEffect(color:int, alpha:Number = 1, blur:int = 25):Array
		{
			var glow:GlowFilter = 	new GlowFilter();
			glow.color 			= 	color;
			glow.alpha 			= 	alpha;
			glow.blurX 			=	blur;
			glow.blurY 			= 	blur;
			glow.quality = BitmapFilterQuality.MEDIUM;
			return [glow];
		}
			
		
		static public function createDarkFilter( color : uint = 0x224422 ) : Array
		{
			var R : Number	=	Number((color & 0xff0000)) / Number(0xff0000);
			var G : Number	=	Number((color & 0x00ff00)) / Number(0x00ff00);
			var B : Number	=	Number((color & 0x0000ff)) / Number(0x0000ff);
			var matrix:Array = new Array();
			matrix = matrix.concat([R, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, G, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, B, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

			return [new ColorMatrixFilter(matrix)];
		}
		
		static public function createBackWhiteImage( r_lum : Number = 0.3333, g_lum : Number = 0.3333, b_lum : Number = 0.3333 ) : Array
		{			
//			var r_lum:Number = 0.212671;
//			var g_lum:Number = 0.715160; 
//			var b_lum:Number = 0.072169;
//			var r_lum:Number = 0.15;
//			var g_lum:Number = 0.5; 
//			var b_lum:Number = 0.05;
//			var r_lum:Number = 0.5;
//			var g_lum:Number = 0.5; 
//			var b_lum:Number = 0.2;
			//
			var matrix:Array = new Array ();
			matrix = matrix.concat ([r_lum, g_lum, b_lum, 0, 0]);
			matrix = matrix.concat ([r_lum, g_lum, b_lum, 0, 0]);
			matrix = matrix.concat ([r_lum, g_lum, b_lum, 0, 0]);
			matrix = matrix.concat ([0, 0, 0, 1, 0]);
			//
			return [new ColorMatrixFilter(matrix)];
		}
		static public function createNormalImage(  ) : Array
		{			
			var matrix:Array = new Array ();
			matrix = matrix.concat ([1, 0, 0, 0, 0]);
			matrix = matrix.concat ([0, 1, 0, 0, 0]);
			matrix = matrix.concat ([0, 0, 1, 0, 0]);
			matrix = matrix.concat ([0, 0, 0, 1, 0]);
			//
			return [new ColorMatrixFilter(matrix)];
		}
		
		static public function createStrokeFilter(color : int = 0, blurX : int = 4.0, blurY : int = 4.0, strength : Number = 10):Array
		{
			return [new GlowFilter( color, 1.0, blurX, blurY, strength )];
		}
	}
}