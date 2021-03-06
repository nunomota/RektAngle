﻿package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	
	public class OptionsMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var title:Image2D;
		private var botBorder:Image2D;
		private var backButton:Image2D;
		
		public function OptionsMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Titles/OptionsTitle.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			addTexture("../Resources/Textures/Menus/Props/UnderConstruction.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			title = instantiate("OptionsTitle", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/16));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/14));
			instantiate("UnderConstruction", new Vector2D(canvas.dimensions.x/2, (canvas.dimensions.y - backButton.getHeight())/2));
			
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
