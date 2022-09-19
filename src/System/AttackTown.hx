package system;

import entity.Entity;

class AttackTown extends System {
	function applyModel(entity:entity.Entity) {
		var location = cast(entity, component.Location);
		var creep = cast(entity, component.Creep);
		var buildings = location.pos.get().filter(entity -> Std.isOfType(entity, component.Building));
		if (buildings.length > 0) {
			manager.remove(entity);
			for (building in buildings) {
				manager.remove(building);
			}
		}
	}

	function applyView(entity:entity.Entity, dt:Float) {}

	public function relevant(entity:Entity):Bool {
		return Std.isOfType(entity, component.Creep) && Std.isOfType(entity, component.Location);
	}
}
