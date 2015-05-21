package GUI {
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.*;
	
	import GUI.Auxiliary.*;
	import flash.display.LoaderInfo;

	public class Canvas {
		
		private static var SCALE_FACTOR:int = 3;
		private var gameEngine:GameEngine;
		public static var width:int = 768;
		public static var height:int = 672;
		
		private var imagesLoaded:Array;
		private var imagesToLoad:int;
		
		public function Canvas(engine:GameEngine) {
			gameEngine = engine;
			imagesLoaded = new Array();
		}
		
		//used to get all the images needed for the current level
		public function populate(requests:Array):void {
			GameEngine.debug.print("Populating level with ".concat(requests.length, " texture(s)"), 0);
			imagesToLoad = requests.length;
			var i:int;
			for (i = 0; i < requests.length; i++) {
				getImageFromUrl(requests[i]);
			}
			//GameEngine.debug.print("Waitting for all textures to load", 0);
			//TODO really wait for all textures to load
		}
		
		//creates a custom Loader for a specific image
		private function getImageFromUrl(request:String):void {
			var loader:ImageLoader = new ImageLoader();
			loader.load(new URLRequest(request));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//used to draw a texture on the screen
		public function draw(imageName:String, posX:int, posY:int):int {
			var image:Bitmap = getImageFromAssets(imageName);
			if (image != null) {
				gameEngine.stage.addChild(image);
				image.x = posX;
				image.y = posY;
				return 0;
			}
			return -1;
		}
		
		//used to search for a image in the canvas' available assets
		private function getImageFromAssets(imageName:String):Bitmap {
			var i:int;
			var imageContainer:ImageContainer;
			for (i = 0; i < imagesLoaded.length; i++) {
				imageContainer = imagesLoaded[i];
				if (imageContainer.name == imageName) {
					return imageContainer.image;
				}
			}
			return null;
		}
		
		//used to clear every image currently being tracked
		public function clear():void {
			GameEngine.debug.print("Removing all child objects of stage", 0);
			while(gameEngine.stage.numChildren > 0) {
				gameEngine.stage.removeChildAt(0);
			}
		}
		
		//as soon as the Loader finishes fetching the image, this runs
		private function doneLoading(event:Event):void {
			var loader:ImageLoader = getLoaderFromEvent(event);
			var imageContainer:ImageContainer = new ImageContainer(loader.targetPath, Bitmap(loader.content));
			imageContainer.image.width *= SCALE_FACTOR;
			imageContainer.image.height *= SCALE_FACTOR;
			imagesLoaded[imagesLoaded.length] = imageContainer;
			removeListeners(loader);
			GameEngine.debug.print("Image finished loading: ".concat(imageContainer.name), 0);
		}
		
		//function used to handle errors while reading images
		private function loadingError(event:IOErrorEvent):void {
			GameEngine.debug.print("Problem loading image: ".concat(event.target), 2);
			var loader:ImageLoader = getLoaderFromEvent(event);
			removeListeners(loader);
		}
		
		private function getLoaderFromEvent(event:Event):ImageLoader {
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var loader:ImageLoader = ImageLoader(loaderInfo.loader);
			return loader;
		}
		
		private function removeListeners(loader:ImageLoader):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//function used foor debugginf purposes
		public function toString():String {
			return "".concat("(", width, ",", height, ") ", imagesLoaded.length, " assets loaded");
		}

	}
	
}
