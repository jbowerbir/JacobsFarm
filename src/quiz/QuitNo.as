package quiz
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
		
	public class QuitNo extends QuizElement
	{
		//These set up the formatting for the various TextFields that are involved in the
		//AnswerVerify class.
		private var font:String = "Calibri";
		private var vFormat:TextFormat = new TextFormat(font, 20, 0x330000, false, false, false);		
		private var mFormat:TextFormat = new TextFormat(font, 20, 0x330000, false, false, false);
		
		//The TextFields
		private var _noField:TextField;
		
		//The correct boolean decides whether it displays a positive or negative message.
		public function QuitNo() 
		{
			noField = new TextField();
			
			noField = TextProperties("No - I want to keep taking the quiz!", vFormat, 0, 0, 400);
			noField.textColor = 0xE42217;
			noField.alpha = .75;
			
			//These control the opacity of the yes/noField			
			noField.addEventListener(MouseEvent.ROLL_OVER, noRoll_Over);
			noField.addEventListener(MouseEvent.ROLL_OUT, noRoll_Out);
		}
				
		private function noRoll_Over(event:Event):void {
			noField.alpha = 1;
		}
		
		private function noRoll_Out(event:Event):void {
			noField.alpha = .75;
		}
				
		public function get noField():TextField {
			return _noField;
		}
		public function set noField(text:TextField):void {
			_noField = text;
		}
	}

}