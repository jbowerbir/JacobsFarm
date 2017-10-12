package quiz
{
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ben Calvin
	 * Takes upper corner, width and height, note that the outline is centered around the outter limit of the rectangle
	 * This means that you have to specify a coordinate 1 pixel inside the actual size of the frame.
	 * 
	 */
	public class Frame extends Sprite
	{
		var rectangle:Shape;
		public function Frame(x:int, y:int, width:int , height:int) 
		{
			rectangle = new Shape;
			rectangle.graphics.lineStyle(2, 0X000000);
			rectangle.graphics.drawRect(x, y, width, height);
			addChild(rectangle);
			
		}
		
	}

}