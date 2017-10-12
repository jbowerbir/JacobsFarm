package ui 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class WaitingForPlayers extends WaitingOnPlayers 
	{
		private var frame:int = 1;
		private var timer:Timer;
		
		public function WaitingForPlayers() 
		{
			//this.gotoAndStop(1);
			var loopBool:Boolean = true;
			timer = new Timer(400, 1);
			timer.addEventListener(TimerEvent.TIMER, loop);
			//begin();
			
		}
		
		private function begin():void
		{
			timer.reset();
			timer.start();
		}
		
		private function loop(e:Event):void
		{
			frame++;
			if (frame < 7)
			{
				this.gotoAndStop(frame);
			}
			else
			{
				frame = 1;
				this.gotoAndStop(frame);
			}
			begin();
		}
		
	}

}