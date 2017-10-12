package treat 
{
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.Layout;
	import flash.events.MouseEvent;
	import ui.SplashScreen;
	import com.greensock.TweenLite;
	import demographics.Demographics;
	import survey.Survey_Vote;
	import allocate.AllocateSplash;
	import util.Submit;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class TreatOne extends Layout 
	{
		public var outcomeSplash:SplashScreen = new SplashScreen;
		public var currentGraph:Bitmap;
		public var currentOverlay:Bitmap;
		public var allocater:allocate.AllocateSplash = new allocate.AllocateSplash();
		
		[Embed(source="../../assets/treatOne/1_1_2.png")]
		private static var roundOne:Class;
		
		[Embed(source="../../assets/treatOne/1_1_1.png")]
		private static var roundOneG:Class;
		
		[Embed(source="../../assets/treatOne/2_1_2.png")]
		private static var roundTwo:Class;
		
		[Embed(source="../../assets/treatOne/2_1_1.png")]
		private static var roundTwoG:Class;
		
		[Embed(source="../../assets/treatOne/3_1_2.png")]
		private static var roundThree:Class;
		
		[Embed(source="../../assets/treatOne/3_1_1.png")]
		private static var roundThreeG:Class;
		
		[Embed(source="../../assets/treatOne/4_1_2.png")]
		private static var roundFour:Class;
		
		[Embed(source="../../assets/treatOne/4_1_1.png")]
		private static var roundFourG:Class;
		
		[Embed(source="../../assets/treatOne/RoundOne_NOCORR_0.png")]
		private static var roundOneNoCorr_0:Class;
		
		[Embed(source="../../assets/treatOne/RoundOne_NOCORR_1.png")]
		private static var roundOneNoCorr_1:Class;
		
		[Embed(source="../../assets/treatOne/RoundTwo_NOCORR_0.png")]
		private static var roundTwoNoCorr_0:Class;
		
		[Embed(source="../../assets/treatOne/RoundTwo_NOCORR_1.png")]
		private static var roundTwoNoCorr_1:Class;
		
		[Embed(source="../../assets/treatOne/RoundThree_NOCORR_0.png")]
		private static var roundThreeNoCorr_0:Class;
		
		[Embed(source="../../assets/treatOne/RoundThree_NOCORR_1.png")]
		private static var roundThreeNoCorr_1:Class;
		
		[Embed(source="../../assets/treatOne/RoundFour_NOCORR_0.png")]
		private static var roundFourNoCorr_0:Class;
		
		[Embed(source="../../assets/treatOne/RoundFour_NOCORR_1.png")]
		private static var roundFourNoCorr_1:Class;
		
		
		protected var corr:int;
		var continueButton_design:Layout_Conitnue = new Layout_Conitnue();
		var continueButton:Sprite = new Sprite();
		public var continueInstructions:ContinueInstructions = new ContinueInstructions();
		
		public function TreatOne(hint:Boolean, quiz:Boolean, corr:int, win:Boolean) 
		{
			continueButton.addChild(continueButton_design);
			continueButton.x = 705;
			continueButton.y = 580;
			outcomeSplash.addChild(continueButton);
			outcomeSplash.addChild(continueInstructions);
			continueInstructions.x = 310;
			continueInstructions.y = 610;
			this.corr = corr;
			
			super(hint, quiz);
		}
		
		override protected function nextRound(round:int):void
		{
			finalizeInstructions.warningText.visible = false;
			if (currentGraph != null)
			{
				currentGraph.alpha = 0;
			}
			if (Main.playerWin)
			{
				if (round == 1)
				{
					currentGraph = new roundOne();
					currentOverlay = new roundOneG();
					currentOverlay.x = 300;
					currentGraph.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					_available_earnings.changeTo(3, 20);
					continueButton.addEventListener(MouseEvent.CLICK, onRoundClick);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr1();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr1();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 2)
				{
					currentGraph = new roundTwo();
					currentOverlay = new roundTwoG();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					_available_earnings.changeTo(6,95);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr2();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr2();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 3)
				{
					currentGraph = new roundThree();
					currentOverlay = new roundThreeG();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					available_earnings.changeTo(8, 10);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr3();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr3();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 4)
				{
					currentGraph = new roundFour();
					currentOverlay = new roundFourG();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr4();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr4();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
					continueButton.removeEventListener(MouseEvent.CLICK, onRoundClick);
					continueButton.addEventListener(MouseEvent.CLICK, onEndClick);
				}
			} else 
			{
				if (round == 1)
				{
					currentGraph = new roundOneNoCorr_1();
					currentOverlay = new roundOneNoCorr_0;
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					_available_earnings.changeTo(2, 25);
					continueButton.addEventListener(MouseEvent.CLICK, onRoundClick);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr1();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr1();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 2)
				{
					currentGraph = new roundTwoNoCorr_1();
					currentOverlay = new roundTwoNoCorr_0();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					_available_earnings.changeTo(2, 60);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr2();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr2();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 3)
				{
					currentGraph = new roundThreeNoCorr_1();
					currentOverlay = new roundThreeNoCorr_0();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					_available_earnings.changeTo(3, 10);
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr3();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr3();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
				}
				if (round == 4)
				{
					currentGraph = new roundFourNoCorr_1();
					currentOverlay = new roundFourNoCorr_0();
					currentGraph.x = 300;
					currentOverlay.x = 300;
					currentOverlay.y = 50;
					currentGraph.y = 50;
					if (corr != 0) {
						currentOverlay.x = 100;
						currentGraph.x = 100;
						if (corr == 1){
							workRankings = new workRankingsCorr4();
							workRankings.x = 500;
							workRankings.y = 50;
						} else
						{
							workRankings = new workRankingsNeCorr4();
							workRankings.x = 500;
							workRankings.y = 50;
						}
						if (corr == 0)
						{
							workRankings.visible = false;
						}
					}
					continueButton.removeEventListener(MouseEvent.CLICK, onRoundClick);
					continueButton.addEventListener(MouseEvent.CLICK, onEndClick);
				}
			}
				available_earnings_var.text = _available_earnings.toString();
				addChild(outcomeSplash);
				currentGraph.alpha = 0;
				outcomeSplash.addChildAt(currentGraph, 0);
				if (workRankings != null) {
				outcomeSplash.addChildAt(workRankings,0);	
				}
				outcomeSplash.addChildAt(currentOverlay,0);
				TweenLite.to(currentGraph, 2, { alpha:1, delay:1 } );
				super.nextRound(round);
		}
		/*
		override protected function nextRound(round:int):void 
		{
			removeChild(workRankings);
			if (Main.playerWin)
			{
				if (currentGraph != null) 
				{
					currentGraph.alpha = 0;
				}
				if (round == 1)
				{
					tiles.mouseChildren = false;
					currentGraph = new roundOne();
					currentOverlay = new roundOneG();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 3200;
					
					if (Main.playerWin){
						workRankings = new workRankingsCorr2();
					} else
					{
						workRankings = new workRankingsNeCorr2();
					}
						continueButton.addEventListener(MouseEvent.CLICK, onRoundClick);
					}
					
				if (round == 2)
				{
					tiles.mouseChildren = false;
					currentGraph = new roundTwo();
					currentOverlay = new roundTwoG();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 6950;
					
					if (Main.playerWin){
						workRankings = new workRankingsCorr3();
					} else
					{
						workRankings = new workRankingsNeCorr3();
					}
				}
				
				if (round == 3)
				{
					tiles.mouseChildren = false;
					currentGraph = new roundThree();
					currentOverlay = new roundThreeG();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 8100;
					if (Main.playerWin){
						workRankings = new workRankingsCorr4();
					} else
					{
						workRankings = new workRankingsNeCorr4();
					}					
					
				}
				
				if (round == 4)
				{
					tiles.mouseChildren = false;
					currentGraph = new roundFour();
					currentOverlay = new roundFourG();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					continueButton.removeEventListener(MouseEvent.CLICK, onRoundClick);
					continueButton.addEventListener(MouseEvent.CLICK, onEndClick);
				}
				currentGraph.alpha = 0;
				currentOverlay.alpha = 1;
				addChild(currentOverlay);
				addChild(currentGraph);
				addChild(continueButton);
				TweenLite.to(currentGraph, 2, { alpha:1 , delay:2} );
				//TweenLite.to(currentOverlay, 2, { alpha:1 } );
				super.nextRound(round);
			} else {
				if (currentGraph != null) 
				{
					currentGraph.alpha = 0;
				}
				if (round == 1)
				{
					tiles.mouseChildren = false;
					currentOverlay = new roundOneNoCorr_0();
					currentGraph = new roundOneNoCorr_1();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 2250;
					continueButton.addEventListener(MouseEvent.CLICK, onRoundClick);
					if (Main.playerWin){
						workRankings = new workRankingsCorr1();
					} else
					{
						workRankings = new workRankingsNeCorr1();
					}			
					
				}
					
				if (round == 2)
				{
					tiles.mouseChildren = false;
					currentOverlay = new roundTwoNoCorr_0();
					currentGraph = new roundTwoNoCorr_1();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 2600;
					
					if (Main.playerWin){
						workRankings = new workRankingsCorr3();
					} else
					{
						workRankings = new workRankingsNeCorr3();
					}			
				}
				
				if (round == 3)
				{
					tiles.mouseChildren = false;
					currentOverlay = new roundThreeNoCorr_0();
					currentGraph = new roundThreeNoCorr_1();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					available_earnings = 3100;
					
					if (Main.playerWin){
						workRankings = new workRankingsCorr4();
					} else
					{
						workRankings = new workRankingsNeCorr4();
					}			
				}
				
				if (round == 4)
				{
					tiles.mouseChildren = false;
					currentOverlay = new roundFourNoCorr_0();
					currentGraph = new roundFourNoCorr_1();
					currentOverlay.x = 555
					currentOverlay.y = 30;
					currentGraph.x = 555;
					currentGraph.y = 30;
					continueButton.removeEventListener(MouseEvent.CLICK, onRoundClick);
					continueButton.addEventListener(MouseEvent.CLICK, onEndClick);
				}
				currentGraph.alpha = 0;
				currentOverlay.alpha = 1;
				addChild(currentOverlay);
				addChild(currentGraph);
				addChild(continueButton);
				TweenLite.to(currentGraph, 2, { alpha:1 , delay:2 } );
				addChildAt(workRankings, 0);
				//TweenLite.to(currentOverlay, 2, { alpha:1 } );
				super.nextRound(round);
			}
			workRankings.x = 550;
			workRankings.y = 70;
		}
		
		*/
		
		public function onRoundClick(e:MouseEvent):void
		{
			outcomeSplash.removeChild(currentOverlay);
			outcomeSplash.removeChild(currentGraph);
			if (workRankings != null){
				outcomeSplash.removeChild(workRankings);
			}
			removeChild(outcomeSplash);
			
			tiles.mouseChildren = true;
			quizRun(quiz);
		}
		
		public var endSurveyScreen:PostVotingScreen;
		public var survey:survey.Survey_Vote;
		public var final_results_splash:SplashScreen;
		
		[Embed(source = "../../assets/FinalResults_Win_Corr.png")]
		private static var final_result_win_corr:Class;
		
		[Embed(source = "../../assets/FinalResults_Win_NoCorr.png")]
		private static var final_result_win_ne_corr:Class;
		
		[Embed(source="../../assets/FinalResults_Win_NoWork.png")]
		private static var final_result_win_no_work:Class;
		
		private var final_results:Bitmap;
		
		public function onEndClick(e:MouseEvent):void
		{
			outcomeSplash.removeChild(currentOverlay);
			outcomeSplash.removeChild(currentGraph);
			if (workRankings != null){
				outcomeSplash.removeChild(workRankings);
			}
			removeChild(outcomeSplash);
			final_results_splash = new SplashScreen();
			if (corr == 1) {
				final_results = new final_result_win_corr();
			} else if (corr == -1) {
				final_results = new final_result_win_ne_corr();
			} else {
				final_results = new final_result_win_no_work();
			}
			final_results_splash.addChild(final_results);
			final_results.x = 160;
			final_results.y = 220;
			final_results_splash.addChild(continueButton);
			continueButton.removeEventListener(MouseEvent.CLICK, onEndClick);
			continueButton.addEventListener(MouseEvent.CLICK, onFinalResultsContinueClick);
			addChild(final_results_splash);
			
		}
			
			
		public function onFinalResultsContinueClick(e:Event):void {
			removeChild(final_results_splash);
			survey = new Survey_Vote(Treatment.globaltreat);
			addChild(survey);
			addEventListener("REDISTRIBUTE", startRedistribute);
			addEventListener("surveyFinished", endSurvey);
		}
			
		public function startRedistribute(e:Event):void	{
			if (corr == 1)  {
				allocater.pos_corr();
			} else if (corr == -1) {
				allocater.neg_corr();
			}
			addChild(allocater);
			this.addEventListener("REDISTRIBUTE_DONE", endGame);
			//SKIPS TO AFTER VOTING PHASE (past end survey)
		}
		
		public function endSurvey(e:Event):void
		{
			removeChild(survey);
			endSurveyScreen = new PostVotingScreen();
			endSurveyScreen.majorityOfPlayers.visible = false;
			endSurveyScreen.paidAmount.visible = false;
			if (Main.playerWin) {
				endSurveyScreen.paidAmount.text = "$9.85";
			} else {
				endSurveyScreen.paidAmount.text = "$3.45";
			}
			addChild(endSurveyScreen);
			var tempTimer:Timer = new Timer(12000, 1);
			tempTimer.addEventListener(TimerEvent.TIMER, majorityOfPlayersAmountPaid);
			tempTimer.start();
		}
		
		public function majorityOfPlayersAmountPaid(e:Event):void
		{
			endSurveyScreen.waiting.visible = false;
			endSurveyScreen.majorityOfPlayers.visible = true;
			endSurveyScreen.paidAmount.visible = true;
			endSurveyScreen.addEventListener(MouseEvent.CLICK, endGame);
		}
		
		
		// No more demographics per Jacob's request :)
		//public function onPaidClick(e:Event):void
		//{
		//	//removeChild(endSurveyScreen);
		//	var demo:Demographics = new Demographics();
		//	addChild(demo);
		//	addEventListener("demographicsFinished", endGame);
		//}
		
		public function endGame(e:Event):void
		{
			removeChild(allocater);
			var thx4playing:ThanksForPlaying = new ThanksForPlaying();
			thx4playing.unique_code.text = "8X"+Main.uniqueCode.toString();
			addChild(thx4playing);
			
		}
		
	}

}