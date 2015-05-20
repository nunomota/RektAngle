package GUI.Auxiliary {
	
	public class ImageRequest {

		public var path:String;
		public var x:int;
		public var y:int;
		
		public function ImageRequest(imagePath:String, posX:int, posY:int) {
			path = imagePath;
			x = posX;
			y = posY;
		}
		
		public function toString():String {
			return "".concat("'", path, "'"," [", x, ", ", y, "]");
		}

	}
	
}
