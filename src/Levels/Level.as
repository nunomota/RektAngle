﻿package Levels {
	
	import GUI.CanvasHandler;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.Image2D;
	
	public class Level {

		private var gameEngine:GameEngine;
		
		protected var canvas:CanvasHandler;
		private var imageRequests:Array;
		
		protected var assetsLoaded:Boolean = false;
		
		private var buttons:Array;
		
		public function Level(engine:GameEngine) {
			gameEngine = engine;
			canvas = new CanvasHandler(engine);
			GameEngine.debug.print("Created new Canvas: ".concat(canvas.toString()), 0);
			imageRequests = new Array();
			buttons = new Array();
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
			}
			return image;
		}
		
		//used by child Objects to populate the Level's assets
		protected function setup():void {
			
		}
		
		//functioned called once, right after all assets are loaded
		protected function start():void {
			GameEngine.debug.print("'Start' method running for level", 0);
		}
		
		//level's main loop
		public function update():void {
			if (!assetsLoaded) {
				if ((assetsLoaded = canvas.assetsLoaded()) == true) {
					GameEngine.debug.print("Assets finished loading", 0);
					start();
				}
				return;
			}
			checkButtonClick();
		}
		
		//used by child classes to create a button from an image
		protected function makeButton(button:Image2D):void {
			buttons[buttons.length] = button;
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
						button.setMouseClick();
					}
				}
			}
		}
		
		//used to clear every asset of the level from the screen
		public function cleanUp():void {
			canvas.clear();
		}

	}
	
}
