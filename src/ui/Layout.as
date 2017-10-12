package ui 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import treat.Default;
	import util.CustomEvent;
	import com.greensock.TweenLite;
	import util.DollarsAndCents;
	import util.Submit;
	import treat.Treatment;

	/**
	 * ...
	 * @author Ben Calvin
	 */

	public class Layout extends Layout_design
	{
		protected var _time_remaining:int = 60;
		protected var _available_earnings:DollarsAndCents;
		protected var _plots_owned:int;
		protected var round:int = 0;
		protected var countdownTimer:Timer;
		protected var waitingScreen:WaitingForPlayers;
		protected var splash:SplashScreen;
				
		//Variables for Controlling the Timers
		protected var roundBeginDelay = 10000;
		
		[Embed(source="../../assets/WorkRankCorr1.png")]
		protected static var workRankingsCorr1:Class;
		
		[Embed(source="../../assets/WorkRankNeCorr1.png")]
		protected static var workRankingsNeCorr1:Class;
		
		[Embed(source="../../assets/WorkRankCorr2.png")]
		protected static var workRankingsCorr2:Class;
		
		[Embed(source="../../assets/WorkRankNeCorr2.png")]
		protected static var workRankingsNeCorr2:Class;
		
		[Embed(source="../../assets/WorkRankCorr3.png")]
		protected static var workRankingsCorr3:Class;
		
		[Embed(source="../../assets/WorkRankNeCorr3.png")]
		protected static var workRankingsNeCorr3:Class;
		
		[Embed(source="../../assets/WorkRankCorr4.png")]
		protected static var workRankingsCorr4:Class;
		
		[Embed(source="../../assets/WorkRankNeCorr4.png")]
		protected static var workRankingsNeCorr4:Class;
		
		protected var workRankings:Bitmap;
		
		protected var beginRoundDisplay:RoundBegin_Design;
		protected var roundBeginSplash:SplashScreen;
		protected var beginRoundSplashScreen:BeginRoundSplashScreen_Design;
		
		public var cost:int = 20;
		
		protected var tiles:Default;
		protected var quizSplash:QuizSplash;
		
		public static var hint:Boolean;
		public static var moneyLeft:Boolean = true;
		public static var quiz:Boolean = true;
		
		public var quizScore:int;
		
		public function Layout(hints:Boolean, quizzes:Boolean)
		{
			/*Variable Init*/
			stop();
			plots_owned = 0;
			available_earnings = new DollarsAndCents(2,0);
			hint = hints;
			
			waitingScreen = new WaitingForPlayers();
			waitingScreen.x = 500;
			waitingScreen.y = 350;
			
			/*Quiz Init*/
			quiz = quizzes;
			
			/*THE TILE INITIALIZATION*/
			tiles = new Default(15, 15);
			addChild(tiles);
			tiles.visible = false;
			
			/*Treatment Settings*/
			layout_key.visible = hint;
			
			/*Score Keeping
			 * Note: Must be able to buy at least one tile*/
			addEventListener("tileSelect", onTileSelect);
			addEventListener("tileUnselect", onTileUnselect);
			
			/*End Round*/
			finalizeButton.addEventListener(MouseEvent.CLICK, onFinalizeClick);
			finalizeInstructions.warningText.visible = false;
			
			
			/*INITIALIZE TIMER*/
			countdownTimer = new Timer(1000, 60);
			countdownTimer.addEventListener(TimerEvent.TIMER, onTimerUpdate);
			
			/*BEGIN RUNNING*/
			quizRun(quiz);
			
			moneyLeft = true;
		}
		
		protected function nextRound(round:int):void
		{
			time_remaining = 60;
		//	tiles.visible = false;
		}
		
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		
		/*QUIZ FUNCTIONS */
		
		protected function quizRun(go:Boolean):void
		{
			if (go)
			{
				quizSplash = new QuizSplash();
				quizSplash.addEventListener("quizFinished", onQuizFinished);
				addChild(quizSplash);
				quizSplash.run("", Treatment.globaltreat, round);
			} else
			{
				roundBeginSplash = new SplashScreen();
				addChild(roundBeginSplash);
				beginRoundDisplay = new RoundBegin_Design();
				beginRoundDisplay.x = 250;
				beginRoundDisplay.y = 300;
				//beginRoundDisplay.iQReveal.visible = false; //doesn't work
				beginRoundDisplay.quizReveal.visible = false;
				beginRoundDisplay.roundNumber.text = (round + 1).toString();
				roundBeginSplash.addChild(beginRoundDisplay);
			
				var roundBeginTimer:Timer = new Timer(roundBeginDelay - 5, 1);
				roundBeginTimer.start();
				roundBeginTimer.addEventListener(TimerEvent.TIMER, beginRound);
			}
		}
		
		private function onQuizFinished(e:CustomEvent):void
		{
			
			removeChild(quizSplash);
			trace("QuizScore: " + e.quizScore);
			trace("Treatment: " + Treatment.globaltreat);
			quizScore = e.quizScore;
			roundBeginSplash = new SplashScreen();
			addChild(roundBeginSplash);
			beginRoundDisplay = new RoundBegin_Design();
			beginRoundDisplay.x = 250;
			beginRoundDisplay.y = 300;
			trace("beginRoundDisplayX: " +beginRoundDisplay.x);
			trace("Round: " + (round + 1));
			trace("NumTilesRevealed: " +  numberOfTilesRevealed(round).toString());
			beginRoundDisplay.iQReveal.visible = false;
			//trace("iqReveal: " +  beginRoundDisplay.iQReveal.visible);
			beginRoundDisplay.quizReveal.visible = false;
			trace("quizReveal: " +  beginRoundDisplay.quizReveal.visible);
			beginRoundDisplay.roundNumber.text = (round + 1).toString();
			trace("roundNumber: " + beginRoundDisplay.roundNumber.text);
			
			//if (Treatment.globaltreat == 2 || Treatment.globaltreat == 3) {
				//beginRoundDisplay.iQReveal.visible = true;
				//beginRoundDisplay.iQReveal.numberOfTiles.text = numberOfTilesRevealed(round).toString();
			//} else if (Treatment.globaltreat > 3) {
				//beginRoundDisplay.quizReveal.visible = true;
				//beginRoundDisplay.quizReveal.numberOfTiles.text = numberOfTilesRevealed(round).toString();
			//}
			
			// Cause iqReveal is missing
			if (Treatment.globaltreat > 2) {
				beginRoundDisplay.quizReveal.visible = true;
				beginRoundDisplay.quizReveal.numberOfTiles.text = numberOfTilesRevealed(round).toString();
			}
			
			roundBeginSplash.addChild(beginRoundDisplay);
			trace("onQuizFiniished - finished");
			var roundBeginTimer:Timer = new Timer(roundBeginDelay, 1);
			roundBeginTimer.start();
			roundBeginTimer.addEventListener(TimerEvent.TIMER, beginRound);
			
		}
		
		private function beginRound(e:Event):void
		{
			roundBeginSplash.removeChild(beginRoundDisplay);
			removeChild(roundBeginSplash);
			
			//ADDS SPLASH
			beginRoundSplashScreen = new BeginRoundSplashScreen_Design();
			//beginRoundSplashScreen.alpha = 0;
			beginRoundSplashScreen.y = 225;
			addChild(beginRoundSplashScreen);
			TweenLite.to(beginRoundSplashScreen, .5, { alpha: 1 } );
			TweenLite.to(beginRoundSplashScreen, 1.5, { alpha:0, delay:2 } );
			
			
			//REMOVES SPLASH
			var beginRoundSplashScreenTimer:Timer = new Timer(3500, 1);
			beginRoundSplashScreenTimer.addEventListener(TimerEvent.TIMER, fadeBeginRoundSplash);
			beginRoundSplashScreenTimer.start();
			trace("beginRound running");
			tilesRun();
		}
		
		private function fadeBeginRoundSplash(e:Event):void
		{
			removeChild(beginRoundSplashScreen);
			trace("fadeBeginRoundSplash");
		}
	
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		
		/*TILE FUNCTIONS */
		
		private function tilesRun():void
		{
			tiles.visible = true;
			if (hint)
			{
				if(quiz)
				{	
					trace(quizScore);
				}
				tiles.reveal(round);
			}
			countdownTimer.stop();
			countdownTimer.reset();
			countdownTimer.start();
//			addChildAt(workRankings,0);
		}
		
		private function onTileSelect(e:Event):void
		{
			_available_earnings.subtract(cost);
			available_earnings_var.text = _available_earnings.toString();
			plots_owned ++;
			if (_available_earnings.dollars < 1 && _available_earnings.cents - cost < 0)
			{
				moneyLeft = false;
			} else
			{
				moneyLeft = true;
			}
		}
		
		private function onTileUnselect(e:Event):void
		{
			_available_earnings.add(cost);
			available_earnings_var.text = _available_earnings.toString();
			moneyLeft = true;
			plots_owned --;
		}
		
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		
		private function onFinalizeClick(e:Event):void
		{
			if (Default.totalSelect > 0)
			{
				countdownTimer.stop();
							
				Submit.addData("tiles_r" + (round + 1).toString(), (Default.totalSelect));
				
				//End Round (Finalize Tiles)
				tiles.endRound();
				
				//Types Purchased (Neutral, Pos, Unknwn)
				Submit.addData("unkwn_r" + (round + 1).toString(), tiles.unknownPurchased);
				Submit.addData("pos_r" + (round + 1).toString(), tiles.posPurchased);
				Submit.addData("neut_r" + (round + 1).toString(), tiles.neutralPurchased);
				
				//POINT WHERE ROUND IS INCREASED!
				round++;
				
				//Reset variables to 0 for next round:
				tiles.unknownPurchased = 0;
				tiles.posPurchased = 0;
				tiles.neutralPurchased = 0;
				
				
				waiting();
				moneyLeft = true;
			} else {
				finalizeInstructions.warningText.visible = true;
			}
			
			
		//	gotoAndStop(2);
		//	tiles.visible = false;
		//	shitButton.addEventListener(MouseEvent.CLICK, on2Click);
			
		}
		
		private function on2Click(e:MouseEvent):void
		{
			gotoAndStop(1);
			tiles.visible = true;
		}
		
		
		
		public function get plots_owned():int
		{
			return _plots_owned;
		}
		
		public function set plots_owned(num:int):void
		{
			plots_earned_var.text = num + " cells";
			_plots_owned = num;
		}
		
		public function get time_remaining():int
		{
			return _time_remaining;
		}
		
		public function set time_remaining(num:int):void
		{
			_time_remaining = num;
			time_remaining_var.text = num + " s";
		}
		
		public function get available_earnings():DollarsAndCents
		{
			return _available_earnings;
		}
		
		public function set available_earnings(value:DollarsAndCents):void
		{
			_available_earnings = value;
			available_earnings_var.text = _available_earnings.toString();
		}
		
		protected function onTimerUpdate(e:TimerEvent):void
		{
			time_remaining = time_remaining - 1;
			if (time_remaining == 0)
			{
				finalizeInstructions.warningText.visible = true;
			}
		}
		
		protected function waiting():void
		{
			splash = new SplashScreen();
			splash.addChild(waitingScreen);
			waitingScreen.alpha = 1;
			addChild(splash);
			var rand:int = Math.random() * 7;
			var waitTimer:Timer = new Timer(3000 + rand * 1000, 1);
			waitTimer.start();
			waitTimer.addEventListener(TimerEvent.TIMER, fadeWait);
		}
		
		protected function fadeWait(e:Event):void
		{
			var waitTimer:Timer = new Timer(500, 1);
			waitTimer.addEventListener(TimerEvent.TIMER, removeWait);
			waitTimer.start();
			tiles.computerRound(round, _available_earnings);
			TweenLite.to(waitingScreen, .5, { alpha:0 } );
		}
		
		protected function removeWait(e:Event):void
		{
			splash.removeChild(waitingScreen);
			removeChild(splash);
			nextRound(round);
		}
		
		protected function numberOfTilesRevealed(currentRound:int):int
		{
			switch(currentRound) {
				case 0:
					return 8;
					break;
				case 1:
					return 7;
					break;
				case 2:
					return 8;
					break;
				case 3:
					return 9;
					break;
				default:
					trace("Error: numberOfTilesRevealed() does not return an int");
					return 0;
			}
		}
	}

}