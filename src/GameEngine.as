package  {

	import flash.display.MovieClip;
	import Debug.*;
	import GUI.*;
	
	public class GameEngine extends MovieClip {

		private var debug:Debug;
		private var canvas:Canvas;

		public function GameEngine() {

			init();
			setup();
			start();
		}

		//used for variable initialization
		private function init():void {

			debug = new Debug(3);
			debug.toggle();
			
			canvas = new Canvas();
	
		}

		//used for populating canvas, etc
		private function setup():void {
			debug.print("Setup started", 0);
			//TODO initial menu setup using canvas
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function start():void {
			debug.print("Game strated running", 0);
			//TODO main loop code
			debug.print("Game finished running", 0);
		}

	}

}