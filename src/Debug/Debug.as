package Debug {
	
	public class Debug {
		
		private var isEnabled:Boolean;
		private var debugTags:Array;
		
		public function Debug() {
			isEnabled = false;
			debugTags = new Array("", "[Warning]", "[Error]");
		}
		
		//function used to toggle debugging functions
		public function toggle():void {
			isEnabled = !isEnabled;
		}

		//function used to print strings if debugging is enabled
		//0 - regular message; 1 - warning message; 2 - error message
		public function print(message:String, type:int):void {
			if (isEnabled) {
				trace(debugTags[type].concat(" ", message));
			}
		}
	}
	
}
