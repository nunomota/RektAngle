package Levels.Templates {
	
	import Levels.*;
	
	public class MainMenu extends Level {

		public function MainMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			addTexture("../Resources/Textures/Menus/Buttons/Account.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			instantiate("Back", 100, 100);
			instantiate("Account", 200, 200);
		}
		
		//level's main loop
		public override function update():void {
			super.update();
			if (!assetsLoaded) {return;}
		}

	}
	
}
