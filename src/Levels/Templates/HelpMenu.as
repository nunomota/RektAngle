package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	
	public class HelpMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var title:Image2D;
		private var botBorder:Image2D;
		private var backButton:Image2D;
		private var toggleButton:Image2D;
		
		private var helpBoard:Image2D;
		private var displayingMore:Boolean = false;
		
		public function HelpMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Titles/HelpTitle.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			addTexture("../Resources/Textures/Menus/Buttons/More.png");
			addTexture("../Resources/Textures/Menus/Buttons/Less.png");
			addTexture("../Resources/Textures/Menus/Text/Help.png");
			addTexture("../Resources/Textures/Menus/Text/MoreHelp.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			title = instantiate("HelpTitle", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/16));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/14));
			helpBoard = instantiate("Help", new Vector2D(canvas.dimensions.x/2, (canvas.dimensions.y - backButton.getHeight())/2));
			toggleButton = instantiate("More", new Vector2D(3*canvas.dimensions.x/4, 11*canvas.dimensions.y/14));
			
			this.makeButton(backButton);
			this.makeButton(toggleButton);
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (backButton.getMouseClick()) {
				return -1;
			} else if (toggleButton.getMouseClick()) {
				if (!displayingMore) {
					destroy(helpBoard, 0);
					helpBoard = instantiate("MoreHelp", new Vector2D(canvas.dimensions.x/2, (canvas.dimensions.y - backButton.getHeight())/2));
					this.removeButton(toggleButton);
					destroy(toggleButton, 0);
					toggleButton = instantiate("Less", new Vector2D(canvas.dimensions.x/4, 11*canvas.dimensions.y/14));
					this.makeButton(toggleButton);
				} else {
					destroy(helpBoard, 0);
					helpBoard = instantiate("Help", new Vector2D(canvas.dimensions.x/2, (canvas.dimensions.y - backButton.getHeight())/2));
					this.removeButton(toggleButton);
					destroy(toggleButton, 0);
					toggleButton = instantiate("More", new Vector2D(3*canvas.dimensions.x/4, 11*canvas.dimensions.y/14));
					this.makeButton(toggleButton);
				}
				displayingMore = !displayingMore;
			}
			return 0;
		}

	}
	
}
