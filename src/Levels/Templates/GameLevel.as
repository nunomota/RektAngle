package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	
	public class GameLevel extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var botBorder:Image2D;
		private var playerSymbol1:Image2D;
		private var playerSymbol2:Image2D;
		private var player1:Image2D;
		private var player2:Image2D;
		private var core:Image2D;
		
		private var nPlayers:int = 1;
		
		public function GameLevel(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/InGame/Background.png");
			addTexture("../Resources/Textures/InGame/Borders/Top.png");
			addTexture("../Resources/Textures/InGame/Borders/Bottom.png");
			addTexture("../Resources/Textures/InGame/Props/Player_1_symbol.png");
			addTexture("../Resources/Textures/InGame/Props/Player_2_symbol.png");
			addTexture("../Resources/Textures/InGame/Active/Player_1.png");
			addTexture("../Resources/Textures/InGame/Active/Player_2.png");
			addTexture("../Resources/Textures/InGame/Active/Core.png");
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
			
			core = instantiate("Core", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			
			player1 = instantiate("Player_1", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2 - core.getHeight()));
			playerSymbol1 = instantiate("Player_1_symbol", new Vector2D(canvas.dimensions.x, 0));
			var offset:Vector2D = new Vector2D(playerSymbol1.getWidth()/10, playerSymbol1.getHeight()/10);
			playerSymbol1.setPosition(new Vector2D(playerSymbol1.getPosition().x - playerSymbol1.getWidth()/2 - offset.x, playerSymbol1.getPosition().y + playerSymbol1.getHeight()/2 + offset.y));
			if (nPlayers == 2) {
				player2 = instantiate("Player_2", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2 + core.getHeight()));
				player2.rotate(Math.PI);
				playerSymbol2 = instantiate("Player_2_symbol", new Vector2D(0, canvas.dimensions.y));
				playerSymbol2.setPosition(new Vector2D(playerSymbol2.getPosition().x + playerSymbol2.getWidth()/2 + offset.x, playerSymbol2.getPosition().y - playerSymbol2.getHeight()/2 - offset.y));
			}
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			return 0;
		}

		//function to set number of players
		public function setPlayerNumber(number:int):void {
			this.nPlayers = number;
			if (nPlayers > 2) {
				nPlayers = 2;
			} else if (nPlayers <= 0) {
				nPlayers = 1;
			}
		}
	}
	
}
