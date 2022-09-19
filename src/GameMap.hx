import creep.King;
import haxe.ds.HashMap;

class GameMap extends h2d.Object {
	public var xDim:Int;
	public var yDim:Int;
	public var buildings:HashMap<Position, Building>;
	public var towers:HashMap<Position, Tower>;

	var map:Array<Array<Ground>>;
	var spawns:Array<Array<Null<Spawn>>>;
	var creeps:Array<Array<Null<King>>>;

	public var pathfinder:Pathfinder;

	public function new() {
		super();
		xDim = 32;
		yDim = 16;
		map = new Array();
		buildings = new HashMap();
		spawns = new Array();
		creeps = new Array();
		towers = new HashMap();
		for (y in 0...16) {
			map.push(new Array());
			spawns.push(new Array());
			creeps.push(new Array());
			for (x in 0...32) {
				map[y].push(new Ground(x, y, this));
				if (x > 25 && x < 30 && y > 5 && y < 10) {
					buildings[new Position(x, y, this)] = new Building(x, y, this);
				}
				if (x > 2 && x < 5 && y > 6 && y < 9) {
					spawns[y].push(new Spawn(x, y, this));
				} else {
					spawns[y].push(null);
				}
				creeps[y].push(null);
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

	public function SpawnKing(start:Position) {}
}
