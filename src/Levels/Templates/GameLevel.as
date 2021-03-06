﻿package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import Handlers.Controls.*;
	import Levels.Physics.*;
	import Levels.AI.*;
	
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import Levels.Auxiliary.PlayerStats;
	import Levels.Auxiliary.Ability;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	
	public class GameLevel extends Level {

		private var MAX_LIVES:int = 4;
		
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
		
		//Popup related
		private var popBoard:Image2D;
		private var popResume:Image2D;
		private var popExit:Image2D;
		
		private var nPlayers:int = 1;
		private var ROT_SPEED:int = 5;
		
		private var coreRot:int = 1;
		
		private var player1Stats:PlayerStats;
		private var player2Stats:PlayerStats;
		private var player1ScoreDisplay:Array;
		private var player2ScoreDisplay:Array;
		private var player1EnergyDisplay:Array;
		private var player2EnergyDisplay:Array;
		
		private var abilities:Array;
		private var blueAbilityTexture:Array = new Array(2);
		private var blueAbilityEnabled:Array = new Array(false, false);
		
		private var isPaused:Boolean = false;
		
		//pause menu related
		private var nextCatch:Number = 0;
		private var catchDelay:Number = 0.2;
		
		private var curLives:int;
		private var timeOfLoss:Number;
		private var timeOfTeleport:Number;
		private var menuTeleportDelay:Number = 8;
		
		//AI related
		private var aiHandler:AI;
		
		//Sound related
		private var ability1Sound:Sound;
		private var ability2Sound:Sound;
		private var ability3Sound:Sound;
		private var explosion:Sound;
		private var gameOver:Sound;
		private var mainSong:Sound;
		private var myChannel:SoundChannel;
		
		public function GameLevel(engine:GameEngine) {
			super(engine);
			this.gameEngine = engine;
			this.curLives = MAX_LIVES;
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
			addTexture("../Resources/Textures/InGame/Active/Warning.png");
			addTexture("../Resources/Textures/InGame/Popup/Resume.png");
			addTexture("../Resources/Textures/InGame/Popup/Exit.png");
			addTexture("../Resources/Textures/InGame/Popup/Board.png");
			addTexture("../Resources/Textures/InGame/Popup/TeleportWarning.png");
			addTexture("../Resources/Textures/InGame/Popup/GameOver.png");
			addTexture("../Resources/Textures/InGame/Active/Core4.png");
			addTexture("../Resources/Textures/InGame/Active/Core3.png");
			addTexture("../Resources/Textures/InGame/Active/Core2.png");
			addTexture("../Resources/Textures/InGame/Active/Core1.png");
			addTexture("../Resources/Textures/InGame/Active/Core0.png");
			addTexture("../Resources/Textures/InGame/Active/Corebg1.png");
			addTexture("../Resources/Textures/InGame/Active/Corebg2.png");
			addTexture("../Resources/Textures/InGame/Active/GreenAbility.png");
			addTexture("../Resources/Textures/InGame/Active/BlueAbility.png");
			addTexture("../Resources/Textures/InGame/Active/PurpleAbility.png");
			addTexture("../Resources/Textures/InGame/Active/Plus.png");
			addTexture("../Resources/Textures/InGame/Active/AI/GreenEnemy.png");
			addTexture("../Resources/Textures/InGame/Active/AI/BlueEnemy.png");
			addTexture("../Resources/Textures/InGame/Active/AI/YellowEnemy.png");
			addTexture("../Resources/Textures/InGame/Active/AI/PurpleEnemy.png");
			
			
			addTexture("../Resources/Textures/InGame/Active/Explosion_1.png");
			var i:int;
			for (i = 0; i < 10; i++) {
				addTexture("../Resources/Textures/InGame/Numbers/".concat(i, ".png"));
			}
			addTexture("../Resources/Textures/InGame/Numbers/Slash.png");
			buildAssets();
			
			player1Stats = new PlayerStats();
			player2Stats = new PlayerStats();
			player1ScoreDisplay = new Array();
			player2ScoreDisplay = new Array();
			player1EnergyDisplay = new Array();
			player2EnergyDisplay = new Array();
			
			abilities = new Array();
			abilities[0] = new Ability("GreenAbility", 30, 50);
			abilities[1] = new Ability("BlueAbility", 2, 50);
			abilities[2] = new Ability("PurpleAbility", 50, 50);
			
			//sound setup
			ability1Sound = new Sound(new URLRequest("../Resources/Sounds/Ability1.mp3"));			
			ability2Sound = new Sound(new URLRequest("../Resources/Sounds/Ability2.mp3"));
			ability3Sound = new Sound(new URLRequest("../Resources/Sounds/Ability3.mp3"));
			explosion = new Sound(new URLRequest("../Resources/Sounds/Explosion.mp3"));
			gameOver = new Sound(new URLRequest("../Resources/Sounds/GameOver.mp3"));
			mainSong = new Sound(new URLRequest("../Resources/Sounds/MainSong.mp3"));
			
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
			core = instantiate("Core4", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			
			player1 = instantiate("Player_1", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			playerSymbol1 = instantiate("Player_1_symbol", new Vector2D(canvas.dimensions.x, 0));
			var offset:Vector2D = new Vector2D(playerSymbol1.getWidth()/10, playerSymbol1.getHeight()/10);
			playerSymbol1.setPosition(new Vector2D(playerSymbol1.getPosition().x - playerSymbol1.getWidth()/2 - offset.x, playerSymbol1.getPosition().y + playerSymbol1.getHeight()/2 + offset.y));
			updateDisplays(1);
			if (nPlayers == 2) {
				player2 = instantiate("Player_2", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
				player2.rotate(180);
				playerSymbol2 = instantiate("Player_2_symbol", new Vector2D(0, canvas.dimensions.y));
				playerSymbol2.setPosition(new Vector2D(playerSymbol2.getPosition().x + playerSymbol2.getWidth()/2 + offset.x, playerSymbol2.getPosition().y - playerSymbol2.getHeight()/2 - offset.y));
				updateDisplays(2);
			}
			
			aiHandler = new AI(canvas, this);
			
			//sound stuff
			myChannel = new SoundChannel();
			myChannel = mainSong.play(0, 99);
		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (curLives > 0) {
				handleEscPress();
				if (!isPaused) {
					playerUpdate();
					aiHandler.update();
					animations();
				} else {
					return popupUpdate();
				}
			} else {
				return gameOverUpdate();
			}
			return 0;
		}
		
		//used to toggle pause with 'esc' press
		private function handleEscPress():void {
			var curTime:Number = getTimer();
			if (curTime >= nextCatch && gameEngine.eventHandler.getKeyDown(Keyboard.ESCAPE)) {
				if (isPaused) {
					unPause();
				} else {
					pause();
				}
				nextCatch = curTime+catchDelay*1000;
			}
		}
		
		private function playerUpdate():void {
			movePlayers();
			blueAbilityDrain();
			player1Stats.update();
			updateEnergy(1);
			handleAICollisions(1);
			if (nPlayers != 1) {
				player2Stats.update();
				updateEnergy(2);
				handleAICollisions(2);
			}
			useAbilities();
		}
		
		private function handleAICollisions(player:int): void {
			var targetPlayer:Image2D = getPlayer(player);
			var enemies:Array = filterCollisions(targetPlayer, checkCollisions(targetPlayer, null, "Enemy"));
			if (enemies != null) {
				var nCollisions:int = enemies.length;
				explodeEnemies(enemies, player);
				if (nCollisions > 0 && !blueAbilityEnabled[player-1]) {
					decreaseLifePoints();
				}
			}
		}
		
		private function animations():void {
			if (core.getData().rotation >= 180 || core.getData().rotation <= -180) {
				coreRot = 0-coreRot;
			}
			core.rotate(coreRot);
			corebg1.rotate(0-coreRot);
			corebg2.rotate(coreRot);
		}
		
		private function gameOverUpdate():int {
			var curTime:Number = getTimer();
			if (curTime >= timeOfTeleport) {
				return -1;
			}
			return 0;
		}
		
		//used to handle button presses while paused
		private function popupUpdate():int {
			if (popResume.getMouseClick()) {
				hidePopup();
				isPaused = false;
			} else if (popExit.getMouseClick()) {
				hidePopup();
				myChannel.stop();
				return -1;
			}
			return 0;
		}
		
		private function movePlayers():void {
			if (nPlayers == 1) {
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.left)) {
					player1.rotate(-ROT_SPEED);
					blueAbilityUpdate(1);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.singlePlayer.right)) {
					player1.rotate(ROT_SPEED);
					blueAbilityUpdate(1);
				}
			} else {
				//Move Player1
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.left)) {
					player1.rotate(-ROT_SPEED);
					blueAbilityUpdate(1);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer1.right)) {
					player1.rotate(ROT_SPEED);
					blueAbilityUpdate(1);
				}
				//Move player2
				if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.left)) {
					player2.rotate(-ROT_SPEED);
					blueAbilityUpdate(2);
				} else if (gameEngine.eventHandler.getKeyDown(PlayerControls.multiPlayer2.right)) {
					player2.rotate(ROT_SPEED);
					blueAbilityUpdate(2);
				}
			}
		}
		
		private function blueAbilityUpdate(player:int):void {
			//update blue ability according to player
			var i:int;
			var targetPlayer:Image2D = getPlayer(player);
			if (blueAbilityEnabled[player-1]) {
				targetPlayer = getPlayer(player);
				blueAbilityTexture[player-1].rotate(targetPlayer.getData().rotation - blueAbilityTexture[player-1].getData().rotation);
			}
		}
		
		private function blueAbilityDrain():void {
			var i:int;
			var targetStats:PlayerStats;
			for (i = 0; i < blueAbilityEnabled.length; i++) {
				if (blueAbilityEnabled[i]) {
					targetStats = getPlayerStats(i+1);
					if (targetStats.drainEnergy(abilities[1].cost) != 0) {
						destroy(blueAbilityTexture[i], 0);
						blueAbilityEnabled[i] = false;
					}
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
			
			if (targetStats.hasReloaded()) {
				GameEngine.debug.print("Player using ability ".concat(ability), 0);
				targetAbility.player = player;
				if (targetStats.spendEnergy(targetAbility.cost) == 0) {
					if (targetAbility.name == "GreenAbility") {
						ability1Sound.play();
						var abilityTexture:Image2D = instantiate(targetAbility.name, new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
						abilityTexture.rotate(targetPlayer.getData().rotation);
						var enemies:Array = filterCollisions(abilityTexture, checkCollisions(abilityTexture, null, "Enemy"));
						explodeEnemies(enemies, player);
						destroy(abilityTexture, 1);
					} else if (targetAbility.name == "BlueAbility") {
						if (blueAbilityEnabled[player-1]) {
							blueAbilityEnabled[player-1] = false;
							destroy(blueAbilityTexture[player-1], 0);
						} else {
							ability2Sound.play();
							blueAbilityTexture[player-1] = instantiate(targetAbility.name, new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
							blueAbilityTexture[player-1].rotate(targetPlayer.getData().rotation);
							blueAbilityEnabled[player-1] = true;
						}
					} else if (targetAbility.name == "PurpleAbility") {
						ability3Sound.play();
						var abilityTexture1:Image2D = instantiate(targetAbility.name, new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
						abilityTexture1.rotate(targetPlayer.getData().rotation);
						var enemies1:Array = filterCollisions(abilityTexture1, checkCollisions(abilityTexture1, null, "Enemy"));
						absorbEnemies(enemies1, player);
						destroy(abilityTexture1, 1);
					}
				} else {
					if (player == 1) {
						destroy(instantiate("Warning", new Vector2D(canvas.dimensions.x/2, topBorder.getPosition().y + topBorder.getHeight()/2)), 2);
					} else {
						destroy(instantiate("Warning", new Vector2D(canvas.dimensions.x/2, botBorder.getPosition().y - botBorder.getHeight()/2)), 2);
					}
					GameEngine.debug.print("Not enough energy to use ability [".concat(targetStats.energy, " available]"), 0);
				}
			}
		}
		
		//used to only get collisions in front of our textures (abilities and players should call this method)
		private function filterCollisions(source:Image2D, enemies:Array):Array {
			var filteredCollisions:Array = new Array();
			var sourcePosition:Vector2D = source.getPosition();
			var rotation:Number = Physics.degToRad(source.getData().rotation);
			var directionVector:Vector2D = new Vector2D(0, -1);
			directionVector = directionVector.rotate(rotation);
			
			var i:int;
			var curEnemy:Image2D;
			var curVector:Vector2D;
			if (enemies != null) {
				for (i = 0; i < enemies.length; i++) {
					curEnemy = enemies[i];
					curVector = Physics.getVector(sourcePosition, curEnemy.getPosition());
					if (Physics.getAngle(directionVector, curVector) <= Math.PI/2) {
						filteredCollisions[filteredCollisions.length] = curEnemy;
					}
				}
			}
			
			GameEngine.debug.print("Objects after filtering: ".concat(filteredCollisions.length), 4);
			if (filteredCollisions.length > 0) {
				return filteredCollisions;
			}
			return null;
		}
		
		//used to destroy the enemies hit
		private function explodeEnemies(enemyArray:Array, player:int):void {
			var i:int;
			var curEnemy:Image2D;
			var curEnemyPos:Vector2D;
			var targetStats:PlayerStats = getPlayerStats(player);
			if (enemyArray != null) {
				GameEngine.debug.print("Enemies to explode: ".concat(enemyArray.length), 5);
				explosion.play();
				for (i = 0; i < enemyArray.length; i++) {
					curEnemy = enemyArray[i];
					curEnemyPos = curEnemy.getPosition();
					destroy(curEnemy, 0);
					destroy(instantiate("Explosion_1", curEnemyPos), 2);
					addPoints(player, 50);
				}
			}
		}
		
		//used to absorb the enemies hit
		private function absorbEnemies(enemyArray:Array, player:int):void {
			var i:int;
			var curEnemy:Image2D;
			var curEnemyPos:Vector2D;
			var targetStats:PlayerStats = getPlayerStats(player);
			if (enemyArray != null) {
				GameEngine.debug.print("Enemies to absorb: ".concat(enemyArray.length), 5);
				explosion.play();
				for (i = 0; i < enemyArray.length; i++) {
					curEnemy = enemyArray[i];
					curEnemyPos = curEnemy.getPosition();
					destroy(curEnemy, 0);
					destroy(instantiate("Plus", curEnemyPos), 2);
					targetStats.absorbEnergy();
					addPoints(player, 50);
				}
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
		
		private function updateDisplays(player:int):void {
			updateScore(player);
			updateEnergy(player);
		}
		
		private function updateScore(player:int):void {
			GameEngine.debug.print("Updating Player ".concat(player, " score"), 0);
			var targetPlayer:Image2D = getPlayer(player);
			var targetStats:PlayerStats = getPlayerStats(player);
			var targetDisplay:Array = getScoreDisplay(player);
			
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
		
		private function updateEnergy(player:int):void {
			var targetStats:PlayerStats = getPlayerStats(player);
			var targetDisplay:Array = getEnergyDisplay(player);
			
			var energy:String = targetStats.energy.toString();
			var targetPosition:Vector2D;
			clearDisplay(targetDisplay);
			if (player == 1) {
				targetPosition = new Vector2D(canvas.dimensions.x/2, topBorder.getPosition().y - topBorder.getHeight()/3);
				targetDisplay[0] = instantiate("0", targetPosition);
				targetPosition = new Vector2D(7*targetDisplay[0].getWidth(), targetDisplay[0].getPosition().y);
				targetDisplay[0].setPosition(targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[1] = instantiate("0", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[2] = instantiate("1", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[3] = instantiate("Slash", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				var j:int;
				for (j = 0; j < energy.length; j++) {
					targetDisplay[4+j] = instantiate(energy.charAt(energy.length-1-j), targetPosition);
					targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				}
			} else {
				targetPosition = new Vector2D(canvas.dimensions.x/2, botBorder.getPosition().y + botBorder.getHeight()/3);
				targetDisplay[0] = instantiate("0", targetPosition);
				targetPosition = new Vector2D(canvas.dimensions.x - targetDisplay[0].getWidth(), targetDisplay[0].getPosition().y);
				targetDisplay[0].setPosition(targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[1] = instantiate("0", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[2] = instantiate("1", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				targetDisplay[3] = instantiate("Slash", targetPosition);
				targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
				var i:int;
				for (i = 0; i < energy.length; i++) {
					targetDisplay[4+i] = instantiate(energy.charAt(energy.length-1-i), targetPosition);
					targetPosition = new Vector2D(targetPosition.x - targetDisplay[0].getWidth(), targetPosition.y);
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
		private function getScoreDisplay(player:int):Array {
			if (player == 1) {
				return player1ScoreDisplay;
			}
			return player2ScoreDisplay;
		}
		
		//retrieves the energy display for a player
		private function getEnergyDisplay(player:int):Array {
			if (player == 1) {
				return player1EnergyDisplay;
			}
			return player2EnergyDisplay;
		}
		
		//used to pause the game
		private function pause():void {
			isPaused = true;
			showPopup();
		}  
		
		//used to unPause the game
		private function unPause():void {
			hidePopup();
			isPaused = false;
		}
		
		//used to show the Game-Over screen
		private function showGameOver():void {
			instantiate("TeleportWarning", new Vector2D(canvas.dimensions.x/2, topBorder.getPosition().y + topBorder.getHeight()/2));
			instantiate("Board", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			instantiate("GameOver", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			gameOver.play();
			myChannel.stop();
		}
		
		//used to show the Pop-up
		private function showPopup():void {
			popBoard = instantiate("Board", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			popResume = instantiate("Resume", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2 - canvas.dimensions.y/22));
			popExit = instantiate("Exit", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2 + canvas.dimensions.y/22));
			this.makeButton(popResume);
			this.makeButton(popExit);
		}
		
		//used to hide the Pop-up
		private function hidePopup():void {
			destroy(popBoard, 0);
			removeButton(popResume);
			destroy(popResume, 0);
			removeButton(popExit);
			destroy(popExit, 0);
		}
		
		//used to decrease the current life points
		private function decreaseLifePoints():void {
			this.curLives--;
			updateCore();
			if (curLives == 0) {
				showGameOver();
				timeOfLoss = getTimer();
				timeOfTeleport = timeOfLoss + menuTeleportDelay*1000;
			}
		}
		
		//used to change core's texture
		private function updateCore():void {
			var corePosition:Vector2D = core.getPosition();
			var coreRotation:Number = core.getData().rotation;
			
			destroy(core, 0);
			core = instantiate("Core".concat(curLives), corePosition);
			core.rotate(coreRotation);
		}
	}
	
}
