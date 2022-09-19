class SystemManager {
	var currId:Int;
	var entities:Map<Int, entity.Entity>;
	var systems:Array<system.System>;

	public function new() {
		currId = 0;
		entities = new Map();
		systems = new Array();
	}

	public function addEntity(entity:entity.Entity) {
		entity.id = currId;
		currId++;
		entities[entity.id] = entity;
		for (system in systems)
			system.maybeAdd(entity);
	}

	public function addSystem(system:system.System) {
		systems.push(system);
		for (entity in entities)
			system.maybeAdd(entity);
	}

	public function remove(entity:entity.Entity) {
		for (system in systems)
			system.remove(entity);
		entity.remove();
	}

	public function updateView(dt:Float) {
		for (system in systems)
			system.updateView(dt);
	}

	public function updateModel() {
		for (system in systems)
			system.updateModel();
	}
}
