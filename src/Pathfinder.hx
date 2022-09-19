import haxe.ds.HashMap;

class Pathfinder {
	var map:GameMap;
	var dist:HashMap<Position, Int>;

	public function new(map:GameMap) {
		this.map = map;
		Recompute();
	}

	public function Recompute() {
		dist = new HashMap();
		var queue = new Array();
		for (building in map.buildings) {
			dist[building.pos] = 0;
			for (neighbour in building.pos.Neighbours()) {
				queue.push(neighbour);
			}
		}
		for (tower in map.towers) {
			dist.set(tower.pos, 1000);
		}
		while (queue.length > 0) {
			var next = queue.pop();
			if (dist.exists(next)) {
				continue;
			}

			var minDist = 1000;

			for (neighbour in next.Neighbours()) {
				if (!dist.exists(neighbour)) {
					queue.push(neighbour);
					continue;
				}
				var newDist = dist[neighbour] + 1;
				if (newDist < minDist) {
					minDist = newDist;
				}
			}
			dist.set(next, minDist);
		}
	}

	public function Move(start:Position):Position {
		var target = start;
		for (neighbour in start.Neighbours()) {
			if (dist[neighbour] < dist[target]) {
				target = neighbour;
			}
		}
		return target;
	}
}
