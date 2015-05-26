package  Levels.AI {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import Handlers.Controls.*;
	import GUI.*
	import Levels.Physics.*;
	import Debug.*;
	
	import flash.ui.Keyboard;
	import Levels.Auxiliary.PlayerStats;
	import Levels.Auxiliary.Ability;
	
	public class Enemy{
		
		private var enemyType:int;
		private var velocity:int = 3;
		private var enemyImage:Image2D;
		private var direction:Vector2D;
		private var canvas:CanvasHandler;
		public var hasTriggered:Boolean;
		private var probability:Number;
		
		private var BLUE_ENEMY:int = 0;
		private var GREEN_ENEMY:int = 1;
		private var YELLOW_ENEMY:int = 2;
		private var PURPLE_ENEMY:int = 3;
		
		
		public static var debug:Debug;

		public function Enemy(enemyTexture:Image2D, enemyType:int, canvas:CanvasHandler) {
			
			this.canvas = canvas;
			
			enemyImage = enemyTexture;
			this.enemyType = enemyType;
			direction = getDirectionToCenter();
			enemyTexture.setTag("Enemy");
			
		} 
		
		public function getEnemyType():int{
			return this.enemyType;
		}
		
		private function getDirectionToCenter():Vector2D {
			var norm:Number;
			var directionAux:Vector2D;
			directionAux = Physics.getVector(enemyImage.getPosition(), new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			norm = directionAux.getMagnitude();
			directionAux.x /= norm;
			directionAux.y /= norm;
			
			return directionAux;
		}
	
		public function move() : void{	
			
			enemyImage.setX(enemyImage.getX() + (direction.x*velocity));
			enemyImage.setY(enemyImage.getY() + (direction.y*velocity));
		}
		
		//funcao que recebe como argumento numero random // se a probabilidade de gerar trgger > chamo trigger
		public function checkToTrigger(prob:Number):void{
			if(prob <= probability && hasTriggered == false) {
				triggerSpecialMovement();
			}
		}
		
		//trigger special movement
		public function triggerSpecialMovement():void {
			
			var newVector:Vector2D = Physics.getVector(new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2), enemyImage.getPosition());
			
			newVector.rotate(Math.random()*(2*Math.PI));
			enemyImage.setX(canvas.dimensions.x/2 + newVector.x);
			enemyImage.setY(canvas.dimensions.y/2 + newVector.y);
			
			direction = getDirectionToCenter();
				
			hasTriggered = true;
		}
		
		public function setTriggerProbability(prob:Number):void{
			this.probability = prob;
		}
		

	}
	
}