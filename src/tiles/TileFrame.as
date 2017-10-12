package tiles 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class TileFrame extends Sprite
	{
		
		public function TileFrame(height:int, width:int, xoffset:int, yoffset:int, tileSize:int) 
		{
			this.x = xoffset;
			this.y = yoffset;
			var g:Graphics = this.graphics;
			g.lineStyle(2);
			for (var i:int = 0; i < height * width; i++)
			{
				var xtemp:int = 0;
				var ytemp:int = 0;
				var jtemp:int = i;
				while (jtemp > 0)
				{
					if ( jtemp >= height)
					{
						ytemp ++;
						jtemp = jtemp - height;
					} 
					else
					{
						xtemp ++;
						jtemp = jtemp - 1;
					}
				}
				g.drawRect(xtemp * tileSize, ytemp * tileSize, tileSize, tileSize);
			}
		}
		
	}

}