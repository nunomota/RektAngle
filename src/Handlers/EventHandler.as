package Handlers {
	
	import flash.events.*;
	
	public class EventHandler {

		private var keyPressed:Array;
		
		private var aCode:int;
		private var zCode:int;
		private var jumpCode:int;
		
		public function EventHandler() {
			keyPressed = new Array(27);
			setupArray();
		}

		//sets up all the initial values for the array and key codes
		private function setupArray():void {
			aCode = "a".charCodeAt();
			zCode = "z".charCodeAt();
			jumpCode = " ".charCodeAt();
			var i:int;
			for (i = 0; i < keyPressed.length; i++) {
				keyPressed[i] = false;
			}
		}
		
		//function called when a keyboard event is fired
		public function setKeyDown(event:KeyboardEvent):void {
			var keyCode:int = event.charCode;
			if (isKeyValid(keyCode)) {
				GameEngine.debug.print("Key '".concat(String.fromCharCode(event.charCode), "' was pressed"), 0);
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
