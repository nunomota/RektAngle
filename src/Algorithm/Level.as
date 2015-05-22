package Algorithm {
	import GUI.CanvasHandler;
	
	public class Level {

		private var canvas:CanvasHandler;
		private var imageRequests:Array;
		
		public function Level(engine:GameEngine) {
			canvas = new CanvasHandler(engine);
			GameEngine.debug.print("Created new Canvas: ".concat(canvas.toString()), 0);
			imageRequests = new Array();
		}
		
		//adds a texture to the level's assets
		public function addTexture(request:String):void {
			imageRequests[imageRequests.length] = request;
		}
		
		//will put all necessary assets in memory
		public function build():void {
			GameEngine.debug.print("Building level", 0);
			canvas.populate(imageRequests);
		}
		
		//used to draw a texture in a certain position
		public function instantiate(imageName:String, posX:int, posY:int):void {
			if (canvas.draw(imageName, posX, posY) != 0) {
				GameEngine.debug.print("Could not draw texture '".concat(imageName, "' (it was either not added to the assets or there is a typo in its name)"), 1);
			}
		}
		
		//level's main loop
		public function update():void {
			
		}
		
		//used to clear every asset of the level from the screen
		public function cleanUp():void {
			canvas.clear();
		}

	}
	
}
