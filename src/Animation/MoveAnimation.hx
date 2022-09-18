package animation;

class MoveAnimation {
	public var start:ViewPosition;
	public var end:ViewPosition;

	var t:Float;
	var length:Float;
	var target:h2d.Bitmap;

	function curve(x:Float):Float {
		var c1 = 1.70158;
		var c3 = c1 + 1;
		return 1 + c3 * Math.pow(x - 1, 3) + c1 * Math.pow(x - 1, 2);
	}

	public function new(target:h2d.Bitmap, start:Position, end:Position, length:Float) {
		this.start = start.ToView();
		this.end = end.ToView();
		this.t = 0;
		this.length = length;
		this.target = target;
	}

	function animate() {
		var p = this.start.lerp(this.end, curve(t / length));
		this.target.x = p.x;
		this.target.y = p.y;
	}

	public function update(dt:Float) {
		t += dt;
		if (t >= length) {
			t = length;
		}
		animate();
	}
}
