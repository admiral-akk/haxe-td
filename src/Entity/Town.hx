package entity;

class Town extends Entity implements component.Building implements component.Sprite implements component.Location {
	public function new(id:Int, x:Int, y:Int, map:GameMap) {
		this.id = id;
		pos = new Position(x, y, map);
		image = new h2d.Bitmap(TileLoader.Town(), map);
		var viewPos = pos.ToView();
		image.setPosition(viewPos.x, viewPos.y);
	}

	public function remove() {
		image.remove();
	}
}
