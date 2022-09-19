package entity;

class King extends Entity implements component.Location implements component.Sprite implements component.Creep {
	public function new(id:Int, x:Int, y:Int, map:GameMap) {
		this.id = id;
		pos = new Position(x, y, map);
		pathfinder = map.pathfinder;
		image = new h2d.Bitmap(TileLoader.King(), map);
		image.tile.dx = -8;
		image.tile.dy = -8;
		image.setPosition(8, 8);
		health = 1;
	}

	public function remove() {
		image.remove();
	}
}
