package quiz
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
		
	public class QuitYes extends QuizElement
	{
		//These set up the formatting for the various TextFields that are involved in the
		//AnswerVerify class.
		private var font:String = "Calibri";
		private var vFormat:TextFormat = new TextFormat(font, 20, 0x330000, false, false, false);		
		private var mFormat:TextFormat = new TextFormat(font, 20, 0x330000, false, false, false);
		
		//The TextFields
		private var _yesField:TextField;
		private var _messageField:TextField;
		
		//The correct boolean decides whether it displays a positive or negative message.
		public function QuitYes() 
		{
			messageField = new TextField();
			yesField = new TextField();
			
			
			messageField = TextProperties("Are you sure you want to quit the quiz?", mFormat, 0, 0, 400);
			
			yesField = TextProperties("Yes - I want to quit early!", vFormat, 0, 60, 400);
			yesField.textColor = 0x4CC417;
			yesField.alpha = .75;
			
			//These control the opacity of the yes/noField
			yesField.addEventListener(MouseEvent.ROLL_OVER, yesRoll_Over);
			yesField.addEventListener(MouseEvent.ROLL_OUT, yesRoll_Out);
		}
		
		private function yesRoll_Over(event:Event):void {
			yesField.alpha = 1;
		}
		
		private function yesRoll_Out(event:Event):void {
			yesField.alpha = .75;
		}
		
				
		public function get messageField():TextField {
			return _messageField;
		}
		public function set messageField(text:TextField):void {
			_messageField = text;
		}
		public function get yesField():TextField {
			return _yesField;
		}
		public function set yesField(text:TextField):void {
			_yesField = text;
		}
	}

}