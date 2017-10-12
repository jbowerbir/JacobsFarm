package treat 
{
	import flash.events.MouseEvent;
	import ui.Layout;
	import ui.OutcomePhase;
	import ui.SplashScreen;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class TreatmentTest extends Layout
	{
		public var outcomeSplash:SplashScreen = new SplashScreen;
		public var outcomeDisplay:OutcomePhase = new OutcomePhase;
		
		public function TreatmentTest() 
		{
			super(true, true);
		}
		
		override protected function nextRound(round:int):void 
		{
			if (round == 1)
			{
				outcomeDisplay.rank1.text = "You";
				outcomeDisplay.rank2.text = "Player 3";
				outcomeDisplay.rank3.text = "Player 1";
				outcomeDisplay.rank1_money.text = String (5.30);
				outcomeDisplay.rank2_money.text = String (4.90);
				outcomeDisplay.rank3_money.text = String (4.00);
				outcomeDisplay.addEventListener(MouseEvent.CLICK, onRoundClick);
				available_earnings = 5.30 - cost * _plots_owned;
			}
				
			if (round == 2)
			{
				outcomeDisplay.rank1.text = "Player 3";
				outcomeDisplay.rank2.text = "You";
				outcomeDisplay.rank3.text = "Player 1";
				outcomeDisplay.rank1_money.text = String (8.40);
				outcomeDisplay.rank2_money.text = String (7.70);
				outcomeDisplay.rank3_money.text = String (6.20);
				available_earnings = 8.60 - cost * _plots_owned;
			}
			
			if (round == 3)
			{
				outcomeDisplay.rank1.text = "You";
				outcomeDisplay.rank2.text = "Player 3";
				outcomeDisplay.rank3.text = "Player 1";
				outcomeDisplay.rank1_money.text = String (10.00);
				outcomeDisplay.rank2_money.text = String (9.40);
				outcomeDisplay.rank3_money.text = String (7.20);
				available_earnings = 8.60 - cost * _plots_owned;
				outcomeDisplay.removeEventListener(MouseEvent.CLICK, onRoundClick);
			}
			
			outcomeSplash.addChild(outcomeDisplay);
			addChild(outcomeSplash);
			super.nextRound(round);
			
		}
		
		public function onRoundClick(e:MouseEvent):void
		{
			removeChild(outcomeSplash);
		}
		
	}

}