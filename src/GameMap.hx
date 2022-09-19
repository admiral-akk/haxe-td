import haxe.ds.HashMap;

class GameMap extends h2d.Object {
	public var xDim:Int;
	public var yDim:Int;
	public var towers:HashMap<Position, Tower>;

	var entities:Map<Int, entity.Entity>;
	var locations:HashMap<Position, Map<Int, entity.Entity>>;

	var map:Array<Array<Ground>>;
	var spawns:Array<Array<Null<Spawn>>>;

	public var pathfinder:Pathfinder;

	public function new() {
		super();
		locations = new HashMap();
		entities = new Map();
		xDim = 32;
		yDim = 16;
		map = new Array();
		spawns = new Array();
		towers = new HashMap();
		for (y in 0...16) {
			map.push(new Array());
			spawns.push(new Array());
			for (x in 0...32) {
				map[y].push(new Ground(x, y, this));
				if (x > 2 && x < 5 && y > 6 && y < 9) {
					spawns[y].push(new Spawn(x, y, this));
				} else {
					spawns[y].push(null);
				}
			}
		}
		pathfinder = new Pathfinder(this);
	}

	public function Move(start:Position):Position {
		return pathfinder.Move(start);
	}

	public function PlaceTower(tower:Tower) {
		towers.set(tower.pos, tower);
		pathfinder.Recompute();
	}

	public function getBuildings():Array<entity.Entity> {
		var arr = new Array();
		for (entity in entities) {
			if (Std.isOfType(entity, component.Building)) {
				arr.push(entity);
			}
		}
		return arr;
	}

	public function maybeAdd(entity:entity.Entity) {
		if (Std.isOfType(entity, component.Location)) {
			entities[entity.id] = entity;
			var location = cast(entity, component.Location);
			if (!locations.exists(location.pos))
				locations[location.pos] = new Map();
			locations[location.pos][entity.id] = entity;
		}
		pathfinder.Recompute();
	}

	public function removeEntity(entity:entity.Entity) {
		entities.remove(entity.id);
		if (Std.isOfType(entity, component.Location)) {
			var location = cast(entity, component.Location);
			locations[location.pos].remove(entity.id);
		}
		pathfinder.Recompute();
	}

	public function moveEntity(entity:entity.Entity, end:Position) {
		var location = cast(entity, component.Location);
		locations[location.pos].remove(entity.id);
		if (!locations.exists(end))
			locations[end] = new Map();
		locations[end][entity.id] = entity;
		pathfinder.Recompute();
	}

	public function get(pos:Position):Array<entity.Entity> {
		var entities = new Array();
		if (locations.exists(pos)) {
			for (entity in locations[pos])
				entities.push(entity);
		}
		return entities;
	}
}
