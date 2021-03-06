﻿package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Sprite; 
    import flash.text.*; 
	

	import Debug.*;
	import Handlers.HighScore.DataHandler;
	import GUI.Auxiliary.Translator;
	import flash.geom.Vector3D;
	
	public class RankingMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var title:Image2D;
		private var botBorder:Image2D;
		private var backButton:Image2D;
		
		private var hasRetrievedHighScores:Boolean = false;
		private var highScoresHandler:DataHandler;
		private var highScores:Array;
		private var translator:Translator;
		
		public function RankingMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Titles/RankingTitle.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			title = instantiate("RankingTitle", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/16));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/14));
			
			this.makeButton(backButton);
			highScoresHandler = new DataHandler();
			translator = new Translator(gameEngine);
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (!hasRetrievedHighScores) {
				if ((highScores = highScoresHandler.getHighscores()) != null) {
					hasRetrievedHighScores = true;
					displayScores();
				}
			}
			
			if (backButton.getMouseClick()) {
				return -1;
			}
			
			return 0;
		}

		private function displayScores():void {
			var i:int;
			var j:int;
			var curScore:Array;
			var initPos:Vector2D = new Vector2D(canvas.dimensions.x/10, canvas.dimensions.y/10);
			var posOffset:Vector2D = new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/5);
			for (i = 0; i < 2; i++) {
				for (j = 0; j < 4; j++) {
					var index:int = i*3+j;
					if (index < highScores.length) {
						curScore = translator.getPixelString(highScores[index]);
						var z:int;
						for (z = 0; z < curScore.length; z++) {
							this.requestDraw(curScore[z]);
						}
					} else {
						return;
					}
				}
			}
		}
	
	}
	
}
