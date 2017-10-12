package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.TextEvent;
	import util.CSS;
	import util.XMLLoader;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class Disclaimer extends SplashScreen
	{
		var field:TextField;
		var xml:XMLLoader;
		var css:CSS;
		var cssBool:Boolean = false;
		var xmlBool:Boolean = false;
		
		[Embed(source="../../assets/agree.png")]
		public static var Agree:Class;
		
		var agreeButton:Bitmap;
				
		public function Disclaimer() 
		{
			super();
			
			field = new TextField();
			addChild(field);
			
			with (field)
			{
				x = 110;
				y = 60;
				multiline = true;
				wordWrap = true;
				condenseWhite = true;
				autoSize = TextFieldAutoSize.CENTER;
				width = 780;
				height = 560;
			}
			
			xml = new XMLLoader();
			xml.load("disclaimer.xml");
			xml.addEventListener("XML_Loaded", xmlDone);
			xml.addEventListener("XML_IOError", error);
			xml.addEventListener("XML_SecurityError", error);
			xml.addEventListener("XML_ParseError", error);
			
			css = new CSS();
			css.load("styles.css");
			css.addEventListener("CSS_Loaded", cssDone);
			css.addEventListener("CSS_IOError", error);
			css.addEventListener("CSS_SecurityError", error);
			css.addEventListener("CSS_ParseError", error);
			
		}
		
		private function error(e:Event):void {  
            switch(e.type) {  
                case "XML_IOError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> XML IO ERROR<br>Please control your XML path!</font></b></p>'  
                break;  
                case "XML_SecurityError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> XML SECURITY ERROR<br>Please control your policy files!</font></b></p>'  
                break;  
                case "XML_ParseError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> XML PARSE ERROR<br>Please debug your XML file!</font></b></p>'  
                break;  
                case "CSS_IOError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> CSS IO ERROR<br>Please control your CSS path!</font></b></p>'  
                break;  
                case "CSS_SecurityError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> CSS SECURITY ERROR<br>Please control your policy files!</font></b></p>'  
                break;  
                case "CSS_ParseError":  
                field.htmlText = '<p align="center"><b><font color="#FF0000" size="12" face="Verdana, Arial, Helvetica, sans-serif"><br> CSS PARSE ERROR<br>Please debug your CSS file!</font></b></p>'  
                break;  
            }  
        }
		
		private function cssDone(e:Event):void
		{
			cssBool = true;
			allDone();
			trace("CSSDONE");
		}
		
		private function xmlDone(e:Event):void
		{
			xmlBool = true;
			allDone();
			trace("XMLDONE");
		}
		
		private function allDone():void
		{
			if (cssBool && xmlBool)
			{
				field.styleSheet = css.sheet;
				field.htmlText = xml.pages[0];
				var style:Object = field.styleSheet.getStyle("para");
				trace(style.fontFamily);
				agreeButton = new Agree();
				addChild(agreeButton);
				with (agreeButton)
				{
					x = 450;
					y = 550;
				}
				addEventListener(MouseEvent.CLICK, onButtonClick);
				trace(agreeButton.height);
				
			}	
		}
		
		private function onButtonClick(e:MouseEvent):void
		{
			parent.removeChild(this);
		}
	}

}