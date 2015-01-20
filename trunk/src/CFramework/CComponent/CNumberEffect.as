package CFramework.CComponent
{	

	public class CNumberEffect extends CLabel
	{		
		private var _fromNumber:Number = 0;
		private var _currentNumber:Number = 0;
		private var _targetNumber:Number = 0;
		private var _delta:Number = 0;
		
		private var _number:Number = 0;
		
		public function onFrameUpdate( deltaTime : Number, totalTime : Number ) : void
		{
			var TIME_NUMBERING:Number = 1.0;
			if (_targetNumber != _number)
				_delta = (_number - _currentNumber) / (TIME_NUMBERING / deltaTime);
			_targetNumber = _number;
			if ((_targetNumber - _currentNumber) != 0)
			{
				_currentNumber += _delta;
				if ((_targetNumber - _currentNumber) * _delta < 0)
				{
					// Stop
					_fromNumber = _number;
					_currentNumber = _number;
					_delta = 0;
				}
				
				this.text = _currentNumber.toFixed(0);
				if (this.text == "0.")
					this.text = "0";
			}
		}
		
		public function get Value():Number
		{
			return _number;
		}

		public function set Value(value:Number):void
		{
			_number = value;
		}

	}
}
