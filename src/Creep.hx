class Creep {
	var pos:Point;
	var map:GameMap;
	var image:h2d.Bitmap;

	public function new(start:Point, gameMap:GameMap) {
		pos = start;
		map = gameMap;
	}

	public function update() {
		var nextPos = map.getMove(pos);
		pos = nextPos;
		image.setPosition(pos.x * 16, pos.y * 16);
	}
}
