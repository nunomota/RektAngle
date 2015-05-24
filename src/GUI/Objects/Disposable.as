package GUI.Objects {
	
	import flash.utils.getTimer;
	
	public class Disposable {

		public var image:Image2D;
		private var timeToDispose:Number;
		
		public function Disposable(image2D:Image2D, seconds:Number) {
			this.image = image2D;
			this.timeToDispose = getTimer() + seconds*1000;
		}
		
		public function isFinished():Boolean {
			if (getTimer() < timeToDispose) {
				return false;
			}
			return true;
		}

	}
	
}
