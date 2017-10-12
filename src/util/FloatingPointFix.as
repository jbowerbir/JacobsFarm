package util 
{
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class FloatingPointFix 
	{
		
		public function FloatingPointFix() 
		{
			
		}
		
		public static function twoDecimals(num:Number):Number {
			
			var string:String = num.toString();
			var array:Array;
			var first:int;
			var second:String;
			
			if (string.indexOf(".") > -1)
			{
				array = string.split(".");
				
				first = int(array[0]);
				second = array[1];
				
				for (var i:int = second.length; i > 2; i--)
				{
					var temp:int;
					
					temp = int(second.substring(i - 1, i));
					if (temp > 4) {
						temp = int(second.substring(i - 2, i - 1));
						temp++;
						second = second.slice(0, i - 2) + temp.toString();
					} else {
						second = second.slice(0, i - 1);
					}
				}
			}
			return Number(first + "." + second);
		}
		
	}

}