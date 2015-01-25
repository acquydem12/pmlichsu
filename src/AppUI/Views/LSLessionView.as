package AppUI.Views
{
	import AppUI.Views.LessionView.ILessionListener;
	import AppUI.Views.LessionView.LessionItem;
	
	import CFramework.CComponent.CImage;
	import CFramework.CComponent.CLabel;
	
	import Data.JSONData;
	
	import Share.CShareMacros;
	
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class LSLessionView extends LSBaseView implements ILessionListener
	{
		private var _bg:CImage;
		
		private var _bgSub:CImage;
		
		private var _lblText:CLabel;
		
		private var _lessions:Vector.<LessionItem>;
		
		public function LSLessionView(identify:String)
		{
			super(identify, true);
		}
		
		public override function onRegisterComplete():void
		{
			super.onRegisterComplete();
			
			var host : DisplayObjectContainer	=	
				_core.holder.releaseVariable( CShareMacros.VAR_CONTAINER_GAME ) as DisplayObjectContainer;
			parentContainer	=	host;
			
			_bg	=	new CImage;
			addChild( _bg );
			
			_bgSub	=	new CImage;
			_bgSub.move( 30, 100 );
			addChild( _bgSub );
			
			var bgClass:Class		=	_core.resourceManager.getClass( "sl4_bg" );
			var bgSubClass:Class	=	_core.resourceManager.getClass( "default_bg_sub1" );
			if( bgClass )
				_bg.source		=	new Bitmap( new bgClass );
			
			if( bgSubClass )
				_bgSub.source	=	new Bitmap( new bgSubClass );
			
			
			_lblText	=	new CLabel;
			_lblText.size	=	23;
			_lblText.setSize( 550, 300 );
			_lblText.bold	=	true;
			_lblText.color	=	0x0;
			_lblText.wrapWord		=	true;
			_lblText.text	=	"Những cuộc kháng chiến chống ngoại xâm của Việt Nam từ thế kỉ X - XV";
			_lblText.move( 250, 30 );
			_lblText.buttonMode=	true;
			_lblText.wrapWord	=	true;
			_lblText.align		=	AlignMode.RIGHT;
			addChild( _lblText );
			
			
			createLessionItem();
			
			checkCreateButtonBar();
		}
		
		protected function createLessionItem():void
		{
			_lessions	=	new Vector.<LessionItem>();
			var count:uint	=	0;
			for( var str:String in JSONData.LessionData )
			{
				var data:Object	=	JSONData.LessionData[str];
				var lession:LessionItem	=	new LessionItem( data.index, data.text, data.color, this );
				lession.x		=	70 + int(count%2) * 400;
				lession.y		=	150 + int(count/2) * 100;
				count++;
				addChild( lession );
				_lessions.push( lession );
			}
		}
		
		public function onClicked(index:uint):void
		{
			for( var i:uint = 0; i < _lessions.length; ++i )
			{
				_lessions[i].normalize();
			}
		}
		
		protected override function onBackClicked(event:MouseEvent):void
		{
			changeView( CShareMacros.LS_LESSIONS, CShareMacros.LS_MENU, true, false );
		}
		
	}
}