package quiz
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
		
	public class NextButton extends QuizElement
	{
		//These set up the formatting for the various TextFields that are involved in the
		//NextButton class.
		private var font:String = "Calibri";
		private var nFormat:TextFormat = new TextFormat(font, 36, 0x330000, false, false, false);		
		private var mFormat:TextFormat = new TextFormat(font, 22, 0x330000, false, false, false);
		
		//The TextFields
		private var _nextField:TextField;
		private var _messageField:TextField;
		
		//The correct boolean decides whether it displays a positive or negative message.
		public function NextButton(correct:Boolean, retry:Boolean, showCorrect:Boolean, timedOut:Boolean, missedOut:Boolean) 
		{
			messageField = new TextField();
			nextField = new TextField();
			
			if (timedOut && missedOut) {
				messageField = TextProperties("Unfortunately you have run out of time for this question and have consequently missed too many questions.  The next round will begin.", mFormat, 0, 0, 500);				
			}
			else if (timedOut) {
				messageField = TextProperties("Unfortunately you have run out of time for this question.", mFormat, 0, 0, 600);				
			}
			if (missedOut) {
				messageField = TextProperties("Unfortunately you have missed too many questions.  This quiz will now end and the next round will soon begin.", mFormat, 0, 0, 500);				
			}
			else {
				if (showCorrect) {
					if (correct) {
						messageField = TextProperties("Your answer was correct!", nFormat, -50, 0, 600);
					}
					else if (retry) {
						messageField = TextProperties("Your answer was incorrect, please try again.", nFormat, -100, 0, 700);
					}
					else {
						messageField = TextProperties("Your answer was incorrect.", nFormat, -50, 0, 600);
					}
				}
				else {
					messageField = TextProperties("Congratulations, your answer was submitted!", mFormat, 0, 0, 600);
					messageField.visible = false;
				}
			}
			
			if (missedOut) {
				nextField = TextProperties("Begin Next Round...", nFormat, 340, 270, 400);
			}
			else if (!correct && retry) {
				nextField = TextProperties("Try Again...", nFormat, 420, 270, 400);
			}
			else {
				nextField = TextProperties("Next Question...", nFormat, 400, 270, 400);
			}
			nextField.alpha = .5;
			
			//These control the opacity of the nextField
			nextField.addEventListener(MouseEvent.ROLL_OVER, nextRoll_Over);
			nextField.addEventListener(MouseEvent.ROLL_OUT, nextRoll_Out);
		}
		
		private function nextRoll_Over(event:Event):void {
			nextField.alpha = 1;
		}
		
		private function nextRoll_Out(event:Event):void {
			nextField.alpha = .5;
		}
				
		public function get messageField():TextField {
			return _messageField;
		}
		public function set messageField(text:TextField):void {
			_messageField = text;
		}
		public function get nextField():TextField {
			return _nextField;
		}
		public function set nextField(text:TextField):void {
			_nextField = text;
		}
	}

}