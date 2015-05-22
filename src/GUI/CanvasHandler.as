package GUI {
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.*;
	
	import GUI.Auxiliary.*;
	import flash.display.LoaderInfo;
	import GUI.Objects.Image2D;
	import GUI.Objects.Auxiliary.Vector2D;

	public class CanvasHandler {
		
		private static var SCALE_FACTOR:int = 3;
		private var gameEngine:GameEngine;
		public var dimensions:Vector2D = new Vector2D(768, 672);
		
		private var imagesLoaded:Array;
		private var imagesToLoad:int;
		
		public function CanvasHandler(engine:GameEngine) {
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
		}
		
		//creates a custom Loader for a specific image
		private function getImageFromUrl(request:String):void {
			var loader:ImageLoader = new ImageLoader();
			loader.load(new URLRequest(request));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//used to draw a texture on the screen
		public function draw(imageName:String, position:Vector2D):Image2D {
			var image:Bitmap = getImageFromAssets(imageName);
			if (image != null) {
				image = new Bitmap(image.bitmapData.clone());
				gameEngine.stage.addChild(image);
				image.x = position.x;
				image.y = position.y;
				image.width *= SCALE_FACTOR;
				image.height *= SCALE_FACTOR;
				return (new Image2D(image, position));
			}
			return null;
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
			imagesLoaded[imagesLoaded.length] = imageContainer;
			removeListeners(loader);
			GameEngine.debug.print("Image finished loading: ".concat(imageContainer.name), 0);
		}
		
		//function used to handle errors while reading images
		private function loadingError(event:IOErrorEvent):void {
			GameEngine.debug.print("Problem loading image: ".concat(event.target), 3);
			var loader:ImageLoader = getLoaderFromEvent(event);
			removeListeners(loader);
		}
		
		//retrieves an ImageLoader object from an event
		private function getLoaderFromEvent(event:Event):ImageLoader {
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var loader:ImageLoader = ImageLoader(loaderInfo.loader);
			return loader;
		}
		
		//removes all the listeners previously added to the ImageLoader
		private function removeListeners(loader:ImageLoader):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,doneLoading);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadingError);
		}
		
		//checks if all the Assets were already loaded
		public function assetsLoaded():Boolean {
			var assetsLoaded:Boolean = false;
			if (imagesLoaded.length == imagesToLoad) {
				assetsLoaded = true;
			}
			return assetsLoaded;
		}
		
		//function used foor debugginf purposes
		public function toString():String {
			return "".concat(dimensions.toString(), " ", imagesLoaded.length, " assets loaded");
		}

	}
	
}
