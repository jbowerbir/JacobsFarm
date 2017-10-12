package tiles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import treat.Default;
	import ui.Layout;
	import util.DollarsAndCents;
	import util.Point;
	
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class TileArray extends Sprite
	{
		public var _array:Array;
		public var aheight:int;
		public var awidth:int;
		public var xoffset:int = 80;
		public var yoffset:int = 100;
		public var tileSize:int = 30;
		public var frame:TileFrame;
		public static var _totalSelect:int;
		public static var numToSelect:int = 10;
		public var numPositive:int = 2;
		public var numNegative:int = 3;
		public var numNeutral:int = 1;
		
		public var unknownPurchased:int = 0;
		public var posPurchased:int = 0;
		public var neutralPurchased:int = 0;
		
		public function TileArray(height:int, width:int)
		{
			this.aheight = height;
			this.awidth = width;
			init(); //Initialization Function
			
			frame = new TileFrame(aheight, awidth, xoffset, yoffset, tileSize); //Draws the Frame for the Array, overlays (so must be on top of everything)
			addChild(frame);
		}
		
		public function setArray(ay:int, ax:int, o:Object):void
		{
			_array[ay * aheight + ax] = o;
		}
		
		public function getArray(ay:int, ax:int):Object
		{
			return _array[ay * aheight + ax];
		}
		
		private function init():void
		{
			_array = new Array((aheight - 1) * (awidth - 1));
			totalSelect = 0;
			for (var i:int = 0; i < (aheight * awidth); i++)
			{
				var ytemp:int = 0;
				var xtemp:int = 0;
				var j:int = i;
				while (j > 0)
				{
					if (j >= aheight)
					{
						ytemp++;
						j = j - aheight;
					}
					else
					{
						xtemp++;
						j = j - 1;
					}
				}
				_array[i] = new State(new Point(xoffset + xtemp * tileSize, yoffset + ytemp * tileSize), new Point(xtemp, ytemp));
				_array[i].activate();
				addChild(_array[i]);
			}
		}
		
		public function endRound():void
		{
			trace(_totalSelect);
			trace(_array.length);
			var tempLength:int = _array.length;
			for (var i:int = 0; i < _array.length; i++)
			{
				if (_array[i].current == 1)
				{
					if (_array[i].revealState == 1)
					{
						posPurchased = posPurchased + 1;
					}
					else if (_array[i].revealState == 2)
					{
						neutralPurchased = neutralPurchased + 1;
					}
					else
					{
						unknownPurchased = unknownPurchased + 1;
					}
					_array[i].deactivate();
					_array.splice(i, 1);
					i--;
				}
			}
			trace("cereal");
			trace(posPurchased);
			trace(unknownPurchased);
			
			_totalSelect = 0;
		}
		
		public function computerRound(round:int, available:DollarsAndCents):void
		{
			var rand:int;
			var round:int = round;
			var blue:int = 0;
			var green:int = 0;
			var percent:Number;
			var notPurchased:int;
			
			notPurchased = available.dollars * 100 + available.cents;
			if (Main.playerWin)
			{
				switch (round)
				{
					case 1: 
						percent = (200 - notPurchased) / 200;
						green = percent * 10;
						blue = percent * 10;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 2: 
						percent = (320 - notPurchased) / 320;
						green = percent * 11;
						blue = percent * 19;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 3: 
						percent = (695 - notPurchased) / 695;
						green = percent * 8;
						blue = percent * 22;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 4: 
						percent = (810 - notPurchased) / 810;
						green = percent * 15;
						blue = percent * 17;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					default: 
						trace("NOT A ROUND, SO NO COMPUTER TILES");
				}
			}
			else
			{
				switch (round)
				{
					case 1: 
						percent = (200 - notPurchased) / 200;
						green = percent * 10;
						blue = percent * 10;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 2: 
						percent = (225 - notPurchased) / 225;
						green = percent * 16;
						blue = percent * 19;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 3: 
						percent = (260 - notPurchased) / 260;
						green = percent * 34;
						blue = percent * 22;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					case 4: 
						percent = (310 - notPurchased) / 310;
						green = percent * 40;
						blue = percent * 17;
						if (blue == 0)
						{
							blue = 1;
						}
						if (green == 0)
						{
							green = 1;
						}
						break;
					default: 
						trace("NOT A ROUND, SO NO COMPUTER TILES");
				}
			}
			
			for (var i:int = 0; i < green; i++)
			{
				rand = (Math.random() * _array.length);
				_array[rand].current = 2;
				_array[rand].deactivate();
				_array.splice(rand, 1);
			}
			for (var i:int = 0; i < blue; i++)
			{
				rand = (Math.random() * _array.length);
				_array[rand].current = 3;
				_array[rand].deactivate();
				_array.splice(rand, 1);
				
			}
		}
		
		public function reveal(round:int):void
		{
			var rand:int;
			var rand2:Number;
			var j:int = 0;
			
			switch (round)
			{
				case 0: 
					numPositive = 1;
					numNegative = 1;
					numNeutral = 6;
					break;
				
				case 1: 
					numPositive = 2;
					numNegative = 2;
					numNeutral = 4;
					break;
				case 2: 
					numPositive = 1;
					numNeutral = 7;
					break;
				case 3: 
					numPositive = 2;
					numNegative = 3;
					numNeutral = 4;
					break;
			}
			numNegative;
			numPositive;
			var a:Array = new Array(numPositive + numNegative);
			
			/*
			   for (var i:int = 0 ; i < num ; i++)
			   {
			   rand = (Math.random() * _array.length);
			   trace("loop");
			   if (check(rand, a))
			   {
			   a[j] = rand;
			   j++;
			   rand2 = Math.random();
			   trace(rand2);
			   if (rand2 < .15)
			   {
			   _array[rand].reveal = 1;
			   } else if (rand2 < .7)
			   {
			   _array[rand].reveal = 3;
			   } else
			   {
			   _array[rand].reveal = 2;
			   }
			
			   } else
			   {
			   i--;
			   }
			   }
			 */
			
			if (Layout.hint)
			{
				for (var i:int = 0; i < numPositive; i++)
				{
					rand = (Math.random() * _array.length);
					if (check(rand, a) && _array[rand].reveal==0)
					{
						_array[rand].reveal = 1;
						a[j] = rand;
						j++;
					}
					else
					{
						i--;
					}
				}
				
				for (var i:int = 0; i < numNegative; i++)
				{
					rand = (Math.random() * _array.length);
					if (check(rand, a) && _array[rand].reveal==0)
					{
						_array[rand].reveal = 3;
						_array[rand].deactivate();
						a[j] = rand;
						j++;
					}
					else
					{
						i--;
					}
					
				}
				
				for (var i:int = 0; i < numNeutral; i++)
				{
					rand = (Math.random() * _array.length);
					if (check(rand, a) && _array[rand].reveal==0)
					{
						_array[rand].reveal = 2;
						//_array[rand].deactivate();
						a[j] = rand;
						j++;
					}
					else
					{
						i--;
					}
					
				}
				
				/*
				   for (var i:int = 0; i < numNeutral; i++)
				   {
				   rand = (Math.random() * _array.length);
				   if (check(rand, a))
				   {
				   _array[rand].reveal = 3;
				   a[j] = rand;
				   j++;
				   } else
				   {
				   i--;
				   }
				   }
				 */
			}
		
		}
		
		public function check(rand:int, a:Array)
		{
			for (var k:int = 0; k < a.length; k++)
			{
				if (rand == a[k])
				{
					return false;
				}
			}
			trace("true");
			return true;
		}
		
		public static function set totalSelect(value:int):void
		{
			_totalSelect = value;
		}
		
		public static function get totalSelect():int
		{
			return _totalSelect;
		}
	
	}

}