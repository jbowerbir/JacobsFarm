package instructions
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Tim Downey
	 * This class is the basis for all of the elements that make up the instructions.
	 * It includes the TextProperties function to make the formatting of textfields
	 * more streamlined.  This class accepts html formatted text.
	 */
		
	public class SectionElement extends Sprite 
	{
		
		public function SectionElement() 
		{
			
		}
		
		//This function makes it simpler to setup TextFields with some commonly used settings.
		public function TextProperties2(text:String, format:TextFormat, x:Number, y:Number, width:Number):TextField
		{
			format.leftMargin = 5;
			format.rightMargin = 5;
			format.blockIndent = 0;
			format.indent = 0;
			
			//var css:StyleSheet = new StyleSheet();
			//css.setStyle("p",{textIndent:0} );
			
			var field:TextField = new TextField();
			field.x = x;
			field.y = y;
			field.width = width;
			field.htmlText = text;
			//field.text = text;
			//field.styleSheet = css;
			field.setTextFormat(format);
			field.selectable = false;
			field.multiline = true;
			field.wordWrap = true;
			field.autoSize = "left";
			field.border = true;
			field.borderColor = 0xDCDCDC;
			field.background = true;
			field.backgroundColor = 0xF5F5F5;
			addChild(field);
			return field;
		
		} 
		
		public function TextProperties1(text:String, format:TextFormat, x:Number, y:Number, width:Number):TextField
		{
			format.leftMargin = 5;
			format.rightMargin = 5;
			format.blockIndent = 0;
			format.indent = 0;
			
			//var css:StyleSheet = new StyleSheet();
			//css.setStyle("p",{textIndent:0} );
			
			var field:TextField = new TextField();
			field.x = x;
			field.y = y;
			field.width = width;
			field.htmlText = text;
			//field.text = text;
			//field.styleSheet = css;
			field.setTextFormat(format);
			field.selectable = false;
			field.multiline = true;
			field.wordWrap = true;
			field.autoSize = "left";
			addChild(field);
			return field;
		
		} 
		
	}

}