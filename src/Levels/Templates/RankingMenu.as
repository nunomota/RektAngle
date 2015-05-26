package Levels.Templates {
	
	import Levels.*;
	import GUI.Objects.Auxiliary.Vector2D;
	import GUI.Objects.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Sprite; 
    import flash.text.*; 
	

	import Debug.*;
	
	public class RankingMenu extends Level {

		private var background:Image2D;
		private var topBorder:Image2D;
		private var title:Image2D;
		private var botBorder:Image2D;
		private var backButton:Image2D;
		
		public function RankingMenu(engine:GameEngine) {
			super(engine);
		}
		
		//used to populate the Level's assets
		protected override function setup():void {
			super.setup();
			
			addTexture("../Resources/Textures/Menus/Background.png");
			addTexture("../Resources/Textures/Menus/Borders/Top.png");
			addTexture("../Resources/Textures/Menus/Titles/RankingTitle.png");
			addTexture("../Resources/Textures/Menus/Borders/Bottom.png");
			addTexture("../Resources/Textures/Menus/Buttons/Back.png");
			buildAssets();
		}
		
		//called once, right after all assets are loaded
		protected override function start():void {
			super.start();
			
			background = instantiate("Background", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/2));
			topBorder = instantiate("Top", new Vector2D(canvas.dimensions.x/2, 0));
			topBorder.setPosition(new Vector2D(topBorder.getPosition().x, topBorder.getPosition().y + topBorder.getHeight()/2));
			title = instantiate("RankingTitle", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y/16));
			botBorder = instantiate("Bottom", new Vector2D(canvas.dimensions.x/2, canvas.dimensions.y));
			botBorder.setPosition(new Vector2D(botBorder.getPosition().x, botBorder.getPosition().y - botBorder.getHeight()/2));
			backButton = instantiate("Back", new Vector2D(canvas.dimensions.x/2, 11*canvas.dimensions.y/14));
			
			this.makeButton(backButton);

			showHighScoresReady();



		}
		
		//level's main loop
		public override function update():int {
			super.update();
			if (!assetsLoaded) {return 0;}
			
			if (backButton.getMouseClick()) {
				return -1;
			}
			
			return 0;
		}

		function showHighScoresReady():void   
		{  

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
