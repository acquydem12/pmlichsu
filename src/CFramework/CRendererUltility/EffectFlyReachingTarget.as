package CFramework.CRendererUltility
{
	import GTweener.TweenLite;
	import GTweener.easing.Circ;
	import GTweener.plugins.BezierPlugin;
	import GTweener.plugins.TweenPlugin;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import org.aswing.AbstractButton;

	public class EffectFlyReachingTarget
	{
		private static var _singleton:EffectFlyReachingTarget = new EffectFlyReachingTarget;
		
		public static function get singleton():EffectFlyReachingTarget
		{
			return _singleton;
		}
		
		public function applyCurvesFly( obj:DisplayObject, target:Point, 
											  onCompleteFunc:Function = null, params:Array = null ):void
		{
			TweenPlugin.activate([BezierPlugin]);
			TweenLite.to( obj, 1, { bezier:[
				{ x:obj.x, y:obj.y }, 
				{ x:obj.x * 1/4, y:obj.y * 3/2 },
				{ x:target.x, y:target.y}],
				onComplete:onCompleteFunc, 
				onCompleteParams:params });
		}
		
		private function applyJump( obj:DisplayObject, high:Number, distance:Number ):void
		{
			TweenPlugin.activate([BezierPlugin]);
			TweenLite.to( obj, 1, { bezier:[
				{ x:obj.x, y:obj.y }, 
				{ x:(obj.x + distance/2), y:(obj.y - high/2) },
				{ x:(obj.x + distance), y:(obj.y + high) } ] 
			});
		}
		
		public function applyJumpFly( obj:DisplayObject, target:Point, 
									 onCompleteFunc:Function = null, params:Array = null ):void
		{
			var dx:Number	=	target.x - obj.x;
			var dy:Number	=	target.y - obj.y;
			for( var i:uint = 0; i < 5; ++i )
			{
				if( i + 1 <= 5 )
				{
					TweenPlugin.activate([BezierPlugin]);
					TweenLite.to( obj, 1, { bezier:[
						{ x:obj.x, y:obj.y }, 
						{ x:(obj.x + dx/10), y:(obj.y - 50) },
						{ x:(obj.x + dx/2), y:(obj.y + 100) } ],
						onComplete:onCompleteFunc, 
						onCompleteParams:params
					});
				}
				else 
					applyJump( obj, 100, dx/5 );
			}
		}
		
		public function applySinFly( obj:DisplayObject, target:Point, 
											onCompleteFunc:Function = null, params:Array = null ):void
		{
			var dy:Number	=	target.y - obj.y;
			
			TweenPlugin.activate([BezierPlugin]);
			TweenLite.to( obj, 1, { bezier:[
				{ x:obj.x, y:obj.y }, 
				{ x:obj.x, y:(obj.y + dy / 4) },
				{ x:target.x, y:(obj.y + 3 * dy / 4)},
				{ x:target.x, y:target.y}],
				onComplete:onCompleteFunc, 
				onCompleteParams:params });
		}
		
		public function applyStraightFly( obj:DisplayObject, target:Point, 
											onCompleteFunc:Function = null, params:Array = null ):void
		{
			TweenPlugin.activate([BezierPlugin]);
			TweenLite.to( obj, 1, { bezier:[
				{ x:obj.x, y:obj.y }, 
				{ x:target.x, y:target.y}],
				onComplete:onCompleteFunc, 
				onCompleteParams:params });
		}
	}
}