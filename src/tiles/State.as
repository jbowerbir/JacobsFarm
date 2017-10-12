package tiles 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.ui.Mouse;
	import treat.Default;
	import ui.Layout;
	import util.CustomEvent;
	import util.Point;
	/**
	 * ...
	 * @author Ben Calvin
	 * The state class has a private variable called "current" that can be changed to change the current state.
	 * As of now,
	 * 0 : Default
	 * 1 : Player
	 * 2 : Comp1 (Green)
	 * 3 : Comp2 (Blue)
	 * 
	 * NOTE:AS OF THIS WRITING, COST AND BEGINNING MONEY MUST BE SET BOTH PLACES (LAYOUT AND HERE)
	 */
	public class State extends Sprite
	{
		
		[Embed(source="../../assets/tiles/defaultTile.gif")]
		public static var blankTile:Class;
		
		[Embed(source = "../../assets/tiles/player.gif")]
		public static var player:Class;
		
		[Embed(source = "../../assets/tiles/comp1.gif")]
		public static var comp1:Class;
		
		[Embed(source = "../../assets/tiles/comp2.gif")]
		public static var comp2:Class;
		
		[Embed(source = "../../assets/tiles/vertical.png")]
		public static var vertical:Class;
		
		[Embed(source = "../../assets/tiles/horizontal.png")]
		public static var horizontal:Class;
		
		[Embed(source = "../../assets/tiles/leanright.png")]
		public static var leanleft:Class;
		
		public static var switcher:Class; //TEMP VARIABLE FOR SWITCHING RED/GREEN
		
		private var _current:int;
		private var _display:Bitmap;
		public var coordinates:util.Point;
		public var location:util.Point;
		public var mouseOver:Bitmap;
		private var _reveal:int = 0;
		private var revealBitmap:Bitmap;
		public var cost:Number = .2;
		public var currency:Number = 3.00;
		public var revealState:int = 0;
		
		if (!(Main.playerWin))
			{
				switcher = player;
				player = comp1;
				comp1 = switcher;
			}
		
		public function State(coordinates:Point, location:Point) 
		{
			
			this.coordinates = coordinates;
			this.location = location;
			this.x = coordinates.x;
			this.y = coordinates.y;
			
			/* The following code is necessary for initializing objects that are called
			 * by later functions:
			 */
			
			_display = new blankTile();
			revealBitmap = new blankTile();
			mouseOver = new player();
			mouseOver.alpha = 0;
			revealBitmap.alpha = 0;
			addChildAt(mouseOver, 0);
			addChild(revealBitmap);

			
			current = 0;
			addChild(_display);
		}
		
		public function set current(state:int):void
		{

			addChild(_display);
			setState(state);
			_current = state;
		}
		
		public function get current():int
		{
			return _current;
		}
		
		private function setState(state:int):void
		{
			removeChild(_display);
			_display.alpha = 0;
			switch (state)
			{
				case 0:
					_display = new blankTile();
					break;
				case 1:
					_display = new player();
					break;
				case 2:
					_display = new comp1();
					break;
				case 3:
					_display = new comp2();
					break;
				default:
					trace("Error - Tile State Failed to Load");
			}
			_display.alpha = 0;
			addChildAt(_display,0);
			TweenLite.to(_display, .2, { alpha:1 } );
		}
		
		public function activate():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function deactivate():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			if (contains(mouseOver))
			{
				removeChild(mouseOver);
			}
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			if (contains(mouseOver))
			{
				TweenLite.to(mouseOver, .2, { alpha:0.5 } );
			}
		}

		private function onClick(e:MouseEvent):void
		{
			if (current == 0  && Layout.moneyLeft) //Removed: && TileArray.totalSelect < TileArray.numToSelect
			{
				current = 1;
				TileArray.totalSelect ++;
				trace(TileArray.totalSelect);
				dispatchEvent(new Event("tileSelect", true));
				
			} else if (current == 1)
			{
				current = 0;
				TileArray.totalSelect --;
				dispatchEvent(new Event("tileUnselect", true));
			}
			
			var refreshInstructions:CustomEvent = new CustomEvent("practiceFinalized", true);
			dispatchEvent(refreshInstructions);
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			if (contains(mouseOver))
			{
				TweenLite.to(mouseOver, .2, { alpha:0 } );
			}
		}
		
		public function get reveal():int
		{
			return _reveal;
		}
		
		public function set reveal(num:int):void
		{
			removeChild(revealBitmap);
			revealState = num;
			switch(num)
			{
				case 0:
					revealBitmap = new blankTile();
					break;
				case 1:
					revealBitmap = new horizontal();
					break;
				case 2:
					revealBitmap = new vertical();
					break;
				case 3:
					revealBitmap = new leanleft();
					break;
				default:
					trace("Bitmap failed to load.");
			}
			revealBitmap.alpha = 0;
			_reveal = num;			
			addChild(revealBitmap);
			TweenLite.to(revealBitmap, .2, { alpha:1 } );
		}
		
		
	}

}