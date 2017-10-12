package ui 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class SplashScreen extends Sprite
	
	 
	{
		
		public static var splashScreen:Class;
		
		
		public function SplashScreen() 
		{
			init(900, 600);
			//this.alpha = 0;
			//TweenLite.to(this, .5, { alpha:1 }); 
		}
		
		private function init(height:int, width:int):void
		{
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(0, 0, 1000, 700);
			this.graphics.endFill();
			
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(50, 50, 900, 600);
			this.graphics.endFill();
			
			
			
		}
	}

}