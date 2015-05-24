package Handlers {
	
	import flash.events.*;
	import flash.ui.Keyboard;
	
	import GUI.Objects.Auxiliary.Vector2D;
	
	public class EventHandler {

		private var specialKeys:Array;
		private var keyPressed:Array;
		private var mouseClicked:Boolean;
		private var mouseClickPos:Vector2D;
		
		public function EventHandler() {
			specialKeys = new Array(Keyboard.SPACE, Keyboard.ESCAPE, Keyboard.LEFT, Keyboard.RIGHT, Keyboard.DOWN, Keyboard.UP, Keyboard.COMMA, Keyboard.PERIOD);
			keyPressed = new Array(26+specialKeys.length);
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
			var keyCode:uint = event.keyCode;
			var index:int = getKeyIndex(keyCode);
			if (index != -1) {
				GameEngine.debug.print("Key '".concat(String.fromCharCode(event.charCode), "' was pressed"), 1);
				keyPressed[index] = true;
			}
		}
		
		//function called when a keyboard event is fired
		public function setKeyUp(event:KeyboardEvent):void {
			var keyCode:uint = event.keyCode;
			var index:int = getKeyIndex(keyCode);
			if (index != -1) {
				GameEngine.debug.print("Key '".concat(String.fromCharCode(event.charCode), "' was released"), 1);
				keyPressed[index] = false;
			}
		}
		
		//function that should be called by every Level to check for key presses
		public function getKeyDown(keyCode:uint):Boolean {
			var wasPressed:Boolean = false;
			var index:int = getKeyIndex(keyCode);
			
			if (index != -1) {
				wasPressed = keyPressed[index];
			}
			return wasPressed;
		}
		
		private function getKeyIndex(keyCode:uint):int {
			var specialIndex:uint;
			if (isKeyValid(keyCode)) {
				return (keyCode-Keyboard.A);
			} else if ((specialIndex = isSpecialKey(keyCode)+(Keyboard.Z-Keyboard.A)) > (Keyboard.Z-Keyboard.A)) {
				return specialIndex;
			}
			return -1;
		}
		
		//function meant to check wether the key is to be tracked or not
		private function isKeyValid(keyCode:uint):Boolean {
			if (keyCode <= Keyboard.Z && keyCode >= Keyboard.A) {
				return true;
			}
			return false;
		}
		
		//function meant to check for speacial keys, like 'spacebar' or 'esc'
		private function isSpecialKey(keyCode:uint):int {
			var i:int;
			for (i = 0; i < specialKeys.length; i++) {
				if (keyCode == specialKeys[i]) {
					return i+1;
				}
			}
			return 0;
		}

	}
	
}
