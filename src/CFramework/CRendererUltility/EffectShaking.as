package CFramework.CRendererUltility
{
	import GTweener.TimelineLite;
	import GTweener.TweenLite;
	import GTweener.easing.Linear;
	
	import PenguinsFarm.Egg.Egg;
	
	import flash.display.DisplayObject;

	public class EffectShaking
	{		
		private static var _inst:EffectShaking	=	new EffectShaking;
		
		private static const SHARK_TIME : Number	=	0.15;
		private static const SHARK_LENGTH : Number	=	7;
		private var _disObj : DisplayObject;
		private var  _timeLine : TimelineLite;
		
		public static function get singleton():EffectShaking
		{
			return _inst;
		}
		
		public function applyAnimationEffect( disObj : DisplayObject, delay : Number ) : void
		{
			if( ! disObj )
				return;
			
			_disObj	=	disObj;
			_timeLine = new TimelineLite();
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH * 0.5, ease : Linear.easeNone })  );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x - SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x - SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x - SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x - SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x - SHARK_LENGTH, ease : Linear.easeNone } ) );
			_timeLine.append(  TweenLite.to( _disObj, SHARK_TIME, { x : _disObj.x + SHARK_LENGTH* 0.5, ease : Linear.easeNone } ) );
		}
		
		private function stop() : void
		{		
			_disObj	=	null;
			_timeLine.kill();
			_timeLine = null;
		}
	}
}