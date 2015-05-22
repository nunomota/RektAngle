package Handlers {
	
	import flash.events.*;
	import GUI.Objects.Auxiliary.Vector2D;
	
	public class EventHandler {

		private var keyPressed:Array;
		private var mouseClicked:Boolean;
		private var mouseClickPos:Vector2D;
		
		private var aCode:int = "a".charCodeAt();
		private var zCode:int = "z".charCodeAt();
		private var jumpCode:int = " ".charCodeAt();
		
		public function EventHandler() {
			keyPressed = new Array(27);
			setupArray();
		}

		//sets up all the initial values for the array and key codes
		private function setupArray():void {
			var i:int;
			for (i = 0; i < keyPressed.length; i++) {
				keyPressed[i] = false;
			}
			mouseClicked = false;
		}
		
		//function called when a mouse event is fired
		public function setMouseClick(event:MouseEvent):void {
			mouseClicked = true;
			mouseClickPos = new Vector2D(event.localX, event.localY);
			GameEngine.debug.print("Mouse click at ".concat(mouseClickPos.toString()), 1);
		}
		
		//function called by every Level to know a mouse click's position
		public function getMouseClick():Vector2D {
			var temp:Boolean = mouseClicked;
			mouseClicked = false;
			if (temp) {
				return mouseClickPos;
			}
			return null;
		}
		
		//function called when a keyboard event is fired
		public function setKeyDown(event:KeyboardEvent):void {
			var keyCode:int = event.charCode;
			if (isKeyValid(keyCode)) {
				GameEngine.debug.print("Key '".concat(String.fromCharCode(event.charCode), "' was pressed"), 1);
				keyPressed[keyCode-aCode] = true;
			}
		}
		
		//function that should be called by every Level to check for key presses
		public function getKeyDown(key:String):Boolean {
			var wasPressed:Boolean = false;
			var keyCode:int = key.charCodeAt();
			var specialIndex:int;
			
			if (isKeyValid(keyCode)) {
				wasPressed = keyPressed[keyCode-aCode];
				keyPressed[keyCode-aCode] = false;
			} else if ((specialIndex = isSpecialKey(keyCode)+zCode) > zCode) {
				wasPressed = keyPressed[specialIndex];
				keyPressed[specialIndex] = false;
			}
			return wasPressed;
		}
		
		//function meant to check wether the key is to be tracked or not
		private function isKeyValid(keyCode:int):Boolean {
			if (keyCode == jumpCode || (keyCode <= zCode && keyCode >= aCode)) {
				return true;
			}
			return false;
		}
		
		//function meant to check for speacial keys, like 'spacebar' or 'esc'
		private function isSpecialKey(keyCode:int):int {
			if (keyCode == jumpCode) {
				return 1;
			}
			return 0;
		}

	}
	
}
