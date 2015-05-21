package GUI.Auxiliary {
	import flash.display.Bitmap;
	
	public class ImageContainer {

		public var path:String;
		public var name:String;
		public var image:Bitmap;
		
		public function ImageContainer(imagePath:String, imageData:Bitmap) {
			path = imagePath;
			name = getImageName(imagePath);
			image = imageData;
		}
		
		//retrieves image name from the complete URL
		private function getImageName(imagePath:String):String {
			var nameExtracted:String = imagePath.slice(imagePath.lastIndexOf("/")+1, imagePath.lastIndexOf("."));
			return nameExtracted;
		}

		public function toString():String {
			return "[".concat(name, ": '", path, "']");
		}
	}
	
}
