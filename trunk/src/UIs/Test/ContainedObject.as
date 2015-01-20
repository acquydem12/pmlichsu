package UIs.Test
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ContainedObject extends Sprite
	{
		private var _source:DisplayObject;
		
		public function ContainedObject()
		{
			super();
		}
		
		public function set source(src:DisplayObject):void
		{
			this._source = src;
			addChild( _source );
		}
		
		public function get source():DisplayObject
		{
			return _source;
		}
	}
}