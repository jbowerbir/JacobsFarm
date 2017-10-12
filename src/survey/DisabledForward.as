package survey 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class DisabledForward extends Sprite
	{
		[Embed(source = "../../assets/forward.png")]
		public static var forwardClass:Class;
		public static var forward:Bitmap = new forwardClass();
		
		public function DisabledForward()
		{
		this.buttonMode = true;
		
		
		var text:TextField = new TextField();
		
		var font:String = "Calibri";		
		var format:TextFormat = new TextFormat(font, 28, 0x330000);
		
		
		text.text = "Next";
		text.setTextFormat(format);
		text.selectable = false;
		text.autoSize = "left";
				
		addChild(forward);
		forward.x = 70;
		forward.y = 5;
		addChild(text);
		
		text.x = forward.width - 55;
		text.y = 17;
		
		this.alpha = .5;
		}
		
		
	}

}