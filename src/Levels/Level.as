package Levels {
	
	import GUI.CanvasHandler;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.Image2D;
	import GUI.Objects.Disposable;
	import Levels.Physics.*;
	
	public class Level {

		private var gameEngine:GameEngine;
		
		protected var canvas:CanvasHandler;
		private var imagesDrawn:Array;
		private var imageRequests:Array;
		
		protected var assetsLoaded:Boolean = false;
		
		private var buttons:Array;
		private var disposables:Array;
		
		private var isShowing:Boolean = false;
		
		public function Level(engine:GameEngine) {
			gameEngine = engine;
			canvas = new CanvasHandler(engine);
			imagesDrawn = new Array();
			GameEngine.debug.print("Created new Canvas: ".concat(canvas.toString()), 0);
			imageRequests = new Array();
			buttons = new Array();
			disposables = new Array();
			setup();
		}
		
		//adds a texture to the level's assets
		protected function addTexture(request:String):void {
			imageRequests[imageRequests.length] = request;
		}
		
		//will put all necessary assets in memory
		protected function buildAssets():void {
			GameEngine.debug.print("Building level", 0);
			canvas.populate(imageRequests);
		}
		
		//used to draw a texture in a certain position
		public function instantiate(imageName:String, position:Vector2D):Image2D {
			var image:Image2D;
			if ((image = canvas.draw(imageName, position)) == null) {
				GameEngine.debug.print("Could not draw texture '".concat(imageName, "' (it was either not added to the assets or there is a typo in its name)"), 2);
			} else {
				imagesDrawn[imagesDrawn.length] = image;
				if (isShowing) {
					gameEngine.stage.addChild(image.getData());
				}
			}
			return image;
		}
		
		//used to draw imported textures
		protected function requestDraw(image:Image2D)void {
			imagesDrawn[imagesDrawn.length] = image;
			if (isShowing) {
				gameEngine.stage.addChild(image.getData());
			}
		}
		
		//used by child Objects to populate the Level's assets
		protected function setup():void {
			
		}
		
		//functioned called once, right after all assets are loaded
		protected function start():void {
			GameEngine.debug.print("'Start' method running for level", 0);
		}
		
		//level's main loop
		public function update():int {
			if (!assetsLoaded) {
				if ((assetsLoaded = canvas.assetsLoaded()) == true) {
					GameEngine.debug.print("All assets are loaded", 0);
					start();
					show();
				}
			}
			checkButtonClick();
			clearDisposables();
			return 0;
		}
		
		//used by child classes to create a button from an image
		protected function makeButton(button:Image2D):void {
			buttons[buttons.length] = button;
		}
		
		//used by child classes to remove a button
		protected function removeButton(button:Image2D):void {
			var newButtons:Array = new Array();
			var i:int;
			for (i = 0; i < buttons.length; i++) {
				if (buttons[i] != button) {
					newButtons[newButtons.length] = buttons[i];
				}
			}
			buttons = newButtons;
		}
		
		//used to handle the 'wasClicked' property of a button
		private function checkButtonClick():void {
			var i:int;
			var button:Image2D;
			var mouseClick:Vector2D = gameEngine.eventHandler.getMouseClick();
			
			if (mouseClick != null) {
				for(i = 0; i < buttons.length; i++) {
					button = buttons[i];
					var rightLimit:int = button.getPosition().x+button.getWidth()/2;
					var leftLimit:int = button.getPosition().x-button.getWidth()/2;
					var botLimit:int = button.getPosition().y+button.getHeight()/2;
					var topLimit:int = button.getPosition().y-button.getHeight()/2;
					if (mouseClick.x <= rightLimit && mouseClick.x >= leftLimit && mouseClick.y >= topLimit && mouseClick.y <= botLimit) {
						GameEngine.debug.print("'".concat(button.getName(), "' button was clicked"), 1);
						button.setMouseClick();
					}
				}
			}
		}
		
		//used to add every texture to the screen
		private function show():void {
			var i:int;
			GameEngine.debug.print("Drawing ".concat(imagesDrawn.length, " menu textures"), 0);
			for (i = 0; i < imagesDrawn.length; i++) {
				gameEngine.stage.addChild(imagesDrawn[i].getData());
			}
			isShowing = true;
		}
		
		//used to clear every asset of the level from the screen
		public function hide():void {
			isShowing = false;
			assetsLoaded = false;
			imagesDrawn.length = 0;
			buttons.length = 0;
			cleanUp();
		}
		
		private function cleanUp():void {
			canvas.clear();
		}
		
		protected function destroy(image:Image2D, delay:Number):void {
			var disposable:Disposable = new Disposable(image, delay);
			GameEngine.debug.print("Disposing of object in ".concat(delay, " seconds"), 0);
			image.isDisposable = true;
			undrawImage();
			disposables[disposables.length] = disposable;
		}
		
		private function undrawImage():void {
			var i:int;
			var newImagesDrawn:Array = new Array();
			for (i = 0; i < imagesDrawn.length; i++) {
				if (!imagesDrawn[i].isDisposable) {
					newImagesDrawn[newImagesDrawn.length] = imagesDrawn[i];
				}
			}
			imagesDrawn = newImagesDrawn;
		}
		
		private function clearDisposables():void {
			var i:int;
			var newDisposables:Array = new Array();
			for (i = 0; i < disposables.length; i++) {
				if (disposables[i].isFinished()) {
					GameEngine.debug.print("Image being disposed", 0);
					gameEngine.stage.removeChild(disposables[i].image.getData());
				} else {
					newDisposables[newDisposables.length] = disposables[i];
				}
			}
			disposables = newDisposables;
		}
		
		//meant to be used by handlers without access to 'instantiate'
		public function requestSpawn(imageName:String, position:Vector2D):Image2D {
			return instantiate(imageName, position);
		}

		//called by child classes to get objects colliding with a 'source'
		protected function checkCollisions(source:Image2D, targetName:String = null, targetTag:String = null):Array {
			var possibleObjects:Array = new Array();
			var collisionsDetected:Array;
			
			var curImage:Image2D;
			var i:int;
			for (i = 0; i < imagesDrawn.length; i++) {
				curImage = imagesDrawn[i];
				if (source != curImage && !curImage.isDisposable) {	//if it is not itself (and is not being disposed)
					if (targetName != null || targetTag != null) {						//if I wanna search by name or tag
						if (targetName != null && curImage.getName() == targetName) {		//if name matches
							possibleObjects[possibleObjects.length] = curImage;
						} else if (targetTag != null && curImage.getTag() == targetTag) {	//if tag matches
							possibleObjects[possibleObjects.length] = curImage;
						}
					} else {											//if I just want everything except itself
						possibleObjects[possibleObjects.length] = curImage;
					}
				}
			}
			GameEngine.debug.print("Passing ".concat(possibleObjects.length, " possible object(s)"), 4);
			collisionsDetected = Physics.checkCollisions(source, possibleObjects);
			return collisionsDetected;
		}
	}
	
}
