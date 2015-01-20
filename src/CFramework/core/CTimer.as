package CFramework.core
{
	import flash.utils.getTimer;

	internal class CTimer
	{		
		private var _deltaTime : Number			=	0.0;
		private var _totalTime : Number			=	0.0;
		private var FPSRate : int				=	0.0;
		
		private var _serverTime : Number		=	0;
		private var _tickingServerTime : Number	=	0;			// Sequently increase along client application live 
		
		//
		private var lastTime : Number			=	0.0;
		private var fpsAccuTime : Number		=	0.0;
		private var fpsMarkTimes : int			=	0;
		
		public function initTimer() : void
		{
			lastTime	=	getTimer();
			_deltaTime	=	0.0;
		}
		
		public function updateTimer() : void
		{
			// Get current Flash Player time
			var currentTime : int	=	getTimer();
			
			// Calculate time since last update
			_deltaTime	=	currentTime - lastTime;
				
			// Trans from milisecond to second per frame
			_deltaTime	/=	1000.0;
			
			// Mark time for next frame
			lastTime	=	currentTime;
			
			// Total time eslapse
			_totalTime	+=	_deltaTime;
			
			// Align on server time
			_tickingServerTime	+=	_deltaTime;
			
			/////////////////////////////////////
			// Update FPS value
			fpsAccuTime	+=	_deltaTime;
			fpsMarkTimes++;
			if( fpsAccuTime >= 1.0 )	// 1.0 second
			{
				FPSRate			=	int( Math.ceil( 1.0 / ( fpsAccuTime / Number( fpsMarkTimes ) ) ) );
				fpsMarkTimes	=	0;
				fpsAccuTime		=	0.0;
			}
		}
		
		///////////////////////////////////////////////////////////
		//
		
		public function get deltaTime() : Number
		{
			return _deltaTime;
		}
		
		public function get totalTime() : Number
		{
			return _totalTime;
		}
		
		public function set totalTime( value:Number ):void
		{
			_totalTime	=	value;
		}
		
		public function get FPS() : Number
		{
			return FPSRate;
		}
		
		public function set serverTime( time : Number ) : void
		{
			_serverTime			=	time;
			_tickingServerTime	=	Number(time);
		}
		
		public function get serverTime() : Number
		{
			return _serverTime;
		}
		
		public function calServerTimeElapse( currTime : uint ) : Number
		{
			return _serverTime - currTime;
		}
		
		public function isOver(time:uint):Boolean
		{
			return _serverTime >= time;
		}
		
		public function get tickingServerTime() : Number
		{
			return _tickingServerTime;
		}
		
		public function set tickingServerTime( val:Number ):void
		{
			_tickingServerTime	=	Number(val);
		}
	}
}