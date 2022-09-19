class Position {
	public var x:Int;
	public var y:Int;

	var map:GameMap;

	public function new(x:Int, y:Int, map:GameMap) {
		this.x = x;
		this.y = y;
		this.map = map;
	}

	public function ToView() {
		return new ViewPosition(x * 16 + 8, y * 16 + 8);
	}

	public function Offset(x:Int, y:Int):Position {
		return new Position(this.x + x, this.y + y, map);
	}

	public function Neighbours():Array<Position> {
		var neighbours = new Array();
		if (x > 0) {
			neighbours.push(new Position(x - 1, y, map));
		}
		if (x < map.xDim - 1) {
			neighbours.push(new Position(x + 1, y, map));
		}
		if (y > 0) {
			neighbours.push(new Position(x, y - 1, map));
		}
		if (y < map.yDim - 1) {
			neighbours.push(new Position(x, y + 1, map));
		}
		return neighbours;
	}

	public function hashCode():Int {
		return x + 1000 * y;
	}

	public function isTown():Bool {
		return map.buildings.exists(this);
	}
}
