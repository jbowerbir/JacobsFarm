package quiz
{
	/**
	 * ...
	 * @author 
	 */
	public class TextProperties 
	{
		
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