package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	
	public class MainMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var title:Image2D;
		private var botBorder:Image2D;
		private var playButton:Image2D;
		private var accountButton:Image2D;
		private var optionsButton:Image2D;
		private var helpButton:Image2D;
		private var rankingPanel:Image2D;
		private var friendPanel:Image2D;
		
		public function MainMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Titles/MainTitle.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Play.png");
			addTexture("../Resources/Textures/Menus/Buttons/Account.png");
			addTexture("../Resources/Textures/Menus/Buttons/Options.png");
			addTexture("../Resources/Textures/Menus/Buttons/Help.png");
			addTexture("../Resources/Textures/Menus/Props/Friends.png");
			addTexture("../Resources/Textures/Menus/Props/Ranking.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			title = instantiate("MainTitle", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/16));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			
			playButton = instantiate("Play", new Vector2D(canvas.dimensions.x/2, 5*canvas.dimensions.y/16));
			accountButton = instantiate("Account", new Vector2D(canvas.dimensions.x/2, 7*canvas.dimensions.y/16));
			optionsButton = instantiate("Options", new Vector2D(canvas.dimensions.x/2, 9*canvas.dimensions.y/16));
			helpButton = instantiate("Help", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/16));
			rankingPanel = instantiate("Ranking", new Vector2D(3*canvas.dimensions.x/16, canvas.dimensions.y/2));
			friendPanel = instantiate("Friends", new Vector2D(13*canvas.dimensions.x/16, canvas.dimensions.y/2));
			
			this.makeButton(playButton);
			this.makeButton(accountButton);
			this.makeButton(optionsButton);
			this.makeButton(helpButton);
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (playButton.getMouseClick()) {
				return 1;
			} else if (accountButton.getMouseClick()) {
				return 2;
			} else if (optionsButton.getMouseClick()) {
				return 3;
			} else if (helpButton.getMouseClick()) {
				return 4;
			}
			
			return 0;
		}

	}
	
}
