class GameMap extends h2d.Object {
	var map:Array<Array<Ground>>;

	public function new() {
		super();
		map = new Array();
		for (y in 0...16) {
			var arr = new Array();
			for (x in 0...32) {
				var g = new Ground(x, y);
				addChild(g);
				arr.insert(arr.length, g);
			}
			map.insert(map.length, arr);
		}
	}

	public function getMove(start:Point):Point {
		return new Point(start.x + 1, start.y);
	}

	public function spawnCreep(start:Point):Creep {
		return new Creep(start, this);
	}
}
