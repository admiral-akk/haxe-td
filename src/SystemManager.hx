class SystemManager {
	var currId:Int;
	var entities:Map<Int, entity.Entity>;
	var systems:Array<system.System>;
	var map:GameMap;

	public function new(map:GameMap) {
		currId = 0;
		entities = new Map();
		systems = new Array();
		this.map = map;
	}

	public function addEntity(entity:entity.Entity) {
		entity.id = currId;
		currId++;
		entities[entity.id] = entity;
		for (system in systems)
			system.maybeAdd(entity);
		map.maybeAdd(entity);
	}

	public function addSystem(system:system.System) {
		systems.push(system);
		for (entity in entities)
			system.maybeAdd(entity);
	}

	public function remove(entity:entity.Entity) {
		for (system in systems)
			system.remove(entity);
		map.removeEntity(entity);
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
