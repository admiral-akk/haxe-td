package creep;

import animation.MoveAnimation;

class King extends h2d.Object {
	var image:h2d.Bitmap;
	var pos:Point;

	var time:Float;
	var animation:Null<MoveAnimation>;

	public function new(x:Int, y:Int) {
		super();
		pos = new Point(x, y);
		time = 0;
		image = new h2d.Bitmap(TileLoader.King(), this);
		image.tile.dx = -8;
		image.tile.dy = -8;
		image.setPosition(8, 8);
	}

	public function gameUpdate() {
		var end = new Point(pos.x, pos.y);
		if (x == 0 && y < 15) {
			end.y += 1;
		}
		if (x < 15 && y == 15) {
			end.x += 1;
		}
		if (x == 15 && y > 0) {
			end.y -= 1;
		}
		if (x > 0 && y == 0) {
			end.x -= 1;
		}

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
