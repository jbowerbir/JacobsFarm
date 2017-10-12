package quiz
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 * 
	 * This class just creates an easy to modify TextField for the score.
	 */
	public class QuitButton extends QuizElement	
	{
		private var font:String = "Calibri";
		private var _quitField:TextField;
		private var sFormat:TextFormat = new TextFormat(font, 22, 0x330000, false, false, false);
		
		
		public function QuitButton() 
		{

			var quit:String = "Exit";
			quitField = new TextField();
			quitField = TextProperties(quit, sFormat, 0 , 0 , 200);
			
			quitField.addEventListener(MouseEvent.ROLL_OVER, verifyRoll_Over);
			quitField.addEventListener(MouseEvent.ROLL_OUT, verifyRoll_Out);
		}
		
		private function verifyRoll_Over(event:Event):void {
			quitField.alpha = 1;
		}
		
		private function verifyRoll_Out(event:Event):void {
			quitField.alpha = .5;
		}
				
		//Get and Set Functions
		public function get quitField():TextField {
			return _quitField;
		}
		public function set quitField(text:TextField):void {
			_quitField = text;
		}
	}

}