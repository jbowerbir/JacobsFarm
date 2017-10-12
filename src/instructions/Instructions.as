package instructions 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import instructions.Section;
	import instructions.StartButton;
	import util.CustomEvent;
	import flash.utils.Timer;
	import com.greensock.TweenLite;

	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Instructions extends Sprite 
	{
		//XML variables:
		//These are used to handle and load the instructions from the supplied XML file.
		private var _source:String;
		private var _instructXML:XML;
		
		//Instructions state variables
		private var _currentSection:int;
		private var currentmax:int;
		private var forwardShown:Array = new Array();
		
		//These keep the next button from being shown until the practices are completed
		public static var practice1:Boolean = true;
		public static var practice2:Boolean = true;
		
		//Components
		private var start:StartButton = new StartButton();
		private var forward:ForwardButton = new ForwardButton();
		private var back:BackButton = new BackButton();
		private var section:Section;
		private var timerlength:int = 1;


		
		public function Instructions(treatment:int):void
		{
			//This loads the XML from the source location and uses two functions:
			//xmlLoaded and xmlLoadError to load it and report the success of the operation.
			instructXML = new XML();
			currentSection = 0;
			currentmax = 1;
			
			switch (treatment)
			{
				case 0: //Treatment 1.0 (Default, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst1.xml");
					break;
				case 1: //Treatment -1.0 (Default, loser)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst-1.xml");
					break;
				case 2: //Treatment 2.0 (IQ, no-corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst2.xml");
					break;
				case 3: //Treatment -2.0 (IQ, no-corr, lose)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst-2.xml");
					break;
				case 4: //Treatment 3.0 (work, no-corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst3.xml");
					break;
				case 5: //Treatment -3.0 (work, no-corr, lose)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst-3.xml");
					break;
				case 6: //Treatment 3.1 (work, +corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst3.xml");
					break;
				case 7: //Treatment -3.1 (work, -corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst-3.xml");
					break;
				case 8: //Treatment 3.2 (work, -corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst3.xml");
					break;
				case 9: //Treatment -3.2 (work, +corr, win)
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst-3.xml");
					break;
				case 10:
					var xmlURL:URLRequest = new URLRequest("instructions_xml/inst4.xml");
					break;
				default:
					trace("Not a valid treatment");
			}
			
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadError);
		}
		
		//Saves the loaded XML data in the quizdata variable and reports success
		private function xmlLoaded(event:Event):void 
		{
			instructXML = XML(event.target.data);	
			sectionLoader();
		
		}
		
		//If there is an error when loading the XML data this reports the error
		private function xmlLoadError(event:IOErrorEvent):void 
		{
			trace(event.text);
		}
		
		private function sectionLoader():void
		{
				var sectionType:String = instructXML.section[currentSection].@type;
				var titleString:String = instructXML.section[currentSection].title.text();
				var contentString:String = instructXML.section[currentSection].content.text();
				section = new Section(titleString, contentString, sectionType, 800);
				
				start.addEventListener(MouseEvent.CLICK, startClicked);
				forward.addEventListener(MouseEvent.CLICK, forwardClicked);
				back.addEventListener(MouseEvent.CLICK, backClicked);
				
				
				if (this.contains(start)) 
				{ 
					this.removeChild(start); 			
				}
				if (this.contains(forward)) 
				{ 
					removeChild(forward);
				}
				if (this.contains(back)) 
				{ 
					removeChild(back);
				}

				
				
				
				if (currentSection == 0)
				{
					this.addChild(section);
					section.x = 100;
					section.y = 50;
									
					this.addChild(start);
					start.x = 300;
					start.y = 275;
				}
				else 
				{	
					this.addChild(section);
					section.x = 100;
					section.y = 50;
					
					this.addChild(forward);
					trace(currentSection);
					trace(currentmax);
					if (currentSection == currentmax && !forwardShown[currentSection - 1]) {
						forward.visible = false;
						forward.alpha = 0;
					}
					else {
						forward.visible = true;
						forward.alpha 1;
					}
					
					forward.x = 765;
					forward.y = 500;
					
					if (currentSection > 1)
					{
						this.addChild(back);
						back.x = 100;
						back.y = 500;
					}
					
				}
				trace(forwardShown[currentSection - 1]);
				//This newPage conditional is to make sure that you only wait on new pages.
				if (currentSection == currentmax && !forwardShown[currentSection - 1]) {
					var waitTimer:Timer = new Timer(timerlength, 1);
					waitTimer.start();
					waitTimer.addEventListener(TimerEvent.TIMER, showForward);
				}
		}
		
		public function showForward(event:TimerEvent):void {
			forward.visible = true;
			forwardShown.push(true);
			TweenLite.to(forward, 1, { alpha:1 } );
		}
		
		public function startClicked(event:MouseEvent):void 
		{
			this.removeChild(section);
			currentSection++;
			
			sectionLoader();
		}
		public function forwardClicked(event:MouseEvent):void 
		{	
			this.removeChild(section);
			if (currentSection == currentmax) {
				currentmax++;
			}
			currentSection++;
			
			if (currentSection < (instructXML.section.length())) 
			{
			sectionLoader();
			}
			else
			{
				this.removeChild(forward);
				this.removeChild(back);
				var eventDone:CustomEvent = new CustomEvent("DONE", true);
				dispatchEvent(eventDone);
			}
		}
		public function backClicked(event:MouseEvent):void 
		{
			this.removeChild(section);
			currentSection--;
			
			sectionLoader();
		}
		
		//Get and set functions for the variables
		
		//XML
		public function get source():String {
			return _source;
		}
		public function set source(newSource:String):void {
			_source = newSource;
		}
		
		public function get instructXML():XML {
			return _instructXML;
		}
		public function set instructXML(newData:XML):void {
			_instructXML = newData;
		}
		
		//State
		public function get currentSection():int {
			return _currentSection;
		}
		public function set currentSection(current:int):void {
			_currentSection = current;
		}
		
	}

}