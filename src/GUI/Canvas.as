package GUI {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;
	
	public class Canvas extends DisplayObjectContainer {

		public static function addImage(image:Bitmap):void {
			this.addChild(image);
		}
	}
	
}
