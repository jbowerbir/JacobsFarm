package util 
{
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class DollarsAndCents 
	{
		public var dollars:int;
		public var cents:int;
		
		public function DollarsAndCents(dollars:int, cents:int)
		{
			this.dollars = dollars;
			this.cents = cents;
		}
		
		public function toString():String
		{
			if (cents < 10) {
				return "$"+dollars.toString() + ".0" + cents.toString();
			} else {
				return "$"+dollars.toString() +"." + cents.toString();
			}
		}
		
		//Adds in cents
		public function add(num:int):void
		{
			cents = cents + num;
			while (cents >= 100) {
				dollars++;
				cents = cents - 100;
			}
		}
		
		//Subtracts in cents
		public function subtract(num:int):void {
			cents = cents - num;
			while (cents < 0) {
				cents = cents + 100;
				dollars--;
			}
		}
		
		//Redefines Amount
		public function changeTo(dollars:int, cents:int):void
		{
			this.dollars = dollars;
			this.cents = cents;
		}
		
	}

}