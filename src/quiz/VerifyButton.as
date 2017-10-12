package quiz
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
		
	public class VerifyButton extends QuizElement
	{
		//These set up the formatting for the various TextFields that are involved in the
		//AnswerVerify class.
		private var font:String = "Calibri";
		private var vFormat:TextFormat = new TextFormat(font, 22, 0x330000, false, false, false);		
		private var mFormat:TextFormat = new TextFormat(font, 22, 0x330000, false, false, false);
		
		//The TextFields
		private var _verifyField:TextField;
		private var _messageField:TextField;
		
		//The correct boolean decides whether it displays a positive or negative message.
		public function VerifyButton(selected:String) 
		{
			messageField = new TextField();
			verifyField = new TextField();
			
			
			messageField = TextProperties("You have selected: " + selected + ".", mFormat, 0, 0, 400);
			
			verifyField = TextProperties("Click here to confirm and submit your answer.", vFormat, 0, 50, 500);
			verifyField.alpha = .5;
			
			//These control the opacity of the nextField
			verifyField.addEventListener(MouseEvent.ROLL_OVER, verifyRoll_Over);
			verifyField.addEventListener(MouseEvent.ROLL_OUT, verifyRoll_Out);
		}
		
		private function verifyRoll_Over(event:Event):void {
			verifyField.alpha = 1;
		}
		
		private function verifyRoll_Out(event:Event):void {
			verifyField.alpha = .5;
		}
				
		public function get messageField():TextField {
			return _messageField;
		}
		public function set messageField(text:TextField):void {
			_messageField = text;
		}
		public function get verifyField():TextField {
			return _verifyField;
		}
		public function set verifyField(text:TextField):void {
			_verifyField = text;
		}
	}

}