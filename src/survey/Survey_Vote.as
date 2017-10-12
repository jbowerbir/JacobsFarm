package survey 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import util.CustomEvent;
	import util.Submit;

	//import util.CustomEvent;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Survey_Vote extends Sprite
	{
		//Data variables
		public var responses:Array = new Array();
		public var demoXML:XML;
		
		private var q1Val:int = -9999;
		private var q2Val:int = -9999;
		private var q3Val:String = "No data";
		private var q4Val:int = -9999;
		private var q5Val:String = "No data";
		private var q6Val:int = -9999;
		private var q7Val:int = -9999;
		
		//Button groups
		private var q1Group:RadioButtonGroup;
		private var q2Group:RadioButtonGroup;
		private var q3Field:TextField;
		private var q4Group:RadioButtonGroup;
		private var q5Field:TextField;
		private var q6Group:RadioButtonGroup;
		private var q7Group:RadioButtonGroup;
		
		
		private var questions:Array = new Array();
		
		//Text formatting variables
		private var font:String = "Calibri";		
		private var tFormat:TextFormat = new TextFormat(font, 26, 0x330000);
		private var cFormat:TextFormat = new TextFormat(font, 18, null);
		private var vFormat:TextFormat = new TextFormat(font, 16, null);
		
		//Images
		private var rankingImage:Bitmap;
		
		[Embed(source = "../../assets/FinalResults_Lose_Corr.png")]
		private static var loseCorrClass:Class;
		
		[Embed(source = "../../assets/FinalResults_Lose_NoCorr.png")]
		private static var loseNoCorrClass:Class;
		
		[Embed(source = "../../assets/FinalResults_Lose_NoWork.png")]
		private static var loseNoWorkClass:Class;
		
		[Embed(source = "../../assets/FinalResults_Win_Corr.png")]
		private static var winCorrClass:Class;
		
		[Embed(source = "../../assets/FinalResults_Win_NoCorr.png")]
		private static var winNoCorrClass:Class;
		
		[Embed(source = "../../assets/FinalResults_Win_NoWork.png")]
		private static var winNoWorkClass:Class;
		
		
		//Text and question components
		private var page1:Page = new Page();
		private var page2:Page = new Page();
		private var page3:Page = new Page();
		private var page4:Page = new Page();
		private var pageFinal:Page = new Page();
		
		private var currentPage:int;
		private var forward:ForwardButton = new ForwardButton();
		private var disabledForward:DisabledForward = new DisabledForward();
		private var back:BackButton = new BackButton();
		private var submit:SubmitButton = new SubmitButton();
		
		private var titleField:TextField;
		private var errorField:TextField;
		private var votingField:TextField;
		private var bOffset:int = 25;
		
		//This ensures that the participant will be notified of any unanswered questions
		//AND be able to still submit if they want.
		private var answeredWarning:Boolean = true;
		
		//This boolean is responsible for making the second vote question appear
		private var redistribute:Boolean = false;
		
		//This ensures that the next button appears after a 15 second delay
		private var nextTimer:Timer;		
		private var maxPageVisited:int = 1;
		
		private function showNextButton(event:TimerEvent):void {
			disabledForward.visible = false;
			forward.visible = true;
			nextTimer.reset();
		}
		
		public function Survey_Vote(treatment:int):void 
		{
			this.graphics.beginFill(0xffffff, 1);
			this.graphics.drawRect(0, 0, 1000, 700);
			this.graphics.endFill();
			switch (treatment)
			{
				case 0: //1.0
					rankingImage = new winNoWorkClass;
					break;
				case 1: //-1.0
					rankingImage = new loseNoWorkClass;
					break;
				case 2: //2.0
					switch(Main.global_work_display_toggle)
					{
						case 0:
							rankingImage = new winNoWorkClass;
							break;
						case 1:
							rankingImage = new winCorrClass;
							break;
						case -1:
							rankingImage = new winNoCorrClass;
							break;
					}
					break;
				case 3: //-2.0
					rankingImage = new loseNoWorkClass;
					break;
				case 4: //3.0
					rankingImage = new winNoWorkClass;
					break;
				case 5: //-3.0
					rankingImage = new loseNoWorkClass;
					break;
				case 6: //3.1
					rankingImage = new winCorrClass;
					break;
				case 7: //-3.1
					rankingImage = new loseCorrClass;
					break;
				case 8: //3.2
					rankingImage = new winNoCorrClass;
					break;
				case 9: //-3.2
					rankingImage = new loseNoCorrClass;
					break;
				case 10:
					rankingImage = new winNoWorkClass;
					break;
				default:
					trace("Not a valid treatment");
			}
			currentPage = 1;
			
			//submit.addEventListener(MouseEvent.CLICK, submitClicked);
			forward.addEventListener(MouseEvent.CLICK, forwardClicked);
			back.addEventListener(MouseEvent.CLICK, backClicked);
			
			//Load the question data from XML
			demoXML = new XML();
			var xmlURL:URLRequest = new URLRequest("survey_vote.xml");
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadError);
					
		}
		
		private function demoLoader():void {
			for (var i:int = 0; i < demoXML.item.length(); i++) {
				questions.push((i+1)+".  " + demoXML.item[i].question.text());
			}
			
			var waitTime:int = int(demoXML.config.waitTime.text());
			nextTimer = new Timer(waitTime);
			nextTimer.addEventListener(TimerEvent.TIMER, showNextButton);
			
			addChild(rankingImage);
			rankingImage.x = 350;
			rankingImage.y = 15;
			
			addChild(forward);
			addChild(disabledForward);
			addChild(back);
			addChild(submit);
			
			forward.x = 840;
			forward.y = 620;
			forward.visible = false;
			
			disabledForward.x = 840;
			disabledForward.y = 620;
			disabledForward.mouseEnabled = false;
			disabledForward.visible = true;
			
			back.x = 15;
			back.y = 620;
			back.visible = false;
			
			submit.x = 380;
			submit.y = 330;
			submit.visible = false;
			
			addChild(page1);
			addChild(page2);
			addChild(page3);
			addChild(page4);
			addChild(pageFinal);
			
			page2.visible = false;
			page3.visible = false;
			page4.visible = false;
			pageFinal.visible = false;
			
			titleField = new TextField();
			titleField = TextProperties2("End Game Survey", tFormat, 15, 15, 235);
			addChild(titleField);
			
			//Page 1 Questions
			nextTimer.start();
			
			//Question 1
				var question1Field:TextField = new TextField();				
				question1Field = TextProperties2(questions[0], cFormat, 30, 60, 400);
				page1.addChild(question1Field);
				
				q1Group = new RadioButtonGroup("q1Group");
				
				var q1responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[0].responses.response.length(); i++) {
					q1responses.push(demoXML.item[0].responses.response[i].text());
				}
				
				var q1_1Radio:RadioButton = RBFormat(q1responses[0], 60, question1Field.y + 45, q1Group,1, 300);
				var q1_2Radio:RadioButton = RBFormat(q1responses[1], 60, q1_1Radio.y + bOffset, q1Group,2, 300); 
				var q1_3Radio:RadioButton = RBFormat(q1responses[2], 60, q1_2Radio.y + bOffset, q1Group,3, 300); 
				var q1_4Radio:RadioButton = RBFormat(q1responses[3], 60, q1_3Radio.y + bOffset, q1Group,4, 300); 
				var q1_5Radio:RadioButton = RBFormat(q1responses[4], 60, q1_4Radio.y + bOffset, q1Group,5, 300); 
							
				page1.addChild(q1_1Radio);
				page1.addChild(q1_2Radio);
				page1.addChild(q1_3Radio);
				page1.addChild(q1_4Radio);
				page1.addChild(q1_5Radio);
				
			//Question 2:
				var question2Field:TextField = new TextField();				
				question2Field = TextProperties2(questions[1], cFormat, 40, q1_5Radio.y + 35, 400);
				page1.addChild(question2Field);
				
				q2Group = new RadioButtonGroup("q2Group");
				
				var q2responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[1].responses.response.length(); i++) {
					q2responses.push(demoXML.item[1].responses.response[i].text());
				}
				
				var q2_1Radio:RadioButton = RBFormat(q2responses[0], 60, question2Field.y + 55, q2Group,1, 300);
				var q2_2Radio:RadioButton = RBFormat(q2responses[1], 60, q2_1Radio.y + bOffset, q2Group,2, 300); 
				var q2_3Radio:RadioButton = RBFormat(q2responses[2], 60, q2_2Radio.y + bOffset, q2Group,3, 300); 
				var q2_4Radio:RadioButton = RBFormat(q2responses[3], 60, q2_3Radio.y + bOffset, q2Group,4, 300); 
				var q2_5Radio:RadioButton = RBFormat(q2responses[4], 60, q2_4Radio.y + bOffset, q2Group,5, 300); 
							
				page1.addChild(q2_1Radio);
				page1.addChild(q2_2Radio);
				page1.addChild(q2_3Radio);
				page1.addChild(q2_4Radio);
				page1.addChild(q2_5Radio);
				
			//Question 3:
				var question3Field:TextField = new TextField();				
				question3Field = TextProperties2(questions[2], cFormat, 40, q2_5Radio.y + 40, 800);
				page1.addChild(question3Field);
				
				q3Field = new TextField();
				var typehere:String = "Please type your response here.";
				q3Field.border = true;
				q3Field.text = typehere;
				q3Field.x = 60;
				q3Field.y = question3Field.y + 90;
				q3Field.width = 500;
				q3Field.height = 150;
				q3Field.wordWrap = true;
				q3Field.type = TextFieldType.INPUT;
				q3Field.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 

				page1.addChild(q3Field);
				
			
			//Question 4
				var question4Field:TextField = new TextField();				
				question4Field = TextProperties2(questions[3], cFormat, 35, 90, 400);
				page2.addChild(question4Field);
				
				q4Group = new RadioButtonGroup("q4Group");
				
				var q4responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[3].responses.response.length(); i++) {
					q4responses.push(demoXML.item[3].responses.response[i].text());
				}
				
				var q4_1Radio:RadioButton = RBFormat(q4responses[0], 60, question4Field.y + 35, q4Group,1, 300);
				var q4_2Radio:RadioButton = RBFormat(q4responses[1], 60, q4_1Radio.y + bOffset, q4Group,2, 300); 
				var q4_3Radio:RadioButton = RBFormat(q4responses[2], 60, q4_2Radio.y + bOffset, q4Group,3, 300); 
				var q4_4Radio:RadioButton = RBFormat(q4responses[3], 60, q4_3Radio.y + bOffset, q4Group,4, 300); 
				var q4_5Radio:RadioButton = RBFormat(q4responses[4], 60, q4_4Radio.y + bOffset, q4Group,5, 300); 
							
				page2.addChild(q4_1Radio);
				page2.addChild(q4_2Radio);
				page2.addChild(q4_3Radio);
				page2.addChild(q4_4Radio);
				page2.addChild(q4_5Radio);
				
			//Question 5:
				var question5Field:TextField = new TextField();				
				question5Field = TextProperties2(questions[4], cFormat, 40, q4_5Radio.y + 40, 400);
				page2.addChild(question5Field);
				
				q5Field = new TextField();
				q5Field.border = true;
				q5Field.text = typehere;
				q5Field.x = 60;
				q5Field.y = question5Field.y + 80;
				q5Field.width = 500;
				q5Field.height = 150;
				q5Field.wordWrap = true;
				q5Field.type = TextFieldType.INPUT;
				q5Field.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 

				page2.addChild(q5Field);
				
			//VOTING
			//VOTING
			//VOTING
			
			votingField = new TextField();
			votingField = TextProperties3(demoXML.vote.text(), vFormat, 50, 300, 900);
			page3.addChild(votingField);
				
			//Question 6:
				var question6Field:TextField = new TextField();				
				question6Field = TextProperties2(questions[5], cFormat, 50, 520, 800);
				page3.addChild(question6Field);
				
				q6Group = new RadioButtonGroup("q6Group");
				
				var q6responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[5].responses.response.length(); i++) {
					q6responses.push(demoXML.item[5].responses.response[i].text());
				}
				
				var q6_1Radio:RadioButton = RBFormat(q6responses[0], 60, question6Field.y + 30, q6Group, 1, 300);
				var q6_2Radio:RadioButton = RBFormat(q6responses[1], 60, q6_1Radio.y + bOffset, q6Group, 2, 300); 
				
				page3.addChild(q6_1Radio);
				page3.addChild(q6_2Radio);
				
			//Question 7:
				var question7Field:TextField = new TextField();				
				question7Field = TextProperties2(questions[6], cFormat, 40, 300, 800);
				page4.addChild(question7Field);
				
				q7Group = new RadioButtonGroup("q7Group");
				
				var q7responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[6].responses.response.length(); i++) {
					q7responses.push(demoXML.item[6].responses.response[i].text());
				}				
				var q7_1Radio:RadioButton = RBFormat(q7responses[0], 60, question7Field.y + 40, q7Group, 1, 700);
				var q7_2Radio:RadioButton = RBFormat(q7responses[1], 60, q7_1Radio.y + bOffset, q7Group, 2, 700); 
				
				page4.addChild(q7_1Radio);
				page4.addChild(q7_2Radio);
				
			
				
			//Final Screen:
				var thxText:String = "Please press the submit button below to cast your vote.";
				var thanksField:TextField = new TextField();				
				thanksField = TextProperties2(thxText, cFormat, 250, 150, 800);
				
				pageFinal.addChild(thanksField);
				pageFinal.addChild(submit);
				
				var errorText:String = "Caution: It seems that you have left some questions unanswered.  Feel free to go back and answer them if you would like, otherwise click \"Submit\" again when you are ready.";
				errorField = new TextField();				
				errorField = TextProperties2(errorText, cFormat, 60, 200, 800);
				errorField.textColor = 0xFF0000;
				pageFinal.addChild(errorField);
				errorField.visible = false;
				
		}
		
		public function textInputCapture(event:TextEvent):void 
        { 
            var str3:String = q3Field.text; 
			var str5:String = q5Field.text;
            q3Val = str3;
			q5Val = str5;
        } 
		
		public function forwardClicked(event:MouseEvent):void 
		{	
			switch(currentPage) {
				case 1:
					page1.visible = false;
					page2.visible = true;
					back.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}
					break;
				case 2:
					page2.visible = false;
					rankingImage.x = 170;
					rankingImage.y = 50;
					
					
					submitSurvey();
					//^^^^^^^^^^^
					/*CHANGE THAT TOTALLY ALTERS THE COURSE OF THE END SURVEY BJC 01/02/2014*/
					
					//page3.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}
					break;
				case 3:
					page3.visible = false;				
					if (int(q6Group.selectedData) == 2) {
						page4.visible = true;
						currentPage++;
					}
					else {
						pageFinal.visible = true;
						submit.visible = true;
						rankingImage.visible = false;
						forward.visible = false;
						currentPage = currentPage + 2;
					}
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}
					break;
				case 4:
					page4.visible = false;
					pageFinal.visible = true;
					currentPage++;
					rankingImage.visible = false;
					forward.visible = false;
					submit.visible = true;
					break;
				
			}
		}
		
		public function backClicked(event:MouseEvent):void 
		{
			switch(currentPage) {
				case 5:
					pageFinal.visible = false;
					if (int(q6Group.selectedData) == 2) {
						page4.visible = true;
						currentPage--;
					}
					else {
						page3.visible = true;
						currentPage = currentPage - 2;
					}
					rankingImage.visible = true;
					forward.visible = true;
					submit.visible = false;
					errorField.visible = false;
					break;
				case 4:
					page4.visible = false;
					page3.visible = true;
					currentPage--;
					break;
					
				case 3:
					page3.visible = false;
					page2.visible = true;
					currentPage--;
					rankingImage.x = 350;
					rankingImage.y = 15;
					break;
				case 2:
					page2.visible = false;
					page1.visible = true;
					currentPage--;
					back.visible = false;
					break;
				
			}
		}
		
		public function submitSurvey():void 
		{
			//Check to see if all questions are answered: JK
			/*var unansweredQ:Boolean = ((q1Group.selection == null) || (q2Group.selection == null) || (q4Group.selection == null)
									|| (q6Group.selection == null) || ((q7Group.selection == null) && (q6Group.selectedData == 2)));
			if (unansweredQ && answeredWarning) {
				errorField.visible = true;
				answeredWarning = false;
			}*/
			//else {
				
				//This big block of ifs sets the value of each question if the value is non-null, otherwise the value
				//remains -9999
				if (q1Group.selectedData) {
					q1Val = int(q1Group.selectedData);
				}
				if (q2Group.selectedData) {
					q2Val = int(q2Group.selectedData);
				}
				/*if (q3Group.selectedData) {
					q3Val = int(q3Group.selectedData);
				}*/
				if (q4Group.selectedData) {
					q4Val = int(q4Group.selectedData);
				}
				/*if (q5Group.selectedData) {
					q5Val = int(q5Group.selectedData);
				}*/
				if (q6Group.selectedData) {
					q6Val = int(q6Group.selectedData);
				}
				if (q7Group.selectedData) {
					q7Val = int(q7Group.selectedData);
				}
				
				// lol the second message wasn't getting grabbed correctly, so let's get it again
					var str5:String = q5Field.text;
					q5Val = str5;
				
				//Now add each question value to the responses array
				responses.push(q1Val);
				responses.push(q2Val);
				responses.push(q3Val);
				responses.push(q4Val);
				responses.push(q5Val);
				responses.push(q6Val);
				responses.push(q7Val);
				
				
				/*if (responses.length == 7) {
					var successText:String = "Your score was successfully submitted!";
					errorField.text = successText;
					errorField.textColor = 0x55AE3A;				
					errorField.visible = true;
				}*/
				trace(responses);
				Submit.addVoteArray(responses);
				var goToRedistibute = new CustomEvent("REDISTRIBUTE", true);
				dispatchEvent(goToRedistibute);
				//var endSurvey = new CustomEvent("surveyFinished", true);
				//dispatchEvent(endSurvey);
				
			//}
		}
		
		//TextProperties2 allows for quick formatting and placement of TextFields
		public function TextProperties2(text:String, format:TextFormat, x:Number, y:Number, width:Number):TextField
		{
			format.leftMargin = 0;
			format.rightMargin = 0;
			format.blockIndent = 0;
			format.indent = 0;
						
			var field:TextField = new TextField();
			field.x = x;
			field.y = y;
			field.width = width;
			field.text = text;
			field.setTextFormat(format);
			field.selectable = false;
			field.multiline = true;
			field.wordWrap = true;
			return field;
		
		} 
		
		public function TextProperties3(text:String, format:TextFormat, x:Number, y:Number, width:Number):TextField
		{
			format.leftMargin = 0;
			format.rightMargin = 0;
			format.blockIndent = 0;
			format.indent = 0;
						
			var field:TextField = new TextField();
			field.x = x;
			field.y = y;
			field.width = width;
			field.height = 340;
			field.htmlText = text;
			field.setTextFormat(format);
			field.selectable = false;
			field.multiline = true;
			field.wordWrap = true;
			return field;
		
		} 
		
		public function RBFormat(text:String, x:int, y:int, group:RadioButtonGroup, value:int,  width:Number):RadioButton
		{
			var button:RadioButton = new RadioButton();
			var format:TextFormat = new TextFormat();
			format.font = "Calibri";
			format.size = 16;
			
			button.label = text;
			button.width = width;
			button.textField.width = width;
			button.textField.setTextFormat(format);
			button.x = x;
			button.y = y;
			button.group = group;
			button.value = value;
			button.setStyle("textFormat", format);
			return button;
		
		} 
		private function xmlLoaded(event:Event):void 
		{
			demoXML = XML(event.target.data);
			demoLoader();
		
		}
		
		//If there is an error when loading the XML data this reports the error
		private function xmlLoadError(event:IOErrorEvent):void 
		{
			trace(event.text);
		}
		
		
		
	}

}