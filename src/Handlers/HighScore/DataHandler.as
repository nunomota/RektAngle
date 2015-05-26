package Handlers.HighScore {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Sprite; 
    import flash.text.*; 

	import Debug.*;
	
	public class DataHandler {
		
		private var isReady:Boolean = false;
		private var highScores:Array;
		
		public function DataHandler() {
			var ldr:URLLoader = new URLLoader();      
			ldr.load(new URLRequest("http://127.0.0.1/getScores.php"));
			var result:String = ldr.data; 
			ldr.addEventListener(IOErrorEvent.IO_ERROR, onError);

				 
			function onError(e:IOErrorEvent):void {
				GameEngine.debug.print("Error opening URL ".concat(e.target), 3);
				ldr.load(new URLRequest("scores.txt"));

				ldr.addEventListener(Event.COMPLETE, onLoaded);

				function onLoaded(e:Event):void {
					var result:String = e.target.data;
					highScores = result.split("#");
					this.isReady = true;

				}	

			}
		}

		public function getHighscores():Array {  
			if (isReady) {
				return highScores;
			}
			return null;
		}
	}
}





/* to use later


var file:File = File.desktopDirectory.resolvePath("MyTextFile.txt");
var stream:FileStream = new FileStream();
stream.open(file, FileMode.WRITE);
stream.writeUTFBytes("This is my text file.");
stream.close();



import stm.mprojector.mSystem;

var computerName:String = mSystem.getComputerName();


function doSubmit(e:MouseEvent):void  
{  
    if(name_txt.length <= 0)  
        return;  
      
    score = Math.floor(Math.random() * 100);  
      
    var req:URLRequest = new URLRequest("http://127.0.0.1/submitScore.php");  
    var vars:URLVariables = new URLVariables();  
    var ldr:URLLoader = new URLLoader();                  
    vars.user = name_txt.text;  
    vars.score = score;           
    req.method = URLRequestMethod.POST;  
    req.data = vars;  
      
    ldr.addEventListener(Event.COMPLETE, onScoreSubmit, false, 0, true);  
    ldr.load(req);                
}  




function onScoreSubmit(e:Event):void   
{  
    data_txt.appendText("Score Submitted: " + score + '\n');  
    var ldr:URLLoader = new URLLoader();  
    ldr.addEventListener(Event.COMPLETE, showHighScores, false, 0, true);  
    ldr.load(new URLRequest("http://127.0.0.1/getScores.php?cb=" + new Date().milliseconds.toString()));  
}  



function showHighScores(e:Event):void   
{  
    var ldr:URLLoader = e.target as URLLoader;  
    var result:String = ldr.data;  
    var scores:Array = result.split('#');  
      
    // remove empty last element  
    scores.pop();  
      
    for each(var s:String in scores)  
    {  
        data_txt.appendText(s + "\n");  
    }             
}  */