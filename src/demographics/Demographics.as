package demographics 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import fl.controls.ComboBox;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import util.CustomEvent;
	import util.Submit;

	//import util.CustomEvent;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Demographics extends Sprite
	{
		//Data variables
		public var responses:Array = new Array();
		public var demoXML:XML;
		
		private var q1Val:int = -9999;
		private var q2Val:int = -9999;
		private var q3Val:int = -9999;
		private var q4Val:int = -9999;
		private var q5Val:int = -9999;
		private var q6Val:int = -9999;
		private var q7Val:int = -9999;
		private var q8Val:int = -9999;
		private var q9Val:int = -9999;
		private var q10Val:int = -9999;
		private var q11Val:int = -9999;
		private var q12Val:int = -9999;
		private var q13Val:int = -9999;
		private var q14Val:int = -9999;
		private var q15Val:int = -9999;
		private var q16Val:int = -9999;
		
		//Button groups
		private var q1Combo:ComboBox;
		private var q2Group:RadioButtonGroup;
		private var q3Group:RadioButtonGroup;
		private var q4Group:RadioButtonGroup;
		private var q5Group:RadioButtonGroup;
		private var q6Group:RadioButtonGroup;
		private var q7Group:RadioButtonGroup;
		private var q8Group:RadioButtonGroup;
		private var q9Group:RadioButtonGroup;
		private var q10Group:RadioButtonGroup;
		private var q11Group:RadioButtonGroup;
		private var q12Group:RadioButtonGroup;
		private var q13Group:RadioButtonGroup;
		private var q14Group:RadioButtonGroup;
		private var q15Group:RadioButtonGroup;
		private var q16Group:RadioButtonGroup;
		
		
		private var questions:Array = new Array();
		
		//Text formatting variables
		private var font:String = "Calibri";		
		private var tFormat:TextFormat = new TextFormat(font, 26, 0x330000);
		private var cFormat:TextFormat = new TextFormat(font, 18, null);
		
		//Text and question components
		private var page1:Page = new Page();
		private var page2:Page = new Page();
		private var page3:Page = new Page();
		private var page4:Page = new Page();
		private var page5:Page = new Page();
		private var page6:Page = new Page();
		private var page7:Page = new Page();
		private var pageFinal:Page = new Page();
		
		private var currentPage:int;
		private var forward:ForwardButton = new ForwardButton();
		private var disabledForward:DisabledForward = new DisabledForward();
		private var back:BackButton = new BackButton();
		private var submit:SubmitButton = new SubmitButton();
		
		private var titleField:TextField;
		private var errorField:TextField;
		private var bOffset:int = 25;
		
		//This ensures that the participant will be notified of any unanswered questions
		//AND be able to still submit if they want.
		private var answeredWarning:Boolean = true;
		
		//This ensures that the next button appears after a 15 second delay
		private var nextTimer:Timer;		
		private var maxPageVisited:int = 1;
		
		private function showNextButton(event:TimerEvent):void {
			disabledForward.visible = false;
			forward.visible = true;
			nextTimer.reset();
		}
		
		public function Demographics() 
		{
			this.graphics.beginFill(0xffffff, 1);
			this.graphics.drawRect(0, 0, 1000, 700);
			this.graphics.endFill();
			currentPage = 1;
			
			submit.addEventListener(MouseEvent.CLICK, submitClicked);
			forward.addEventListener(MouseEvent.CLICK, forwardClicked);
			back.addEventListener(MouseEvent.CLICK, backClicked);
			
			//Load the question data from XML
			demoXML = new XML();
			var xmlURL:URLRequest = new URLRequest("demographics.xml");
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadError);
					
		}
		
		private function demoLoader() {
			for (var i:int = 0; i < demoXML.item.length(); i++) {
				questions.push((i+1)+".  " + demoXML.item[i].question.text());
			}
			
			var waitTime:int = int(demoXML.config.waitTime.text());
			nextTimer = new Timer(waitTime);
			nextTimer.addEventListener(TimerEvent.TIMER, showNextButton);
			
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
			addChild(page5);
			addChild(page6);
			addChild(page7);
			addChild(pageFinal);
			
			page2.visible = false;
			page3.visible = false;
			page4.visible = false;
			page5.visible = false;
			page6.visible = false;
			page7.visible = false;
			pageFinal.visible = false;
			
			titleField = new TextField();
			titleField = TextProperties2("Demographic Survey", tFormat, 15, 15, 235);
			addChild(titleField);
			
			//Page 1 Questions
			nextTimer.start();
			
			//Question 1
				var question1Field:TextField = new TextField();				
				question1Field = TextProperties2(questions[0], cFormat, 40, 70, 700);
				page1.addChild(question1Field);
				
				q1Combo = new ComboBox();
				//Populate the ComboBox with possible ages
				q1Combo.addItem( { label:"" } );
				for (var i:int = 1; i < 100; i++) {
					if (i == 1) {
						q1Combo.addItem({label:i + " year old."});
					}
					else q1Combo.addItem({label:i + " years old."});
				}
				page1.addChild(q1Combo);
				var comboFormat:TextFormat = new TextFormat("Calibri", 16);
				q1Combo.selectedIndex = 0;
				q1Combo.setStyle("embedFonts", true);
				q1Combo.setStyle("textFormat", comboFormat);
				q1Combo.x = 60;
				q1Combo.y = 110;
				
			//Question 2:
				var question2Field:TextField = new TextField();				
				question2Field = TextProperties2(questions[1], cFormat, 40, 160, 800);
				page1.addChild(question2Field);
				
				q2Group = new RadioButtonGroup("q2Group");
				
				var q2responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[1].responses.response.length(); i++) {
					q2responses.push(demoXML.item[1].responses.response[i].text());
				}
				
				var q2_1Radio:RadioButton = RBFormat(q2responses[0], 60, question2Field.y + 70, q2Group,1, 300);
				var q2_2Radio:RadioButton = RBFormat(q2responses[1], 60, q2_1Radio.y + bOffset, q2Group,2, 300); 
				var q2_3Radio:RadioButton = RBFormat(q2responses[2], 60, q2_2Radio.y + bOffset, q2Group,3, 300); 
				var q2_4Radio:RadioButton = RBFormat(q2responses[3], 60, q2_3Radio.y + bOffset, q2Group,4, 300); 
				var q2_5Radio:RadioButton = RBFormat(q2responses[4], 60, q2_4Radio.y + bOffset, q2Group,5, 300); 
				var q2_6Radio:RadioButton = RBFormat(q2responses[5], 60, q2_5Radio.y + bOffset, q2Group,6, 300); 
							
				page1.addChild(q2_1Radio);
				page1.addChild(q2_2Radio);
				page1.addChild(q2_3Radio);
				page1.addChild(q2_4Radio);
				page1.addChild(q2_5Radio);
				page1.addChild(q2_6Radio);
				
			//Question 3:
				var question3Field:TextField = new TextField();				
				question3Field = TextProperties2(questions[2], cFormat, 40, q2_6Radio.y + 40, 800);
				page1.addChild(question3Field);
				
				q3Group = new RadioButtonGroup("q3Group");
				
				var q3responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[2].responses.response.length(); i++) {
					q3responses.push(demoXML.item[2].responses.response[i].text());
				}
				
				var q3_1Radio:RadioButton = RBFormat(q3responses[0], 60, question3Field.y + 40, q3Group, 1, 300);
				var q3_2Radio:RadioButton = RBFormat(q3responses[1], 60, q3_1Radio.y + bOffset, q3Group, 2, 300); 
				var q3_3Radio:RadioButton = RBFormat(q3responses[2], 60, q3_2Radio.y + bOffset, q3Group, 3, 300); 
				var q3_4Radio:RadioButton = RBFormat(q3responses[3], 60, q3_3Radio.y + bOffset, q3Group, 4, 300); 

				page1.addChild(q3_1Radio);
				page1.addChild(q3_2Radio);
				page1.addChild(q3_3Radio);
				page1.addChild(q3_4Radio);
				
			
			//Question 4:
				var question4Field:TextField = new TextField();				
				question4Field = TextProperties2(questions[3], cFormat, 40, 70, 800);
				page2.addChild(question4Field);
				
				q4Group = new RadioButtonGroup("q4Group");
				
				var q4responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[3].responses.response.length(); i++) {
					q4responses.push(demoXML.item[3].responses.response[i].text());
				}
				
				var q4_1Radio:RadioButton = RBFormat(q4responses[0], 60, question4Field.y + 40, q4Group, 1, 300);
				var q4_2Radio:RadioButton = RBFormat(q4responses[1], 60, q4_1Radio.y + bOffset, q4Group, 2, 300); 
				var q4_3Radio:RadioButton = RBFormat(q4responses[2], 60, q4_2Radio.y + bOffset, q4Group, 3, 300); 
				var q4_4Radio:RadioButton = RBFormat(q4responses[3], 60, q4_3Radio.y + bOffset, q4Group, 4, 300); 
				
				page2.addChild(q4_1Radio);
				page2.addChild(q4_2Radio);
				page2.addChild(q4_3Radio);
				page2.addChild(q4_4Radio);
				
			//Question 5:
				var question5Field:TextField = new TextField();				
				question5Field = TextProperties2(questions[4], cFormat, 40, q4_4Radio.y + 40, 800);
				page2.addChild(question5Field);
				
				q5Group = new RadioButtonGroup("q5Group");
				
				var q5responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[4].responses.response.length(); i++) {
					q5responses.push(demoXML.item[4].responses.response[i].text());
				}				
				var q5_1Radio:RadioButton = RBFormat(q5responses[0], 60, question5Field.y + 40, q5Group, 1, 300);
				var q5_2Radio:RadioButton = RBFormat(q5responses[1], 60, q5_1Radio.y + bOffset, q5Group, 2, 300); 
				var q5_3Radio:RadioButton = RBFormat(q5responses[2], 60, q5_2Radio.y + bOffset, q5Group, 3, 300); 
				var q5_4Radio:RadioButton = RBFormat(q5responses[3], 60, q5_3Radio.y + bOffset, q5Group, 4, 300); 
				var q5_5Radio:RadioButton = RBFormat(q5responses[4], 60, q5_4Radio.y + bOffset, q5Group, 5, 300); 
				var q5_6Radio:RadioButton = RBFormat(q5responses[5], 60, q5_5Radio.y + bOffset, q5Group, 6, 300);
				var q5_7Radio:RadioButton = RBFormat(q5responses[6], 60, q5_6Radio.y + bOffset, q5Group, 7, 300);
				
				page2.addChild(q5_1Radio);
				page2.addChild(q5_2Radio);
				page2.addChild(q5_3Radio);
				page2.addChild(q5_4Radio);
				page2.addChild(q5_5Radio);
				page2.addChild(q5_6Radio);
				page2.addChild(q5_7Radio);
				
			//Question 6:
				var question6Field:TextField = new TextField();				
				question6Field = TextProperties2(questions[5], cFormat, 40, 70, 800);
				page3.addChild(question6Field);
				
				q6Group = new RadioButtonGroup("q6Group");
				
				var q6responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[5].responses.response.length(); i++) {
					q6responses.push(demoXML.item[5].responses.response[i].text());
				}
				
				var q6_1Radio:RadioButton = RBFormat(q6responses[0], 60, question6Field.y + 40, q6Group, 1, 300);
				var q6_2Radio:RadioButton = RBFormat(q6responses[1], 60, q6_1Radio.y + bOffset, q6Group, 2, 300); 
				
				page3.addChild(q6_1Radio);
				page3.addChild(q6_2Radio);
				
			//Question 7:
				var question7Field:TextField = new TextField();				
				question7Field = TextProperties2(questions[6], cFormat, 40, q6_2Radio.y + 40, 800);
				page3.addChild(question7Field);
				
				q7Group = new RadioButtonGroup("q7Group");
				
				var q7responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[6].responses.response.length(); i++) {
					q7responses.push(demoXML.item[6].responses.response[i].text());
				}				
				var q7_1Radio:RadioButton = RBFormat(q7responses[0], 60, question7Field.y + 40, q7Group, 1, 300);
				var q7_2Radio:RadioButton = RBFormat(q7responses[1], 60, q7_1Radio.y + bOffset, q7Group, 2, 300); 
				var q7_3Radio:RadioButton = RBFormat(q7responses[2], 60, q7_2Radio.y + bOffset, q7Group, 3, 300); 
				var q7_4Radio:RadioButton = RBFormat(q7responses[3], 60, q7_3Radio.y + bOffset, q7Group, 4, 300); 
				var q7_5Radio:RadioButton = RBFormat(q7responses[4], 60, q7_4Radio.y + bOffset, q7Group, 5, 300); 
				
				page3.addChild(q7_1Radio);
				page3.addChild(q7_2Radio);
				page3.addChild(q7_3Radio);
				page3.addChild(q7_4Radio);
				page3.addChild(q7_5Radio);
				
			//Question 8:
				var question8Field:TextField = new TextField();				
				question8Field = TextProperties2(questions[7], cFormat, 40, q7_5Radio.y + 40, 800);
				page3.addChild(question8Field);
				
				q8Group = new RadioButtonGroup("q8Group");
				
				var q8responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[7].responses.response.length(); i++) {
					q8responses.push(demoXML.item[7].responses.response[i].text());
				}				
				var q8_1Radio:RadioButton = RBFormat(q8responses[0], 60, question8Field.y + 40, q8Group, 1, 300);
				var q8_2Radio:RadioButton = RBFormat(q8responses[1], 60, q8_1Radio.y + bOffset, q8Group, 2, 300); 
				var q8_3Radio:RadioButton = RBFormat(q8responses[2], 60, q8_2Radio.y + bOffset, q8Group, 3, 300); 
				
				page3.addChild(q8_1Radio);
				page3.addChild(q8_2Radio);
				page3.addChild(q8_3Radio);
				
			//Question 9:
				var question9Field:TextField = new TextField();				
				question9Field = TextProperties2(questions[8], cFormat, 40, 70, 800);
				page4.addChild(question9Field);
				
				q9Group = new RadioButtonGroup("q9Group");
				
				var q9responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[8].responses.response.length(); i++) {
					q9responses.push(demoXML.item[8].responses.response[i].text());
				}
				
				var q9_1Radio:RadioButton = RBFormat(q9responses[0], 60, question9Field.y + 40, q9Group, 1, 300);
				var q9_2Radio:RadioButton = RBFormat(q9responses[1], 60, q9_1Radio.y + bOffset, q9Group, 2, 300); 
				var q9_3Radio:RadioButton = RBFormat(q9responses[2], 60, q9_2Radio.y + bOffset, q9Group, 3, 300);
				var q9_4Radio:RadioButton = RBFormat(q9responses[3], 60, q9_3Radio.y + bOffset, q9Group, 4, 300);
				var q9_5Radio:RadioButton = RBFormat(q9responses[4], 60, q9_4Radio.y + bOffset, q9Group, 5, 300);
				var q9_6Radio:RadioButton = RBFormat(q9responses[5], 60, q9_5Radio.y + bOffset, q9Group, 6, 300); 
				var q9_7Radio:RadioButton = RBFormat(q9responses[6], 60, q9_6Radio.y + bOffset, q9Group, 7, 300); 
				
				page4.addChild(q9_1Radio);
				page4.addChild(q9_2Radio);
				page4.addChild(q9_3Radio);
				page4.addChild(q9_4Radio);
				page4.addChild(q9_5Radio);
				page4.addChild(q9_6Radio);
				page4.addChild(q9_7Radio);
				
			//Question 10:
				var question10Field:TextField = new TextField();				
				question10Field = TextProperties2(questions[9], cFormat, 40, q9_7Radio.y + 40, 800);
				page4.addChild(question10Field);
				
				q10Group = new RadioButtonGroup("q10Group");
				
				var q10responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[9].responses.response.length(); i++) {
					q10responses.push(demoXML.item[9].responses.response[i].text());
				}				
				var q10_1Radio:RadioButton = RBFormat(q10responses[0], 60, question10Field.y + 40, q10Group, 1, 300);
				var q10_2Radio:RadioButton = RBFormat(q10responses[1], 60, q10_1Radio.y + bOffset, q10Group, 2, 300); 
				var q10_3Radio:RadioButton = RBFormat(q10responses[2], 60, q10_2Radio.y + bOffset, q10Group, 3, 300); 
				var q10_4Radio:RadioButton = RBFormat(q10responses[3], 60, q10_3Radio.y + bOffset, q10Group, 4, 300); 
				var q10_5Radio:RadioButton = RBFormat(q10responses[4], 60, q10_4Radio.y + bOffset, q10Group, 5, 300); 
				var q10_6Radio:RadioButton = RBFormat(q10responses[5], 60, q10_5Radio.y + bOffset, q10Group, 6, 300);
				
				page4.addChild(q10_1Radio);
				page4.addChild(q10_2Radio);
				page4.addChild(q10_3Radio);
				page4.addChild(q10_4Radio);
				page4.addChild(q10_5Radio);
				page4.addChild(q10_6Radio);

			//Question 11:
				var question11Field:TextField = new TextField();				
				question11Field = TextProperties2(questions[10], cFormat, 40, 70, 800);
				page5.addChild(question11Field);
				
				q11Group = new RadioButtonGroup("q11Group");
				
				var q11responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[10].responses.response.length(); i++) {
					q11responses.push(demoXML.item[10].responses.response[i].text());
				}
				
				var q11_1Radio:RadioButton = RBFormat(q11responses[0], 60, question11Field.y + 40, q11Group, 1, 300);
				var q11_2Radio:RadioButton = RBFormat(q11responses[1], 60, q11_1Radio.y + bOffset, q11Group, 2, 300); 
				var q11_3Radio:RadioButton = RBFormat(q11responses[2], 60, q11_2Radio.y + bOffset, q11Group, 3, 300);
				var q11_4Radio:RadioButton = RBFormat(q11responses[3], 60, q11_3Radio.y + bOffset, q11Group, 4, 300);
				var q11_5Radio:RadioButton = RBFormat(q11responses[4], 60, q11_4Radio.y + bOffset, q11Group, 5, 300);
				var q11_6Radio:RadioButton = RBFormat(q11responses[5], 60, q11_5Radio.y + bOffset, q11Group, 6, 300); 
				var q11_7Radio:RadioButton = RBFormat(q11responses[6], 60, q11_6Radio.y + bOffset, q11Group, 7, 300); 
				
				page5.addChild(q11_1Radio);
				page5.addChild(q11_2Radio);
				page5.addChild(q11_3Radio);
				page5.addChild(q11_4Radio);
				page5.addChild(q11_5Radio);
				page5.addChild(q11_6Radio);
				page5.addChild(q11_7Radio);
				
			//Question 12:
				var question12Field:TextField = new TextField();				
				question12Field = TextProperties2(questions[11], cFormat, 40, q11_7Radio.y + 40, 800);
				page5.addChild(question12Field);
				
				q12Group = new RadioButtonGroup("q12Group");
				
				var q12responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[11].responses.response.length(); i++) {
					q12responses.push(demoXML.item[11].responses.response[i].text());
				}				
				var q12_1Radio:RadioButton = RBFormat(q12responses[0], 60, question12Field.y + 40, q12Group, 1, 300);
				var q12_2Radio:RadioButton = RBFormat(q12responses[1], 60, q12_1Radio.y + bOffset, q12Group, 2, 300); 
				var q12_3Radio:RadioButton = RBFormat(q12responses[2], 60, q12_2Radio.y + bOffset, q12Group, 3, 300); 
				var q12_4Radio:RadioButton = RBFormat(q12responses[3], 60, q12_3Radio.y + bOffset, q12Group, 4, 300); 
				var q12_5Radio:RadioButton = RBFormat(q12responses[4], 60, q12_4Radio.y + bOffset, q12Group, 5, 300); 
				var q12_6Radio:RadioButton = RBFormat(q12responses[5], 60, q12_5Radio.y + bOffset, q12Group, 6, 300);
				var q12_7Radio:RadioButton = RBFormat(q12responses[6], 60, q12_6Radio.y + bOffset, q12Group, 7, 300);
				
				page5.addChild(q12_1Radio);
				page5.addChild(q12_2Radio);
				page5.addChild(q12_3Radio);
				page5.addChild(q12_4Radio);
				page5.addChild(q12_5Radio);
				page5.addChild(q12_6Radio);
				page5.addChild(q12_7Radio);
				
			//Question 13:
				var question13Field:TextField = new TextField();				
				question13Field = TextProperties2(questions[12], cFormat, 40, 70, 800);
				page6.addChild(question13Field);
				
				q13Group = new RadioButtonGroup("q13Group");
				
				var q13responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[12].responses.response.length(); i++) {
					q13responses.push(demoXML.item[12].responses.response[i].text());
				}
				
				var q13_1Radio:RadioButton = RBFormat(q13responses[0], 60, question13Field.y + 40, q13Group, 1, 300);
				var q13_2Radio:RadioButton = RBFormat(q13responses[1], 60, q13_1Radio.y + bOffset, q13Group, 2, 300); 
				var q13_3Radio:RadioButton = RBFormat(q13responses[2], 60, q13_2Radio.y + bOffset, q13Group, 3, 300);
				var q13_4Radio:RadioButton = RBFormat(q13responses[3], 60, q13_3Radio.y + bOffset, q13Group, 4, 300);
				var q13_5Radio:RadioButton = RBFormat(q13responses[4], 60, q13_4Radio.y + bOffset, q13Group, 5, 300);
				var q13_6Radio:RadioButton = RBFormat(q13responses[5], 60, q13_5Radio.y + bOffset, q13Group, 6, 300); 
				var q13_7Radio:RadioButton = RBFormat(q13responses[6], 60, q13_6Radio.y + bOffset, q13Group, 7, 300); 
				
				page6.addChild(q13_1Radio);
				page6.addChild(q13_2Radio);
				page6.addChild(q13_3Radio);
				page6.addChild(q13_4Radio);
				page6.addChild(q13_5Radio);
				page6.addChild(q13_6Radio);
				page6.addChild(q13_7Radio);
				
			//Question 14:
				var question14Field:TextField = new TextField();				
				question14Field = TextProperties2(questions[13], cFormat, 40, q13_7Radio.y + 40, 800);
				page6.addChild(question14Field);
				
				q14Group = new RadioButtonGroup("q14Group");
				
				var q14responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[13].responses.response.length(); i++) {
					q14responses.push(demoXML.item[13].responses.response[i].text());
				}				
				var q14_1Radio:RadioButton = RBFormat(q14responses[0], 60, question14Field.y + 35, q14Group, 1, 300);
				var q14_2Radio:RadioButton = RBFormat(q14responses[1], 60, q14_1Radio.y + bOffset, q14Group, 2, 300); 
				var q14_3Radio:RadioButton = RBFormat(q14responses[2], 60, q14_2Radio.y + bOffset, q14Group, 3, 300); 
				var q14_4Radio:RadioButton = RBFormat(q14responses[3], 60, q14_3Radio.y + bOffset, q14Group, 4, 300); 
				var q14_5Radio:RadioButton = RBFormat(q14responses[4], 60, q14_4Radio.y + bOffset, q14Group, 5, 300); 
				var q14_6Radio:RadioButton = RBFormat(q14responses[5], 60, q14_5Radio.y + bOffset, q14Group, 6, 300);
				var q14_7Radio:RadioButton = RBFormat(q14responses[6], 60, q14_6Radio.y + bOffset, q14Group, 7, 300);
				var q14_8Radio:RadioButton = RBFormat(q14responses[7], 60, q14_7Radio.y + bOffset, q14Group, 8, 300);
				
				page6.addChild(q14_1Radio);
				page6.addChild(q14_2Radio);
				page6.addChild(q14_3Radio);
				page6.addChild(q14_4Radio);
				page6.addChild(q14_5Radio);
				page6.addChild(q14_6Radio);
				page6.addChild(q14_7Radio);
				page6.addChild(q14_8Radio);
				
			//Question 15:
				var question15Field:TextField = new TextField();				
				question15Field = TextProperties2(questions[14], cFormat, 40, 70, 800);
				page7.addChild(question15Field);
				
				q15Group = new RadioButtonGroup("q15Group");
				
				var q15responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[14].responses.response.length(); i++) {
					q15responses.push(demoXML.item[14].responses.response[i].text());
				}
				
				var q15_1Radio:RadioButton = RBFormat(q15responses[0], 60, question15Field.y + 40, q15Group, 1, 300);
				var q15_2Radio:RadioButton = RBFormat(q15responses[1], 60, q15_1Radio.y + bOffset, q15Group, 2, 300); 
				var q15_3Radio:RadioButton = RBFormat(q15responses[2], 60, q15_2Radio.y + bOffset, q15Group, 3, 300);
				var q15_4Radio:RadioButton = RBFormat(q15responses[3], 60, q15_3Radio.y + bOffset, q15Group, 4, 300);
				
				page7.addChild(q15_1Radio);
				page7.addChild(q15_2Radio);
				page7.addChild(q15_3Radio);
				page7.addChild(q15_4Radio);
				
			//Question 16:
				var question16Field:TextField = new TextField();				
				question16Field = TextProperties2(questions[15], cFormat, 40, q15_4Radio.y + 40, 800);
				page7.addChild(question16Field);
				
				q16Group = new RadioButtonGroup("q16Group");
				
				var q16responses:Array = new Array();
				for (var i:int = 0; i < demoXML.item[15].responses.response.length(); i++) {
					q16responses.push(demoXML.item[15].responses.response[i].text());
				}
				
				var q16_1Radio:RadioButton = RBFormat(q16responses[0], 60, question16Field.y + 40, q16Group, 1, 300);
				var q16_2Radio:RadioButton = RBFormat(q16responses[1], 60, q16_1Radio.y + bOffset, q16Group, 2, 300); 
				var q16_3Radio:RadioButton = RBFormat(q16responses[2], 60, q16_2Radio.y + bOffset, q16Group, 3, 300);
				var q16_4Radio:RadioButton = RBFormat(q16responses[3], 60, q16_3Radio.y + bOffset, q16Group, 4, 300);
				
				page7.addChild(q16_1Radio);
				page7.addChild(q16_2Radio);
				page7.addChild(q16_3Radio);
				page7.addChild(q16_4Radio);
				
			//Final Screen:
				var thxText:String = "Thanks for playing!  Press the \"Submit\" button below to complete the game and submit your score.";
				var thanksField:TextField = new TextField();				
				thanksField = TextProperties2(thxText, cFormat, 80, 150, 800);
				
				pageFinal.addChild(thanksField);
				
				var errorText:String = "Caution: It seems that you have left some questions unanswered.  Feel free to go back and answer them if you would like, otherwise click \"Submit\" again when you are ready.";
				errorField = new TextField();				
				errorField = TextProperties2(errorText, cFormat, 60, 200, 800);
				errorField.textColor = 0xFF0000;
				pageFinal.addChild(errorField);
				errorField.visible = false;
				
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
					page3.visible = true;
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
					page4.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}			
					break;
				case 4:
					page4.visible = false;
					page5.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}			
					break;
				case 5:
					page5.visible = false;
					page6.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}			
					break;
				case 6:
					page6.visible = false;
					page7.visible = true;
					currentPage++;
					if (currentPage > maxPageVisited) {
						maxPageVisited = currentPage;
						forward.visible = false;
						disabledForward.visible = true;
						nextTimer.start();
					}			
					break;
				case  7:
					page7.visible = false;
					pageFinal.visible = true;
					currentPage++;
					forward.visible = false;
					submit.visible = true;
					break;
			}
		}
		
		public function backClicked(event:MouseEvent):void 
		{
			switch(currentPage) {
				case 8:
					pageFinal.visible = false;
					page7.visible = true;
					forward.visible = true;
					submit.visible = false;
					errorField.visible = false;
					currentPage--;
					break;
				case 7:
					page7.visible = false;
					page6.visible = true;
					currentPage--;
					break;
				case 6:
					page6.visible = false;
					page5.visible = true;
					currentPage--;
					break;
				case 5:
					page5.visible = false;
					page4.visible = true;
					currentPage--;
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
					break;
				case 2:
					page2.visible = false;
					page1.visible = true;
					currentPage--;
					back.visible = false;
					break;
			}
		}
		
		public function submitClicked(event:MouseEvent):void 
		{
			//Check to see if all questions are answered:
			var unansweredQ:Boolean = ((q2Group.selection == null) || (q3Group.selection == null) || (q4Group.selection == null) || (q5Group.selection == null) 
									|| (q6Group.selection == null) || (q7Group.selection == null) || (q8Group.selection == null) || (q9Group.selection == null) 
									|| (q10Group.selection == null) || (q11Group.selection == null) || (q12Group.selection == null) || (q13Group.selection == null) 
									|| (q14Group.selection == null) || (q15Group.selection == null) || (q16Group.selection == null));
			if (unansweredQ && answeredWarning) {
				errorField.visible = true;
				answeredWarning = false;
			}
			else {
				
				//This big block of ifs sets the value of each question if the value is non-null, otherwise the value
				//remains -9999
				if (q1Combo.selectedIndex) {
					q1Val = q1Combo.selectedIndex;
				}
				if (q2Group.selectedData) {
					q2Val = int(q2Group.selectedData);
				}
				if (q3Group.selectedData) {
					q3Val = int(q3Group.selectedData);
				}
				if (q4Group.selectedData) {
					q4Val = int(q4Group.selectedData);
				}
				if (q5Group.selectedData) {
					q5Val = int(q5Group.selectedData);
				}
				if (q6Group.selectedData) {
					q6Val = int(q6Group.selectedData);
				}
				if (q7Group.selectedData) {
					q7Val = int(q7Group.selectedData);
				}
				if (q8Group.selectedData) {
					q8Val = int(q8Group.selectedData);
				}
				if (q9Group.selectedData) {
					q9Val = int(q9Group.selectedData);
				}
				if (q10Group.selectedData) {
					q10Val = int(q10Group.selectedData);
				}
				if (q11Group.selectedData) {
					q11Val = int(q11Group.selectedData);
				}
				if (q12Group.selectedData) {
					q12Val = int(q12Group.selectedData);
				}
				if (q13Group.selectedData) {
					q13Val = int(q13Group.selectedData);
				}
				if (q14Group.selectedData) {
					q14Val = int(q14Group.selectedData);
				}
				if (q15Group.selectedData) {
					q15Val = int(q15Group.selectedData);
				}
				if (q16Group.selectedData) {
					q16Val = int(q16Group.selectedData);
				}
				
				//Now add each question value to the responses array
				responses.push(q1Val);
				responses.push(q2Val);
				responses.push(q3Val);
				responses.push(q4Val);
				responses.push(q5Val);
				responses.push(q6Val);
				responses.push(q7Val);
				responses.push(q8Val);
				responses.push(q9Val);
				responses.push(q10Val);
				responses.push(q11Val);
				responses.push(q12Val);
				responses.push(q13Val);
				responses.push(q14Val);
				responses.push(q15Val);
				responses.push(q16Val);
				
				/*if (responses.length == 16) {
					var successText:String = "Your score was successfully submitted!";
					errorField.text = successText;
					errorField.textColor = 0x55AE3A;				
					errorField.visible = true;
				}*/
				Submit.addDemArray(responses);
				var endDemo = new CustomEvent("demographicsFinished", true);
				dispatchEvent(endDemo);
				Submit.finalSubmit();
			}
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