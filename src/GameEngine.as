package  {

	import flash.display.MovieClip;
	import flash.events.*;
	
	import Debug.*;
	import GUI.*;
	import Levels.*;
	import Levels.Templates.*;
	import Handlers.EventHandler;
	
	public class GameEngine extends MovieClip {

		public static var debug:Debug;
		private var eventHandler:EventHandler;
		
		private var level:Level;

		public function GameEngine() {

			init();
			setup();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, eventHandler.setKeyDown);
			stage.addEventListener(MouseEvent.CLICK, eventHandler.setMouseClick);
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		//used for variable initialization
		private function init():void {

			debug = new Debug(3);
			debug.toggle();
			eventHandler = new EventHandler();
		}

		//used for populating canvas, etc
		private function setup():void {
			debug.print("Setup started", 0);
			
			level = new MainMenu(this);
			
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function update(event:Event):void {
			//TODO main loop code
			//debug.print("Main loop running", 0);
			level.update();
		}

	}

}