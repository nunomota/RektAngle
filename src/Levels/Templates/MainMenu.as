package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.Image2D;
	
	public class MainMenu extends Level {

		var backButton:Image2D;
		
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
			
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/4));
			instantiate("Account", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			instantiate("Back", new Vector2D(canvas.dimensions.x/2, 3*canvas.dimensions.y/4));
		}
		
		//level's main loop
		public override function update():void {
			super.update();
			if (!assetsLoaded) {return;}
			
			backButton.setPosition(new Vector2D(backButton.getPosition().x + 1, backButton.getPosition().y));
		}

	}
	
}
