package treat 
{
	import flash.events.Event;
	import flash.text.engine.CFFHinting;
	import tiles.State;
	import tiles.TileArray;
	import ui.Basic;
	import ui.Layout;
	import util.Score;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class Default extends TileArray
	{
		//NEEDS TO HAVE A BASIC UI ADDED TO IT (UNDER CONSTRUCTION)
		
		
		/*Treatment Variables Enable or Disable */
		
		public var ranking:Rank;
		public var effort:Effort;
		public var layout:Layout;
		
		public function Default(height:int, width:int) 
		{
			super(height, width);
			//layout = new Layout(hint);
			//addChild(layout);
			//addEventListener("tileSelect", onTileSelect);
			//addEventListener("tileUnselect", onTileUnselect);
			
			
		}
		
		public static function set totalSelect(value:int):void
		{
			_totalSelect = value;
		}
		
		public static function get totalSelect():int {
			return _totalSelect;
		}
		
		
	}

}