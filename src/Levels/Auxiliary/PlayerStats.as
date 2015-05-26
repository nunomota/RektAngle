package Levels.Auxiliary {
	
	import flash.utils.getTimer;

	public class PlayerStats {
		
		public var score:int = 0;
		public var energy:int = 0;
		private var rechargeDelay:Number = 0.2;		//in seconds
		private var reloadDelay:Number = 0.2;
		private var drainDelay:Number = 0.2;
		
		private var nextTick:Number;			//timer for energy recharge
		private var nextShot:Number = 0;		//timer for weapon reload
		private var nextDrain:Number = 0;		//timer for energy drain
		
		private var energyAbsortion:int = 10;
		
		public function PlayerStats() {
			nextTick = getTimer() + rechargeDelay*1000;
			nextShot = getTimer() + reloadDelay*1000;
			nextDrain = getTimer() + drainDelay*1000;
		}
		
		public function addPoints(points:int):void {
			this.score += points;
		}
		
		public function update():void {
			recharge();
		}
		
		public function hasReloaded():Boolean {
			var curTime:Number = getTimer();
			if (curTime >= nextShot) {
				nextShot = curTime+reloadDelay*1000;
				return true;
			}
			return false;
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
		
		public function drainEnergy(energyDrained:int):int {
			var curTime:Number = getTimer();
			if (curTime >= nextDrain) {
				nextDrain = curTime+drainDelay*1000;
				return spendEnergy(energyDrained);
			}
			return 0;
		}
		
		public function absorbEnergy():void {
			this.energy += energyAbsortion;
			if (this.energy > 100) {
				this.energy = 100;
			}
		}

	}
	
}
