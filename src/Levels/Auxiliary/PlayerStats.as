package Levels.Auxiliary {
	
	import flash.utils.getTimer;

	public class PlayerStats {
		
		public var score:int = 0;
		public var energy:int = 0;
		private var rechargeDelay:Number = 0.2;		//in seconds
		
		private var nextTick:Number;
		
		public function PlayerStats() {
			nextTick = getTimer() + rechargeDelay*1000;
		}
		
		public function addPoints(points:int):void {
			this.score += points;
		}
		
		public function update():void {
			recharge();
		}
		
		public function spendEnergy(energySpent:int):int {
			if ((energy - energySpent) > 0) {
				this.energy -= energySpent;
				return 0;
			}
			return -1;
		}
		
		private function recharge():void {
			var curTime:Number = getTimer();
			if (energy < 100) {
				if (curTime >= nextTick) {
					energy++;
					nextTick = curTime+rechargeDelay*1000;
				}
			} else {
				energy = 100;
			}
		}

	}
	
}
