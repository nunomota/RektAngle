package  {

	import flash.display.MovieClip;
	import Debug.*;
	import GUI.*;
	import Algorithm.Level;
	
	public class GameEngine extends MovieClip {

		public static var debug:Debug;
		private var level:Level;

		public function GameEngine() {

			init();
			setup();
			start();
		}

		//used for variable initialization
		private function init():void {

			debug = new Debug(3);
			debug.toggle();
	
		}

		//used for populating canvas, etc
		private function setup():void {
			debug.print("Setup started", 0);
			
			level = new Level(this);
			level.addTexture("../Resources/Textures/Menus/Buttons/Account.png");
			level.addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			level.build();
			level.instantiate("Back", 100, 100);
			
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function start():void {
			debug.print("Game started running", 0);
			//TODO main loop code
			level.update();
			debug.print("Game finished running", 0);
		}

	}

}