package Handlers.Controls {
	
	import flash.ui.Keyboard;
	
	public class PlayerControls {
		
		public static var singlePlayer:ControlSet = new ControlSet(Keyboard.A, Keyboard.S, Keyboard.D, Keyboard.LEFT, Keyboard.RIGHT);
		public static var multiPlayer1:ControlSet = new ControlSet(Keyboard.A, Keyboard.S, Keyboard.D, Keyboard.V, Keyboard.B);
		public static var multiPlayer2:ControlSet = new ControlSet(Keyboard.LEFT, Keyboard.DOWN, Keyboard.RIGHT, Keyboard.COMMA, Keyboard.PERIOD);
		
		public function KeyCode() {

		}

	}
	
}
