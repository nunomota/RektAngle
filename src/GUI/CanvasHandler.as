package GUI {
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.*;
	
	import GUI.Canvas;
	import GUI.Auxiliary.ImageRequest;
	import flash.display.LoaderInfo;

	public class CanvasHandler {
		
		public function CanvasHandler() {
			
		}
		
		//used to get all the images needed for the current level
		public function populate(requests:Array):void {
			GameEngine.debug.print("Populating level with ".concat(requests.length, " texture(s)"), 0);
			var i:int;
			for (i = 0; i < requests.length; i++) {
				getImage(requests[i]);
			}
		}
		
		//creates a Loader for a specific image
		private function getImage(request:ImageRequest):void {
			GameEngine.debug.print("Loading image: ".concat(request.toString()), 0);
			var loader:Loader = new Loader();
			loader.x = request.x;
			loader.y = request.y;
			loader.load(new URLRequest(request.path));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//used to clear every image currently being tracked
		public function clear():void {
			
		}
		
		//as soon as the Loader finishes fetching the image, this runs
		private function doneLoading(event:Event):void {
			GameEngine.debug.print("Image finished loading", 0);
			var loaderInfo:LoaderInfo =  LoaderInfo(event.target);
			var loader:Loader = loaderInfo.loader;
			var image:Bitmap = Bitmap(loader.content);
			//Canvas.addImage(image);
			//TODO add image to an Array as well; other instances of the same image will not be requested again;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//function used to handle errors while reading images
		private function loadingError(event:IOErrorEvent):void {
			GameEngine.debug.print("Problem loading image: ".concat(event.target), 2);
		}

	}
	
}
