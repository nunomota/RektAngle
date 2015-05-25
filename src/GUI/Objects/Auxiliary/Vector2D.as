package GUI.Objects.Auxiliary {
	
	public class Vector2D {
		
		public var x:int;
		public var y:int;

		public function Vector2D(posX:int = 0, posY:int = 0) {
			x = posX;
			y = posY;
		}
		
		public function getMagnitude():Number {
			return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
		}
		
		public function toString():String {
			return "(".concat(x, ",", y, ")");
		}

	}
	
}
