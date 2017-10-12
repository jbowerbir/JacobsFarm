package treat 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class Treatment extends Sprite
	{
		protected var treat:int;
		public static var globaltreat:int;
		protected var treatOne:treat.TreatOne;
		public static var revealed:Boolean = true;
		
		public function Treatment(treat:int) 
		{
			Treatment.globaltreat = treat;
			this.treat = treat;
			switch (treat)
			{
				case 0: //Treatment 1.0 (Default, win)
					treatOne = new treat.TreatOne(false, false, 0, true);
					revealed = false;
					addChild(treatOne);
					break;
				case 1: //Treatment -1.0 (Default, loser)
					treatOne = new treat.TreatOne(false, false, 0, false);
					revealed = false;
					addChild(treatOne);
					break; 
				case 2: //Treatment 2.0 (IQ, no-corr, win)
					Treatment.globaltreat = 2;
					treatOne = new treat.TreatOne(true, true, Main.global_work_display_toggle, true); 
					addChild(treatOne);
					break;
				case 3: //Treatment -2.0 (IQ, no-corr, lose)
					treatOne = new treat.TreatOne(true, true, Main.global_work_display_toggle, false);
					addChild(treatOne);
					break;
				case 4: //Treatment 3.0 (work, no-corr, win)
					Treatment.globaltreat = 4;
					treatOne = new treat.TreatOne(true, true, 0, true);
					addChild(treatOne);
					break;
				case 5: //Treatment -3.0 (work, no-corr, lose)
					treatOne = new treat.TreatOne(true, true, 0, false);
					addChild(treatOne);
					break;
				case 6: //Treatment 3.1 (work, +corr, win)
					treatOne = new treat.TreatOne(true, true, 1, true);
					addChild(treatOne);
					break;
				case 7: //Treatment -3.1 (work, +corr, lose)
					treatOne = new treat.TreatOne(true, true, -1, false);
					addChild(treatOne);
					break;
				case 8: //Treatment 3.2 (work, -corr, win)
					treatOne = new treat.TreatOne(true, true, -1, true);
					addChild(treatOne);
					break;
				case 9: //Treatment -3.2 (work, -corr, lose)
					treatOne = new treat.TreatOne(true, true, 1, false);
					addChild(treatOne);
					break;
				case 10: //Same as 2.0, but with tiles randomly revealed.
					treatOne = new treat.TreatOne(true, false, Main.global_work_display_toggle, true);
					addChild(treatOne);
					break;
				default:
					trace("Not a valid treatment");
				
			}
		}
		
	}

}