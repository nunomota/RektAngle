package Levels.Auxiliary {
	
	public class Ability {

		public var name:String;
		public var cost:int;
		public var damage:int;
		
		public var player:int;
		
		public function Ability(newName:String, abilityCost:int, abilityDamage:int) {
			this.name = newName;
			this.cost = abilityCost;
			this.damage = abilityDamage;
		}

	}
	
}
