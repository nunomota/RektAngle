package  Levels{
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import Handlers.Controls.*;
	
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import Levels.Auxiliary.PlayerStats;
	import Levels.Auxiliary.Ability;
	
	import GUI.CanvasHandler;

	
	public class AI {
		private var difficulty : int;
		private var canvas:CanvasHandler;
		private var spawnDelay:Number = 5; //in seconds is how long an enemy will spawn
		private var spawnTick:Number = 5; //time in seconds of when to decrease the spawnDelay
		private var nextDecrease:Number; //when the decrease of spawn delay will happen
		private var nextSpawn:Number; //when the next spawn will happen
		private var curLevel:Level;
		private var enemyTexture:Image2D;
		
		private var allEnemies:Array;
		private var blueEnemies:Array;
		private var greenEnemies:Array;
		private var yellowEnemies:Array;
		private var purpleEnemies:Array;
		
		private var teleportDelay:Number = 2; //Time in seconds that I check if it teleports or not
		private var nextTeleportCheck:Number;
		
		private var BLUE_ENEMY:int = 0;
		private var GREEN_ENEMY:int = 1;
		private var YELLOW_ENEMY:int = 2;
		private var PURPLE_ENEMY:int = 3;
		
		public function AI(teste:CanvasHandler, curLevel:Level) {
			canvas = teste;
			this.curLevel = curLevel;
			nextDecrease = getTimer() + spawnTick*1000;
			nextSpawn = getTimer() + spawnDelay * 1000;
			
			
			allEnemies = new Array();
			blueEnemies = new Array();
			greenEnemies = new Array();
			yellowEnemies = new Array();
			purpleEnemies = new Array();
		}
		
		
		//this funciton is now not void and must return an EnemySpawn
		public function spawnLogic():void
		{
			//Math.random() * (max - min) + min;
			var n : int;
			var enemyType : int;
			var curTime:Number = getTimer();
			var newEnemy:Enemy;
			
			//if the current time is > than nextSpawn then spawn an enemy and update the nextSpawn;
			if (curTime > nextSpawn) {
				n = Math.random() * 4;
				enemyType = Math.random() * 4;
				
				if (enemyType == BLUE_ENEMY) {
					enemyTexture = curLevel.requestSpawn("BlueEnemy", new Vector2D(-100,-100));
				} else if(enemyType == GREEN_ENEMY) {
					enemyTexture = curLevel.requestSpawn("GreenEnemy", new Vector2D(-100,-100));
				} else if(enemyType == YELLOW_ENEMY) {
					enemyTexture = curLevel.requestSpawn("YellowEnemy", new Vector2D(-100,-100));
				} else if(enemyType == PURPLE_ENEMY) {
					enemyTexture = curLevel.requestSpawn("PurpleEnemy", new Vector2D(-100,-100));
				}
				
				this.spawnFixUp(enemyTexture, n);
				
				newEnemy = new Enemy(enemyTexture, enemyType, canvas);
				addToEnemyArray(newEnemy);
				
				nextSpawn = getTimer() + spawnDelay*1000;
				
			}
			
			//if curTime > nex decrease update it and decrease the spawn delay by 1
			//when spawn delay reaches 2 we do not decrease it so that it is not OP
			if (curTime > nextDecrease) {
				nextDecrease = getTimer() * spawnTick*1000;
				if (spawnDelay > 1) {
					spawnDelay--;
				} else {
					spawnDelay -= 0.5;
				}
			}
			
		}
		
		private function spawnFixUp(enemy:Image2D, edge:int):void{
			
				//spawn at top
				if (edge == 0) {
					enemy.setPosition(new Vector2D(int(Math.random()*(canvas.dimensions.x - (enemy.getWidth()/2))), -1 * enemy.getHeight()));
				
				//spawn at left
				} else if (edge == 1) {
					enemy.setPosition(new Vector2D(int(Math.random()*(canvas.dimensions.y - (enemy.getHeight()/2))),  -1 * (enemy.getWidth())));
				
				//spawn at bot
				} else if (edge == 2) {
					enemy.setPosition(new Vector2D(int(Math.random()*(canvas.dimensions.x - (enemy.getWidth()/2))), canvas.dimensions.y + enemy.getHeight()));
				
				//spawn at right
				} else if (edge == 3) {
					enemy.setPosition(new Vector2D(int(Math.random()*(canvas.dimensions.y - (enemy.getHeight()/2))), canvas.dimensions.x + enemy.getWidth()));
				}
		}
		
		private function addToEnemyArray(enemy:Enemy):void{
			var enemyType:int = enemy.getEnemyType();
			
			if (enemyType == BLUE_ENEMY){
				blueEnemies.push(enemy);
			} else if (enemyType == GREEN_ENEMY) {
				greenEnemies.push(enemy);
			} else if (enemyType == YELLOW_ENEMY) {
				yellowEnemies.push(enemy);
			} else if (enemyType == PURPLE_ENEMY) {
				purpleEnemies.push(enemy);
			}
			
			allEnemies.push(enemy);
		}
		
		public function enemyMovementUpdate() :void{
		
			var i:int = 0;
			var curEnemy:Enemy;
			var size:int = allEnemies.length;
			
			for (i = 0; i < size; i++) {
				curEnemy = allEnemies[i];
				curEnemy.move();
			}
		}
		

	}
	
}
