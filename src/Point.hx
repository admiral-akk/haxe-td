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
