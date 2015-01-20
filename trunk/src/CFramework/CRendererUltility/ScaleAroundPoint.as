package CFramework.CRendererUltility
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ScaleAroundPoint
	{
		public function ScaleAroundPoint()
		{
		}
		
		public static function scaleAroundPoint(objToScale:DisplayObject, regX:int, regY:int, scaleX:Number, scaleY:Number):void{
			if (!objToScale){
				return;
			}
			var matrix:Matrix	=	new Matrix();
			matrix.identity();
			matrix.translate(-regX,-regY);
			matrix.scale( scaleX, scaleY );
			matrix.translate(regX,regY);
			objToScale.transform.matrix	=	matrix;
		}
	}
}