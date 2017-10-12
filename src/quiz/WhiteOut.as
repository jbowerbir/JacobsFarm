package quiz 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class WhiteOut extends Sprite
	 
	{
		
			
		public function WhiteOut() 
		{
			init(900, 600);
			this.alpha = 0;
			TweenLite.to(this, .5, { alpha:1 }); 
		}
		
		private function init(height:int, width:int):void
		{		
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(50, 50, 900, 600);
			this.graphics.endFill();
			
			
			
		}
	}

}