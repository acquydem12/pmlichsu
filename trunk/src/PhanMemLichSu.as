package
{
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
	
	[SWF( frameRate="24", width="836", height="640")]
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
			_hlbCore.onInit( this, null, "media/swf/res.swf" );
			
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
//			
//			_hlbCore.register( CShareMacros.HLB_VIEW, new GatoDecorateView(CShareMacros.HLB_VIEW) );
//			_hlbCore.register( CShareMacros.HLB_MENU, new MenuView(CShareMacros.HLB_MENU) );
//			_hlbCore.register( CShareMacros.HLB_TN, new TNView(CShareMacros.HLB_TN) );
//			_hlbCore.showView( CShareMacros.HLB_MENU );
			
			playSound();
		}
		
		protected function loadFont():void
		{
			var cls:Class	=	Global.CoreGame.resourceManager.getClass( "UVN Banh Mi" );
			if( cls )
				Font.registerFont( cls );
		}
		
		protected function playSound():void
		{
			var sound:Sound = new Sound();
			var soundChannel:SoundChannel;
			
			sound.addEventListener(Event.COMPLETE, onSoundLoadComplete);
			
			sound.load( new URLRequest("media/swf/sound.mp3") );
			
			function onSoundLoadComplete(e:Event):void{
				sound.removeEventListener(Event.COMPLETE, onSoundLoadComplete);
//				soundChannel = sound.play();
//				soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
			}
			
			//  this is called when the sound channel completes.
			function onSoundChannelSoundComplete(e:Event):void{
				e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
				soundChannel = sound.play();
			}
		}
	}
}