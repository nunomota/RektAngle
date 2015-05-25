package GUI.Objects.Auxiliary {
	
	import Levels.Physics.*
	
	public class Vector2D {
		
		public var x:Number;
		public var y:Number;

		public function Vector2D(posX:Number = 0, posY:Number = 0) {
			x = posX;
			y = posY;
		}
		
		public function getMagnitude():Number {
			return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
		}
		
		//used to rotate vector 
		public function rotate(angleRad:Number):Vector2D {
			var rotVector:Vector2D = new Vector2D(this.x * Math.cos(-angleRad) + this.y * Math.sin(-angleRad), -1 * this.x * Math.sin(-angleRad) + this.y * Math.cos(-angleRad));
			GameEngine.debug.print("Vector ".concat(this.toString(), " rotated to ", rotVector.toString(), " by ", Physics.radToDeg(angleRad), " degrees"), 4);
			return rotVector;
		}
		
		public function toString():String {
			return "(".concat(x, ",", y, ")");
		}

	}
	
}
