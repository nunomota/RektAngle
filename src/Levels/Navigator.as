package Levels {
	
	import Levels.Templates.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	
	public class Navigator {

		private var gameEngine:GameEngine;
		
		private var curLevel:Level;
		private var mainMenu:Level;
		private var playMenu:Level;
		private var rankingMenu:Level;
		private var accountMenu:Level;
		private var optionsMenu:Level;
		private var helpMenu:Level;
		private var gameLevel:GameLevel;
		
		private var curLevelBehaviour:int;
		
		//sound stuff
		private var mouseClickSound:Sound;
		private var mainMenuSong:Sound;
		private var myChannel:SoundChannel;
		
		public function Navigator(engine:GameEngine) {
			this.gameEngine = engine;
			this.init();
			this.setup();
		}
		
		//used for variable initialization
		private function init():void {
			mainMenu = new MainMenu(gameEngine);
			playMenu = new PlayMenu(gameEngine);
			rankingMenu = new RankingMenu(gameEngine);
			accountMenu = new AccountMenu(gameEngine);
			optionsMenu = new OptionsMenu(gameEngine);
			helpMenu = new HelpMenu(gameEngine);
			//gameLevel = new GameLevel(gameEngine);
			
			
		}
		
		//used for value attribution
		private function setup():void {
			//sound setup
			mouseClickSound = new Sound(new URLRequest("../Resources/Sounds/MouseClick.mp3"));
			mainMenuSong = new Sound(new URLRequest("../Resources/Sounds/MainMenu.mp3"));
			myChannel = new SoundChannel();
			
			curLevel = mainMenu;
			
			myChannel = mainMenuSong.play();
		
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
					switch(curLevelBehaviour) {
						case 1:
							myChannel.stop();
							changeLevel((gameLevel = new GameLevel(gameEngine)));
							gameLevel.setPlayerNumber(1);
							break;
						case 2:
							myChannel.stop();
							changeLevel((gameLevel = new GameLevel(gameEngine)));
							gameLevel.setPlayerNumber(2);
							break;
						case 3:
							changeLevel(rankingMenu);
							break;
						default:
							break;
					}
				}
			}
		}
		
		//used to change the current level
		private function changeLevel(targetLevel:Level):void {
			mouseClickSound.play();
			if (curLevel == gameLevel) {
				myChannel = mainMenuSong.play();
			}
			curLevel.hide();
			curLevel = targetLevel;
		}

	}
	
}
