package allocate 
{
	import flash.display.GraphicsBitmapFill;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.events.*;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flashx.textLayout.events.*;
	import util.CustomEvent;
	import util.Submit;
	import fl.events.SliderEvent;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class AllocateSplash extends Sprite
	{
		private var original_payout:int = 985;
		private var original_comp1:int = 345;
		private var original_comp2:int = 470;
		private var _current_payout:int = original_payout;
		private var _current_comp1:int = original_comp1;
		private var _current_comp2:int = original_comp2;
		private var _bound_comp1:int = original_comp1 + original_payout;
		private var _bound_comp2:int = original_comp2 + original_payout;
		
		private var amount_give_comp1_dollar:TextField = new TextField();
		private var amount_give_comp2_dollar:TextField = new TextField();
		private var amount_give_comp1_cent:TextField = new TextField();
		private var amount_give_comp2_cent:TextField = new TextField();
		
		private var cents1:int = 0;
		private var cents2:int = 0;
		private var dollars1:int = 0;
		private var dollars2:int = 0;
		
		public var allocate_ui:Allocate_layout = new Allocate_layout();;
		public var are_you_sure:Submit_Final = new Submit_Final();
		public var payoff_screen:Payoff_Screen = new Payoff_Screen();
		
		public function AllocateSplash() 
		{
			
			// Initialize the TextFields
			/*
			allocate_ui.dollars1_text.maxChars = 1;
			allocate_ui.dollars2_text.maxChars = 1;
			allocate_ui.cents1_text.maxChars = 2;
			allocate_ui.cents2_text.maxChars = 2;
			allocate_ui.dollars1_text.restrict = "0-9";
			allocate_ui.dollars2_text.restrict = "0-9";
			allocate_ui.cents1_text.restrict = "0-9";
			allocate_ui.cents2_text.restrict = "0-9";
			allocate_ui.dollars1_text.type = TextFieldType.INPUT;
			allocate_ui.dollars2_text.type = TextFieldType.INPUT;
			allocate_ui.cents1_text.type = TextFieldType.INPUT;
			allocate_ui.cents2_text.type = TextFieldType.INPUT;
			allocate_ui.cents1_text.text = "00";
			*/
			trace("hey!");
			allocate_ui.pos_corr_show.visible = false;
			allocate_ui.neg_corr_show.visible = false;
			
			allocate_ui.comp1_slider.minimum = 0;
			allocate_ui.comp1_slider.maximum = bound_comp1 - original_comp1;
			allocate_ui.comp1_slider.snapInterval = 5;
			allocate_ui.comp1_slider.liveDragging = true;
			allocate_ui.comp1_slider.addEventListener(SliderEvent.CHANGE, comp1_change);
			
			allocate_ui.comp2_slider.minimum = 0;
			allocate_ui.comp2_slider.maximum = bound_comp2 - original_comp2;
			allocate_ui.comp2_slider.snapInterval = 5;
			allocate_ui.comp2_slider.liveDragging = true;
			allocate_ui.comp2_slider.addEventListener(SliderEvent.CHANGE, comp2_change);
			
			
			addChild(allocate_ui);
			
			
			
			/*
			amount_give_comp1_dollar.type = TextFieldType.INPUT;
			amount_give_comp2_dollar.type = TextFieldType.INPUT;
			amount_give_comp1_cent.type = TextFieldType.INPUT;
			amount_give_comp2_cent.type = TextFieldType.INPUT;
			amount_give_comp1_dollar.text = "0";
			amount_give_comp2_dollar.text = "0";
			amount_give_comp1_cent.text = "00";
			amount_give_comp2_cent.text = "00";
			amount_give_comp1_dollar.restrict = "0-9";
			amount_give_comp2_dollar.restrict = "0-9";
			amount_give_comp1_cent.restrict = "0-9";
			amount_give_comp2_cent.restrict = "0-9";
			amount_give_comp1_dollar.maxChars = 1;
			amount_give_comp2_dollar.maxChars = 1;
			amount_give_comp1_cent.maxChars = 2;
			amount_give_comp2_cent.maxChars = 2;
			addChild(amount_give_comp1_dollar);
			addChild(amount_give_comp2_dollar);
			addChild(amount_give_comp1_cent);
			addChild(amount_give_comp2_cent);
			amount_give_comp1_dollar.y = 100;
			amount_give_comp1_dollar.x = 100;
			amount_give_comp1_cent.y = 100;
			amount_give_comp1_cent.x = 120;
			amount_give_comp2_dollar.y = 200;
			amount_give_comp2_dollar.x = 100;
			amount_give_comp2_cent.y = 200;
			amount_give_comp2_cent.x = 120;
			*/
			
			//Setup Listeners
			/*
			allocate_ui.dollars1_text.addEventListener(FocusEvent.FOCUS_OUT, dollar_comp1_validate);
			allocate_ui.dollars2_text.addEventListener(FocusEvent.FOCUS_OUT, dollar_comp2_validate);
			allocate_ui.cents1_text.addEventListener(FocusEvent.FOCUS_OUT, cent_comp1_validate);
			allocate_ui.cents2_text.addEventListener(FocusEvent.FOCUS_OUT, cent_comp2_validate);
			*/			
			
			allocate_ui.submit_button.addEventListener(MouseEvent.ROLL_OVER, submit_mouse_over);
			allocate_ui.submit_button.addEventListener(MouseEvent.ROLL_OUT, submit_mouse_out);
			allocate_ui.submit_button.addEventListener(MouseEvent.CLICK, submit_click);
			
			are_you_sure.yes_button.addEventListener(MouseEvent.CLICK, yes_i_am_sure);
			are_you_sure.yes_button.addEventListener(MouseEvent.ROLL_OVER, yes_mouse_roll);
			are_you_sure.yes_button.addEventListener(MouseEvent.ROLL_OUT, yes_mouse_out);
			are_you_sure.no_button.addEventListener(MouseEvent.ROLL_OVER, no_mouse_roll);
			are_you_sure.no_button.addEventListener(MouseEvent.ROLL_OUT, no_mouse_out);
			are_you_sure.no_button.addEventListener(MouseEvent.CLICK, no_i_am_not);
				
			payoff_screen.next_button.addEventListener(MouseEvent.CLICK, next_button_click);
			payoff_screen.next_button.addEventListener(MouseEvent.ROLL_OVER, next_mouse_over);
			payoff_screen.next_button.addEventListener(MouseEvent.ROLL_OUT, next_mouse_out);
			
			/* Tests 
			_current_payout = 1000;
			_current_comp1 = 450;
			
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
			current_comp1 = 600;
			current_comp2 = 300;
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
			current_comp1 = 1200;
			current_comp2 = 850;
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
			current_comp1 = 500;
			current_comp2 = 990;
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
			current_comp1 = 400;
			current_comp2 = 1300;
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
			*/
		}
		
		private function comp1_change(e:SliderEvent):void {
			current_comp1 = allocate_ui.comp1_slider.value + original_comp1;
			current_comp2 = current_comp2;
			allocate_ui.comp1_slider.value = current_comp1 - original_comp1;
			allocate_ui.comp2_slider.value = current_comp2 - original_comp2;
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp1_payoff.text = (current_comp1 / 100).toFixed(2).toString();
			allocate_ui.comp1_gift.text = ((current_comp1 - original_comp1) / 100).toFixed(2).toString();
			allocate_ui.player_gift.text = ((original_payout - current_payout) / 100).toFixed(2).toString();
			trace(current_comp1);
			trace(allocate_ui.comp1_slider.value);
		}
		
		
		private function comp2_change(e:SliderEvent):void {
			current_comp2 = allocate_ui.comp2_slider.value + original_comp2;
			current_comp1 = current_comp1;
			allocate_ui.comp2_slider.value = current_comp2 - original_comp2;
			allocate_ui.comp1_slider.value = current_comp1 - original_comp1;
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp2_payoff.text = (current_comp2 / 100).toFixed(2).toString();
			allocate_ui.comp2_gift.text = ((current_comp2 - original_comp2) / 100).toFixed(2).toString();
			allocate_ui.player_gift.text = ((original_payout - current_payout) / 100).toFixed(2).toString();
			trace(current_comp2);
			trace(allocate_ui.comp2_slider.value);
		}
		
		private function next_mouse_out(e:MouseEvent):void 
		{
			payoff_screen.next_button.alpha = 1;
		}
		
		private function next_mouse_over(e:MouseEvent):void 
		{
			payoff_screen.next_button.alpha = .7;
		}
		
		private function next_button_click(e:MouseEvent):void 
		{
			

			var eventDone:CustomEvent = new CustomEvent("REDISTRIBUTE_DONE", true);
			dispatchEvent(eventDone);
		}
		
		private function no_mouse_out(e:MouseEvent):void 
		{
			are_you_sure.no_button.alpha = 1;
		}
		
		private function no_mouse_roll(e:MouseEvent):void 
		{
			are_you_sure.no_button.alpha = .7;
		}
		
		private function yes_mouse_out(e:MouseEvent):void 
		{
			are_you_sure.yes_button.alpha = 1;
		}
		
		private function yes_mouse_roll(e:MouseEvent):void 
		{
			are_you_sure.yes_button.alpha = .7;
		}
		
		private function no_i_am_not (e:Event):void {
			are_you_sure.yes_button.alpha = 1;
			are_you_sure.no_button.alpha = 1;
			removeChild(are_you_sure);
		}
		
		private function yes_i_am_sure (e:Event):void {
			removeChild(are_you_sure);
			removeChild(allocate_ui);
			payoff_screen.player_payoff.text = (current_payout/100).toFixed(2).toString();
			payoff_screen.player_payoff1.text = (current_payout/100).toFixed(2).toString();
			payoff_screen.comp1_given.text = ((current_comp1 - original_comp1)/100).toFixed(2).toString();
			payoff_screen.comp2_given.text = ((current_comp2 - original_comp2) / 100).toFixed(2).toString();
			payoff_screen.comp1_payoff.text = (current_comp1 / 100).toFixed(2).toString();
			payoff_screen.comp2_payoff.text = (current_comp2 / 100).toFixed(2).toString();
			addChild(payoff_screen);
			Submit.addData("redist_offer_blue", current_comp1 - original_comp1);
			Submit.addData("redist_offer_green", current_comp2 - original_comp2);
			Submit.addData("payoff_redist_red", current_payout);
			Submit.addData("payoff_redist_blue", current_comp1);
			Submit.addData("payoff_redist_green", current_comp2);
			Submit.finalSubmit();
		}
		
		private function submit_click(e:Event):void {
			are_you_sure.comp1_submit_payoff.text = ((current_comp1 - original_comp1)/100).toFixed(2).toString();
			are_you_sure.comp2_submit_payoff.text = ((current_comp2 - original_comp2)/100).toFixed(2).toString();
			are_you_sure.player_sumbit_payoff.text = ((current_payout)/100).toFixed(2).toString();
			addChild(are_you_sure);
		}
		
		private function submit_mouse_over(e:Event):void {
			allocate_ui.submit_button.alpha = .7;
		}
		
		private function submit_mouse_out(e:Event):void {
			allocate_ui.submit_button.alpha = 1;
		}
		
		public function dollar_comp1_validate(e:Event):void {
			current_comp1 = original_comp1 + int(allocate_ui.dollars1_text.text) * 100 + cents1;
			dollars1 = Math.floor((current_comp1 - original_comp1) / 100);
			cents1 = current_comp1 - original_comp1 - dollars1 * 100;
			allocate_ui.cents1_text.text = cents1.toString();
			allocate_ui.dollars1_text.text = dollars1.toString();
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp1_payoff.text = (current_comp1 / 100).toFixed(2).toString();
			trace(dollars1);
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
		}
		
		public function dollar_comp2_validate(e:Event):void {
			current_comp2 = original_comp2 + int(allocate_ui.dollars2_text.text) * 100 + cents2;
			dollars2 = Math.floor((current_comp2 - original_comp2) / 100);
			cents2 = current_comp2 - original_comp2 - dollars2*100;
			allocate_ui.cents2_text.text = cents2.toString();
			allocate_ui.dollars2_text.text = dollars2.toString();
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp2_payoff.text = (current_comp2 / 100).toFixed(2).toString();
			trace(dollars2);
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
		}
		
		public function cent_comp1_validate(e:Event):void {
			current_comp1 = original_comp1 +int(allocate_ui.cents1_text.text) + dollars1*100;
			var remainder:int = current_comp1 - original_comp1 - dollars1*100;
			cents1 = current_comp1 - original_comp1 - dollars1*100;
			allocate_ui.cents1_text.text = cents1.toString();	
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp1_payoff.text = (current_comp1 / 100).toFixed(2).toString();
			if (allocate_ui.cents1_text.text.length == 1) {
				allocate_ui.cents1_text.text = "0" + allocate_ui.cents1_text.text ;
			}
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
		}
		
		public function cent_comp2_validate(e:Event):void {
			current_comp2 = original_comp2 +int(allocate_ui.cents2_text.text) + dollars2*100;
			var remainder:int = current_comp2 - original_comp2 - dollars2*100;
			cents2 = current_comp2 - original_comp2 - dollars2*100;
			allocate_ui.cents2_text.text = cents2.toString();
			allocate_ui.player_payoff.text = (current_payout / 100).toFixed(2).toString();
			allocate_ui.comp2_payoff.text = (current_comp2 / 100).toFixed(2).toString();
			if (allocate_ui.cents2_text.text.length == 1) {
				allocate_ui.cents2_text.text = "0" + allocate_ui.cents2_text.text ;
			}
			trace (current_payout + "   P1:" + current_comp1 + "   P2:" + current_comp2 + "    Sum:" + (current_payout + current_comp1 + current_comp2));
		}
		
		public function set current_payout(value:int):void {
			_current_payout = value;
		}
		
		public function set current_comp1(value:int):void {
			if ((value >= original_comp1) && (value <= bound_comp1)) {
				var change:int = value - current_comp1;
				_current_comp1 = value;
				current_payout = current_payout - change;
				bound_comp2 = current_comp2 + current_payout;
			} else if ( value < original_comp1) {
				var change:int = original_comp1 - current_comp1;
				_current_comp1 = original_comp1;
				current_payout = current_payout - change;
				bound_comp2 = current_comp2 + current_payout;
			} else {
				var change:int = bound_comp1 - current_comp1;
				_current_comp1 = bound_comp1;
				current_payout = current_payout - change;
				bound_comp2 = current_comp2 + current_payout;
			}
		}
		
		public function set current_comp2(value:int):void {
			if ((value >= original_comp2) && (value <= bound_comp2)) {
				var change:int = value - current_comp2;
				_current_comp2 = value;
				current_payout = current_payout - change;
				bound_comp1 = current_comp1 + current_payout;
			} else if ( value < original_comp2) {
				var change:int = original_comp2 - current_comp2;
				_current_comp2 = original_comp2;
				current_payout = current_payout - change;
				bound_comp1 = current_comp1 + current_payout;
			} else {
				var change:int = bound_comp2 - current_comp2;
				_current_comp2 = bound_comp2;
				current_payout = current_payout - change;
				bound_comp1 = current_comp1 + current_payout;
			}
		}	
		
		public function set bound_comp1(value:int):void {
			//allocate_ui.comp1_slider.maximum = value - original_comp1;
			_bound_comp1 = value;
		}
		
		public function set bound_comp2(value:int):void {
			//allocate_ui.comp2_slider.maximum = value - original_comp2;
			_bound_comp2 = value;
		}
		
		public function get bound_comp1():int {
			return _bound_comp1;
		}
		
		public function get bound_comp2():int {
			return _bound_comp2;
		}
		
		public function get current_payout():int {
			return _current_payout;
		}
		
		public function get current_comp1():int {
			return _current_comp1;
		}
		
		public function get current_comp2():int {
			return _current_comp2;
		}
		
		public function pos_corr():void {
			allocate_ui.results_move.y = 95;
			allocate_ui.pos_corr_show.visible = true;
		}
		
		public function neg_corr():void {
			allocate_ui.results_move.y = 95;
			allocate_ui.neg_corr_show.visible = true;
		}
	}

}
