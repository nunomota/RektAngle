package Handlers.Controls {
	
	public class ControlSet {

		public var key1:uint;
		public var key2:uint;
		public var key3:uint;
		public var left:uint;
		public var right:uint;
		
		public function ControlSet(power1:uint, power2:uint, power3:uint, sideLeft:uint, sideRight:uint) {
			this.key1 = power1;
			this.key2 = power2;
			this.key3 = power3;
			this.left = sideLeft;
			this.right = sideRight;
		}

	}
	
}
