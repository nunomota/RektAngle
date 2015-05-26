package GUI.Auxiliary {
	
	import Levels.Level;
	import GUI.Objects.Auxiliary.Vector2D;
	
	public class Translator extends Level {

		private var alphabet:String = "abcdefghijklmnopqrstuvwxyz0123456789";
		
		public function Translator(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
		
			var i : int;
			for (i = 0; i < alphabet.length; i++) {
				addTexture("../Resources/Textures/Menus/Characters/".concat(alphabet.charAt(i), ".png"));
			}
			addTexture("../Resources/Textures/Menus/Characters/space.png");
			
			buildAssets();
		}
		
		public function getPixelString(string:String):Array {
			var array:Array = new Array();
			var i:int;
			for (i = 0; i < string.length; i++) {
				var curChar:String = string.charAt(i);
				if (charAt(i) == " ") {
					array[array.length] = instantiate("space", new Vector2D(0, 0));
				} else {
					array[array.length] = instantiate(string.charAt(i), new Vector2D(0, 0));
				}
			}
			
			var width:int = array[0].getWidth();
			var j:int;
			for (j = 0; j < array.length; j++) {
				array[j].setPosition(new Vector2D(j*width, 0));
			}
			return array;
		}

	}
	
}
