package creep;

import animation.MoveAnimation;

class King extends h2d.Object {
	var image:h2d.Bitmap;
	var pos:Position;
	var map:GameMap;

	var time:Float;
	var animation:Null<MoveAnimation>;

	public function new(x:Int, y:Int, map:GameMap) {
		super();
		this.map = map;
		pos = new Position(x, y, map);
		time = 0;
		image = new h2d.Bitmap(TileLoader.King(), this);
		// Center the pivot for rotation
		image.tile.dx = -8;
		image.tile.dy = -8;
		image.setPosition(8, 8);
	}

	public function gameUpdate() {
		var end = map.Move(pos);
		this.animation = new MoveAnimation(image, pos, end, 1.5);
		pos = end;
	}

	public function viewUpdate(dt:Float) {
		time += dt;
		if (this.animation != null) {
			this.animation.update(dt);
		}
		image.rotation = Math.sin(5 * time) / 2;
	}
}
