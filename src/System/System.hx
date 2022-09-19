package system;

abstract class System {
	var entities:Map<Int, entity.Entity>;
	var manager:SystemManager;

	abstract function applyView(entity:entity.Entity, dt:Float):Void;

	public function updateView(dt:Float) {
		for (entity in entities) {
			applyView(entity, dt);
		}
	}

	abstract function applyModel(entity:entity.Entity):Void;

	public function updateModel() {
		for (entity in entities) {
			applyModel(entity);
		}
	}

	abstract function relevant(entity:entity.Entity):Bool;

	public function maybeAdd(entity:entity.Entity) {
		if (relevant(entity)) {
			entities[entity.id] = entity;
		}
	}

	public function remove(entity:entity.Entity) {
		entities.remove(entity.id);
	}

	public function new(manager:SystemManager) {
		entities = new Map();
		this.manager = manager;
	}
}
