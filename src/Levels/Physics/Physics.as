package Levels.Physics {
	
	import GUI.Objects.Image2D;
	import GUI.Objects.Auxiliary.Vector2D;
	
	public class Physics {

		public function Physics() {
			
		}
		
		//used to get all the objects that collided with 'source', inside an 'objectList'
		public static function checkCollisions(source:Image2D, objectList:Array):Array {
			GameEngine.debug.print("Checking collisions with '".concat(source.getName(), "'"), 4);
			var i:int;
			var curObject:Image2D;
			var sourceVertices:Array = getVertices(source);
			var nearVertices:Array;
			var collidedObjects:Array = new Array();
			for (i = 0; i < objectList.length; i++) {
				curObject = objectList[i];
				nearVertices = getNearestVertices(sourceVertices, curObject);
				var angle1:Number = getAngle(getVector(nearVertices[0], nearVertices[1]), getVector(nearVertices[0], source.getPosition()));
				var angle2:Number = getAngle(getVector(nearVertices[0], nearVertices[2]), getVector(nearVertices[0], source.getPosition()));
				if (angle1 <= Math.PI && angle2 <= Math.PI) {
					collidedObjects[collidedObjects.length] = curObject;
				}
			}
			
			GameEngine.debug.print("Found '".concat(collidedObjects.length, "' objects"), 4);
			if (collidedObjects.length == 0) {
				return null;
			}
			return collidedObjects;
		}
		
		//returns an array where all vertices come in increasing distance to target point
		private static function getNearestVertices(sourceVertices:Array, targetObject:Image2D):Array {
			//TODO increase sourceVertices coordinates according to targetObject.width/2, so that they collide on proximity and not on overlap
			var i:int;
			var j:int;
			var sortedArray:Array = new Array(sourceVertices.length);
			var initLength:int = sourceVertices.length;
			for (i = 0; i < initLength; i++) {
				var minDistance:Number = getDistance(sourceVertices[0], targetObject.getPosition());
				var minIndex:int = 0;
				for (j = 1; j < sourceVertices.length; j++) {
					var curDistance:Number = getDistance(sourceVertices[j], targetObject.getPosition());
					if (curDistance < minDistance) {
						minDistance = curDistance;
						minIndex = j;
					}
				}
				GameEngine.debug.print("Nearest vertice ".concat(i, " is ", sourceVertices[minIndex].toString(), " with distance ", minDistance), 4);
				sortedArray[i] = sourceVertices[minIndex];
				sourceVertices.splice(minIndex, 1);
			}
			return sortedArray;
		}
		
		//return the distance between 2 points in 2D space
		public static function getDistance(point1:Vector2D, point2:Vector2D):Number {
			var vector:Vector2D = getVector(point1, point2);
			return vector.getMagnitude();
		}
		
		//return the vertices of an Image2D
		private static function getVertices(image:Image2D):Array {
			var vertices:Array = new Array(4);
			var position:Vector2D = image.getPosition();
			var dimensions:Vector2D = new Vector2D(image.getWidth(), image.getHeight());
			var rotation:Number = image.getData().rotation;
			var radius:Number;
			
			//how vertices would be b4 their rotation
			vertices[0] = new Vector2D(-dimensions.x/2, dimensions.y/2);
			vertices[1] = new Vector2D(dimensions.x/2, dimensions.y/2);
			vertices[2] = new Vector2D(dimensions.x/2, -dimensions.y/2);
			vertices[3] = new Vector2D(-dimensions.x/2, -dimensions.y/2);
			radius = vertices[0].getMagnitude();
			
			//transform vertices to after the rotation (around 0,0)
			var j:int;
			var angle1:Number;
			var angle2:Number;
			var newCoords:Vector2D;
			for (j = 0; j < vertices.length; j++) {
				newCoords = vertices[j].rotate(degToRad(rotation));		//angle after the rotation
				vertices[j] = newCoords;								//set new coordinates for vertice
				GameEngine.debug.print("Vertice ".concat(j, " at ", vertices[j].toString()), 4);
			}
			
			//add their current position (take image away from 0,0)
			var i:int;
			for (i = 0; i < vertices.length; i++) {
				vertices[i] = new Vector2D(vertices[i].x + position.x, vertices[i].y + position.y);
				//GameEngine.debug.print("Vertice ".concat(i, " at ", vertices[i].toString()), 4);
			}
			return vertices;
		}
		
		//returns the vector between 2 points in 2D space (from the 1st to the 2nd)
		public static function getVector(position1:Vector2D, position2:Vector2D):Vector2D {
			return (new Vector2D(position2.x - position1.x, position2.y - position1.y));
		}
		
		//return angle between two vectors, in radians
		private static function getAngle(vector1:Vector2D, vector2:Vector2D = null):Number {
			var magnitude1:Number = vector1.getMagnitude();
			if (vector2 == null) {
				vector2 = new Vector2D(1, 0);
			}
			var magnitude2:Number = vector2.getMagnitude();
			var dotProduct:Number = vector1.x * vector2.x + vector1.y * vector2.y;
			var angleRad:Number = Math.acos(dotProduct/(magnitude1*magnitude2));
			GameEngine.debug.print("Angle between ".concat(vector1.toString(), " and ", vector2.toString(), " is ", radToDeg(angleRad)), 4);
			return angleRad;
		}
		
		//converts angles from degrees to radians
		public static function degToRad(angleDeg:Number):Number {
			return (angleDeg/180)*Math.PI;
		}
		
		//converts angles from radians to degrees
		public static function radToDeg(angleRad:Number):Number {
			return (angleRad/Math.PI)*180;
		}

	}
	
}
