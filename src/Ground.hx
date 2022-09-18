class Ground extends h2d.Object {
	var pos:Point;
	var tile:h2d.Bitmap;

	public function new(x:Int, y:Int) {
		super();
		pos = new Point(x, y);
		tile = new h2d.Bitmap(TileLoader.Grass(), this);
		tile.setPosition(x * tile.getSize().width, y * tile.getSize().height);
	}
}
