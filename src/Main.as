package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import quiz.Quiz;
	import start_the_game.StartGame;
	import treat.Default;
	import treat.Treatment;
	import treat.TreatmentTest;
	import treat.TreatOne;
	import ui.Basic;
	import ui.Disclaimer;
	import ui.Layout;
	import ui.LoadingScreen;
	import ui.SplashScreen;
	import ui.TestUI;
	import ui.WaitingForPlayers;
	import util.Point;
	import tiles.State;
	import tiles.TileArray;
	import instructions.Instructions;
	import flash.net.SharedObject;
	import util.Submit;
	import ui.QuizSplash;
	import survey.Survey_Vote
	import allocate.AllocateSplash;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class Main extends Sprite
	{
		
		public static var uniqueCode:int;
		private var loader:LoadingScreen;
		private var instructions:Instructions;
		private var quizSplash:QuizSplash;
		private var startGameSplash:StartGame;
		private var userID:SharedObject;
		public var treatment:int;
		public static var playerWin:Boolean; //VARIABLE TO BE: 0 IF LOSE, 1 IF WIN
		public var playersConnecting:PlayersConnecting_Design = new PlayersConnecting_Design();
		public var playerConnected:PlayersFoundBegin_Design;
		public static var array4:Array = [000000000, 20140315, 150827, 151353, 3, -9999, -9999, -9999, -9999, -9999, -9999, -9999, -9999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 4, 1, 1, 1, 1, 4, 0, 1, 0, 3, 0, 4, 0, 6, 0, 6, 0, 6, 0, 10, 0, 17, 0, 21, 0, 21, null, null, null, null, null, null, null, 2, 3, 1, 4, 3, 1, 5, 1, 5, 2, 5, 3, 2, 3, 3, 1, 985, 0, 0, 1330, 470];

		
	/* These two variables are used to toggle the treatment:
		 *  1.0: Set treatment to 0, work_display_toggle to 0
		 *  2.0: Set treatment to 2, work_display_toggle to 0
		 *  2.1: Set treatment to 2, work_display_toggle to 1
		 *  2.2: Set treatment to 2, work_display_toggle to -1
		 *  3.0: Set treatment to 4, work_display_toggle to 0
		 *  3.1: Set treatment to 6, ignore work_display_toggle to 1
		 *  3.2: Set treatment to 8, ignore work_display_toggle to -1
		 *  4.0: Set treatment to 10, work_display_toggle to 0
	*/
	
	public static var global_treatment_override:int = 10;
	public static var global_work_display_toggle:int = 0;
	
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			Submit.init();
			//Submit.finalSubmit();
			
			userID = SharedObject.getLocal("ID");
			trace(userID.data.ID);
			//userID.clear();
			
			
			//ID Assigned
			if (userID.size == 0)
			{
				userID.data.ID = Math.random() * 5;
				userID.flush();
			
				trace(userID.data.ID);
				//ID Written
				Submit.addData("id", (userID.data.ID * 100000000));
				uniqueCode = userID.data.ID * 100000000;
				//Treatment Assigned
				treatment = userID.data.ID;

				if (treatment == 0) {
					treatment = 0;
				}
				else if (treatment == 1) {
					treatment = 2;
				}
				else if (treatment == 2) {
					treatment = 4;
				}
				else if (treatment == 3) {
					treatment = 6;
				}
				else if (treatment == 4) {
					treatment = 8;
				}
				
				//DELETE ME!!!!
				//treatment = 8;
				
				treatment = Main.global_treatment_override;
				
				//Treatment Written
				trace("Treatment: "+treatment);
				Submit.addData("condition", treatment);
				
				//Start Date
				var date:Date = new Date();
				var startDate:String = date.fullYear.toString() + correctDate(date.month+1) + correctDate(date.date);
				//Start Date Written
				Submit.addData("date", int (startDate));
				var startTime:String = correctDate(date.hours) + correctDate(date.minutes) + correctDate(date.seconds);
				//Start Time Written
				Submit.addData("t0", int (startTime));
				
			// ACTIVATE IF WE NEED PLAYER COLOR CHANGE:
				  //WIN/LOSE (PLAYER COLOR)
				if (treatment ==  0 || treatment == 2 || treatment == 4 || treatment == 6 || treatment == 8 || treatment == 10)
				{
					playerWin = true; //Player Wins
					trace("player wins");
				}
				else if ( treatment == 1 || treatment == 3 || treatment == 5 || treatment == 7 || treatment == 9)
				{
					playerWin = false; //Player Lose
					trace("player lose");
				}
				
				
				
				loader = new LoadingScreen();
				addChild(loader);
				addEventListener("READY", onReady);
				//addEventListener("READY", test);
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			else 
			{
				var sorry:sorry_play_once = new sorry_play_once();
				addChild(sorry);
			}
		}
		/*
		 //Allocate Test
		public var allocate:allocate.AllocateSplash = new AllocateSplash();
		public function test(e:Event):void {

			addChild(allocate);
			this.addEventListener("REDISTRIBUTE_DONE", test2);
		}
		
		
		public function test2(e:Event):void {
			removeChild(allocate);
		}
		*/
		
		public function onReady(e:Event):void
		{
			removeChild(loader);
			playersConnecting.x = 270;
			playersConnecting.y = 300;
			addChild(playersConnecting);
			var tempTimer:Timer = new Timer(15000, 1);
			tempTimer.addEventListener(TimerEvent.TIMER, cleanUp);
			var tempTimer2:Timer = new Timer(10000, 1);
			tempTimer2.addEventListener(TimerEvent.TIMER, onReady2);
			tempTimer.start();
			tempTimer2.start();
		}
		public function onReady2(e:Event):void
		{
			playersConnecting.visible = false;
			playerConnected = new PlayersFoundBegin_Design();
			removeChild(playersConnecting);
			playerConnected.x = 210;
			playerConnected.y = 300;
			addChild(playerConnected);
		}
		
		public function cleanUp(e:Event):void
		{
			removeChild(playerConnected);
			onBegin(e);
		}
		
		public function onBegin(e:Event):void
		{
			
			//The Instructions class takes an integer corresponding with the treatment (0 through 9)
			instructions = new Instructions(treatment);
			addChild(instructions);
			this.addEventListener("DONE", inst_quiz);
			
			//run(e);
			trace(treatment);
		}
		
		public function inst_quiz(e:Event):void 
		{
			removeChild(instructions);
			quizSplash = new QuizSplash();
			addChild(quizSplash);
			quizSplash.run("instructions", treatment, 0);
			quizSplash.addEventListener("quizFinished", start_game_splash);
		}
		
		public function start_game_splash(e:Event):void 
		{
			if ( quizSplash != null)
			{
				removeChild(quizSplash);
			}
			
			if (treatment == 2 || treatment == 3) {
				startGameSplash = new StartGame("IQ");
				addChild(startGameSplash);
				startGameSplash.addEventListener("CONTINUE_WAS_CLICKED", run);
			}
			else if (treatment >= 4 && treatment < 10) {
				startGameSplash = new StartGame("HARD_WORK");
				addChild(startGameSplash);
				startGameSplash.addEventListener("CONTINUE_WAS_CLICKED", run);
			} else if (treatment == 10) {
				startGameSplash = new StartGame("4.0");
				addChild(startGameSplash);
				startGameSplash.addEventListener("CONTINUE_WAS_CLICKED", run);
			}
			else {
				run(e);
			}
		}
		
		public function run(e:Event):void
		{
			if ( startGameSplash != null)
			{
				removeChild(startGameSplash);
			}
			var test:Treatment = new Treatment(treatment);
			trace("Treatment is " + treatment);
			addChildAt(test, 0);
		}
		
		//Corrects Date Datatype
		public function correctDate(num:Number):String {
			if (num < 10) {
				return "0" + num.toString();
			}
			else return num.toString();
		}
	
	}

}