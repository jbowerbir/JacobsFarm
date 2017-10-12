package start_the_game 
{
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import util.CustomEvent;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class StartGame extends Sprite
	{
		//XML variables:
		//These are used to handle and load the instructions from the supplied XML file.
		private var startGameXML:XML;
		
		private var message:String;
		private var font:String = "Calibri";		
		private var cFormat:TextFormat = new TextFormat(font, 18, null);
		private var contentField:TextField = new TextField();
		private var continue_button:ContinueButton = new ContinueButton();
		
		public function StartGame(quiz_type:String) 
		{
			//Load the question data from XML
			startGameXML = new XML();
			var xmlURL:URLRequest;
			
			
			
		if (quiz_type == "IQ") {
			//message = "The game has begun.  Before going to the grid where you can buy cells, you have an opportunity to learn something about the value of cells.  When you hit the \"Continue\" button, you will be taken to an intelligence (IQ) test.  Some players will naturally do very well.  Others will struggle with the questions.  The more questions you answer correctly, the more information you get about the grid, the better your chances of making money.";
			xmlURL = new URLRequest("start_game_iq.xml");
			}
		else if (quiz_type == "HARD_WORK") {
			//message = "The game has begun.  Before going to the grid where you can buy cells, you have an opportunity to learn something about the value of cells.  When you hit the \"Continue\" button, you will be taken to a test that lasts as long as you want it to.  The questions require no special skill or knowledge; just patience and hard work.  The more questions you answer correctly, the more information you get about the grid, the better your chances of making money.  You can stop answering questions whenever you like by hitting the \"Exit\" button.";
			xmlURL = new URLRequest("start_game_hardwork.xml");
			}
		else if (quiz_type == "4.0") {
			xmlURL = new URLRequest("start_game_random.xml");
		}
		else {
			//message = "The game has begun.  Press \"Continue\" to begin.";
			xmlURL = new URLRequest("start_game_noquiz.xml");
		}
		
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadError);
		}
		
		public function startGameLoader():void {
			message = startGameXML.message[0].text();
			trace(message);
		continue_button.addEventListener(MouseEvent.CLICK, continueClicked);
		
		contentField = TextProperties2(message, cFormat, 0, 70, 800);
		contentField.x = 100;
		contentField.y = 150;
		
		addChild(continue_button);
		continue_button.x = 765;
		continue_button.y = 500;
		}
		
		public function continueClicked(event:MouseEvent):void 
		{	
			{
				var continueWasClicked:CustomEvent = new CustomEvent("CONTINUE_WAS_CLICKED", true);
				dispatchEvent(continueWasClicked);
			}
		}
		
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
		
		private function xmlLoaded(event:Event):void 
		{
			startGameXML = XML(event.target.data);
			startGameLoader();
		
		}
		
		//If there is an error when loading the XML data this reports the error
		private function xmlLoadError(event:IOErrorEvent):void 
		{
			trace(event.text);
		}
		
	}

}