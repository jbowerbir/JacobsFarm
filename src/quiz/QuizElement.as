package quiz
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 * This class is the basis for all of the elements that are present in the quiz.
	 * It includes the TextProperties function to make the formatting of textfields
	 * more streamlined.
	 */
		
	public class QuizElement extends Sprite 
	{
		
		public function QuizElement() 
		{
			
		}
		
		//This function makes it simpler to setup TextFields with some commonly used settings.
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
		
		} 
		
	}

}