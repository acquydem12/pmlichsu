/**
 * CheckBox.as
 * Keith Peters
 * version 0.9.10
 * 
 * A basic CheckBox component.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package CFramework.CComponent
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	public class CImageCheckBox extends Sprite
	{
		protected var _face : BitmapData;
		protected var _faceContainer : Bitmap;
		protected var _loadingIcon:DisplayObject;
		protected var _checkSkin:DisplayObject		=	null;
		protected var _disableSkin:DisplayObject	=	null;
		protected var _uncheckSkin:DisplayObject	=	null;
		
		protected var _centerAlign : Boolean	=	true;
		
		protected var _selected:Boolean = false;
		
		protected var _width : Number	=	1;
		protected var _height : Number	=	1;
		protected var _enabled : Boolean	=	true;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label String containing the label for this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function CImageCheckBox( checkSkin:DisplayObject = null, 
										 uncheckSkin:DisplayObject = null, 
										 disableSkin:DisplayObject = null)
		{					
			super();
			
			this._checkSkin			=	checkSkin;
			this._disableSkin		=	disableSkin;
			this._uncheckSkin		=	uncheckSkin;
			
			buttonMode 		= 	true;
			useHandCursor 	= 	true;
			mouseChildren 	= 	false;		
			
			_faceContainer	=	new Bitmap();			
			addChild( _faceContainer );			
			
			_loadingIcon			=	new CLoadingIcon;
			
			invalidateSize();
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function set uncheckSkin( val : DisplayObject ) : void
		{
			_uncheckSkin		=	val;		
			
			invalidateSize();
			
			if( _enabled )
			{
				if( _selected )
					drawFace( _checkSkin );
				else
					drawFace( _uncheckSkin );
			}	
			else
				drawFace( _disableSkin );
		}
		
		public function get uncheckSkin() : DisplayObject
		{
			return _uncheckSkin;	
		}
		
		public function set disableSkin( val : DisplayObject ) : void
		{
			_disableSkin		=	val;		
			
			invalidateSize();
			
			if( _enabled )
			{
				if( _selected )
					drawFace( _checkSkin );
				else
					drawFace( _uncheckSkin );
			}	
			else
				drawFace( _disableSkin );
		}
		
		public function get disableSkin() : DisplayObject
		{
			return _disableSkin;	
		}
		
		public function set checkSkin( val : DisplayObject ) : void
		{
			_checkSkin		=	val;		
			
			invalidateSize();
			
			if( _enabled )
			{
				if( _selected )
					drawFace( _checkSkin );
				else
					drawFace( _uncheckSkin );
			}	
			else
				drawFace( _disableSkin );
		}
		
		public function get checkSkin() : DisplayObject
		{
			return _checkSkin;	
		}
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseClick(event:MouseEvent):void
		{			
			_selected	=	! _selected;
			if( _selected )
				drawFace( _checkSkin );
			else
				drawFace( _uncheckSkin );
		}
		
		protected function invalidateSize() : void
		{
			if( _checkSkin )
			{
				if( _width < _checkSkin.width ) _width		=	_checkSkin.width;
				if( _height < _checkSkin.width ) _height	=	_checkSkin.height;
			}
			
			if( _disableSkin )
			{
				if( _width < _disableSkin.width ) _width	=	_disableSkin.width;
				if( _height < _disableSkin.width ) _height	=	_disableSkin.height;
			}
			
			if( _uncheckSkin )
			{
				if( _width < _uncheckSkin.width ) _width	=	_uncheckSkin.width;
				if( _height < _uncheckSkin.width ) _height	=	_uncheckSkin.height;
			}
			
			_face	=	new BitmapData( _width, _height );
			_faceContainer.bitmapData	=	_face;
			
			//
			updateLoadingIcon();
		}
		
		protected function drawFace( src : IBitmapDrawable ) : void
		{
			if(src == null)
				return;
			
			_face.fillRect( new Rectangle( 0, 0, _face.width, _face.height ), 0 );
			_face.draw( src );			
			
			if( _centerAlign )
			{
				var offX : Number	=	0;
				var offY : Number	=	0;
				
				if( src == _checkSkin )
				{
					offX	=	- _checkSkin.width * 0.5;
					offY	=	- _checkSkin.height * 0.5;
				}
				else if( src == _disableSkin )
				{
					offX	=	- _disableSkin.width * 0.5;
					offY	=	- _disableSkin.height * 0.5;
				}
				else
				{
					offX	=	- _uncheckSkin.width * 0.5;
					offY	=	- _uncheckSkin.height * 0.5;
				}
				
				_faceContainer.x	=	offX;
				_faceContainer.y	=	offY;				
			}
		}		
		
		public function set enabled(value:Boolean):void
		{
			mouseEnabled = value;
			
			_enabled	=	value;
			
			if( value )
			{
				drawFace( _disableSkin );
			}
			else
			{
				if( _selected )
					drawFace( _checkSkin );
				else
					drawFace( _uncheckSkin );
			}
		}
		
		public function set selected(value:Boolean):void
		{
			_selected	=	value;
			
			if( _enabled )
			{
				if( _selected )
					drawFace( _checkSkin );
				else
					drawFace( _uncheckSkin );
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
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
			if( _checkSkin != null &&
			   _uncheckSkin != null &&
			   _disableSkin != null )
			{
				if( _loadingIcon )
				{
					removeChild( _loadingIcon );
					_loadingIcon = null;
				}
			}
			else
			{
				addChild( _loadingIcon );
			}
			
		}
	}
}