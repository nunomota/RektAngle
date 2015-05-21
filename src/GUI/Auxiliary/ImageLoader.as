package GUI.Auxiliary {
	
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.net.URLRequest;
	
	public class ImageLoader extends Loader {

		public var targetPath:String;
		
		public function ImageLoader() {
			super();
		}
		
		//starts loading an image from memory and stores the target URL
		public override function load(request:URLRequest, context:LoaderContext = null):void {
			GameEngine.debug.print("Loading image: ".concat(request.url), 0);
			targetPath = request.url;
			super.load(request, context);
		}

	}
	
}
