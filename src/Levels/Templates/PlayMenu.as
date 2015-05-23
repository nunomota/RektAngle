package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	
	public class PlayMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var botBorder:Image2D;
		private var singleButton:Image2D;
		private var coopButton:Image2D;
		private var rankingButton:Image2D;
		private var backButton:Image2D;
		private var singleProp:Image2D;
		private var coopProp:Image2D;
		
		public function PlayMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Single.png");
			addTexture("../Resources/Textures/Menus/Buttons/Co-op.png");
			addTexture("../Resources/Textures/Menus/Buttons/Ranking.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			addTexture("../Resources/Textures/Menus/Props/Solo.png");
			addTexture("../Resources/Textures/Menus/Props/Multiplayer.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			
			singleButton = instantiate("Single", new Vector2D(canvas.dimensions.x/2, 7*canvas.dimensions.y/28));
			singleProp = instantiate("Solo", new Vector2D(canvas.dimensions.x/2, singleButton.getPosition().y-singleButton.getHeight()/2));
			singleProp.setPosition(new Vector2D(singleProp.getPosition().x, singleProp.getPosition().y-singleProp.getHeight()/2));
			coopButton = instantiate("Co-op", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/28));
			coopProp = instantiate("Multiplayer", new Vector2D(canvas.dimensions.x/2, coopButton.getPosition().y-coopButton.getHeight()/2));
			coopProp.setPosition(new Vector2D(coopProp.getPosition().x, coopProp.getPosition().y-coopProp.getHeight()/2));
			rankingButton = instantiate("Ranking", new Vector2D(canvas.dimensions.x/2, 15*canvas.dimensions.y/28));
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/14));
			
			this.makeButton(singleButton);
			this.makeButton(coopButton);
			this.makeButton(rankingButton);
			this.makeButton(backButton);
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (backButton.getMouseClick()) {
				return -1;
			}
			
			return 0;
		}
	}
	
}
