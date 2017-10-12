package quiz
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	import quiz.Question;
	import util.CustomEvent;
	import util.Submit;
	import flash.utils.Timer;
	import com.greensock.TweenLite;

	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Quiz extends Sprite
	{
		//Quiz configuration
		private var showScore:Boolean;
		private var showCorrect:Boolean;
		private var showQuit:Boolean;
		private var timeLimit:Boolean;
		private var waitTime:int;
		private var maxIncorrect:int;
		
		//XML variables:
		//These are used to handle and load the questions from the supplied XML file.
		private var _source:String;
		private var _quizdata:XML;
		//private var _configfile:XML;
		
		//Quiz state variables
		private var _currentQuestion:int;
		private var _numAsked:int;
		private var _numCorrect:int;
		private var numIncorrect:int;
		private var _playerAnswers:Array;
		private var saveData:CustomEvent;
		public var selectedAnswer:int;
		public var correctAnswer:int;
		private var type:String;
		private var round:int;
		private var treatment:Number;
		private var timedOut:Boolean;
		private var missedOut:Boolean;
		private var retry:Boolean;
		
		//Key components
		private var _score:QuizScore;		
		private var next:NextButton;
		private var confirm:VerifyButton;
		private var quit:QuitButton;
		private var quitconfirm:QuitYes;
		private var quitno:QuitNo;
		private var whiteScreen:WhiteOut;
		private var questionTimer:Timer;
		
		//Questions and answers are added to this Sprite
		private var questionBlock:Sprite;
		
		private var submitString:String;
		
		
		public function Quiz(type:String, treatment:Number, round:int):void {
			
			//This loads the XML from the source location and uses two functions:
			//xmlLoaded and xmlLoadError to load it and report the success of the operation.
			currentQuestion = 0;
			quizdata = new XML();
			playerAnswers = new Array();
			this.type = type;
			this.round = round;
			this.treatment = treatment;
			
			if (treatment == 2 || treatment == 3) {
				submitString = "iq_r";
			} else {
				submitString = "test_r";
			}
			
			switch(type) 
			{
				case "instructions":
					switch (treatment)
						{
							case 0: //Treatment 1.0 (Default, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz1.xml");
								break;
							case 1: //Treatment -1.0 (Default, loser)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz-1.xml");
								break;
							case 2: //Treatment 2.0 (IQ, no-corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz2.xml");
								break;
							case 3: //Treatment -2.0 (IQ, no-corr, lose)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz-2.xml");
								break;
							case 4: //Treatment 3.0 (work, no-corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz3.xml");
								break;
							case 5: //Treatment -3.0 (work, no-corr, lose)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz-3.xml");
								break;
							case 6: //Treatment 3.1 (work, +corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz3.xml");
								break;
							case 7: //Treatment -3.1 (work, -corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz-3.xml");
								break;
							case 8: //Treatment 3.2 (work, -corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz3.xml");
								break;
							case 9: //Treatment -3.2 (work, +corr, win)
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz-3.xml");
								break;
							case 10: //Treatment 4.0
								var xmlURL:URLRequest = new URLRequest("instructions_xml/quiz4.xml");
								break;
							default:
								trace("Not a valid treatment");
						}	
					break;
				default:
					switch(treatment) {
						case 2:
							switch(round)
							{
								case 0:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq1.xml");
								break;
								
								case 1:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq2.xml");
								break;
								
								case 2:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq3.xml");
								break;
								
								case 3:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq4.xml");
								break;
								
								default:
								trace("No round information available.");
							}
							break;
						case 3:
							switch(round)
							{
								case 0:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq1.xml");
								break;
								
								case 1:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq2.xml");
								break;
								
								case 2:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq3.xml");
								break;
								
								case 3:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_iq4.xml");
								break;
								
								default:
								trace("No round information available.");
							}
							break;
						default:
							switch(round)
							{
								case 0:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_r1.xml");
								break;
								
								case 1:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_r2.xml");
								break;
								
								case 2:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_r3.xml");
								break;
								
								case 3:
								var xmlURL:URLRequest = new URLRequest("quizzes_xml/questions_r4.xml");
								break;
								
								default:
								trace("No round information available.");
							}
							break;
					}
			}
			
			
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadError);

			
		}
		
		
		
		
		
		//Saves the loaded XML data in the quizdata variable and reports success
		private function xmlLoaded(event:Event):void {
			quizdata = XML(event.target.data);
			//trace(quizdata.item.responses.response[1]);
			trace("Data loaded.");	
			//trace(quizdata.item.length());
			
			showScore = false;
			showCorrect = false;
			showQuit = false;
			timeLimit = false;
			retry = false;
			
			//This if is necessary because the AS3 boolean interprets all non-empty strings from XML as true.
			if (quizdata.config.showScore == "true") {
				showScore = true;
			}
			if (quizdata.config.showCorrect == "true") {
				showCorrect = true;
			}
			if (quizdata.config.showQuit == "true") {
				showQuit = true;
			}
			if (quizdata.config.timeLimit == "true") {
				timeLimit = true;
				waitTime = int(quizdata.config.waitTime.text());
				//INitialize the timer (it's not started until QuestionLoader
				questionTimer = new Timer(waitTime, 1);
			}
			
			//Maximum number of questions a player can miss and related variables
			maxIncorrect = int(quizdata.config.maxIncorrect.text());
			numIncorrect = 0;
			missedOut = false;
			
			//Initialize the score display
			
			score = new QuizScore(numCorrect, numAsked);
			addChild(score);
			score.x = 800;
			
			//Code to accomodate images for the IQ test
			if (treatment == 2) {
				score.y = 110;
			}
			else score.y = 110;
			
			if (showScore == false) {
				score.visible = false;
			}
			
			if (showQuit) {
				quit = new QuitButton();
				quit.addEventListener(MouseEvent.CLICK, onQuitClick);
				addChild(quit);
				quit.x = 900;
				quit.y = 55;
			}
			
			//The questionLoader function creates a new questionBlock containing the
			//question and answers.
			questionLoader();						
		}
		
		//If there is an error when loading the XML data this reports the error
		private function xmlLoadError(event:IOErrorEvent):void {
			trace(event.text);
		}
		
		//When an answer element is clicked, this executes.
		private function answerClicked(event:Event):void {
			
			//For this if statement to work, it must check that the confirmation button is both
			//initialized and on the stage.
			if (confirm && this.contains(confirm)) { 
				removeChild(confirm); 			
			}
			//event.currentTarget.alpha = 1;
			var selectedLetter:String = event.currentTarget.letterField.text;
			selectedAnswer = event.currentTarget.answerID;
			correctAnswer = quizdata.item[currentQuestion].answer;
			confirm = new VerifyButton(selectedLetter);
			addChild(confirm);
			confirm.x = 500;
			confirm.y = 550;
			
			confirm.addEventListener(MouseEvent.CLICK, confirmClicked); 
		}	
		private function confirmClicked(event:Event):void {
			if (timeLimit) {
				questionTimer.stop();
				questionTimer.reset();
			}
			playerAnswers.push(selectedAnswer);
			removeChild(confirm);
			numAsked = numAsked + 1;
			removeChild(questionBlock);
			
			/*This if statement checks to see if the selected answer is the correct answer as
			specified in the XML document.  It then creates a next button that tells the player
			whether their answer was correct (true) or incorrect (false).*/
			
			if (selectedAnswer == correctAnswer) {
				numCorrect = numCorrect + 1;
				
				
				next = new NextButton(true, retry, showCorrect, timedOut, missedOut);
				addChild(next);
				next.x = 240;
				next.y = 300;
				if (type != "instructions"){
						Submit.addData(submitString + (round + 1).toString(), 1);
				}
			}
			else {
				if (type == "instructions") {
					retry = true;
				}
				numIncorrect++;
				trace(numIncorrect);
				trace(maxIncorrect);
				if (numIncorrect > maxIncorrect) {
					missedOut = true;
				}
				next = new NextButton(false, retry, showCorrect, timedOut, missedOut);
				addChild(next);
				next.x = 240;
				next.y = 300;
				if (type != "instructions"){
					Submit.addData(submitString + (1 + round).toString(), 0);
				}
			}
			
			
			updateScore();
			next.addEventListener(MouseEvent.CLICK, nextClicked);
		}
		
		private function timedOutConfirm(event:Event):void {
			timedOut = true;
			selectedAnswer = -9999;
			playerAnswers.push(selectedAnswer);
			numAsked = numAsked + 1;
			removeChild(questionBlock);
			trace(selectedAnswer);
			
			/*This if statement checks to see if the selected answer is the correct answer as
			specified in the XML document.  It then creates a next button that tells the player
			whether their answer was correct (true) or incorrect (false).*/
			
			if (selectedAnswer == correctAnswer) {
				numCorrect = numCorrect + 1;
				
				
				next = new NextButton(true, retry, showCorrect, timedOut, missedOut);
				addChild(next);
				next.x = 240;
				next.y = 300;
				Submit.addData(submitString +(round+1).toString(), 1);
			}
			else {
				numIncorrect++;
				if (numIncorrect > maxIncorrect) {
					missedOut = true;
				}
				next = new NextButton(false, retry, showCorrect, timedOut, missedOut);
				addChild(next);
				next.x = 240;
				next.y = 300;
				Submit.addData(submitString + (1+round).toString(), 0);
			}
			
			
			updateScore();
			next.addEventListener(MouseEvent.CLICK, nextClicked);
		}
		
		
		//When the next button is clicked, this checks to see if their are questions remaining
		//and if there are then it reinitializes the questionLoader.
		public function nextClicked(event:MouseEvent):void {
			removeChild(next);
			//trace(playerAnswers);
			
			if (missedOut) {
				addEventListener(MouseEvent.CLICK, onEndClick);
			}
			
			if (retry) {
				questionLoader();
			}
			else {
				if (currentQuestion < (quizdata.item.length() - 1)) {				
					currentQuestion = currentQuestion + 1;
					questionLoader();				
				}
				
				else {
					var end:TextField = new TextField();
					end.width = 300;
					if (showScore){
						end.text = "You have completed the quiz!  Your score was: " + numCorrect + " / " + numAsked;
						addEventListener(MouseEvent.CLICK, onEndClick);
					}
					else {
						end.text = "You have completed the quiz!";
						addEventListener(MouseEvent.CLICK, onEndClick);
					}
					addChild(end);
					end.x = 300;
					end.y = 300;
					
			}
			}
		}
		
		private function onQuitClick(e:MouseEvent):void {
			whiteScreen = new WhiteOut();
			addChild(whiteScreen);
			quitconfirm = new QuitYes();
			quitconfirm.addEventListener(MouseEvent.CLICK, onEndClick);
			
			quitno = new QuitNo();
			quitno.addEventListener(MouseEvent.CLICK, onNoClick);
			
			addChild(quitconfirm);
			addChild(quitno);
			
			quitconfirm.x = 90;
			quitconfirm.y = 100;
			
			quitno.x = 450;
			quitno.y = 160;
		}
		
		private function onNoClick(e:MouseEvent):void {
			TweenLite.to(whiteScreen, .75, { alpha:0 } );
			removeChild(quitconfirm);
			removeChild(quitno);
			removeChild(whiteScreen);
		}
		
		private function onEndClick(e:MouseEvent):void
		{
			saveData = new CustomEvent("quizFinished", true);
			
			saveData.playerAnswers = _playerAnswers.slice(0);
			trace("playerAnswers: " + saveData.playerAnswers);
			
			saveData.quizScore = _numCorrect;
			trace("QuizScore: " + saveData.quizScore);
			dispatchEvent(saveData);
		}
		
		//This function updates the score.
		public function updateScore():void {
			this.removeChild(score)
			score = new QuizScore(numCorrect, numAsked);
			addChild(score);
			score.x = 800;
			if (treatment == 2) {
				score.y = 110;
			}
			else score.y = 110;
			
			if (!showScore) {
				score.visible = false;
			}
			//trace(score.scoreField.text);
		}
		
		/*This loads the question and answer elements.  The infoType and responseType variables
		will be used ot distinguish between text and images when I add that.*/
		public function questionLoader():void {
			questionBlock = new Sprite();
			addChild(questionBlock);
			timedOut = false;
			retry = false;
			
			
			var titleString:String = quizdata.item[currentQuestion].title;
			var infoString:String = quizdata.item[currentQuestion].info;
			var questionString:String = quizdata.item[currentQuestion].question;
			var responsesSize:int = quizdata.item[currentQuestion].responses.response.length();
			
			var correctAnswer:int = quizdata.item[currentQuestion].answer;
			var infoType:String = quizdata.item[currentQuestion].info.@type;
			var responseType:String = quizdata.item[currentQuestion].responses.@type;
			
			var question:Question = new Question(titleString, infoString, questionString, infoType, currentQuestion);
			questionBlock.addChild(question);
			
			question.x = 100;
			question.y = 80;

			
			var k:int = 0;
			var j:int = 0;
			for (var i:int = 0; i < responsesSize; i++) {
				//j and k are involved with the placement of the responses


				var responseString:String = quizdata.item[currentQuestion].responses.response[i];
				var answer:Answer = new Answer(responseString, responseType, i, correctAnswer);
				questionBlock.addChild(answer);
				
				if (i % 4 == 0) {
					j = 0;
					k += 80;
				}
								
				answer.x = (question.x + (j * 200));
				if (infoType = "image") {
					answer.y = question.y + 275 + k;
				}
				else answer.y = question.y + k;
				
				answer.alpha = .5;
				answer.addEventListener(MouseEvent.CLICK, answerClicked); 
				j++;
			}
			
			if (timeLimit) {
						questionTimer.start();
						questionTimer.addEventListener(TimerEvent.TIMER, timedOutConfirm);
			}
			
		}
		
		
		
		//Get and set functions for the variables
		
		//XML
		public function get source():String {
			return _source;
		}
		public function set source(newSource:String):void {
			_source = newSource;
		}
		
		public function get quizdata():XML {
			return _quizdata;
		}
		public function set quizdata(newData:XML):void {
			_quizdata = newData;
		}
		
		//State
		public function get currentQuestion():int {
			return _currentQuestion;
		}
		public function set currentQuestion(current:int):void {
			_currentQuestion = current;
		}
		
		public function get numAsked():int {
			return _numAsked;
		}
		public function set numAsked(asked:int):void {
			_numAsked = asked;
		}
		
		public function get numCorrect():int {
			return _numCorrect;
		}
		public function set numCorrect(correct:int):void {
			_numCorrect = correct;
		}
		
		public function get playerAnswers():Array {
			return _playerAnswers;
		}
		public function set playerAnswers(answers:Array):void {
			_playerAnswers = answers;
		}
		
		public function get score():QuizScore {
			return _score;
		}
		public function set score(qs:QuizScore):void {
			_score = qs;
		}
	}

}