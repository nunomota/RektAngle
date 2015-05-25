package Levels.Physics {
	
	import GUI.Objects.Image2D;
	import GUI.Objects.Auxiliary.Vector2D;
	
	public class Physics {

		public function Physics() {
			
		}
		
		//used to get all the objects that collided with 'source', inside an 'objectList'
		public static function checkCollisions(source:Image2D, objectList:Array):Array {
			var i:int;
			var curObject:Image2D;
			var sourceVertices:Array;
			var nearVertices:Array;
			var collidedObjects:Array = new Array();
			for (i = 0; i < objectList.length; i++) {
				curObject = objectList[i];
				nearVertices = getNearestVertices(sourceVertices, curObject);
				var angle1:Number = getAngle(getVector(nearVertices[0], nearVertices[1]), getVector(nearVertices[0], source.getPosition()));
				var angle2:Number = getAngle(getVector(nearVertices[0], nearVertices[2]), getVector(nearVertices[0], source.getPosition()));
				if (angle1 <= 90 && angle2 <= 90) {
					collidedObjects[collidedObjects.length] = curObject;
				}
			}
			
			if (collidedObjects.length == 0) {
				return null;
			}
			return collidedObjects;
		}
		
		//returns an array where all vertices come in increasing distance to target point
		private static function getNearestVertices(sourceVertices:Array, targetObject:Image2D):Array {
			var i:int;
			var j:int;
			var sortedArray:Array = new Array(sourceVertices.length);
			var initLength:int = sourceVertices.length;
			for (i = 0; i < initLength; i++) {
				var minDistance:Number = getDistance(sourceVertices[0], targetObject.getPosition());
				var minIndex:int = 0;
				for (j = 1; j < sourceVertices.length; j++) {
					var curDistance:Number = getDistance(sourceVertices[1], targetObject.getPosition());
					if (curDistance < minDistance) {
						minDistance = curDistance;
						minIndex = j;
					}
				}
				sortedArray[i] = sourceVertices[minIndex];
				sourceVertices.splice(minIndex, 1);
			}
			return sortedArray;
		}
		
		//return the distance between 2 points in 2D space
		public static function getDistance(point1:Vector2D, point2:Vector2D):Number {
			var vector:Vector2D = new Vector2D(point1.x - point2.x, point1.y - point2.y);
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
			vertices[0] = new Vector2D(dimensions.x/2, dimensions.y/2);
			vertices[1] = new Vector2D(dimensions.x/2, -dimensions.y/2);
			vertices[2] = new Vector2D(-dimensions.x/2, -dimensions.y/2);
			vertices[3] = new Vector2D(-dimensions.x/2, dimensions.y/2);
			radius = vertices[0].getMagnitude();
			
			//transform vertices to after the rotation (around 0,0)
			var j:int;
			var angle1:Number;
			var angle2:Number;
			var newCoords:Vector2D;
			for (j = 0; j < vertices.length; j++) {
				angle1 = getAngle(vertices[j], new Vector2D(1, 0));		//angle before rotation
				angle2 = angle1+rotation;								//angle after rotation
				newCoords = new Vector2D(radius*Math.cos(angle2), radius*Math.sin(angle2));
				vertices[j] = newCoords;								//set new coordinates for vertice
			}
			
			//add their current position (take image away from 0,0)
			var i:int;
			for (i = 0; i < vertices.length; i++) {
				vertices[i] = new Vector2D(vertices[i].x + position.x, vertices[i].y + position.y);
			}
			return vertices;
		}
		
		//returns the vector between 2 points in 2D space (from the 1st to the 2nd)
		public static function getVector(position1:Vector2D, position2:Vector2D):Vector2D {
			return (new Vector2D(position2.x - position1.x, position2.y - position1.y));
		}
		
		//return angle between two vectors, in degrees
		private static function getAngle(vector1:Vector2D, vector2:Vector2D):Number {
			var magnitude1:Number = vector1.getMagnitude();
			var magnitude2:Number = vector2.getMagnitude();
			var dotProduct:Number = vector1.x * vector2.x + vector1.y * vector2.y;
			
			return Math.acos(dotProduct/(magnitude1*magnitude2));
		}
		
		//converts angles from degrees to radians
		public static function degToRad(angleDeg:Number):Number {
			return (angleDeg/180)*Math.PI;
		}

	}
	
}
