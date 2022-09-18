class ViewPosition {
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public function lerp(other:ViewPosition, t:Float):ViewPosition {
		return new ViewPosition(x * (1 - t) + other.x * t, y * (1 - t) + other.y * t);
	}
}
