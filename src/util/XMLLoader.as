package util 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class XMLLoader extends EventDispatcher
	{
		
		private var loader:URLLoader;
		private var data:XML;
		private var i:uint;
		private var lenXML:uint;
		public var pages:Array = [];
		
		public function XMLLoader() 
		{
			loader = new URLLoader();
		}
		
		public function load(_req:String):void
		{
			loader.load(new URLRequest(_req));
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.addEventListener(Event.COMPLETE, loaded);
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			dispatchEvent(new Event("XML_IOError"));
		}
		
		private function secError(e:SecurityErrorEvent):void
		{
			dispatchEvent(new Event("XML_SecurityError"));
		}
		
		private function loaded(e:Event):void
		{
			try
			{
				data = new XML(loader.data);
				lenXML = data.children().length();
				
				for (i = 0; i < lenXML; i++)
				{
					pages.push(data.children()[i]);
				}
				dispatchEvent(new Event("XML_Loaded"));
			} catch (e:Error) {
				dispatchEvent(new Event("XML_ParseError"));
			}
		}
	}

}