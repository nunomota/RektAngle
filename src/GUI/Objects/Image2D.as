package GUI.Objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	import GUI.Objects.Auxiliary.Vector2D;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Image2D {
		private var imageData:Bitmap;
		private var position:Vector2D;
		public var name:String = "";
		
		private var wasClicked:Boolean = false;
		
		private var lastRotation:Number = 190;

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
		
		//used to rotate the image
		public function rotate(angleDeg:Number, mode:int = 1):void {
			var matrix:Matrix = imageData.transform.matrix;
			var rect:Rectangle = imageData.getBounds(imageData.parent);

			matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
			matrix.rotate((angleDeg / 180) * Math.PI);
			matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
			imageData.transform.matrix = matrix;

			imageData.rotation = Math.round(imageData.rotation);
			if (mode == 1) {
				if (imageData.rotation == 0) {
					GameEngine.debug.print("Calibrating Position", 0);
					imageData.x = this.position.x - imageData.width/2;
					imageData.y = this.position.y - imageData.height/2;
				} else if (imageData.rotation == 180 || imageData.rotation == -180) {
					GameEngine.debug.print("Calibrating Position", 0);
					imageData.x = this.position.x + imageData.width/2;
					imageData.y = this.position.y + imageData.height/2;
				}
			}
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
		
		public function getWidth():int {
			return this.imageData.width;
		}
		
		public function getHeight():int {
			return this.imageData.height;
		}
		
		public function setMouseClick():void {
			wasClicked = true;
		}
		
		public function getMouseClick():Boolean {
			var temp:Boolean = wasClicked;
			wasClicked = false;
			return temp;
		}
		
		public function setName(newName:String):void {
			this.name = newName;
		}
		
		public function getName():String {
			return this.name;
		}
		
		public function getData():Bitmap {
			return this.imageData;
		}
	}
	
}
