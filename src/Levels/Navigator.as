package Levels {
	
	import Levels.Templates.*;
	
	public class Navigator {

		private var gameEngine:GameEngine;
		
		private var curLevel:Level;
		private var mainMenu:Level;
		private var playMenu:Level;
		private var accountMenu:Level;
		private var optionsMenu:Level;
		private var helpMenu:Level;
		
		private var curLevelBehaviour:int;
		
		public function Navigator(engine:GameEngine) {
			this.gameEngine = engine;
			this.init();
			this.setup();
		}
		
		//used for variable initialization
		private function init():void {
			mainMenu = new MainMenu(gameEngine);
			playMenu = new PlayMenu(gameEngine);
			accountMenu = new AccountMenu(gameEngine);
			optionsMenu = new OptionsMenu(gameEngine);
			helpMenu = new HelpMenu(gameEngine);
		}
		
		//used for value attribution
		private function setup():void {
			curLevel = mainMenu;
		}
		
		public function update():void {
			curLevelBehaviour = curLevel.update();
			
			if (curLevelBehaviour == 0) {
				//stay at the same level
			} else if (curLevelBehaviour == -1) {
				GameEngine.debug.print("Returning to main menu", 0);
				changeLevel(mainMenu);
			} else {
				if (curLevel == mainMenu) {
					switch(curLevelBehaviour) {
						case 1:
							changeLevel(playMenu);
							break;
						case 2:
							changeLevel(accountMenu);
							break;
						case 3:
							changeLevel(optionsMenu);
							break;
						case 4:
							changeLevel(helpMenu);
							break;
						default:
							break;
					}
				} else if (curLevel == playMenu) {
					
				}
			}
		}
		
		//used to change the current level
		private function changeLevel(targetLevel:Level):void {
			curLevel.hide();
			curLevel = targetLevel;
		}

	}
	
}
