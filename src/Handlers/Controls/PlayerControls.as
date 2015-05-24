package Handlers.Controls {
	
	import flash.ui.Keyboard;
	
	public class PlayerControls {
		
		public static var singlePlayer:ControlSet = new ControlSet(Keyboard.A, Keyboard.S, Keyboard.D, Keyboard.LEFT, Keyboard.RIGHT);
		public static var multiPlayer1:ControlSet = new ControlSet(Keyboard.A, Keyboard.S, Keyboard.D, Keyboard.B, Keyboard.M);
		public static var multiPlayer2:ControlSet = new ControlSet(Keyboard.NUMBER_1, Keyboard.NUMBER_2, Keyboard.NUMBER_3, Keyboard.LEFT, Keyboard.RIGHT);
		
		public function KeyCode() {

		}

	}
	
}
