package quiz
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*; 
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	 
	public class Answer extends QuizElement
	{
		private var imageLoader:Loader;
		private var imageRequest:URLRequest;
		//These set up the formatting for the various TextFields that are involved in the
		//Answer class.
		private var font:String = "Calibri";
		
		private var lFormat:TextFormat = new TextFormat(font, 18, 0x330000, true, false, false);
		private var aFormat:TextFormat = new TextFormat(font, 18, 0x330000, false, false, false);
		
		//The various variables involved.  correctAnswer isn't really used.
		private var _letter:String;
		private var _answerID:int;
		private var _correctAnswer:int;
		private var _letterField:TextField;
		private var _answerField:TextField;
		public var imageheight:int = 0;
		
		
		public function Answer(text:String, type:String, id:int, correct:int) 
		{
			letterField = new TextField();
			answerField = new TextField();
			answerID = id;
			correctAnswer = correct;
			
			//The letter variable is used to create a letter designator (ie. a), b), c), etc.) for each answer.
			letter = String.fromCharCode(97 + id) + ")";
			
			//I have a separate letter and answer field so that they can be formatted differently.
			letterField = TextProperties(letter, lFormat, 0, 0, 40);
			
			if (type == "image") {
				var imageLoader:Loader = new Loader();
				var imageRequest:URLRequest = new URLRequest("assets/quiz/" + text);
				imageLoader.load(imageRequest);
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
				addChild(imageLoader);
				imageLoader.x = 20;
				imageLoader.y = 0;
			}
			else{
				answerField = TextProperties(text, aFormat, 20, 0, 550);
			}
			
			//These modify the opacity of the Answer object.
			this.alpha = .5;
			
			this.addEventListener(MouseEvent.ROLL_OVER, answerRoll_Over);
			this.addEventListener(MouseEvent.ROLL_OUT, answerRoll_Out);
			
		}
		
		private function imgLoaded(event:Event):void {
                imageheight = event.target.loader.content.height;
		}

		
		private function answerRoll_Over(event:Event):void {
			this.alpha = 1;
		}
		
		private function answerRoll_Out(event:Event):void {
			this.alpha = .5;
		}
		
		/*//This function makes it simpler to setup TextFields with specified settings.
		public function TextProperties(text:String, format:TextFormat, x:Number, y:Number, width:Number):TextField
		{
			var field:TextField = new TextField();
			field.x = x;
			field.y = y;
			field.width = width;
			field.text = text;
			field.setTextFormat(format);
			field.selectable = false;
			field.multiline = true;
			field.wordWrap = true;
			addChild(field);
			return field;
		
		}*/
		
		
		// Get and Set Functions
		public function get letter():String {
			return _letter;
		}
		public function set letter(s:String):void {
			_letter = s;
		}
		
		public function get answerID():int {
			return _answerID;
		}
		public function set answerID(i:int):void {
			_answerID = i;
		}
		
		public function get correctAnswer():int {
			return _correctAnswer;
		}
		public function set correctAnswer(i:int):void {
			_correctAnswer = i;
		}
		
		public function get letterField():TextField {
			return _letterField;
		}
		public function set letterField(text:TextField):void {
			_letterField = text;
		}
		
		public function get answerField():TextField {
			return _answerField;
		}
		public function set answerField(text:TextField):void {
			_answerField = text;
		}
	}

}