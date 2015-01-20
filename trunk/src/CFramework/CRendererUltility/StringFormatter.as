package CFramework.CRendererUltility
{
	import XMFramework.Interface.IFramework;
	
	
	/**
	 * Convert or format string to another string 
	 * @author quocpt
	 * 
	 */	
	public class StringFormatter
	{		
		/**
		 * Convert dd:hh:mm:ss to seconds value
		 * @param seconds
		 * @return 
		 * 
		 */		
		public static function toSeconds( d : uint, h : uint, m : uint, s : uint ) : uint
		{	
			var dsec : uint	=	d * 24 * 60 * 60;
			var hsec : uint	=	h * 60 * 60;
			var msec : uint	=	m * 60;
			
			return dsec + hsec + msec + s;
		}
		
		/**
		 * Convert time value (seconds) to string format 
		 * @param seconds
		 * @return 
		 * 
		 */		
		public static function formatTime( _coreSNSFramework : IFramework, seconds : uint, ignoreText : Boolean = false ) : String
		{
			var _days: int = 0;
			var _hour: int = 0;
			var _min:int = 0;
			var _second:int = 0;
			var str:String = "";
			
			_days 	= 	seconds / 86400;	// 3600 * 24 = 86400
			seconds	-=	_days * 86400;
			
			_hour 	= 	seconds / 3600;
			seconds	-=	_hour * 3600;
			
			_min 	= 	seconds / 60;
			seconds	-=	_min * 60;
			
			_second = 	seconds;
			
			if(_days != 0)
				str = _days + (ignoreText ? ":" : " " + _coreSNSFramework.localizer.getString( ShareLocalization.day ) + " ");
			if(_hour != 0)
				str += _hour + (ignoreText ? ":" : " " + _coreSNSFramework.localizer.getString( ShareLocalization.hour ) + " ");
			if(_min != 0)
				str += _min + (ignoreText ? ":" : " "  + _coreSNSFramework.localizer.getString( ShareLocalization.minute ) + " ");
			if(_second != 0)
				str += _second + (ignoreText ? "" : " " + _coreSNSFramework.localizer.getString( ShareLocalization.second ) + " ");
			
			if( str == "" )
				str	=	" 0 " + _coreSNSFramework.localizer.getString( ShareLocalization.second );
			
			return str;
		}
		
		public static function formatTime_noSeconds( _coreSNSFramework : IFramework, seconds : uint, ignoreText : Boolean = false ) : String
		{
			var _days: int = 0;
			var _hour: int = 0;
			var _min:int = 0;
			var _second:int = 0;
			var str:String = "";
			
			_days 	= 	seconds / 86400;	// 3600 * 24 = 86400
			seconds	-=	_days * 86400;
			
			_hour 	= 	seconds / 3600;
			seconds	-=	_hour * 3600;
			
			_min 	= 	seconds / 60;
			seconds	-=	_min * 60;
			
			_second = 	seconds;
			
			if(_days != 0)
				str = _days + (ignoreText ? ":" : " " + _coreSNSFramework.localizer.getString( ShareLocalization.day ) + " ");
			if(_hour != 0)
				str += _hour + (ignoreText ? ":" : " " + _coreSNSFramework.localizer.getString( ShareLocalization.hour ) + " ");
			if(_min != 0)
				str += _min + (ignoreText ? ":" : " "  + _coreSNSFramework.localizer.getString( ShareLocalization.minute ) + " ");
			if( str == "" )
			{
				if(_second!= 0)
					str	=	_second + _coreSNSFramework.localizer.getString( ShareLocalization.second );				
			}
			return str;
		}
		
		public static function formatTimeignoreText( _coreSNSFramework : IFramework, seconds : uint) : String
		{
			var _days: int = 0;
			var _hour: int = 0;
			var _min:int = 0;
			var _second:int = 0;
			var str:String = "";
			
			_days 	= 	seconds / 86400;	// 3600 * 24 = 86400
			seconds	-=	_days * 86400;
			
			_hour 	= 	seconds / 3600;
			seconds	-=	_hour * 3600;
			
			_min 	= 	seconds / 60;
			seconds	-=	_min * 60;
			
			_second = 	seconds;
			
			if(_days != 0)
				str = (_days < 10 ? "0" + _days : _days) + ":";
			if(_hour != 0)
				str += (_hour < 10 ? "0" + _hour : _hour) + ":";
			
			str += (_min < 10 ? "0" + _min : _min) + ":";
			str += (_second < 10 ? "0" + _second : _second);
			return str;
		}
		
		public static function formatExpireTime( _coreSNSFramework : IFramework, seconds : uint ) : String
		{
			var _days: int = 0;
			var _hour: int = 0;
			var _min:int = 0;
			var _second:int = 0;
			var str:String = "";
			
			_days 	= 	seconds / 86400;	// 3600 * 24 = 86400
			seconds	-=	_days * 86400;
			
			_hour 	= 	seconds / 3600;
			seconds	-=	_hour * 3600;
			
			_min 	= 	seconds / 60;
			seconds	-=	_min * 60;
			
			_second = 	seconds;
			
			if(_days != 0)
			{
				str = String(_days + 1) + " " + _coreSNSFramework.localizer.getString( ShareLocalization.day );
				return str;
			}
			else
			{
				if(_hour != 0)
					str += _hour + ":";
				else
					str += "0:"
				
				if(_min != 0)
					str += _min + ":";
				else
					str += "0:";
				
				if(_second != 0)
					str += _second;
				else
					str += "0";
				
				return str;
			}
		}		
		
		public static function moneyFormat( money : Number ):String
		{
			var str : String = String( money );
			var numDot :int =  str.length / 3;
			var indexBegin : int =  str.length % 3;
			var result:String = "";
			var temp:String = str.substr(0, indexBegin);
			for( var i : int = 0; i<= numDot; i++)
			{
				result += temp;
				if(i != numDot && temp.length != 0)
					result += ".";
				temp	= 	str.substr(indexBegin, 3);
				indexBegin += 3;
			}
			return result;
		}
	}
}