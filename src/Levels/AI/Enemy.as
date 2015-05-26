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
		private var hasTeleported:Boolean = (Math.random() > .5) ? true : false;
		private var distanceToCenter;
		
		private var BLUE_ENEMY:int = 0;
		private var GREEN_ENEMY:int = 1;
		private var YELLOW_ENEMY:int = 2;
		private var PURPLE_ENEMY:int = 3;
		
		
		public static var debug:Debug;

		//TODO
		//DONUT FORGET ADD TEXTURE OF IT EXPLODING
		//o enemy vai receber a imagem que controla depois posso move la a partir daqui 
		public function Enemy(enemyTexture:Image2D, enemyType:int, canvas:CanvasHandler) {
			
			this.canvas = canvas;
			
			debug = new Debug(4);
			debug.toggle();
			
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
			
			if (enemyType == GREEN_ENEMY) {
				enemyImage.setX(enemyImage.getX() + (direction.x*velocity));
				enemyImage.setY(enemyImage.getY() + (direction.y*velocity));
			} else if (enemyType == BLUE_ENEMY) {
				var newVector:Vector2D = Physics.getVector(new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2), enemyImage.getPosition());

				if (newVector.getMagnitude() < distanceToCenter && hasTeleported == false) {
					//so faz isto uma vez
					newVector.rotate(Math.random()*(2*Math.PI));
					enemyImage.setX(canvas.dimensions.x/2 + newVector.x);
					enemyImage.setY(canvas.dimensions.y/2 + newVector.y);
					direction = getDirectionToCenter();
					hasTeleported = true;
				}
				
				enemyImage.setX(enemyImage.getX() + (direction.x*velocity));
				enemyImage.setY(enemyImage.getY() + (direction.y*velocity));
				
			} else if (enemyType == YELLOW_ENEMY) {
			}
			
		}
		

	}
	
}