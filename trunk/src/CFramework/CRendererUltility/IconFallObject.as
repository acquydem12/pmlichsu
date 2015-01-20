package CFramework.CRendererUltility
{
	import GTweener.TimelineLite;
	import GTweener.TweenLite;
	import GTweener.easing.Sine;
	
	import CFramework.CComponent.CLabel;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;

	public class IconFallObject
	{
		private var _icon : DisplayObject;
		private var _host : DisplayObjectContainer;
		private var _posX : Number;
		private var _posY : Number;
		private var _targetX : Number;
		private var _targetY : Number;		
		private var _lblMessage : CLabel		=	null;	
		private var _leftSide : Number			=	1.0;	
		private var _timeline : TimelineLite;
		private var _index : int = 1;
		private var _onCompelte : Function;

		
		/**
		 * 
		 * @param params[""]
		 * @param icon : DisplayObject
		 * @param host : DisplayObjectContainer
		 * @param posX : Number
		 * @param posY : Number
		 * @param targetX : Number
		 * @param targetY : Number
		 * @param leftSide : Boolean
		 * @param index : int
		 * 
		 */		
		public function IconFallObject( params : Object )
		{
			_icon		=	params.icon;
			_host		=	params.host;
			_posX		=	params.posX;
			_posY		=	params.posY;
			_targetX	=	params.targetX;
			_targetY	=	params.targetY;
			_index		=	params.index;
			_leftSide	=	params.leftSide != 0 ? params.leftSide : 1 ;
			_onCompelte = 	params.onComplete;
			_timeline = new TimelineLite();
		}
		
		public function applyAnimationEffect( params : Object ) : void
		{	
			var message : String 	= params.text;
			var color : uint  		= params.color;
			if( message )
			{
				_lblMessage	=	new CLabel();
				_lblMessage.textField.selectable		=	false;
				_lblMessage.color		=	color;
				_lblMessage.mouseEnabled	=	false;
				_lblMessage.tabEnabled		=	false;
				_lblMessage.filters			=	[new GlowFilter(0)];
				_lblMessage.textField.autoSize		=	TextFieldAutoSize.RIGHT;
				_lblMessage.size = 15;
				_lblMessage.filters = FilterEffect.createStrokeFilter();
				_lblMessage.text			=	message;
				_lblMessage.cacheAsBitmap = true;
			}
			
			_icon.x		=	_posX;
			_icon.y		=	_posY;
			
			_icon.scaleY	=	0.75;
			_icon.scaleX	=	1.25;
			
			// 
			var objParam:Object	=	new Object();
			objParam.x			=	_posX;
			objParam.y			=	_posY - 5;
			objParam.scaleY		=	1.0;
			objParam.scaleX		=	1.0;
			objParam.delay		=	_index*0.15;
			objParam.onInit 	=	onEffectStart;
			
			// dropdown
			var objParam2 : Object	=	new Object();	
			var objParam3 : Object	=	new Object();	
			objParam2.ease			=	Sine.easeIn ;
			objParam3.ease			=	Sine.easeOut ;
			switch( _index )
			{
				case 1:
					objParam2.y				=	_posY + 65;	
					objParam3.x				=	_posX + 40*_leftSide;
					break;
				case 2:
					objParam2.y				=	_posY + 65;	
					objParam3.x				=	_posX + 65*_leftSide;
					break;
				case 3:
					objParam2.y				=	_posY + 40;	
					objParam3.x				=	_posX + 50*_leftSide;
					break;
				case 4:
					objParam2.y				=	_posY + 95;	
					objParam3.x				=	_posX + 50*_leftSide;
					break;
				case 5:
					objParam2.y				=	_posY + 65;	
					objParam3.x				=	_posX + 90*_leftSide;
					break;
				case 6:
					objParam2.y				=	_posY + 40;	
					objParam3.x				=	_posX + 90*_leftSide;
					break;
				default:
					objParam2.y				=	_posY + 40;	
					objParam2.x				=	_posX + 110*_leftSide;
					break;
			}

			_timeline.append( TweenLite.to( _icon, 0.075, objParam));// xuat hien
			_timeline.appendMultiple( [
								TweenLite.to( _icon, 0.05, {x : _posX + (10 +  5*_index)*_leftSide, ease : Sine.easeOut } ),
								TweenLite.to( _icon, 0.05, {y : _posY - 15*_index, ease : Sine.easeOut } )
										]);// di chuyen len
			_timeline.appendMultiple(  [
				TweenLite.to( _icon, 0.3, objParam2),// di chuyen xuong
				TweenLite.to( _icon, 0.3, objParam3),// di chuyen xuong
				TweenLite.to(_icon,0.1, {scaleY:0.6,scaleX:1.3,delay : 0.075,onInit:InitInvisible  } )// zoom in
				]);
			_timeline.append(TweenLite.to(_icon,0.1, {scaleY:1,scaleX:1} ));// zoom out
			_timeline.append(TweenLite.to(_icon,0.5, { delay : 0.9 + (Math.random() * 0.25) }  ));// wait disble
			_timeline.append(TweenLite.to(_icon,0.25, {scaleY:0.8,scaleX:0.8} ));
			_timeline.append(TweenLite.to(_icon,0.25, {scaleY:1,scaleX:1} ));
			_timeline.append(TweenLite.to(_icon,0.2, {scaleY:0.8,scaleX:0.8} ));
			_timeline.append(TweenLite.to(_icon,0.2, {scaleY:1,scaleX:1} ));
			_timeline.append(TweenLite.to(_icon,0.15, {scaleY:0.8,scaleX:0.8} ));
			_timeline.append(TweenLite.to(_icon,0.15, {scaleY:1,scaleX:1} ));
			_timeline.append(TweenLite.to(_icon,0.1, {scaleY:0.8,scaleX:0.8} ));
			_timeline.append(TweenLite.to(_icon,0.1, {scaleY:1,scaleX:1, onComplete : invisible} ));
			

		}
		
		private function onEffectStart() : void			
		{
			_host.addChild( _icon );
		}
		
		private function InitInvisible() : void
		{				
			_icon.addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			
		}
		
		private	function invisible() : void // move to target
		{	
			if( _icon == null || _icon.parent == null )
			{
				removeIcon();
				return;
			}
			if( _lblMessage )
			{
				_host.addChild( _lblMessage );
				_lblMessage.x		=	_icon.x;
				_lblMessage.y		=	_icon.y;
				TweenLite.to( _lblMessage, 2, { y : _lblMessage.y - 100, alpha : 0.1,onComplete	:removeLabel  } );
			}

			var ltr : Point		=	_icon.parent.globalToLocal( new Point( _targetX, _targetY ) );
			var timeline  : TimelineLite = new TimelineLite( {onComplete  : removeIcon});
			timeline.appendMultiple( [
				TweenLite.to( _icon, 0.35, { x : ltr.x, ease : Sine.easeOut } ),
				TweenLite.to( _icon, 0.35, { y : ltr.y, ease : Sine.easeIn } )
				]);
		
		}
		
		private function removeLabel() : void
		{
			if( _lblMessage && _host.contains(_lblMessage) )
				_host.removeChild( _lblMessage );
			_lblMessage		=	null;
		}
		
		private function removeIcon() : void
		{
			if( _icon && _host.contains(_icon) )
				_host.removeChild( _icon );
			_icon		=	null;
			_timeline = null;
			if( _onCompelte != null )
				_onCompelte();
		}
		
		private function onMouseOver( event : MouseEvent ) : void
		{			
			_icon.removeEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			_timeline.kill();
			_timeline = null;
			_icon.y		-=	7;
			_icon.x		+=	5;		
			_icon.scaleX		=	1.35;
			_icon.scaleY		=	1.35;	
			TweenLite.to( _icon, 0.2, {scaleX : 1, scaleY : 1, onComplete : invisible  }  );
		}
	}
}