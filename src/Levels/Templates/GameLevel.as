package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import Handlers.Controls.*;
	
	import flash.ui.Keyboard;
	import Levels.Auxiliary.PlayerStats;
	import Levels.Auxiliary.Ability;
	
	public class GameLevel extends Level {

		private var gameEngine:GameEngine;
		
		private var background:Image2D;
		private var topBorder:Image2D;
		private var botBorder:Image2D;
		private var playerSymbol1:Image2D;
		private var playerSymbol2:Image2D;
		private var player1:Image2D;
		private var player2:Image2D;
		private var core:Image2D;
		private var corebg1:Image2D;
		private var corebg2:Image2D;
		
		private var nPlayers:int = 1;
		private var ROT_SPEED:int = 5;
		
		private var coreRot:int = 1;
		
		private var player1Stats:PlayerStats;
		private var player2Stats:PlayerStats;
		private var player1ScoreDisplay:Array;
		private var player2ScoreDisplay:Array;
		
		private var abilities:Array;
		
		public function GameLevel(engine:GameEngine) {
			super(engine);
			this.gameEngine = engine;
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
			addTexture("../Resources/Textures/InGame/Active/Corebg1.png");
			addTexture("../Resources/Textures/InGame/Active/Corebg2.png");
			addTexture("../Resources/Textures/InGame/Active/GreenRay.png");
			var i:int;
			for (i = 0; i < 10; i++) {
				addTexture("../Resources/Textures/InGame/Numbers/".concat(i, ".png"));
			}
			buildAssets();
			
			player1Stats = new PlayerStats();
			player2Stats = new PlayerStats();
			player1ScoreDisplay = new Array();
			player2ScoreDisplay = new Array();
			
			abilities = new Array();
			abilities[0] = new Ability("GreenRay", 50, 50);
			//abilities[1] = new Ability();
			//abilities[2] = new Ability();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			
			corebg2 = instantiate("Corebg2", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			corebg1 = instantiate("Corebg1", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			corebg2.getData().width /= 1.2;
			corebg2.getData().height /= 1.2;
			corebg1.getData().width /= 1.2;
			corebg1.getData().height /= 1.2;
			corebg2.rotate(180);
			corebg1.rotate(180);
			core = instantiate("Core", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			
			player1 = instantiate("Player_1", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			playerSymbol1 = instantiate("Player_1_symbol", new Vector2D(canvas.dimensions.x, 0));
			var offset:Vector2D = new Vector2D(playerSymbol1.getWidth()/10, playerSymbol1.getHeight()/10);
			playerSymbol1.setPosition(new Vector2D(playerSymbol1.getPosition().x - playerSymbol1.getWidth()/2 - offset.x, playerSymbol1.getPosition().y + playerSymbol1.getHeight()/2 + offset.y));
			updateScore(1);
			if (nPlayers == 2) {
				player2 = instantiate("Player_2", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
				player2.rotate(180);
				playerSymbol2 = instantiate("Player_2_symbol", new Vector2D(0, canvas.dimensions.y));
				playerSymbol2.setPosition(new Vector2D(playerSymbol2.getPosition().x + playerSymbol2.getWidth()/2 + offset.x, playerSymbol2.getPosition().y - playerSymbol2.getHeight()/2 - offset.y));
				updateScore(2);
			}
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			playerUpdate();
			animations();
			return 0;
		}
		
		private function playerUpdate():void {
			movePlayers();
			player1Stats.update();
			player2Stats.update();
			useAbilities();
		}
		
		private function animations():void {
			if (core.getData().rotation >= 180 || core.getData().rotation <= -180) {
				coreRot = 0-coreRot;
			}
			core.rotate(coreRot);
			corebg1.rotate(0-coreRot);
			corebg2.rotate(coreRot);
		}
		
		private function movePlayers():void {
			if (nPlayers == 1) {
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.left)) {
					player1.rotate(-ROT_SPEED);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.right)) {
					player1.rotate(ROT_SPEED);
				}
			} else {
				//Move Player1
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.left)) {
					player1.rotate(-ROT_SPEED);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.right)) {
					player1.rotate(ROT_SPEED);
				}
				//Move player2
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.left)) {
					player2.rotate(-ROT_SPEED);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.right)) {
					player2.rotate(ROT_SPEED);
				}
			}
		}
		
		private function useAbilities():void {
			if (nPlayers == 1) {
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.key1)) {
					useAbility(1, 1);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.key2)) {
					useAbility(1, 2);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.key3)) {
					useAbility(1, 3);
				}
			} else {
				//Use by Player1
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.key1)) {
					useAbility(1, 1);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.key2)) {
					useAbility(1, 2);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.key3)) {
					useAbility(1, 3);
				}
				//Use by Player2
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.key1)) {
					useAbility(2, 1);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.key2)) {
					useAbility(2, 2);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.key3)) {
					useAbility(2, 3);
				}
			}
		}
		
		private function useAbility(player:int, ability:int):void {
			var targetPlayer:Image2D = getPlayer(player);
			var targetStats:PlayerStats = getPlayerStats(player);
			var targetAbility:Ability = abilities[ability-1];
			
			if (targetStats.spendEnergy(targetAbility.cost) == 0) {
				GameEngine.debug.print("Player using ability ".concat(ability), 0);
				var abilityTexture:Image2D = instantiate(targetAbility.name, new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
				abilityTexture.rotate(targetPlayer.getData().rotation);
				destroy(abilityTexture, 1);
			} else {
				GameEngine.debug.print("Not enough energy to use ability [".concat(targetStats.energy, " available]"), 0);
			}
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
		
		private function updateScore(player:int):void {
			GameEngine.debug.print("Updating Player ".concat(player, " score"), 0);
			var targetPlayer:Image2D = getPlayer(player);
			var targetStats:PlayerStats = getPlayerStats(player);
			var targetDisplay:Array = getDisplay(player);
			
			var score:String = targetStats.score.toString();
			var targetPosition:Vector2D;
			clearDisplay(targetDisplay);
			if (player == 1) {
				targetPosition = new Vector2D(playerSymbol1.getPosition().x - playerSymbol1.getWidth()/2, playerSymbol1.getPosition().y);
				var i:int;
				for (i = 0; i < score.length; i++) {
					targetDisplay[i] = instantiate(score.charAt(score.length-1-i), targetPosition);
					targetDisplay[i].setPosition(new Vector2D(targetPosition.x - targetDisplay[i].getWidth(), targetPosition.y));
				}
			} else {
				targetPosition = new Vector2D(playerSymbol2.getPosition().x + playerSymbol2.getWidth()/2, playerSymbol2.getPosition().y);
				var j:int;
				for (j = 0; j < score.length; j++) {
					targetDisplay[j] = instantiate(score.charAt(j), targetPosition);
					targetDisplay[j].setPosition(new Vector2D(targetPosition.x + targetDisplay[j].getWidth(), targetPosition.y));
				}
			}
		}
		
		//used to update both the points of the player and its display on screen
		private function addPoints(player:int, points:int):void {
			var targetStats:PlayerStats = getPlayerStats(player);
			targetStats.addPoints(points);
			updateScore(player);
		}
		
		//used to clear a score display
		private function clearDisplay(array:Array):void {
			var i:int;
			for (i = 0; i < array.length; i++) {
				destroy(array[i], 0);
			}
			array.length = 0;
		}
		
		//retrieves a Image2D reference for a player
		private function getPlayer(player:int):Image2D {
			if (player == 1) {
				return player1;
			} 
			return player2;
		}
		
		//retrieves PlayerStats for a player
		private function getPlayerStats(player:int):PlayerStats {
			if (player == 1) {
				return player1Stats;
			}
			return player2Stats;
		}
		
		//retrieves the score display for a player
		private function getDisplay(player:int):Array {
			if (player == 1) {
				return player1ScoreDisplay;
			}
			return player2ScoreDisplay;
		}
	}
	
}
