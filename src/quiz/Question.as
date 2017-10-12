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
		
	public class Question extends QuizElement
	{
		private var imageLoader:Loader;
		private var imageRequest:URLRequest;
		//These set up the formatting for the various TextFields that are involved in the
		//Question class.
		private var font:String = "Calibri";		
		private var tFormat:TextFormat = new TextFormat(font, 22, 0x330000, false, false, false);
		private var iFormat:TextFormat = new TextFormat(font, 18, 0x330000, false, true, false);
		private var qFormat:TextFormat = new TextFormat(font, 18, 0x330000, false, false, false);
		
		//These are the three TextFields that are involved in the class and an int variable that
		//stores the question number in case it is desired.
		private var _titleField:TextField;
		private var _infoField:TextField;
		private var _questionField:TextField;
		private var _questionID:int;
		
		//placement variables
		private var tHeight:int = 30;
		private var iHeight:int = 100;
		private var qHeight:int = 160;
		
		//The type input will be used when these need to distinguish between text and images.
		public function Question(title:String, text:String, question:String, type:String, id:int) 
		{
			titleField = new TextField();
			infoField = new TextField();
			questionField = new TextField();
			questionID = id;
			
			titleField = TextProperties(title, tFormat, 0, tHeight, 550);
			
			if (type == "image"){
				imageLoader = new Loader();
				imageRequest = new URLRequest("assets/quiz/" + text);
				imageLoader.load(imageRequest);
				addChild(imageLoader);
				imageLoader.x = 10;
				imageLoader.y = 70;
			}
			else {
				infoField = TextProperties(text, iFormat, 0, iHeight, 550);	
			}
			if (type == "image") {
				qHeight = 300;
			}
			if (infoField.text == "" && type != "image") {
				qHeight = iHeight;
			}
			questionField =  TextProperties(question, qFormat, 0, qHeight, 550);

		}
		
		//Get and Set Functions
		public function get titleField():TextField {
			return _titleField;
		}
		public function set titleField(text:TextField):void {
			_titleField = text;
		}
		
		public function get infoField():TextField {
			return _infoField;
		}
		public function set infoField(text:TextField):void {
			_infoField = text;
		}
		
		public function get questionField():TextField {
			return _questionField;
		}
		public function set questionField(text:TextField):void {
			_questionField = text;
		}
		
		public function get questionID():int {
			return _questionID;
		}
		public function set questionID(id:int):void {
			_questionID = id;
		}
		
	}

}