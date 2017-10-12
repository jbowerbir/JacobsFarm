package instructions 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class StartButton extends Sprite
	{
		[Embed(source = "../../assets/start.png")]
		public static var letsgoClass:Class;
		public static var letsgo:Bitmap = new letsgoClass();
		
		public function StartButton()
		{
		this.buttonMode = true;
		
		
		var text:TextField = new TextField();
		
		var font:String = "Calibri";		
		var format:TextFormat = new TextFormat(font, 32, 0x330000);
		
		
		text.text = "Click to begin!";
		text.setTextFormat(format);
		text.selectable = false;
		text.autoSize = "left";
		
		this.graphics.beginFill(0xDCDCDC, 1);
		this.graphics.drawRect(110, 0, 200, 100);
		this.graphics.endFill();
		this.graphics.beginFill(0xF5F5F5, 1);
		this.graphics.drawRect(111, 1, 198, 98);
		this.graphics.endFill();
		
		addChild(letsgo);
		letsgo.x = 160;
		letsgo.y = 20;
		//addChild(text);
		text.y = letsgo.height + 35;
		text.x = 100;
		
		//These control the opacity
			this.addEventListener(MouseEvent.ROLL_OVER, coolRoll_Over);
			this.addEventListener(MouseEvent.ROLL_OUT, coolRoll_Out);
	
		}
	private function coolRoll_Over(event:Event):void 
	{
		this.alpha = .8;
	}
		
		private function coolRoll_Out(event:Event):void 
	{
		this.alpha = 1;
	}
	}	
}

