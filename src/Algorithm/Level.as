package Algorithm {
	import GUI.CanvasHandler;
	import GUI.Auxiliary.ImageRequest;
	
	public class Level {

		private var canvas:CanvasHandler;
		private var imageRequests:Array;
		
		public function Level() {
			canvas = new CanvasHandler();
			imageRequests = new Array();
		}
		
		public function addTexture(request:ImageRequest):void {
			imageRequests[imageRequests.length] = request;
		}
		
		public function build():void {
			GameEngine.debug.print("Building level", 0);
			canvas.populate(imageRequests);
		}
		
		public function update():void {
			
		}

	}
	
}
