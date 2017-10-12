package util
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	import flash.utils.Dictionary;
	import treat.Treatment;
	
	/**
	 * ...
	 * @author Tim Downey
	 */
	public class Submit
	{
		
		//Server URL
		private static var url:String = "submission.server.example.com";
		
		private static var loader:URLLoader = new URLLoader;
		private static var urlreq:URLRequest = new URLRequest(url);
		private static var urlvars:URLVariables = new URLVariables;
		private static var quiz1Array:Array = new Array(21);
		private static var general:Array = new Array(80);
		
		//Init Variables That are Additive
		general[13] = 0;
		general[14] = 0;
		general[15] = 0;
		general[16] = 0;
		general[18] = 0;
		general[19] = 0;
		general[20] = 0;
		general[21] = 0;
		
		general[5] = -9999;
		general[6] = -9999;
		general[7] = -9999;
		general[8] = -9999;
		general[9] = -9999;
		general[10] = -9999;
		general[11] = -9999;
		general[12] = -9999;
		
		
		public function Submit()
		{
		}
		
		static public function init()
		{
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.dataFormat = "VARIABLES";
			//Submit.finalSubmit();

			//This doesn't work (it should), but setting the method to "POST" does.
			//urlreq.method = URLRequestMethod.POST;
			urlreq.method = "POST";
			trace(urlreq.method);
			urlvars.message = "testMessage";
			//Use this for each piece of data that you want to send:
			//Example:
			//urlvars.somearray = array;
			
			loader.addEventListener(Event.COMPLETE, finished);
			
			//Init variables that are additive:
		}
		
		static private function finished(event:Event):void
		{
			trace("Data submitted.");
		}
		
		static public function finalSubmit():void
		{
			var date:Date = new Date();
			var startTime:String = correctDate(date.hours) + correctDate(date.minutes) + correctDate(date.seconds);
			Submit.addData("t1", int ( startTime));
			
			general[17] = general[13] + general[14] + general[15] + general[16];
			general[22] = general[18] + general[19] + general[20] + general[21];
			general[27] = general[23] + general[24] + general[25] + general[26];
			general[32] = general[28] + general[29] + general[30] + general[31];
			general[41] = general[33] + general[35] + general[37] + general[39];
			general[51] = general[43] + general[45] + general[47] + general[49];
						
			if (Treatment.revealed)
			{
				general[34] = 1;
				general[36] = 2 + general[34] - general[33];
				general[38] = 1 + general[36] - general[35];
				general[40] = 2 + general[38] - general[37];
				general[42] = general[40] - general[39];
				general[44] = 6;
				general[46] = 4 + general[44] - general[43];
				general[48] = 7 + general[46] - general[45];
				general[50] = 4 + general[48] - general[47];
				general[52] = general[50] - general[49];
			} else {
			general[34] = 0;
			general[36] = 0;
			general[38] = 0;
			general[40] = 0;
			general[42] = 0;
			general[44] = 0;
			general[46] = 0;
			general[48] = 0;
			general[50] = 0;
			general[52] = 0;
			}
			trace(general);
			
			//urlvars.general = JSON.encode(general);
			//urlvars.arraytest = JSON.encode(Main.array4);
			urlvars.arraytest = JSON.encode(general);
			trace(general.length);
			trace(JSON.encode(general));
			//trace(Main.array4);
			urlreq.data = urlvars;
			trace(urlreq);
			loader.load(urlreq);
		}
		
		
		public static function correctDate(num:Number):String {
			if (num < 10) {
				return "0" + num.toString();
			}
			else return num.toString();
		}
		/* Function that takes data name (corresponding to spreadsheet) and puts it into the appropriate index of the array based on spreadsheet order" */
		
		static public function addData(varName:String, val:int):void
		{
			var index:int;
			switch (varName)
			{
				case "id": //DONE (Main.as)
					general[0] = val;
					break;
				case "date": //DONE (Main.as)
					general[1] = val;
					break;
				case "t0": //DONE (Main.as) *****NOTE: May have bug, and not display correctly with leading "0" for hours, in which case it will be shorter number)*****
					general[2] = val;
					break;
				case "t1": //DONE (Submit.as ~60)
					general[3] = val;
					break;
				case "condition": //DONE (Main.as)
					general[4] = conditionNumber(val);
					trace("Treatment recorded: " + conditionNumber(val));
					break;
				case "intro_q1":
					general[5] = val;
					break;
				case "intro_q2":
					general[6] = val;
					break;
				case "intro_q3":
					general[7] = val;
					break;
				case "intro_q4":
					general[8] = val;
					break;	
				case "intro_q5":
					general[9] = val;
					break;	
				case "intro_q6":
					general[10] = val;
					break;	
				case "intro_q7":
					general[11] = val;
					break;
				case "intro_total":
					general[12] = val;
					break;
				case "test_r1": //DONE (Quiz.as 178 & 186)
					general[13] = general[13] + val;
					break;
				case "test_r2": //DONE (Quiz.as 178 & 186)
					general[14] = general[14] + val;
					break;
				case "test_r3": //DONE (Quiz.as 178 & 186)
					general[15] = general[15] + val;
					break;
				case "test_r4": //DONE (Quiz.as 178 & 186)
					general[16] = general[16] + val;
					break;
				case "test_total":  //DONE
					general[17] = val;
					break;	
				case "iq_r1": //DONE
					general[18] = val;
					break;
				case "iq_r2": //DONE
					general[19] = val;
					break;
				case "iq_r3": //DONE
					general[20] = val;
					break;
				case "iq_r4": //DONE
					general[21] = val;
					break;
				case "iq_total": //DONE
					general[22] = val;
					break;
				case "tiles_r1": //DONE (Layout.as 153)
					general[23] = val;
					break;
				case "tiles_r2": //DONE (Layout.as 153)
					general[24] = val;
					break;	
				case "tiles_r3": //DONE (Layout.as 153)
					general[25] = val;
					break;
				case "tiles_r4": //DONE (Layout.as 153)
					general[26] = val;
					break;
				case "tiles_total": //DONE
					general[27] = val;
					break;
				case "unkwn_r1": //DONE (Layout.as 159)
					general[28] = val;
					break;
				case "unkwn_r2": //DONE (Layout.as 159)
					general[29] = val;
					break;
				case "unkwn_r3": //DONE (Layout.as 159)
					general[30] = val;
					break;
				case "unkwn_r4": //DONE (Layout.as 159)
					general[31] = val;
					break;
				case "unkwn_total": //DONE
					general[32] = val;
					break;
				case "pos_r1": //DONE (Layout.as 159)
					general[33] = val;
					break;
				case "pos_r1a": //DONE
					general[34] = val;
					break;
				case "pos_r2": //DONE (Layout.as 159)
					general[35] = val;
					break;
				case "pos_r2a": //DONE
					general[36] = val;
					break;
				case "pos_r3": //DONE (Layout.as 159)
					general[37] = val;
					break;
				case "pos_r3a": //DONE
					general[38] = val;
					break;
				case "pos_r4": //DONE (Layout.as 159)
					general[39] = val;
					break;
				case "pos_r4a": //DONE
					general[40] = val;
					break;
				case "pos_total": //DONE
					general[41] = val;
					break;
				case "pos_totala": //DONE
					general[42] = val;
					break;
				case "neut_r1": //DONE (Layout.as 159)
					general[43] = val;
					break;
				case "neut_r1a": //DONE
					general[44] = val;
					break;
				case "neut_r2": //DONE (Layout.as 159)
					general[45] = val;
					break;
				case "neut_r2a": //DONE
					general[46] = val;
					break;
				case "neut_r3": //DONE (Layout.as 159)
					general[47] = val;
					break;
				case "neut_r3a": //DONE
					general[48] = val;
					break;
				case "neut_r4": //DONE (Layout.as 159)
					general[49] = val;
					break;
				case "neut_r4a": //DONE
					general[50] = val;
					break;
				case "neut_total": //DONE
					general[51] = val;
					break;
				case "neut_totala": //DONE
					general[52] = val;
					break;
				case "redist_offer_blue":
					general[76] = val;
					break;
				case "redist_offer_green":
					general[77] = val;
					break;
				case "payoff_redist_red":
					general[78] = val;
					break;
				case "payoff_redist_blue":
					general[79] = val;
					break;
				case "payoff_redist_green":
					general[80] = val;
					break;
				default:
					trace("INPUT NOT RECOGNIZED FOR SUBMITTING.");
			}
					
		/* switch (dataType)
		   {
		   case "general":
		
		   switch (varName)
		   {
		   //General Information
		   case "uid":
		   index = 0;
		   break;
		   case "date":
		   index = 0;
		   break;
		   }
		   general[index] = o;
		   break;
		
		   case "quiz1":
		   switch (varName)
		   {
		   //Data Input for Quiz 1 Array
		   case "quiz1_0":
		   index = 0;
		   break;
		   case "quiz1_1":
		   index = 1;
		   break;
		   case "quiz1_2":
		   index = 2;
		   break;
		   case "quiz1_3":
		   index = 3;
		   break;
		   case "quiz1_4":
		   index = 4;
		   break;
		   case "quiz1_5":
		   index = 5;
		   break;
		   case "quiz1_6":
		   index = 6;
		   break;
		   case "quiz1_7":
		   index = 7;
		   break;
		   case "quiz1_8":
		   index = 8;
		   break;
		   case "quiz1_9":
		   index = 9;
		   break;
		   case "quiz1_10":
		   index = 10;
		   break;
		   case "quiz1_11":
		   index = 11;
		   break;
		   case "quiz1_12":
		   index = 12;
		   break;
		   case "quiz1_13":
		   index = 13;
		   break;
		   case "quiz1_14":
		   index = 14;
		   break;
		   case "quiz1_15":
		   index = 15;
		   break;
		   case "quiz1_16":
		   index = 16;
		   break;
		   case "quiz1_17":
		   index = 17;
		   break;
		   case "quiz1_18":
		   index = 18;
		   break;
		   case "quiz1_19":
		   index = 19;
		   break;
		   case "quiz1_total":
		   index = 20;
		   break;
		
		   }
		   quiz1Array[index] = o;
		   break;
		   }
		 */
		}
		
		public static function addVoteArray(arre:Array):void
		{
			var index:int = 0;
			for (var i:int = 53; i < 60; i++)
			{
				general[i] = arre[index];
				index++;
			}
		}
		
		public static function addDemArray(arre:Array):void
		{
			var index:int = 0;
			for (var i:int = 60; i < 76 ; i++)
			{
				general[i] = arre[index];
				index++;
			}
		}
		
		//Takes the actual value assigned for the condition and translates it into the appropriate vallue
		//Returns the appropriate value
		private static function conditionNumber(treatment:Number):Number
		{
			var value:Number;
			switch (treatment)
			{
				case 0: 
					value = 1.0;
					break;
				case 1: 
					value = -1.0;
					break;
				case 2:
					switch(Main.global_work_display_toggle)
					{
						case 0:
							value = 2.0;
							break;
						case 1:
							value = 2.1;
							break;
						case -1:
							value = 2.2;
							break;
					}
					break;
				case 3: 
					value = -2.0;
					break;
				case 4: 
					value = 3.0;
					break;
				case 5: 
					value = -3.0;
					break;
				case 6: 
					value = 3.1;
					break;
				case 7: 
					value = -3.1;
					break;
				case 8: 
					value = 3.2;
					break;
				case 9: 
					value = -3.2;
					break;
				case 10:
					value = 4.0;
					break;
				default: 
					value = -10;
					return value;
			}
			return value;
		}
	
	}
}