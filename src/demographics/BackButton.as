package demographics 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class BackButton extends Sprite
	{
		[Embed(source = "../../assets/back.png")]
		public static var backClass:Class;
		public static var back:Bitmap = new backClass();
		
		public function BackButton()
		{
		this.buttonMode = true;
		
		
		var text:TextField = new TextField();
		
		var font:String = "Calibri";		
		var format:TextFormat = new TextFormat(font, 28, 0x330000);
		
		
		text.text = "Back";
		text.setTextFormat(format);
		text.selectable = false;
		text.autoSize = "left";
		
		/*this.graphics.beginFill(0xDCDCDC, 1);
		this.graphics.drawRect(0, 0, 135, 74);
		this.graphics.endFill();
		this.graphics.beginFill(0xF5F5F5, 1);
		this.graphics.drawRect(1, 1, 133, 72);
		this.graphics.endFill();*/
		
		addChild(back);
		back.x = 4;
		back.y = 5;
		addChild(text);
		
		text.x = back.width + 5;
		text.y = 17;
		
		//These control the opacity
			this.addEventListener(MouseEvent.ROLL_OVER, coolRoll_Over);
			this.addEventListener(MouseEvent.ROLL_OUT, coolRoll_Out);
		}
		
		private function coolRoll_Over(event:Event):void {
			this.alpha = .8;
		}
		
		private function coolRoll_Out(event:Event):void {
			this.alpha = 1;
		}
		
	}

}