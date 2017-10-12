package instructions 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class ForwardButton extends Sprite
	{
		[Embed(source = "../../assets/forward.png")]
		public static var forwardClass:Class;
		public static var forward:Bitmap = new forwardClass();
		
		public function ForwardButton()
		{this.buttonMode = true;
		
		
		var text:TextField = new TextField();
		
		var font:String = "Calibri";		
		var format:TextFormat = new TextFormat(font, 28, 0x330000);
		
		
		text.text = "Next";
		text.setTextFormat(format);
		text.selectable = false;
		text.autoSize = "left";
		
		this.graphics.beginFill(0xDCDCDC, 1);
		this.graphics.drawRect(0, 0, 135, 74);
		this.graphics.endFill();
		this.graphics.beginFill(0xF5F5F5, 1);
		this.graphics.drawRect(1, 1, 133, 72);
		this.graphics.endFill();
		
		addChild(forward);
		forward.x = 70;
		forward.y = 5;
		addChild(text);
		
		text.x = forward.width - 55;
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