package util 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class CustomEvent extends Event
	{
		public var playerAnswers:Array;
		public var quizScore:int;
		
		public function CustomEvent(s:String, bubbles:Boolean) 
		{
			super(s, bubbles);
		}
		
	}

}