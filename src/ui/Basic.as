package ui 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class Basic extends Sprite
	{
		private static var _txt:TextField;
		private var format:TextFormat;
		
		public function Basic() 
		{
			this.x = 800;
			this.y = 100;
			_txt = new TextField();
			_txt.multiline = true;
			_txt.text = "Hello!"
			
			
			format = new TextFormat();
			format.color = 0xFF0000;
			format.font = "Verdana";
			format.size = 20;
			_txt.setTextFormat(format);
			
			addChild(_txt);
			
		}
			
		public function set txt(s:String):void
		{
			removeChild(_txt);
			_txt.text = "okay";
			addChild(_txt);
		}
		
		public function get txt():String
		{
			return _txt.text;
		}
		
	}

}