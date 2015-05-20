package  {

	import flash.display.MovieClip;
	import Debug.*;
	import GUI.*;
	import GUI.Auxiliary.ImageRequest;
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
			
			level = new Level();
			level.addTexture(new ImageRequest("../Resources/Textures/Menus/Buttons/Account.png", 100, 100));
			level.addTexture(new ImageRequest("../Resources/Textures/Menus/Buttons/Back.png", 200, 200));
			level.build();
			
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function start():void {
			debug.print("Game strated running", 0);
			//TODO main loop code
			level.update();
			debug.print("Game finished running", 0);
		}

	}

}