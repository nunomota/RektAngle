﻿package Debug {
	
	public class Debug {
		
		private var isEnabled:Boolean;
		private var debugTags:Array;
		private var messageFilter:int;
		
		public function Debug(filter:int) {
			isEnabled = false;
			debugTags = new Array("", "[Event]", "[Warning]", "[Error]", "[Physics]", "[Temp]");
			messageFilter = filter;
		}
		
		//function used to toggle debugging functions
		public function toggle():void {
			isEnabled = !isEnabled;
		}

		//function used to print strings if debugging is enabled
		//0 - regular message; 1 - event messages; 2 - warning message; 3 - error message
		public function print(message:String, type:int):void {
			if (isEnabled && (messageFilter == type || messageFilter == debugTags.length)) {
				trace(debugTags[type].concat(" ", message));
			}
		}
	}
	
}
