package
{
	import AppUI.Views.LSBHView;
	import AppUI.Views.LSBTMenuView;
	import AppUI.Views.LSDAView;
	import AppUI.Views.LSDTSubView;
	import AppUI.Views.LSDTView;
	import AppUI.Views.LSHelpView;
	import AppUI.Views.LSIntroView;
	import AppUI.Views.LSLessionMenuView;
	import AppUI.Views.LSLessionView;
	import AppUI.Views.LSMenuView;
	import AppUI.Views.LSMessageBox;
	import AppUI.Views.LSTLView;
	import AppUI.Views.LSTNView;
	
	import CFramework.TooltipManager.TooltipController;
	import CFramework.TooltipManager.TooltipView;
	import CFramework.core.CCore;
	
	import Share.CShareMacros;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.Font;
	
	[SWF( frameRate="24", width="842", height="576")]
	public class PhanMemLichSu extends Sprite
	{
		private var _hlbCore:CCore;
		
		private var _gameContainer:Sprite;
		private var _container_topmost:Sprite;
		
		public function PhanMemLichSu()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
		}
		
		protected function onAddToStage( evt:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddToStage );
			
			_gameContainer	=	new Sprite;
			addChild( _gameContainer );
			
			_container_topmost	=	new Sprite;
			addChild( _container_topmost );
			
			onInit();
		}
		
		protected function onInit():void
		{
			_hlbCore	=	new CCore();
			_hlbCore.onInit( this, null, "debug/media/swf/res.swf" );
			
			_hlbCore.holder.holdVariable( CShareMacros.VAR_APP_WIDTH, 842 );
			_hlbCore.holder.holdVariable( CShareMacros.VAR_APP_HEIGHT, 576 );
			_hlbCore.holder.holdVariable( CShareMacros.VAR_CONTAINER_TOPMOST, _container_topmost );
			_hlbCore.holder.holdVariable( CShareMacros.VAR_CONTAINER_GAME, _gameContainer );
			
			Global.CoreGame	=	_hlbCore;
			
			_hlbCore.holder.holdVariable( CShareMacros.VAR_APP_ROOT, this );
			
			_hlbCore.start(onInitFrameworkComplete);
		}
		
		protected function onInitFrameworkComplete( event:Event ):void
		{
			loadFont();
			
			_hlbCore.register( CShareMacros.VIEW_TOOLTIP, new TooltipView, null, new TooltipController );
			_hlbCore.showView( CShareMacros.VIEW_TOOLTIP );
			
			_hlbCore.register( CShareMacros.LS_MESSAGEBOX, new LSMessageBox(CShareMacros.LS_MESSAGEBOX) );
			_hlbCore.register( CShareMacros.LS_DAVIEW, new LSDAView(CShareMacros.LS_DAVIEW) );
			
			_hlbCore.register( CShareMacros.LS_INTRO, new LSIntroView(CShareMacros.LS_INTRO) );
			_hlbCore.register( CShareMacros.LS_HELP, new LSHelpView(CShareMacros.LS_HELP) );
//			_hlbCore.register( CShareMacros.LS_MENU, new LSMenuView(CShareMacros.LS_MENU) );
			
			_hlbCore.register( CShareMacros.LS_LESSION_DETAIL, new LSLessionMenuView(CShareMacros.LS_LESSION_DETAIL) );
			_hlbCore.register( CShareMacros.LS_LESSION_BT_MENU, new LSBTMenuView(CShareMacros.LS_LESSION_BT_MENU) );
			_hlbCore.register( CShareMacros.LS_LESSION_TN, new LSTNView(CShareMacros.LS_LESSION_TN) );
			_hlbCore.register( CShareMacros.LS_LESSION_TL, new LSTLView(CShareMacros.LS_LESSION_TL) );
			_hlbCore.register( CShareMacros.LS_LESSION_DT, new LSDTView(CShareMacros.LS_LESSION_DT) );
			_hlbCore.register( CShareMacros.LS_LESSION_DT_DETAIL, new LSDTSubView(CShareMacros.LS_LESSION_DT_DETAIL) );
			_hlbCore.register( CShareMacros.LS_LESSION_BH, new LSBHView(CShareMacros.LS_LESSION_BH) );
			
			_hlbCore.showView( CShareMacros.LS_INTRO );
//			LSTNView.show( 17 );
//			LSDTView.show( 1 );
//			LSBHView.show( 17 );
			
			playSound();
		}
		
		protected function loadFont():void
		{
			var courier:Class	=	Global.CoreGame.resourceManager.getClass( "CourierNew" );
			var myriad:Class	=	Global.CoreGame.resourceManager.getClass( "MyriadPro" );
			var bachdang:Class	=	Global.CoreGame.resourceManager.getClass( "UVNBachDang" );
			var unicorn:Class	=	Global.CoreGame.resourceManager.getClass( "Unicorn Regular" );
			var victorian:Class	=	Global.CoreGame.resourceManager.getClass( "Victorian" );
			
			Font.registerFont( courier );
			Font.registerFont( myriad );
			Font.registerFont( bachdang );
			Font.registerFont( unicorn );
			Font.registerFont( victorian );
		}
		
		protected function playSound():void
		{
//			var sound:Sound = new Sound();
//			var soundChannel:SoundChannel;
//			
//			sound.addEventListener(Event.COMPLETE, onSoundLoadComplete);
//			
//			sound.load( new URLRequest("media/swf/sound.mp3") );
//			
//			function onSoundLoadComplete(e:Event):void{
//				sound.removeEventListener(Event.COMPLETE, onSoundLoadComplete);
////				soundChannel = sound.play();
////				soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
//			}
//			
//			//  this is called when the sound channel completes.
//			function onSoundChannelSoundComplete(e:Event):void{
//				e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
//				soundChannel = sound.play();
//			}
		}
	}
}