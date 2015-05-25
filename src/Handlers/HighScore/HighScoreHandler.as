/* to use later



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