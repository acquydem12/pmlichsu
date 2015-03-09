// QuocPT
 
package CFramework.CComponent
{
	import CFramework.CRendererUltility.FilterEffect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class CImageButton extends Sprite
	{
		protected var _face : BitmapData;
		protected var _faceContainer : Bitmap;
		protected var _loadingIcon:DisplayObject;
		
		protected var _upSkin:DisplayObject			=	null;
		protected var _overSkin:DisplayObject		=	null;
		protected var _downSkin:DisplayObject		=	null;
		protected var _disableSkin:DisplayObject	=	null;
		
		public var _scaleObj:Object					=	null;
		
		protected var _isMouseDown:Boolean			=	false;
		protected var _isMouseOver:Boolean			=	false;
		
		protected var _width : Number				=	1;
		protected var _height : Number				=	1;
		protected var _enabled : Boolean			=	true;
		protected var _centerAlign : Boolean		=	true;				
		
		private var _hitArea:Sprite = null;
		
		// implement CZTimerDown
		private var _localTimer : Timer;
		private var _timerDown : Timer;
		private var _isCZTimerDown : Boolean;
		private var _Delay : int = 50;
		private const _CZTimerDown:String = "CZTimerDown";
		
		private var isHighlight:Boolean				=	false;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The string to use for the initial label of this component.
 		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function CImageButton()
		{			
			super();
			
			buttonMode 			=	true;
			useHandCursor 		=	true;
			mouseChildren		=	false;
			
			_faceContainer	=	new Bitmap();			
			addChild( _faceContainer );
			
			_hitArea = new Sprite();
			_hitArea.mouseEnabled = false;
			_hitArea.mouseChildren = false;
			_hitArea.visible = false;
			addChild(_hitArea);
			
			this.hitArea = _hitArea;
			
			_loadingIcon			=	new CLoadingIcon;		
			
			invalidateSize();			
			drawFace( _upSkin );			
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}	
		
		public function get isCZTimerDown():Boolean
		{
			return _isCZTimerDown;
		}

		public function set isCZTimerDown(value:Boolean):void
		{
			if( value == true && !_isCZTimerDown )
			{
				_timerDown = new Timer(_Delay);
				_timerDown.addEventListener(TimerEvent.TIMER, onTimerDown);
				this.addEventListener(MouseEvent.MOUSE_DOWN, startCZTimerDown);
				this.addEventListener(MouseEvent.MOUSE_UP, stopCZTimerDown);
				this.addEventListener(MouseEvent.ROLL_OUT, stopCZTimerDown);
				_localTimer = new Timer(200,1);
				_localTimer.addEventListener(TimerEvent.TIMER, actionStartCZTimerDown);
			}
			_isCZTimerDown = value;
		}
		
		protected function onTimerDown(event:TimerEvent):void
		{
			dispatchEvent(new Event(_CZTimerDown));
		}
		
		private function startCZTimerDown(e : Event):void
		{
			_localTimer.start();
		}
		
		private function actionStartCZTimerDown(e : Event):void
		{
			_timerDown.start();
		}
		
		private function stopCZTimerDown(e : Event):void
		{
			_timerDown.stop();
			_localTimer.stop();
		}

		protected function onMouseClick(event:MouseEvent):void
		{
			if( _enabled == false )
				event.stopImmediatePropagation();
		}
		
		public function get scaleObj():Object
		{
			if( _scaleObj == null )
				_scaleObj 	= 	new Object();
			return _scaleObj;
		}
		
		public function set disableSkin( val : DisplayObject ) : void
		{
			_disableSkin		=	val;		
			
			invalidateSize();
			
			if( enabled == false )
				drawFace( _disableSkin );
				
			else
				drawFace( _upSkin );
		}
		
		public function get disableSkin() : DisplayObject
		{
			return _disableSkin;	
		}
		
		public function set downSkin( val : DisplayObject ) : void
		{
			_downSkin		=	val;
			
			invalidateSize();
			
			drawFace( _upSkin );
		}
		
		public function get downSkin() : DisplayObject
		{
			return _downSkin;	
		}
		
		public function set overSkin( val : DisplayObject ) : void
		{
			_overSkin		=	val;
			
			invalidateSize();
			
			drawFace( _upSkin );
		}
		
		public function get overSkin() : DisplayObject
		{
			return _overSkin;	
		}
		
		public function set upSkin( val : DisplayObject ) : void
		{
			_upSkin		=	val;		
			
			invalidateSize();			
			
			if( enabled == false )
				drawFace( _disableSkin );
			else			
				drawFace( _upSkin );	
			
			_hitArea.graphics.clear();
			_hitArea.graphics.beginFill(0xff00ff,0.7);
			_hitArea.graphics.drawRect(0,0,_upSkin.width,_upSkin.height );
			_hitArea.graphics.endFill();
			
			_hitArea.x = -_upSkin.width * 0.5;
			_hitArea.y = -_upSkin.height * 0.5;
		}
		
		public function get upSkin() : DisplayObject
		{
			return _upSkin;	
		}
		
		public function setSize(w:Number, h:Number):void
		{			
			_width	=	w;
			_height	=	h;
			
			invalidateSize();
		}
		
		protected function invalidateSize() : void
		{
			if( _upSkin )
			{
				if( _width < _upSkin.width ) _width		=	_upSkin.width;
				if( _height < _upSkin.height ) _height	=	_upSkin.height;
			}
			
			if( _overSkin )
			{
				if( _width < _overSkin.width ) _width	=	_overSkin.width;
				if( _height < _overSkin.height ) _height	=	_overSkin.height;
			}
			
			if( _downSkin )
			{
				if( _width < _downSkin.width ) _width	=	_downSkin.width;
				if( _height < _downSkin.height ) _height	=	_downSkin.height;
			}
			
			if( _disableSkin )
			{
				if( _width < _disableSkin.width ) _width	=	_disableSkin.width;
				if( _height < _disableSkin.height ) _height	=	_disableSkin.height;
			}
			
			_face	=	new BitmapData( _width, _height );
			_faceContainer.bitmapData	=	_face;
			
			//
			updateLoadingIcon();
		}
				
		protected function drawFace( src : IBitmapDrawable ) : void
		{
			if( src == null )
				return;

			_face.fillRect( new Rectangle( 0, 0, _face.width, _face.height ), 0 );
			_face.draw( src );
			
			
			if( _centerAlign )
			{
				var offX : Number	=	0;
				var offY : Number	=	0;
				
				if( src == _upSkin )
				{
					offX	=	- _upSkin.width * 0.5;
					offY	=	- _upSkin.height * 0.5;
				}
				else if( src == _downSkin )
				{
					offX	=	- _downSkin.width * 0.5;
					offY	=	- _downSkin.height * 0.5;
				}
				else if( src == _overSkin )
				{
					offX	=	- _overSkin.width * 0.5;
					offY	=	- _overSkin.height * 0.5;
				}
				else
				{
					offX	=	- _disableSkin.width * 0.5;
					offY	=	- _disableSkin.height * 0.5;
				}
				
				_faceContainer.x	=	offX;
				_faceContainer.y	=	offY;	
		
			}
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		public function set enabled(value:Boolean):void
		{
			_enabled 		= 	value;
			
//			mouseEnabled	=	_enabled;
//			mouseChildren	=	_enabled;
			
			
			
			if( ! _enabled )
			{
				copyProperties( _disableSkin );
				drawFace( _disableSkin );
			}
			else
			{
				copyProperties( _upSkin );
				drawFace( _upSkin );
			}
		}
		
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver(event:MouseEvent):void
		{			
			if( _enabled && stage )
			{
				copyProperties( _overSkin );
				drawFace( _overSkin );
				
				_isMouseOver	=	true;
				
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut(event:MouseEvent):void
		{
			if( _enabled && stage )
			{
				if(! _isMouseDown )
				{
					if( _enabled )
					{
						copyProperties( _upSkin );
						
						drawFace( _upSkin );
					}
						
					else
					{
						copyProperties( _disableSkin );
						
						drawFace( _disableSkin );
					}
				}
				
				_isMouseOver	=	false;
				
				removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown(event:MouseEvent):void
		{					
			if( _enabled && stage )
			{
				copyProperties( _downSkin );
				drawFace( _downSkin );
				
				_isMouseDown	=	true;
				
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
			}
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp(event:MouseEvent):void
		{
			if( _enabled && stage )
			{
				
				if( _isMouseOver )
				{
					copyProperties( _overSkin );
					drawFace( _overSkin );
				}
				else
				{
					copyProperties( _upSkin );
					drawFace( _upSkin );
				}
				
				_isMouseDown	=	false;
				
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
			}
		}
		
		protected function copyProperties( val : DisplayObject ):void
		{
			if( !val )
				return;
			
			this.filters	=	val.filters;
		}
		
		public function set centerAlign( val : Boolean ) : void
		{
			_centerAlign = val;
		}
		
		public function get centerAlign() : Boolean
		{
			return _centerAlign;
		}
		
		private function updateLoadingIcon() : void
		{
			// Remove loading icon
			if( _upSkin != null &&
			   _downSkin != null &&
			   _overSkin != null &&
			   _disableSkin != null )
			{
				try
				{
					removeChild( _loadingIcon );
					_loadingIcon = null;
				}
				catch( ex : * ){}
			}
			else
			{
				addChild( _loadingIcon );
			}
		}
		
		public function set highlight( isHighlight:Boolean ):void
		{
			this.isHighlight	=	isHighlight;
		}
		
		public function move( x: Number, y:Number ) : void
		{
			this.x	=	x;
			this.y	=	y;
		}
	
		public function disable( callBack:Function ):void
		{
			if( !disableSkin )
			{
				filters	=	FilterEffect.createBackWhiteImage();
			} else
			{
				copyProperties( _disableSkin );
				drawFace( _disableSkin );
				if( stage )
				{
					stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
			}
			enabled	=	false;
			removeEventListener(MouseEvent.CLICK, callBack);
		}
		
		public function enable( callBack:Function ):void
		{
			if( !disableSkin )
			{
				filters	=	null;
			} else {
				copyProperties( _upSkin );
				drawFace( _upSkin );
				if( stage )
				{
					stage.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
			}
			enabled	=	true;
			addEventListener(MouseEvent.CLICK, callBack);
		}
	}
}