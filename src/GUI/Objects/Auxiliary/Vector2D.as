package GUI.Objects.Auxiliary {
	
	public class Vector2D {
		
		public var x:int;
		public var y:int;

		public function Vector2D(posX:int = 0, posY:int = 0) {
			x = posX;
			y = posY;
		}
		
		public function toString():String {
			return "(".concat(x, ",", y, ")");
		}

	}
	
}
