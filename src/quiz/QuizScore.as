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
	public class QuizScore extends QuizElement	
	{
		private var font:String = "Calibri";
		private var _scoreField:TextField;
		private var sFormat:TextFormat = new TextFormat(font, 20, 0x330000, false, false, false);
		
		
		public function QuizScore(numCorrect:int, numAsked:int) 
		{

			var score:String = "Score: " + numCorrect + " / " + numAsked;
			scoreField = new TextField();
			scoreField = TextProperties(score, sFormat, 0 , 0 , 200);
		}
		
				
		//Get and Set Functions
		public function get scoreField():TextField {
			return _scoreField;
		}
		public function set scoreField(text:TextField):void {
			_scoreField = text;
		}
	}

}