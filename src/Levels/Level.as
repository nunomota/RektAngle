package Levels {
	
	import GUI.CanvasHandler;
	
	public class Level {

		private var canvas:CanvasHandler;
		private var imageRequests:Array;
		
		protected var assetsLoaded:Boolean = false;
		
		public function Level(engine:GameEngine) {
			canvas = new CanvasHandler(engine);
			GameEngine.debug.print("Created new Canvas: ".concat(canvas.toString()), 0);
			imageRequests = new Array();
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
		public function instantiate(imageName:String, posX:int, posY:int):void {
			if (canvas.draw(imageName, posX, posY) != 0) {
				GameEngine.debug.print("Could not draw texture '".concat(imageName, "' (it was either not added to the assets or there is a typo in its name)"), 1);
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
		public function update():void {
			if (!assetsLoaded) {
				if ((assetsLoaded = canvas.assetsLoaded()) == true) {
					GameEngine.debug.print("Assets finished loading", 0);
					start();
				}
				return;
			}
		}
		
		//function meant to be implement by different child objects
		protected function algorithm():void {
			
		}
		
		//used to clear every asset of the level from the screen
		public function cleanUp():void {
			canvas.clear();
		}

	}
	
}
