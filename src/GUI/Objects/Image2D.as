package GUI.Objects {
	import flash.display.Bitmap;
	import flash.events.*;
	
	import GUI.Objects.Auxiliary.Vector2D;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Image2D {
		private var imageData:Bitmap;
		private var position:Vector2D;

		public function Image2D(data:Bitmap, pos:Vector2D) {
			this.imageData = data;
			this.position = pos;
			
			centerImage();
		}
		
		//used to change the default top-left anchor of an image to a centered one
		private function centerImage():void {
			var newPosition:Vector2D = centralizePosition(this.position);
			imageData.x = newPosition.x;
			imageData.y = newPosition.y;
		}
		
		//used to convert the coordinates of the image
		private function centralizePosition(oldPosition:Vector2D):Vector2D {
			return (new Vector2D(oldPosition.x - imageData.width/2, oldPosition.y - imageData.height/2));
		}
		
		/*--------------------------------------
		----------- Getters & Setters ----------
		--------------------------------------*/
		
		public function setX(newX:int):void {
			imageData.x += newX - position.x;
			position.x = newX;
		}
		
		public function getX():int {
			return position.x;
		}
		
		public function setY(newY:int):void {
			imageData.y += newY - position.y;
			position.y = newY;
		}
		
		public function getY():int {
			return position.y;
		}
		
		public function setPosition(newPosition:Vector2D):void {
			setX(newPosition.x);
			setY(newPosition.y);
		}
		
		public function getPosition():Vector2D {
			return (new Vector2D(getX(), getY()));
		}
	}
	
}
