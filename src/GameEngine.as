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
		public var eventHandler:EventHandler;
		private var navigator:Navigator;

		public function GameEngine() {

			init();
			setup();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, eventHandler.setKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, eventHandler.setKeyUp);
			stage.addEventListener(MouseEvent.CLICK, eventHandler.setMouseClick);
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		//used for variable initialization
		private function init():void {

			debug = new Debug(4);
			debug.toggle();
			eventHandler = new EventHandler();
			navigator = new Navigator(this);
		}

		//used for value attribution
		private function setup():void {
			debug.print("Setup started", 0);
			
			debug.print("Setup ended", 0);
		}
		
		//used for this class' main loop
		private function update(event:Event):void {
			navigator.update();
		}

	}

}