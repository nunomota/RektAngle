package  {

	import flash.display.MovieClip;
	import flash.events.*;
	
	import Debug.*;
	import GUI.*;
	import Levels.*;
	import Levels.Templates.*;
	
	public class GameEngine extends MovieClip {

		public static var debug:Debug;
		private var level:Level;

		public function GameEngine() {

			init();
			setup();
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		//used for variable initialization
		private function init():void {

			debug = new Debug(3);
			debug.toggle();
	
		}

		//used for populating canvas, etc
		private function setup():void {
			debug.print("Setup started", 0);
			
			level = new MainMenu(this);
			
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function update(event:Event):void {
			//debug.print("Game started running", 0);
			//TODO main loop code
			debug.print("Main loop running", 0);
			level.update();
			//debug.print("Game finished running", 0);
		}

	}

}