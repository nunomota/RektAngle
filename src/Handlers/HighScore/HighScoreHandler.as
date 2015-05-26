package Handlers.HighScore {
	
	public class HighScoreHandler {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Sprite; 
    import flash.text.*; 
	

	import Debug.*;


		function showHighScoresReady():void {  

					var ldr:URLLoader = new URLLoader();      
					ldr.load(new URLRequest("http://127.0.0.1/getScores.php"));
					var result:String = ldr.data;
					trace(result);  
					ldr.addEventListener(IOErrorEvent.IO_ERROR, onError);

				 
					function onError(e:IOErrorEvent):void {
					ldr.load(new URLRequest("scores.txt"));

					ldr.addEventListener(Event.COMPLETE, onLoaded);

						function onLoaded(e:Event):void {
							var result:String = e.target.data;
							var strings:Array = result.split("#");
							
							var myTextBox:TextField = new TextField(); 
							myTextBox.text = strings[0]; 
							gameEngine.stage.addChild(myTextBox);
							
							var myTextBox2:TextField = new TextField(); 
							myTextBox2.text = strings[1]; 
							 gameEngine.stage.addChild(myTextBox2); 
							
							trace(strings[0]); 
							trace(strings[1]);
							trace(strings[2]); 
							trace(strings[3]);
							trace(strings[4]); 

						}	

				}  
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