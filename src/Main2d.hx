class King {
	public var kingBmp:h2d.Bitmap;

	var x:Int;
	var y:Int;
	var time:Float;
	var timeToMove:Float;
	var animation:Null<MoveAnimation>;

	public function new(bmp:h2d.Bitmap, x:Int, y:Int) {
		this.kingBmp = bmp;
		this.x = x;
		this.y = y;
	}

	public function update(dt:Float) {
		timeToMove -= dt;
		if (timeToMove < 0) {
			timeToMove = 2;
			var start = new Point(x, y);
			var end = new Point(x, y);
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

			x = Std.int(end.x);
			y = Std.int(end.y);

			this.animation = new MoveAnimation(kingBmp, start, end, 1.5);
		}
		time += dt;
		if (this.animation != null) {
			this.animation.update(dt);
		}

		kingBmp.rotation = Math.sin(5 * time) / 2;
	}
}

class Point {
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public function lerp(other:Point, t:Float):Point {
		return new Point((1 - t) * x + t * other.x, (1 - t) * y + t * other.y);
	}
}

class MoveAnimation {
	public var start:Point;
	public var end:Point;

	var t:Float;
	var length:Float;
	var target:h2d.Bitmap;

	function curve(x:Float):Float {
		var c1 = 1.70158;
		var c3 = c1 + 1;

		return 1 + c3 * Math.pow(x - 1, 3) + c1 * Math.pow(x - 1, 2);
	}

	public function new(target:h2d.Bitmap, start:Point, end:Point, length:Float) {
		this.start = start;
		this.end = end;
		this.t = 0;
		this.length = length;
		this.target = target;
	}

	function animate() {
		var p = this.start.lerp(this.end, curve(t / length));
		this.target.x = p.x * 16 + 8;
		this.target.y = p.y * 16 + 8;
	}

	public function update(dt:Float) {
		t += dt;
		if (t >= length) {
			t = length;
		}
		animate();
	}
}

class Main2d extends hxd.App {
	var king:King;

	override private function init():Void {
		super.init();

		var tileMap = hxd.Res.img.tilemap_packed.toTile();
		var tileWidth = 16;
		var tileHeight = 16;
		var width = tileMap.width / tileWidth;
		var height = tileMap.height / tileHeight;

		var tileGroup = new h2d.TileGroup(tileMap, s2d);

		var tiles = [
			for (y in 0...Std.int(height))
				for (x in 0...Std.int(width))
					tileMap.sub(x * tileWidth, y * tileHeight, tileWidth, tileHeight)
		];

		var ground = tiles[0];
		var kingTile = tiles[23 * 4 - 1];

		s2d.scaleMode = h2d.Scene.ScaleMode.LetterBox(256, 256);

		for (y in 0...16)
			for (x in 0...16)
				tileGroup.add(x * tileWidth, y * tileHeight, ground);

		s2d.addChild(tileGroup);
		var kingBmp = new h2d.Bitmap(kingTile);
		kingBmp.tile.dx = -8;
		kingBmp.tile.dy = -8;
		kingBmp.setPosition(8, 8);
		king = new King(kingBmp, 0, 0);
		tileGroup.addChild(kingBmp);
	}

	override function update(dt:Float) {
		king.update(dt);
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main2d();
	}
}
