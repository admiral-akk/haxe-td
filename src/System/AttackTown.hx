package system;

import entity.Entity;

class AttackTown extends System {
	function applyModel(entity:entity.Entity) {
		var location = cast(entity, component.Location);
		var creep = cast(entity, component.Creep);
		if (location.pos.isTown()) {
			manager.remove(entity);
		}
	}

	function applyView(entity:entity.Entity, dt:Float) {}

	public function relevant(entity:Entity):Bool {
		return Std.isOfType(entity, component.Creep) && Std.isOfType(entity, component.Location);
	}
}
