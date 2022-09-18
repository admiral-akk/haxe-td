package animation;

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
