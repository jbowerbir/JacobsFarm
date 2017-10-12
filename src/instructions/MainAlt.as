package instructions
{
	import flash.display.Sprite;
	import flash.events.Event;
	import instructions.Instructions;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Main extends Sprite 
	{
		
		public var instructMe:Instructions;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			instructMe = new Instructions("");
			addChild(instructMe);
		}
		
	}
	
}