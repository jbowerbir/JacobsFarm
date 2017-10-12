package ui 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import util.CustomEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class LoadingScreen extends Sprite
	{
		
		private var event:CustomEvent;
		
		
		public function LoadingScreen() 
		{
			var loadingScreen:LoadingScreenDesign = new LoadingScreenDesign();
			loadingScreen.x = 500;
			loadingScreen.y = 350;
			addChild(loadingScreen);
			
			event = new CustomEvent("READY", true);
			addEventListener(MouseEvent.CLICK, onClick);
			
		}
		
		private function onClick(e:Event):void
		{
			dispatchEvent(event);
		}
		
	}

}