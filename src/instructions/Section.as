package instructions
{	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLRequest;
	import tiles.TileArray;
	import Layout_finalizeButton;
	import util.CustomEvent;
	import ui.Layout;
	import util.DollarsAndCents;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
		
	public class Section extends SectionElement
	{
		[Embed(source = "../../assets/fullmap.png")]
		private static var fullmapClass:Class;
		private static var fullmap:Bitmap = new fullmapClass();
		
		[Embed(source = "../../assets/treatOne/Instructions_Results_Green1.png")]
		private static var summaryGreenClass:Class;
		private static var summaryGreen:Bitmap = new summaryGreenClass();
		
		[Embed(source = "../../assets/treatOne/Instructions_Results_Red1.png")]
		private static var summaryRedClass:Class;
		private static var summaryRed:Bitmap = new summaryRedClass();
		
		[Embed(source = "../../assets/sampleWorkQ.png")]
		private static var sampleWorkClass:Class;
		private static var sampleWork:Bitmap = new sampleWorkClass();
		
		[Embed(source = "../../assets/sampleIQQ.png")]
		private static var sampleIQClass:Class;
		private static var sampleIQ:Bitmap = new sampleIQClass();
		
		[Embed(source = "../../assets/tileKey.png")]
		private static var tileKeyClass:Class;
		private static var tileKey:Bitmap = new tileKeyClass();
		
		private var finalizeButton:Layout_finalizeButton = new Layout_finalizeButton();
		
		
		//These set up the formatting for the various TextFields that are involved in the
		//Section class.
		private var font:String = "Calibri";		
		private var tFormat:TextFormat = new TextFormat(font, 26, 0x330000);
		private var cFormat:TextFormat = new TextFormat(font, 18, null);

		
		//These are the three TextFields that are involved in the class and an int variable that
		//stores the Section number in case it is desired.
		private var _titleField:TextField;
		private var _contentField:TextField;
		private var niceField:TextField;
		private var badField:TextField;
		private var money:DollarsAndCents = new DollarsAndCents(2, 0);
		private var moneyField:TextField;
		private var practiceGrid:TileArray;
		private var oldTotalTiles:int = 0;

		
		//The type input will be used when these need to distinguish between text and images.
		public function Section(title:String, text:String, type:String, width:int) 
		{
			if (type == "fullmap") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				contentField = TextProperties2(text, cFormat, 0, 70, width / 2);
				
				fullmap.x = (width / 2) + 40;
				fullmap.y = 70;
				addChild(fullmap);
				
				// Add the module here (try to make its width, width)
				//tilesz = new TileArray(5, 5);
				//addChild(tilesz);

			}
			
			else if (type == "summaryGreen") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				contentField = TextProperties2(text, cFormat, 0, 70, width / 2);
				
				summaryGreen.x = (width / 2) + 40;
				summaryGreen.y = 70;
				addChild(summaryGreen);
			}
			else if (type == "summaryRed") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				contentField = TextProperties2(text, cFormat, 0, 70, width / 2);
				
				summaryRed.x = (width / 2) + 40;
				summaryRed.y = 70;
				addChild(summaryRed);
			}
			else if (type == "practice1") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				contentField = TextProperties2(text, cFormat, 0, 70, width / 2 + 20);
				
				niceField = new TextField();
				
				badField = new TextField();
				
				finalizeButton.x = (width / 2) + 150;
				finalizeButton.y = 370;
				addChild(finalizeButton);
				
				niceField = TextProperties1("Nice job!", cFormat, (width / 2) + 90, 310, 300);
				niceField.textColor = 0x55AE3A;
				badField = TextProperties1("Please select exactly 5 tiles.", cFormat, (width / 2) + 90, 310, 300);
				badField.textColor = 0xFF0000;
				
				niceField.visible = false;
				badField.visible = false;
				
				practiceGrid = new TileArray(5, 5);
				//practiceGrid.numToSelect = 5;
				practiceGrid.xoffset = 0;
				practiceGrid.yoffset = 0;
				practiceGrid.x = (width / 2) + 50;
				practiceGrid.y = 20;
				addChild(practiceGrid);
				
				finalizeButton.addEventListener(MouseEvent.CLICK, finalizeClicked1);
				

			}
			else if (type == "sampleWork") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				
				contentField = TextProperties2(text, cFormat, 0, 70, width);
				sampleWork.x = 15;
				sampleWork.y = 200;
				addChild(sampleWork);
			}
			else if (type == "sampleIQ") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				
				contentField = TextProperties2(text, cFormat, 0, 70, width);
				sampleIQ.x = 15;
				sampleIQ.y = 200;
				addChild(sampleIQ);
			}
			else if (type == "tileKey") {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				
				contentField = TextProperties2(text, cFormat, 0, 70, width);
				tileKey.x = 200;
				tileKey.y = 300;
				addChild(tileKey);
			}
			else if (type == "practice2") {
				this.addEventListener("practiceFinalized", updateMoney);
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				contentField = TextProperties2(text, cFormat, 0, 70, width / 2 + 20);
				
				finalizeButton.addEventListener(MouseEvent.CLICK, finalizeClicked2);
				
				finalizeButton.x = (width / 2) + 150;
				finalizeButton.y = 370;
				addChild(finalizeButton);

				
				niceField = new TextField();
				moneyField = new TextField();
				badField = new TextField();
				
				moneyField = TextProperties1("Money available: " + money.toString(), cFormat, (width / 2) + 40, 70, 300);
				niceField = TextProperties1("Nice job!", cFormat, (width / 2) + 90, 310, 300);
				niceField.textColor = 0x55AE3A;
				badField = TextProperties1("Please spend exactly $1.20", cFormat, (width / 2) + 90, 310, 300);
				badField.textColor = 0xFF0000;
				
				niceField.visible = false;
				badField.visible = false;
				
				practiceGrid = new TileArray(5, 5);
				practiceGrid.xoffset = 0;
				practiceGrid.yoffset = 0;
				practiceGrid.x = (width / 2) + 50;
				practiceGrid.y = 20;
				addChild(practiceGrid);
				
				
			}
			else {
				titleField = new TextField();
				contentField = new TextField();
				titleField = TextProperties2(title, tFormat, 0, 15, width);
				
				contentField = TextProperties2(text, cFormat, 0, 70, width);
				trace(this.contains(contentField));
			}
		}
		
		private function finalizeClicked1(event:MouseEvent) {
			if (TileArray.totalSelect == 5) {
				niceField.visible = true;
				badField.visible = false;
			}
			else { 
				badField.visible = true;
				niceField.visible = false;
			}
			
		}
		
		private function finalizeClicked2(event:MouseEvent) {
			if (money.dollars == 0 && money.cents == 80) {
				niceField.visible = true;
				badField.visible = false;				
			}
			else { 
				badField.visible = true;
				niceField.visible = false;
			}
			
		}
		
		private function updateMoney(event:CustomEvent) {			
			//var cash:int = TileArray.totalSelect * 20;
			//money.subtract(20);
			if (TileArray.totalSelect > oldTotalTiles && Layout.moneyLeft) {
				money.subtract(20);
			}
			else if (TileArray.totalSelect < oldTotalTiles) {
				money.add(20);
			}
			if (money.dollars == 0 && money.cents < 20) {
				Layout.moneyLeft = false;
			}
			else Layout.moneyLeft = true;
			removeChild(moneyField);
			moneyField = TextProperties1("Money available: " + money.toString(), cFormat, (width / 2) + 40, 70, 300);
			oldTotalTiles = TileArray.totalSelect;
		}
		
		//Get and Set Functions
		public function get titleField():TextField {
			return _titleField;
		}
		public function set titleField(text:TextField):void {
			_titleField = text;
		}
		
		public function get contentField():TextField {
			return _contentField;
		}
		public function set contentField(text:TextField):void {
			_contentField = text;
		}
		
	}

}