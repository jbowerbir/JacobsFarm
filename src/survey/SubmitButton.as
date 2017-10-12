package survey
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class SubmitButton extends Sprite
	{
		[Embed(source = "../../assets/transparentbox.png")]
		public static var letsgoClass:Class;
		public static var letsgo:Bitmap = new letsgoClass();
		
		public function SubmitButton()
		{
		this.buttonMode = true;
		
		var text:TextField = new TextField();
		
		var font:String = "Calibri";		
		var format:TextFormat = new TextFormat(font, 32, 0x330000);
		
		text.text = "Submit";
		text.setTextFormat(format);
		text.selectable = false;
		text.autoSize = "left";
		
		this.graphics.beginFill(0xDCDCDC, 1);
		this.graphics.drawRect(0, 0, 150, 70);
		this.graphics.endFill();
		this.graphics.beginFill(0xF5F5F5, 1);
		this.graphics.drawRect(1, 1, 148, 68);
		this.graphics.endFill();
		
		
		
		
		addChild(text);
		text.x = 25;
		text.y = 15;
		
		addChild(letsgo);
		letsgo.x = 0;
		letsgo.y = 0;

		
		//These control the opacity
			this.addEventListener(MouseEvent.ROLL_OVER, coolRoll_Over);
			this.addEventListener(MouseEvent.ROLL_OUT, coolRoll_Out);
	
		}
	private function coolRoll_Over(event:Event):void 
	{
		this.alpha = .7;
	}
		
		private function coolRoll_Out(event:Event):void 
	{
		this.alpha = 1;
	}
	}	
}

