package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Quiz;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Main extends Sprite 
	{
		public var q:Quiz; 
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			run("../lib/");
		}
		
		private function run(path:String):void {
			q = new Quiz(path);
			addChild(q);
		}
		
		private function end():void {
			removeChild(q);
		}
		
	}
	
}